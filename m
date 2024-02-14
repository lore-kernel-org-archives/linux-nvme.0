Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730C3C48BC4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I5Wg0Cj3JegRTnNd2EoUUKxzIofczHMEd2+lFhD2lDw=; b=P6o09aOBp3DXUIRz/40Dd1EPCZ
	nBjWnp13jIgk3TxCnefLdAej0vIiKHzMn+h6eO+0lCn2fMmjebznvIcWgkj9SNy6p+XW4vz8Lu/Xq
	XShsc/tDGkZOcabNZ8r5wGSQ5u1Lav5D4q+aQ8FrLyT+Tyfr/Tr+3G27phRQXyPBZftgAe9L17jIb
	OIsMhgLz34ZHyEs7NO4CUFNA/B5divPJ9SkzI2msFKnO685/64scdeMeVoX/AGHs4acx4rqO1Jbu0
	jLZGN0F3TOb3MXjx78vpKCsq/k5cDs2BGoU25w8832q7woseG0TcVQD6bDEEC8IBFDnmj98ruUeOX
	48E9HWXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raALJ-0000000C7Gw-43C9;
	Wed, 14 Feb 2024 08:10:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raALI-0000000C7GZ-0TXa
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 08:10:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D135227AAC; Wed, 14 Feb 2024 09:10:04 +0100 (CET)
Date: Wed, 14 Feb 2024 09:10:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saravana Kannan <saravanak@google.com>
Cc: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
	hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	bhelgaas@google.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] driver core: Support two-pass driver shutdown.
Message-ID: <20240214081003.GA10980@lst.de>
References: <20240129181953.1183084-1-jallison@ciq.com> <20240129181953.1183084-2-jallison@ciq.com> <CAGETcx_eUELgBcTdmgA=iN9Mx7U4jHmjEZm_ZjEphF-VB4Thyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_eUELgBcTdmgA=iN9Mx7U4jHmjEZm_ZjEphF-VB4Thyw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_001008_314692_31E5E1C8 
X-CRM114-Status: GOOD (  16.42  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 13, 2024 at 07:36:35PM -0800, Saravana Kannan wrote:
> > This changes the bus driver interface with an additional entry point
> > to enable devices to implement two-pass shutdown. The existing
> > synchronous interface to shutdown is called, and if a shutdown_wait
> > method is defined the device is moved to an alternate list.
> 
> This sounds more like you need a parallelized async shutdown than a
> two-pass shutdown. Similar to how async probes are done today. Why not
> do that so it'll actually be useful in a more general fashion? You can
> even add a flag like we have for probes so that drivers don't need to
> do anything special to allow this parallelism.

Well, we had that discussion before.  The typically time consuming
part in a shutdown is waiting for the device to actually shut down.
An submit and then wait later scheme is more efficient for that,
even if the "simple" async shutdown that just spawns more threads
will also work, while being a lot less efficient.  So unless we
have a strong reason for that the two-phase scheme seems preferable
to me.

