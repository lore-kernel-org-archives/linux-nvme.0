Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5434BEDE99F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vnMWXcPpD8c0ia9PzaJ5yxm7KkZ9ez/09qplgGr6oFI=; b=qI+Oljhq5DfCNw1g5M67vQyZVS
	naQl2UKy+BZYA+ZB4MQ5iwehyChr41F/qeZPkMwnNy2b5EVkDwbuavDrCydFvLJ876nSl3PXhybWX
	MNiXtTdWjiA9LEEWEygbCaNuRbCtcB3fdXMKWhapj6nuAX/L0uiQ5lLQXyPvd9q6GmhS5PC6fldGj
	Ez8hAETgvIc/nkA4/efS6WLbUXLlyUnu/JzG9urDZg2sHc+kq+ArM4vtlIQI5/ay1pE3hDmVjMP4+
	cGfk3taNbC7J0CJOMNpikL67Lr38kHVnyR+Aef29kOEL3uAARtZL2mlJ0nHglJbcUoM3KQdqbI8eE
	a2C2pt4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so35X-00000006DGP-2yuE;
	Tue, 10 Sep 2024 15:47:31 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so2xd-000000069mR-2wpM
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 15:39:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5D6E5A43E03;
	Tue, 10 Sep 2024 15:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105ACC4CEC3;
	Tue, 10 Sep 2024 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725982760;
	bh=gqnIRsyOZvYlumv1w6sgCwEqmA0ykjp1xDrMLzjEcds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RclTTXgXiw4c5CLvhhyoHhy6AUUEynnX3GLJz8QF0UdBJFFoFyG2HUoz9A2KsPn2W
	 LDmwh1H+GfWpORCqdCI0noZSxTbgUK48CkxNA/2E2z6GrFbx4+h7g9WKFixR+X535J
	 tBN3lroSVZSznQ7LLpgY3z5jbvviTqXzTiXBPO9kxglw/uHRP9anmAkucQo/kC6KwD
	 dzzEIIdok/x3w7L+m22VdEr8O3/GvRWv+35nUDYIC5bxY497mTtjtwpS4d8P6BlKnx
	 wU+hdMYABkNvrNTl3NGkCelTbbtI9eytjhu2mp4xVL+HzY0rr377QYI/BsHGI5WPqa
	 5+JGOGcjDPCng==
Date: Tue, 10 Sep 2024 09:39:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv3 02/10] block: provide helper for nr_integrity_segments
Message-ID: <ZuBoJYw5Ke9cdTXK@kbusch-mbp>
References: <20240904152605.4055570-1-kbusch@meta.com>
 <20240904152605.4055570-3-kbusch@meta.com>
 <20240910153046.GB23805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910153046.GB23805@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_083921_832540_330B0431 
X-CRM114-Status: GOOD (  15.29  )
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

On Tue, Sep 10, 2024 at 05:30:46PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 04, 2024 at 08:25:57AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > This way drivers that want this value don't need to concern themselves
> > with the CONFIG_BLK_DEV_INTEGRITY setting.
> 
> Looks ok:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Although I wonder if we should simply define the field unconditionally
> given that it is only 2 bytes wide and packs nicely.

Good idea, I didn't consider that. Various parts become cleaner if it's
unconditionally part of the request. I'll try it out.

BTW, just want to mention the the return value here is unreliable until
patch 10. I've reworked the series so that appears first to avoid a
bisect hazard. The end result is the same though, so I didn't want to
spam the mailing list with a v2 just yet.

