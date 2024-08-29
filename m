Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D046FC761AE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 06:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zWkhvWSvJ9BGxC0PBHRhg1KTPIVM4Yhp96B6vy57l98=; b=jS4vB44B0zudi+7dJ62OuW8PNE
	kgNAB6KKBgSKa98hQVT65tX/AmbK/XSmNNRC8XgSYK25LR9bh2uMRpcX+sx+0UO4YJf2Eg5+QG+PJ
	owELEY8R6ainZ+IcjODgU02Rz/kEJKnyLWFJlK98VbeYp9yMFwA2dWeHyYjHIqhcd9psPtAEC8yyL
	uzYPXZypa+ktp6+7UupXu131RP0s8d4t6cVZiUwd8x5zsGsupppILoghAByYmCfdffa33UMYjN4jg
	mnYOf8yzo1xASaPqbn9Y3DIzwp48fDYi8ORaTA7AZdMyv/7ddeqWbLabKtfP63tyKDxsiPLGC+/Au
	hjV+vKIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYo7-00000000oKc-0QZa;
	Thu, 29 Aug 2024 06:38:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYfl-00000000mbM-3xio
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 06:30:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9357268AA6; Thu, 29 Aug 2024 08:30:17 +0200 (CEST)
Date: Thu, 29 Aug 2024 08:30:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: core: shorten duration of multipath namespace
 rescan
Message-ID: <20240829063017.GA6696@lst.de>
References: <20240826163951.68078-1-mwilck@suse.com> <20240827063332.GA11773@lst.de> <41331f243b0b3172cfdcf0ef33b8ed34e813bac2.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41331f243b0b3172cfdcf0ef33b8ed34e813bac2.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_233022_149292_F8089E79 
X-CRM114-Status: GOOD (  18.15  )
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

On Tue, Aug 27, 2024 at 05:42:52PM +0200, Martin Wilck wrote:
> Not sure if I understood you correctly, but a single helper for
> unfreezing both the path and the multipath queues won't work.The
> following code block
> 
>         if (blk_queue_is_zoned(ns->queue)) {
>                 ret = blk_revalidate_disk_zones(ns->disk);
>                 if (ret && !nvme_first_scan(ns->disk))
>                         goto out;
>         }
> 
> must be called from nvme_update_ns_info_block() after unfreezing the
> path queue, but its result is used in the code that must run with the
> multipath queue still frozen. So we can freeze both queues at the same
> time, but we must unfreeze them separately.

I don't see what we'd use from blk_revalidate_disk_zones in the
propagation to the multipath node.   I've written up my suggested
prep steps as very lightly tested patches, and they seem to work
fine.  I'll send them out.




