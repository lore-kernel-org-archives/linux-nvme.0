Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4906C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTZsmXOaXOYBEcbaXgwdoljfLwm5QlSej+Bxq/Cbw+A=; b=dXLGNVnUOHRGP3B9m+lAl02VjT
	1gXfMbNnbr4UrF9f9U7vQXmfIDlzDw9ZT99ulDNz1w78RhMG5WrnHX5/bUFc954KP8/F3aB6h0vvx
	mKmcLUD48BKPvociHo156maYZRDVhcWjAf4ML3u1e2UTdtlJys57Z+NBuYkeFI3eh+xOKEGfiXG22
	GWwam/or6luwC9DhBmuUwun4RgVv+Rh649hj6l0yClWOt/z5ES5L4MNd6vW7poFz/YvNf5JFDdh1b
	YaEo2yhmGFAZy0dVtfn7t9YmHJeLaiqHlMLkuEtdK+Qr805Diss3TpQoYyRt4Dm+T8K4wKr7rEALz
	3JqbyAsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YjH-00EAIU-4y; Tue, 05 Jul 2022 02:55:59 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YjE-00EAHY-6J
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989755; x=1688525755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y8lcgAPDEr2cqKnB0CgGnKFQmRqGD0zu4iwMGeDrRYo=;
  b=Nno4SFxyG9Jb4jn7AF0ualk4zwJeRcLpDLYSQz4lCTMOAZ/oO4u8f6GF
   BiAIdPUqgVNxbgVo/+zHzbohPDI/KNxNQNnTBwYd76eyMColulJPq78bE
   lCGAxXXJf97osDwMGyiNR9vLYQPBGg/iA5V0uVAZnwArVtsBY16TGitdF
   ra+Eejf0j1vAHp1c/oqyDQl3PQ4Q+5WaNSDa5crItk2JjkYbsK14sTVDX
   itPgdcVT3YoXdVJP4hnll0cZCex5QctIHFkaCSeLvuV9+5JXCtDvheVOp
   qr8HtBlan3udXIn4zjVv2H56lbTqx0URitN7gxxBHVcKeMrADcVVur2+e
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205521014"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:55:55 +0800
IronPort-SDR: D3t3krRWqH1nG42vlOZXoF93DCUYN2FtnizBBjjK8SQfzMscnmvGJz+cy15v19lk7WHqo5a0wB
 25PSoPWWwGtnNr/dXadEe426YKw4SjVaJTM7J52yna9NuwwGxYCAa1BXokUdfuE/1d/EH2XaPQ
 3/FJdC5+SsImHIH+Njf0+ndYOFXUSfZtrYb/ITACMG6uiLaxVLzc+/D4xyn4LtZ50KPT/nMeeH
 DeIbuZmKgEjw+iJgVk+M6ftjLjD+jiwv54XAwo6+7EK/R7uD4RXQPgpknTfXPsgHAa/jV9QUlz
 bryerp5h8d4erFsVInrLnGDm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:17:46 -0700
IronPort-SDR: I/IrGvo8mf1OMcZRI7kgvvhf8DCvgHR/ML5uXfQiqWJ8Z/RlrUVc+NtRJ5EfHTyDu81f1uv96e
 4/aIB0pID4vwhl8VK4067rbmIb8bj+BOF5ggmmXP+w1yw3jSUIJRuREMFyRT8wCJ6EPwUpPv07
 g7F4ilwIf0a5U1OabJ0NQ6XjlKPAnh8p1+Aljye9KPHtPV0VAaegmzajE+36umaq6zrjTeYRW9
 905O9WqKAoubeEGgmNvj57xmHA/DBM8Jaicx/6WGzRWM0RGIKaHOVZ/RKyDVSUHyDQPjjKUACD
 Q8o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:55:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcS3b0bLbz1Rwnx
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:55:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656989754; x=1659581755; bh=Y8lcgAPDEr2cqKnB0CgGnKFQmRqGD0zu4iw
	MGeDrRYo=; b=DbdYtbrAPEpkNXcR5ct8xxau/LljEmNX1k6H3A6NYsEs9PJFhNp
	anVlqxX3Fos6UX6AQWMUlmKU5XWXxyOaXirFSZjLLD0rSWik7E9Q0HpG0Wm2WKAO
	ZZDcZVqmWMhB1skK9W6ITUs9faTytKvvxk5xftGbtwoxHZA8sZeMpJIVl9oKlWlY
	0L9oJmLRZDgD7AGSw8l/1QC3G9QnMgU9e6nUiYSiFOME51yx5PX41lj/OCA5lNm6
	1OpJssZ9DHlhBlN4GIzvnnJBCNoWGwsYqT67YpEhsqEAWzfYwF3BonbkEMls/GEe
	GDJ59RSEh3+WNdUWjDZ0IUQauLNWoqQ0Rdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uRbYYSdvgaML for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:55:54 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcS3Y3vhHz1RtVk;
	Mon,  4 Jul 2022 19:55:53 -0700 (PDT)
