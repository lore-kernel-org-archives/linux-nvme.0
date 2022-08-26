Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2862AECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 20:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UjyohoxGONTRXH/EZQWHg7Vd8WDGSLA0ChZFPqsLFMI=; b=wL4/ylouyNsv7xB0saroYX49yF
	1aq+8027B2FI8BfWuaCV63+SMfTRo0clTqkKNN/sGn5pkMIUfkEsj1dS0QJMKB22EqKcCYHynpBnU
	QpapbbWyJdObwm190+Si2zHVtltHg/rn5gw/z+EvPjhEL1DqkxVp1oJBdtIyPYJ18j2eaMKsc16xP
	vqapjwleQesX6gzhpqnG5JvQiL6nsDz/x8KFY2VVVBNMbQTGdT39cnSKAD05fyDPNTlNm9sSzSBAq
	hu+2T9UzGAOnPIDHNMXV3EF2Zb6sl2ZqRzjcD5qBMnZXuMe2nRPLuLG6ZBw9vmBzG4Gogi6yrd/Wr
	oYYH0QGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRfe0-00BKdH-Sv; Fri, 26 Aug 2022 20:09:32 +0000
Received: from out1.migadu.com ([91.121.223.63])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRfdx-00BKYZ-9o
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 20:09:31 +0000
Message-ID: <09bb7615-cf72-7f1e-9158-2ce231c0dda8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1661544565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjyohoxGONTRXH/EZQWHg7Vd8WDGSLA0ChZFPqsLFMI=;
	b=ZHQH6E21r5gQpUgfSZBO9eiEUtPRX/u1oIU4YQ7WNNbzWB8WSsWqYXKPARo2bI2poJNQ8F
	yqsew0MWPtW8pYmzHQEQ+yOdwY7yA/U+AwAYrHKiKUzmI6+Q0j2x9y2GChb2zdYiZikRWh
	xQ03RPlpEMGxSQ8QT1K9gdENVhUD1nI=
Date: Fri, 26 Aug 2022 14:09:22 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v12 03/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
To: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com, hch@lst.de
Cc: pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
 jaegeuk@kernel.org, linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
 gost.dev@samsung.com, bvanassche@acm.org, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121904eucas1p1cdedb3e9af928e25564f46e70765d39b@eucas1p1.samsung.com>
 <20220823121859.163903-4-p.raghav@samsung.com>
 <1dc85f87-7146-ccd2-bbf4-e3077dd7a548@linux.dev>
In-Reply-To: <1dc85f87-7146-ccd2-bbf4-e3077dd7a548@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_130929_798688_15494C48 
X-CRM114-Status: GOOD (  26.61  )
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



