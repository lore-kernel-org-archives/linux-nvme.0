Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7549DC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 03:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6V7xxR+//IJT2DZUMYIOezFUjNbZztF8mBG4KYcIT2I=; b=OlTRXCDe4XzISpiTIvTYCYCjeG
	Oq30hOixaSO4dwH42cayP0SD/3FXf4aFl7tVuwCYgiSNNgQ9/rR2AHe4fgyu/LVXwS7oL0Gtrxu0o
	3GURTHGMThUX+1NmBf0mTyO3RiJ/aaBf6zfSU7AOxLlUMwU4LXn72pg8NYnfNxPQT6AaMfBAdp8/b
	XIfmSys4xNIV237XmncHgMsWCqfWWVwMGuSrZ9w6KCg2Zrd3lSyi/0LekVSqO1bTaliGLRIqdQRtp
	tf9b08lpNSa++l3x7LjJlt+j1A8rCyVqYjL6Y+Z4G87nEYeH3eVyrGCye2ONznAHHnn+ffLMJ1SuB
	iWeIU+3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGts0-003LfX-Aw; Thu, 28 Jul 2022 03:07:28 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtrw-003Lct-JQ
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 03:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658977644; x=1690513644;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XVQ7CO6TM7Kcq25ho/AaV+rwZ8tMT1r4ApMmxYvb8s4=;
  b=cL/00LYzfzLc/TwZ/3DL6/pwg/489S24fXjxUXxH+2WRvA969vLJo7q4
   ORkads9VZlY/Fvyn86eyV0GWYQaKbBoBAYlQflnPEGJMIG1exuTzoYfiB
   VRixcZ4h7SgYDP8TXY2joK6y+9e7JQyy664pxkLMMtGGRf7Mz8/hKrzO7
   0pMwwqkCMn9rvEoHRVunZEa6T4gJsE9eNDH9pXTLkAY8SLUiurcUkbCOh
   PSkJjZp2u24dd/u5DywRf11hVgCf8aLTA4k/G0rkuGz/ls5BfxKpVzbjn
   XCURZQMGyGx5cIvKOFUisTDO6WKT5XuY5HikBxw14Li8ysEkI0luRfr1v
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="319201341"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:07:22 +0800
IronPort-SDR: lRUcOtNF0OzixpIzWgN0rSD+W6058IebwOJ7dUJmFyAcsXAc83K0WX2cgFhNArbBv5bbY3gaBo
 8pFsptA1+ud1W1qp+Z0w1vWeu3Do6ScHnbhDUPJiFe5/NFCa6t8laGmyFy5I8Nety++jpWNVK3
 1Kjlye4MsUWGFrwyikVF0O6HYT7v6uOpLPM99Ar/nVPtC84OCGtTBhiL5N8hIGuTDmkD/VA5T8
 iGRpMz9b7mPg3vuhtekSQHYWTSsoEvVGDq1wWzJhdtMbKLQRLg36Am6EKQH38qPL9vrNOKptto
 sijZyR22sLWyiOjRpLlDvyzg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:23:30 -0700
IronPort-SDR: ZW7shanhlUnjB+WjIxL2Qco8pFtf2+RHvCRxHGe08osRc4eDp86CR3v3egY16HFGDmftNSrM6g
 TrirUKuY18pZcrVvoAT6zbNfaK/DQqQeCls/bH9C2SUPFP6KkUUx2U6qWNZ/g+T+oIUMfiBNHM
 DNWC71gHXGXBnXn0uaxLIkMCK7JbOvgzBW6nniDXP2QwcESEhxoUBx9NPlFgIgGMbl5CmGDcBR
 UEtkGZeSubX5rE9cirl0rIzv8lK3o7J0O6b9fYLYk1Ip7GT5lxNkzcLsz4szBGQXCNa8Wv4EWB
 YRc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:07:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbDB1wKkz1Rws9
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 20:07:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658977639; x=1661569640; bh=XVQ7CO6TM7Kcq25ho/AaV+rwZ8tMT1r4ApM
	mxYvb8s4=; b=KF+46DCLR29I7XcTg4uAsuqNoJ8ZrRXpVhXrcnM1xkf+E1tw0eF
	aMEUpduro4enrX6tvo/V76NemgnAjHhSQQyn2+dTMCSmRwGVfcG3o36q40kc3vVw
	MIX9RFspo1BTsACO6vrm0T8UPjnry4+8VLy9g1ysAkUV6w9kVL9GD73m0F8175YM
	O5+yYAoLPu8JC0Z6EnPMAgWn+n7CDSCxxkubU2+kqOWoeb1CJgvkfXKlWXt150Nb
	7AAqLMZF9nUcGChBh0CtkxHSzjkROKNFFEav2Na0ptvNr5CToz2jhy7/56dOkdFo
	pATv47ohrVjfWzvC/5jqn+A2uZaC67sYpcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cGsBYWzvZXk6 for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 20:07:19 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbD46Qd4z1RtVk;
	Wed, 27 Jul 2022 20:07:16 -0700 (PDT)
Message-ID: <e9663c20-65d5-48f5-3fe1-e3a8f5ab3214@opensource.wdc.com>
Date: Thu, 28 Jul 2022 12:07:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
 <20220727162245.209794-3-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_200725_162798_D161C889 
X-CRM114-Status: GOOD (  42.59  )
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

