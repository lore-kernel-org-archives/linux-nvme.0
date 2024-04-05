Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A1ECD1284
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 06:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LJ2iLPeGyQOFWVDXetjicOrZ0HiaUTj703Hb6dh2FW4=; b=zxaHPn8EIVYRWrRjvDLtsXmOFb
	dVW3un6r2zKKtJfQfUN+3ltuzoW2WpOArNHy4nqYZqznFZs+k+n1iLHEAQFE9DhbgFOwqe91MtTWp
	b8o7hyNZ4erjykEc+pxvlEkqkhTmHivVXO18SYkegqqih/tZEUzVV+76LV+LZCIEysSLxFC84Z4r9
	2876HyNGNyfcBuSAs09GOQ9YVs7v/otZHgWxiDbrJ1Yu0zQyzArNHyFMwx8mbqqZ6DJ/+Mi/D9wz0
	lXNe6BZLVRdTELF9NRFi/u/Htar4hTJws5gqsIlG42O7h9FjETFKg1lSdTK+fcpDstTiZbmwaThtI
	8Cueg9mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsdOd-00000005XCy-3obU;
	Fri, 05 Apr 2024 06:49:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsdOa-00000005XCN-2lDE
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 06:49:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8CB5C68D07; Fri,  5 Apr 2024 08:49:49 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:49:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] nvme: authentication error are always
 non-retryable
Message-ID: <20240405064949.GB3788@lst.de>
References: <20240404154500.2101-1-dwagner@suse.de> <20240404154500.2101-2-dwagner@suse.de> <20240405061624.GA3107@lst.de> <woyigt522zjki3zqudphkxmnzqmerrbk4qdammefuuxww3n3a2@ahfxqfztkmvp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <woyigt522zjki3zqudphkxmnzqmerrbk4qdammefuuxww3n3a2@ahfxqfztkmvp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_234952_861597_D2C27390 
X-CRM114-Status: GOOD (  21.01  )
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

On Fri, Apr 05, 2024 at 08:45:11AM +0200, Daniel Wagner wrote:
> > This is still abusing on the wire status code for in-kernel return
> > codes.  Can we please sort this out properly?
> 
> Okay, though I am not really sure how to do it correctly.
> 
> So the current mapping is
> 
>   ret < 0: kernel errors
>   ret = 0: all good
>   ret > 0: wire status incl DNR

Yes.

> In order to split the internal DNR away, we could attach it to the cmd.
> Is this what you had in mind? Or do you mean we should not return
> NVME_SC_AUTH_REQUIRED at all. Instead just a negative value and update
> the error handling on the callers?

The latter.