On 8/26/2022 2:06 PM, Jonathan Derrick wrote:
> 
> 
> On 8/23/2022 6:18 AM, Pankaj Raghav wrote:
>> Checking if a given sector is aligned to a zone is a common
>> operation that is performed for zoned devices. Add
>> bdev_is_zone_start helper to check for this instead of opencoding it
>> everywhere.
>>
>> Convert the calculations on zone size to be generic instead of relying on
>> power-of-2(po2) based arithmetic in the block layer using the helpers
>> wherever possible.
>>
>> The only hot path affected by this change for zoned devices with po2
>> zone size is in blk_check_zone_append() but bdev_is_zone_start() 
>> helper is
>> used to optimize the calculation for po2 zone sizes.
>>
>> Finally, allow zoned devices with non po2 zone sizes provided that their
>> zone capacity and zone size are equal. The main motivation to allow zoned
>> devices with non po2 zone size is to remove the unmapped LBA between
>> zone capcity and zone size for devices that cannot have a po2 zone
>> capacity.
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>   block/blk-core.c       |  2 +-
>>   block/blk-zoned.c      | 24 ++++++++++++++++++------
>>   include/linux/blkdev.h | 30 ++++++++++++++++++++++++++++++
>>   3 files changed, 49 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index a0d1104c5590..1cb519220ffb 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -563,7 +563,7 @@ static inline blk_status_t 
>> blk_check_zone_append(struct request_queue *q,
>>           return BLK_STS_NOTSUPP;
>>       /* The bio sector must point to the start of a sequential zone */
>> -    if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 
>> 1) ||
>> +    if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>>           !bio_zone_is_seq(bio))
>>           return BLK_STS_IOERR;
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index dce9c95b4bcd..6806c69c81dc 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -285,10 +285,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, 
>> enum req_op op,
>>           return -EINVAL;
>>       /* Check alignment (handle eventual smaller last zone) */
>> -    if (sector & (zone_sectors - 1))
>> +    if (!bdev_is_zone_start(bdev, sector))
>>           return -EINVAL;
>> -    if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
>> +    if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
>>           return -EINVAL;
>>       /*
>> @@ -486,14 +486,26 @@ static int blk_revalidate_zone_cb(struct 
>> blk_zone *zone, unsigned int idx,
>>        * smaller last zone.
>>        */
>>       if (zone->start == 0) {
>> -        if (zone->len == 0 || !is_power_of_2(zone->len)) {
>> -            pr_warn("%s: Invalid zoned device with non power of two 
>> zone size (%llu)\n",
>> -                disk->disk_name, zone->len);
>> +        if (zone->len == 0) {
>> +            pr_warn("%s: Invalid zero zone size", disk->disk_name);
>> +            return -ENODEV;
>> +        }
>> +
>> +        /*
>> +         * Non power-of-2 zone size support was added to remove the
>> +         * gap between zone capacity and zone size. Though it is 
>> technically
>> +         * possible to have gaps in a non power-of-2 device, Linux 
>> requires
>> +         * the zone size to be equal to zone capacity for non power-of-2
>> +         * zoned devices.
>> +         */
>> +        if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
>> +            pr_err("%s: Invalid zone capacity %lld with non 
>> power-of-2 zone size %lld",
>> +                   disk->disk_name, zone->capacity, zone->len);
>>               return -ENODEV;
>>           }
>>           args->zone_sectors = zone->len;
>> -        args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
>> +        args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
>>       } else if (zone->start + args->zone_sectors < capacity) {
>>           if (zone->len != args->zone_sectors) {
>>               pr_warn("%s: Invalid zoned device with non constant zone 
>> size\n",
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 84e7881262e3..d0d66a0db224 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -704,6 +704,30 @@ static inline unsigned int disk_zone_no(struct 
>> gendisk *disk, sector_t sector)
>>       return div64_u64(sector, zone_sectors);
>>   }
>> +static inline sector_t bdev_offset_from_zone_start(struct 
>> block_device *bdev,
>> +                           sector_t sec)
>> +{
>> +    sector_t zone_sectors = bdev_zone_sectors(bdev);
>> +    u64 remainder = 0;
>> +
>> +    if (!bdev_is_zoned(bdev))
>> +        return 0;
> See below
> 
>> +
>> +    if (is_power_of_2(zone_sectors))
>> +        return sec & (zone_sectors - 1);
>> +
>> +    div64_u64_rem(sec, zone_sectors, &remainder);
>> +    return remainder;
>> +}
>> +
>> +static inline bool bdev_is_zone_start(struct block_device *bdev, 
>> sector_t sec)
>> +{
>> +    if (!bdev_is_zoned(bdev))
>> +        return false;
> Duplicating the same check above, and the check above is less clear in 
> the case of !zoned since it returns 0 and not some warning that makes 
> sense in the case of zoned check on !zoned bdev.
> Can you simply exclude above check?
Nevermind, just noticed bdev_offset_from_zone_start is used in later 
patches.

> 
> 
>> +
>> +    return bdev_offset_from_zone_start(bdev, sec) == 0;
>> +}
>> +
>>   static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t 
>> sector)
>>   {
>>       if (!blk_queue_is_zoned(disk->queue))
>> @@ -748,6 +772,12 @@ static inline unsigned int disk_zone_no(struct 
>> gendisk *disk, sector_t sector)
>>   {
>>       return 0;
>>   }
>> +
>> +static inline bool bdev_is_zone_start(struct block_device *bdev, 
>> sector_t sec)
>> +{
>> +    return false;
>> +}
>> +
>>   static inline unsigned int bdev_max_open_zones(struct block_device 
>> *bdev)
>>   {
>>       return 0;