Message-ID: <98bebb07-d8a6-7a65-7843-874e62422fd6@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:55:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 16/17] block: remove blk_queue_zone_sectors
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-17-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_195556_363118_8641B204 
X-CRM114-Status: GOOD (  24.72  )
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

On 7/4/22 21:44, Christoph Hellwig wrote:
> Always use bdev_zone_sectors instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-table.c  |  4 +---
>  drivers/md/dm-zone.c   | 10 ++++++----
>  include/linux/blkdev.h | 11 +++--------
>  3 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index b36b528e56cff..df904b7e95ce3 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1620,13 +1620,11 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
>  static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
>  					   sector_t start, sector_t len, void *data)
>  {
> -	struct request_queue *q = bdev_get_queue(dev->bdev);
>  	unsigned int *zone_sectors = data;
>  
>  	if (!bdev_is_zoned(dev->bdev))
>  		return 0;
> -
> -	return blk_queue_zone_sectors(q) != *zone_sectors;
> +	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
>  }
>  
>  /*
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 6d105abe12415..842c31019b513 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -334,7 +334,7 @@ static int dm_update_zone_wp_offset_cb(struct blk_zone *zone, unsigned int idx,
>  static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
>  				    unsigned int *wp_ofst)
>  {
> -	sector_t sector = zno * blk_queue_zone_sectors(md->queue);
> +	sector_t sector = zno * bdev_zone_sectors(md->disk->part0);
>  	unsigned int noio_flag;
>  	struct dm_table *t;
>  	int srcu_idx, ret;
> @@ -373,7 +373,7 @@ struct orig_bio_details {
>  static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  				  unsigned int zno, struct bio *clone)
>  {
> -	sector_t zsectors = blk_queue_zone_sectors(md->queue);
> +	sector_t zsectors = bdev_zone_sectors(md->disk->part0);
>  	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
>  
>  	/*
> @@ -443,7 +443,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md, unsigned int z
>  		return BLK_STS_OK;
>  	case REQ_OP_ZONE_FINISH:
>  		WRITE_ONCE(md->zwp_offset[zno],
> -			   blk_queue_zone_sectors(md->queue));
> +			   bdev_zone_sectors(md->disk->part0));
>  		return BLK_STS_OK;
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
> @@ -593,6 +593,7 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
>  {
>  	struct mapped_device *md = io->md;
>  	struct request_queue *q = md->queue;
> +	struct gendisk *disk = md->disk;
>  	struct bio *orig_bio = io->orig_bio;
>  	unsigned int zwp_offset;
>  	unsigned int zno;
> @@ -608,7 +609,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
>  		 */
>  		if (clone->bi_status == BLK_STS_OK &&
>  		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
> -			sector_t mask = (sector_t)blk_queue_zone_sectors(q) - 1;
> +			sector_t mask =
> +				(sector_t)bdev_zone_sectors(disk->part0) - 1;
>  
>  			orig_bio->bi_iter.bi_sector +=
>  				clone->bi_iter.bi_sector & mask;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 183aa83143fd2..f1eca3f5610eb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -669,11 +669,6 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  	}
>  }
>  
> -static inline sector_t blk_queue_zone_sectors(struct request_queue *q)
> -{
> -	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
> -}
> -
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  {
> @@ -1312,9 +1307,9 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
>  
> -	if (q)
> -		return blk_queue_zone_sectors(q);
> -	return 0;
> +	if (!blk_queue_is_zoned(q))
> +		return 0;
> +	return q->limits.chunk_sectors;
>  }
>  
>  static inline int queue_dma_alignment(const struct request_queue *q)


-- 
Damien Le Moal
Western Digital Research

