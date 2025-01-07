Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91246E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fzgUQaA45GYmAtWF4h8jZBvOVZmJvTCwpVPTndrd7y8=; b=WBkNgyJX0n7rEuwDGi7F2Dh97+
	HKbNRrjn0I+xRGW7Mvu6pjBel2Zg7fjJBTPKv579X1RBEerZ9hgnBa+x98uoixqumDxnQFkIF9nos
	1SuBhwSGs0Pnb8zBgVf6VT/LRN/rZTSrncndZpI+nm3jbSUTILqK0FxH/bT2FuMSYv/iBOXnH5eFk
	2sgl9I3CKbJFPomhsxGnP0XRdBgTrfMFzIbI+H9NMGMYVLpBwAUF8MWB2qtmn3YnD3u4//L0AT7GX
	bqcxRsFPOH8FT5vHq7aas5gU7H2EaxcXLJMDB0GN4fQigNV36GbtyYjmDVVcgsOd2Wm7a3xpuqLrI
	ZjwWxHCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4rk-00000003ueY-30kx;
	Tue, 07 Jan 2025 08:23:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4qb-00000003uR5-06Bd
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 08:21:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3418768AFE; Tue,  7 Jan 2025 09:21:46 +0100 (CET)
Date: Tue, 7 Jan 2025 09:21:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 3/8] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <20250107082145.GA15960@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-4-hch@lst.de> <220cdd33-527f-405d-90af-2abaace36645@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220cdd33-527f-405d-90af-2abaace36645@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_002157_204250_F1C4FAEB 
X-CRM114-Status: GOOD (  12.94  )
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

On Tue, Jan 07, 2025 at 12:27:35PM +0530, Nilay Shroff wrote:
> As discussed in another thread with Damien, shouldn't we need to 
> move bdev_can_poll() to header file?

Well, if it was needed I would have done it, otherwise the code wouldn't
compile, would it?

> We also need to use this 
> function while reading sysfs attribute "io-poll", no?  

This now reports polling support when the driver declared it but
later resized the number of queues to have no queues left.  Which I
think is a fine tradeoff if you do that.


