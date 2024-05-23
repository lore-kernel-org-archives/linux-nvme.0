Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84ECC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 06:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+E0QdcyuhwrEvdlpYdlkSDPKm9Kp4dMOk1fsO8gM7I=; b=f4/o29bj05zN6QJZ+k2/TV/OCG
	JKhS0n9KFMxaHgmoUR4svNwsCcjluVI/+6KnomXMCO0bHee3/8yVTe1K34EWHi7AorP00O7Ncvmxj
	MxmGz9u5b0AlumEs2pqojYDgmJETwdxa91NvBqism3E2O2C6PVI4/fViHEEKtLcm2fwPL/B0gKtZ8
	4329TFjhU9pnDJ6Ox57Uvy9M5Jj6QkI5vjHoZ64hobUCyZ8lhU8B67CLdussnRmTUoI7x8O+GoqZF
	f5nIpiZFMyGMQF8e1VmQMFsipX0SgLYsmVHkZS74mISl/jx3ZqHG3ASYHJFFgbp4BMN4GenTO6qYg
	Dowg87uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2Cv-00000005F4u-0t5h;
	Thu, 23 May 2024 06:45:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2Cp-00000005F3p-2jKi
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 06:45:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 551AD68C7B; Thu, 23 May 2024 08:45:26 +0200 (CEST)
Date: Thu, 23 May 2024 08:45:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>, hch@lst.de, sagi@grimberg.me,
	emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523064525.GA28524@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com> <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_234539_857509_30A9A00F 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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

On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
> Christoph, Sagi, 6.10 merge window is still open and this has been
> iterating long before that. Any objection?

No, it's not.  The window for development closes with the release for
6.9.  New features must be in before that.

