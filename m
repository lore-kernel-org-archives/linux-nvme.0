Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:10:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0422332A
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0422332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EP51S5ZnpFi/IcYm6A5HBVA1q0GKxRhUWstxK5MoYhY=; b=O/VtgWedXxzil7zV10Ch09w5I
	DeC186fCVzoDtRLYXfqb4GGH2xIQus0weYIyzBKTb2qTqvV0t0b0gciQYRr0dz6IXMPoD0z1ox1SV
	l/NN0snVPaVIwkg3P6+RLOFS482SDKHUVdqIbezxLdTv27exwOpCDOCwNvt5UevNcmZbLJ+AQ5Moc
	RiE+YMGuumJaX4uwLnXVSc2FZnqzT86urak11KQwDG6nhXWG9/0Rz4tBXOHW3HdB/K4/xl4xi7Ruv
	ZvCtepSF26m+293DVS4Idp7Bz+pSHtxUoaac/i/6/hgTpgZvc3fBU9QAwe0DBVvBO0hnpE6oTiUa5
	kGjel84+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2ARU-0007D5-AM; Wed, 20 Jan 2021 10:10:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2ARS-0007Ce-7t
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 10:10:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 06F3868AFE; Wed, 20 Jan 2021 11:10:19 +0100 (CET)
Date: Wed, 20 Jan 2021 11:10:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v2 1/2] block: introduce zone_write_granularity limit
Message-ID: <20210120101018.GB25746@lst.de>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
 <20210119131723.1637853-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119131723.1637853-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_051022_542711_AC874C64 
X-CRM114-Status: GOOD (  30.42  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 19, 2021 at 10:17:22PM +0900, Damien Le Moal wrote:
> Per ZBC and ZAC specifications, host-managed SMR hard-disks mandate that
> all writes into sequential write required zones be aligned to the device
> physical block size. However, NVMe ZNS does not have this constraint and
> allows write operations into sequential zones to be logical block size
> aligned. This inconsistency does not help with portability of software
> across device types.
> To solve this, introduce the zone_write_granularity queue limit to
> indicate the alignment constraint, in bytes, of write operations into
> zones of a zoned block device. This new limit is exported as a
> read-only sysfs queue attribute and the helper
> blk_queue_zone_write_granularity() introduced for drivers to set this
> limit. The scsi disk driver is modified to use this helper to set
> host-managed SMR disk zone write granularity to the disk physical block
> size. The nvme driver zns support use this helper to set the new limit
> to the logical block size of the zoned namespace.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/block/queue-sysfs.rst |  7 +++++++
>  block/blk-settings.c                | 28 ++++++++++++++++++++++++++++
>  block/blk-sysfs.c                   |  7 +++++++
>  drivers/nvme/host/zns.c             |  1 +
>  drivers/scsi/sd_zbc.c               | 10 ++++++++++
>  include/linux/blkdev.h              |  3 +++
>  6 files changed, 56 insertions(+)
> 
> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> index 2638d3446b79..c8bf8bc3c03a 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst
> @@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
>  do not support zone commands, they will be treated as regular block devices
>  and zoned will report "none".
>  
> +zone_write_granularity (RO)
> +---------------------------
> +This indicates the alignment constraint, in bytes, for write operations in
> +sequential zones of zoned block devices (devices with a zoned attributed
> +that reports "host-managed" or "host-aware"). This value is always 0 for
> +regular block devices.
> +
>  Jens Axboe <jens.axboe@oracle.com>, February 2009
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 43990b1d148b..6be6ed9485e3 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->io_opt = 0;
>  	lim->misaligned = 0;
>  	lim->zoned = BLK_ZONED_NONE;
> +	lim->zone_write_granularity = 0;

I think this should default to 512 just like the logic and physical
block size.

>  }
>  EXPORT_SYMBOL(blk_set_default_limits);
>  
> @@ -366,6 +367,31 @@ void blk_queue_physical_block_size(struct request_queue *q, unsigned int size)
>  }
>  EXPORT_SYMBOL(blk_queue_physical_block_size);
>  
> +/**
> + * blk_queue_zone_write_granularity - set zone write granularity for the queue
> + * @q:  the request queue for the zoned device
> + * @size:  the zone write granularity size, in bytes
> + *
> + * Description:
> + *   This should be set to the lowest possible size allowing to write in
> + *   sequential zones of a zoned block device.
> + */
> +void blk_queue_zone_write_granularity(struct request_queue *q,
> +				      unsigned int size)
> +{
> +	if (WARN_ON(!blk_queue_is_zoned(q)))
> +		return;
> +
> +	q->limits.zone_write_granularity = size;
> +
> +	if (q->limits.zone_write_granularity < q->limits.logical_block_size)
> +		q->limits.zone_write_granularity = q->limits.logical_block_size;

I think this should be a WARN_ON_ONCE.

> +	if (q->limits.zone_write_granularity < q->limits.io_min)
> +		q->limits.zone_write_granularity = q->limits.io_min;

I don't think this makes sense at all.

> +static ssize_t queue_zone_write_granularity_show(struct request_queue *q, char *page)

Overly long line.

> +	/*
> +	 * Per ZBC and ZAC specifications, writes in sequential write required
> +	 * zones of host-managed devices must be aligned to the device physical
> +	 * block size.
> +	 */
> +	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
> +		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
> +	else
> +		blk_queue_zone_write_granularity(q, sdkp->device->sector_size);

Do we really want to special case HA drives here?  I though we generally
either treat them as drive managed (if they have partitions) or else like
host managed ones.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