On 7/28/22 01:22, Pankaj Raghav wrote:
> Checking if a given sector is aligned to a zone is a common
> operation that is performed for zoned devices. Add
> bdev_is_zone_start helper to check for this instead of opencoding it

The patch actually introduces bdev_is_zone_aligned(). I agree with Bart
that bdev_is_zone_start() is a better name.

> everywhere.
> 
> Convert the calculations on zone size to be generic instead of relying on
> power_of_2 based logic in the block layer using the helpers wherever

s/based logic/arithmetics

> possible.
> 
> The only hot path affected by this change for power_of_2 zoned devices
> is in blk_check_zone_append() but bdev_is_zone_start() helper is
> used to optimize the calculation for po2 zone sizes. Note that the append
> path cannot be accessed by direct raw access to the block device but only
> through a filesystem abstraction.

And so what ? What is the point here ?

> 
> Finally, allow non power of 2 zoned devices provided that their zone

Please spell things out clearly: ...allow zoned devices with a zone size
that is not a power of 2 number of sectors...

> capacity and zone size are equal. The main motivation to allow non
> power_of_2 zoned device is to remove the unmapped LBA between zcap and
> zsze for devices that cannot have a power_of_2 zcap.

zcap, zsze are nvme field names. Please phrase these in plain english to
clarify.

> 
> To make this work bdev_get_queue(), bdev_zone_sectors() and
> bdev_is_zoned() are moved earlier without modifications.

"moved earlier" -> declared earlier in xxx.h ?

> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c       |  2 +-
>  block/blk-zoned.c      | 24 +++++++++---
>  include/linux/blkdev.h | 84 ++++++++++++++++++++++++++++++------------
>  3 files changed, 79 insertions(+), 31 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3d286a256d3d..1f7e9a90e198 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -570,7 +570,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_aligned(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>  	    !bio_zone_is_seq(bio))
>  		return BLK_STS_IOERR;
>  
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index dce9c95b4bcd..a01a231ad328 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!bdev_is_zone_aligned(bdev, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!bdev_is_zone_aligned(bdev, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> @@ -486,14 +486,26 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  	 * smaller last zone.
>  	 */
>  	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zone size", disk->disk_name);

You removed the zone size value print, so please update the message to
something like:

pr_warn("%s: Invalid zero zone size", disk->disk_name);

> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * Non power-of-2 zone size support was added to remove the
> +		 * gap between zone capacity and zone size. Though it is technically
> +		 * possible to have gaps in a non power-of-2 device, Linux requires
> +		 * the zone size to be equal to zone capacity for non power-of-2
> +		 * zoned devices.
> +		 */
> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_warn("%s: Invalid zone capacity for non power of 2 zone size",
> +				disk->disk_name);

As Bart suggested, please print the zone capacity and zone size values.

>  			return -ENODEV;
>  		}
>  
>  		args->zone_sectors = zone->len;
> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);

		args->nr_zones = disk_zone_no(disk, capacity);

>  	} else if (zone->start + args->zone_sectors < capacity) {
>  		if (zone->len != args->zone_sectors) {
>  			pr_warn("%s: Invalid zoned device with non constant zone size\n",
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 85b832908f28..1be805223026 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -634,6 +634,11 @@ static inline bool queue_is_mq(struct request_queue *q)
>  	return q->mq_ops;
>  }
>  
> +static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> +{
> +	return bdev->bd_queue;	/* this is never NULL */
> +}
> +
>  #ifdef CONFIG_PM
>  static inline enum rpm_status queue_rpm_status(struct request_queue *q)
>  {
> @@ -665,6 +670,25 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  	}
>  }
>  
> +static inline bool bdev_is_zoned(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return blk_queue_is_zoned(q);
> +
> +	return false;
> +}
> +
> +static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (!blk_queue_is_zoned(q))
> +		return 0;
> +	return q->limits.chunk_sectors;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  {
> @@ -684,6 +708,30 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  	return div64_u64(sector, zone_sectors);
>  }
>  
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	u64 remainder = 0;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sec & (zone_sectors - 1);
> +
> +	div64_u64_rem(sec, zone_sectors, &remainder);
> +	return remainder;
> +}
> +
> +static inline bool bdev_is_zone_aligned(struct block_device *bdev, sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;

This is checked in bdev_offset_from_zone_start(). No need to add it again
here.

> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}
> +
>  static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
>  {
>  	if (!blk_queue_is_zoned(disk->queue))
> @@ -728,6 +776,18 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
>  	return 0;
>  }
> +
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	return 0;
> +}

This one is not used when CONFIG_BLK_DEV_ZONED is not set. No need to
define it.

> +
> +static inline bool bdev_is_zone_aligned(struct block_device *bdev, sector_t sec)
> +{
> +	return false;
> +}
> +
>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return 0;
> @@ -891,11 +951,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
>  int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
>  			unsigned int flags);
>  
> -static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> -{
> -	return bdev->bd_queue;	/* this is never NULL */
> -}
> -
>  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
>  
> @@ -1295,25 +1350,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> -static inline bool bdev_is_zoned(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return blk_queue_is_zoned(q);
> -
> -	return false;
> -}
> -
> -static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (!blk_queue_is_zoned(q))
> -		return 0;
> -	return q->limits.chunk_sectors;
> -}
> -
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research

