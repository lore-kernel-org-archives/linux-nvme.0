Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5894EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+shuYiOMOTbS7RmKTsh9Rcg33nlKjWDhWGRYehF4pY=; b=Y4TfZxKpSW5JKAwpvZP127q8AO
	FfgwAhMoPOf+yPdvElPwOsWBM1Hf4XJmWEHmN4dFdMB4/XPAj386MWLjII6MkgWzdt+IByOWsUE1g
	cO9DZKEoc7K+x1TPnq20F13yQLscrkLmRJlkFj+6STgpCtNR8Bumt9d3pb88BA5ICmC7G9vfbI7ne
	QU/2wX6JIc0/7Y93Hs9Xgnpi7NL5wANApSUoXE1jowD4KFw7yp1w8ywH1EEJt2yfTIRMvfIhvIKtX
	U+FwKoLnWCddDUqNr4PUwaNvWBq1VAlMeKjPD+SZjO2ar7jYgy6q41Yg0NUX7IUNlGm1Tj3AELHWL
	vkXgwyOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njrE5-003x8T-J9; Wed, 27 Apr 2022 23:37:41 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njrE2-003x5t-3f
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 23:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651102658; x=1682638658;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yHKaW5zTI9WZN6XlbM6WV522YA4NJP0ufKH9fAehyOY=;
 b=aa3edcSqqCbqB/Jo77yKfnQ0PQg1i3+tiAujHUcR3XBbT8szvFmAYBmw
 KPLRUi0u3ecKmt74//GH/qX4aa9sPnvEEl5225FXrNwwlUPeAiY18uJf/
 GA/wxKdheHHF+2rHYkllfARxT7LE6Rdakp45QrsboGiAalRaeVhS7LAFG
 iWHxfOpidB7QNkrdQPAlH0eRbSCqPgPkW9lQoYXGovduiV04C/tXtnTLy
 gu/ywCrAvhBvSj5GM4/9pqLyustGYQ92lOqT5LH8CVklNxvJ9iQR2CwKV
 iyJaTl+B53QZ9vO9BoHTBScqqzeu+rQjX+CZ9TSbb67Mp9s7jktMKNfIW g==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="197844286"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:37:36 +0800
IronPort-SDR: mxGqEqKNA0RjV+UeOg79Jj3kLQkiaBMPxccz9w3STLGckVCuzu1YiIraP8kA/bTFcEGkgDBdNV
 yIAcz+sPxuUaJi6DoJqmVNWdfU/1vnNOnLdlFIdbingDTtqfoS5nC5PNIFgNYbp5tELAn88sZW
 24WisvTwey993sZzw08z4msryYEURGE9sKWe9lcDAYQINHCfklpNztwH9ynTJcdfXybgeQS/ib
 AnmT3/VkYEhFddZz4p+7ZbgmR9tN6mLwnYppHRkJiqOfELJqhNkiDa2LgdxQW2frEE6Yom7zin
 sphsp8fTUVlEa89fopbgwe6T
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:08:28 -0700
IronPort-SDR: vutvgFZVP8IVTbe/mdVMrDB3aKQmF05eaJTUtWdtff+2TysoqvQwRRkgnLUrrk2aSu6Z2zzGWF
 369GGfR5MnRJYOj0paQDoy1pBXZeUo9NtVMabFIHu/uIIedmJSM688G9JibPKPe3qo3Waq8jRh
 KIjFD41AuF7XNj246NZfN6LClw4PVi58ReKsYrq+Yf1JyQAftSaeon1J6zjkUxc3k8yT/8ArU5
 1764gyVjZS4NJFC8U7VwPHLnKStE1mfNgvk0KGmZO10uSeuEKZ7IRle4VSEnelAEoqkjebx5Cc
 6D0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:37:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpZt73c6Tz1SHwl
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:37:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651102654; x=1653694655; bh=yHKaW5zTI9WZN6XlbM6WV522YA4NJP0ufKH
 9fAehyOY=; b=omMAaNcAu4C2yHYQb1NClkSwg2xHp13YAJ2SJFHQcpzAm7KwKtr
 LoyEbaprBAqXCi8vJVE8STd2nWRh72RwP+tsxCLdjrW122FhlORiBAJ8dnK+srl9
 3w1eKFOkpl1sQiG+Jw/wdu7z2ERwVaBSZVfkOkvF99qQqSEXxFfHnln0i40KAU/Z
 Rgsaekp7gheGMuCzGRy7neZeHEpBkYADsxKlKyaPXvPrCEfGYZfBs8AldO5KdA8A
 Widzt5gxXgMgTajwk3U2C0i7oJEtbBMNJ39YP0YWgmM6yf9XrjjBtapx0eQ1JfGG
 dk7Riq4IhGTM4HZ/ocUmEc8dhcniKD7mQgw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Jg6NGugayAxV for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 16:37:34 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpZt05KG9z1Rvlc;
 Wed, 27 Apr 2022 16:37:28 -0700 (PDT)
Message-ID: <eeb86052-399c-a79b-32ab-1ed1b2d05e07@opensource.wdc.com>
Date: Thu, 28 Apr 2022 08:37:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 04/16] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
 <20220427160255.300418-5-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_163738_246103_13F176FE 
X-CRM114-Status: GOOD (  32.90  )
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

On 4/28/22 01:02, Pankaj Raghav wrote:
> Convert the calculations on zone size to be generic instead of relying on
> power_of_2 based logic in the block layer using the helpers wherever
> possible.
> 
> The only hot path affected by this change for power_of_2 zoned devices
> is in blk_check_zone_append() but the effects should be negligible as the
> helper blk_queue_zone_aligned() optimizes the calculation for those
> devices. Note that the append path cannot be accessed by direct raw access
> to the block device but only through a filesystem abstraction.
> 
> Finally, remove the check for power_of_2 zone size requirement in
> blk-zoned.c
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c  |  3 +--
>  block/blk-zoned.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 937bb6b86331..850caf311064 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (pos & (blk_queue_zone_sectors(q) - 1) ||
> -	    !blk_queue_zone_is_seq(q, pos))
> +	if (!blk_queue_zone_aligned(q, pos) || !blk_queue_zone_is_seq(q, pos))

blk_queue_zone_aligned() is a little confusing since "aligned" is also
used for write-pointer aligned. I would rename this helper

blk_queue_is_zone_start()

or something like that.


>  		return BLK_STS_IOERR;
>  
>  	/*
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 1dff4a8bd51d..f7c7c3bd148d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -288,10 +288,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!blk_queue_zone_aligned(q, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!blk_queue_zone_aligned(q, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> @@ -489,14 +489,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  	 * smaller last zone.
>  	 */
>  	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zoned device size",
> +				disk->disk_name);

The message is weird now. Please change it to "Invalid zone size".

Also, the entire premise of this patch series is that it is hard for
people to support the unusable sectors between zone capacity and zone end
for drives with a zone capacity smaller than the zone size.

Yet, here you do not check that zone capacity == zone size for drives that
do not have a zone size equal to a power of 2 number of sectors. This
means that we can still have drives with ZC < ZS AND ZS not equal to a
power of 2. So from the point of view of your arguments, no gains at all.
Any thoughts on this ?

>  			return -ENODEV;
>  		}
>  
>  		args->zone_sectors = zone->len;
> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
>  	} else if (zone->start + args->zone_sectors < capacity) {
>  		if (zone->len != args->zone_sectors) {
>  			pr_warn("%s: Invalid zoned device with non constant zone size\n",


-- 
Damien Le Moal
Western Digital Research

