Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBEAE77198
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hozFIaNBcykSph3B1TwDgEb2lnwmx1AV1y6CmmKgcEo=; b=2QLYh6ea5yp6Jl/lDGEuBkd6EL
	xqOTgpsQZAiJQF4ypnUiqAp6fcUNIEuZ1F0kjVw+ULF7nGfmKs62QDGw9nOTG87at5u2jS+HKk8aK
	UnTfl3H8w4jmSVzudk6eJuSf2WSpHPfciJat//+1v9UWZozXoanqos7F6tqdniDOKFBrPys8FGvkt
	Pbr/kKbKPZn9J5ixk/Yp+wPEmD4S4TwAJYSiYzJbtlJTJVRvXZfr2v9XWDY/h4ui1nLreRJNA7s4b
	v/DjCPmHipYBrp5oMma2l+XkunoqfKadnKDNY6XHUeMJVzfRBVo8CBhkNFAqzyEcjM4zmMRJz/Oib
	0EBYdbMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4rl-00000003uei-1KLa;
	Tue, 07 Jan 2025 08:23:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4r8-00000003uYd-0x5o
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 08:22:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D7E568AFE; Tue,  7 Jan 2025 09:22:25 +0100 (CET)
Date: Tue, 7 Jan 2025 09:22:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 6/8] nvme: fix queue freeze vs limits lock order
Message-ID: <20250107082224.GB15960@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-7-hch@lst.de> <96c48ba0-3db5-4504-a456-e57440aa1b56@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c48ba0-3db5-4504-a456-e57440aa1b56@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_002230_404174_8B87D467 
X-CRM114-Status: GOOD (  11.62  )
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

On Tue, Jan 07, 2025 at 12:28:29PM +0530, Nilay Shroff wrote:
> > -	blk_mq_freeze_queue(ns->disk->queue);
> >  	lim = queue_limits_start_update(ns->disk->queue);
> >  	nvme_set_ctrl_limits(ns->ctrl, &lim);
> > +
> > +	blk_mq_freeze_queue(ns->disk->queue);
> >  	ret = queue_limits_commit_update(ns->disk->queue, &lim);
> >  	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> >  	blk_mq_unfreeze_queue(ns->disk->queue);
> 
> I think we should freeze queue before nvme_set_ctrl_limits(). 

Why?


