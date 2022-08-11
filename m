Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD32C19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 20:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yx0sXs+fqW3ZiCGHdLumT5h4ryWNLeouddLY2sQoHBE=; b=Q3xJGdGhWgbskwtEYjnpODY0vE
	3S4n5xYTZnxbfWKfeKJBvRbp6OAHfZcfv9yuziqW+rtlnGKAycTRrK7SKlVv7/gnLfJtDT4ZA16Yn
	Ex44vgT+6twelDtLOrjSZyg60+JZtD2I1TDLTXg0PT8Vo72KHGsEQdi9agwcUodX5b+pNPIdiBOvi
	QatJ1cjls9qDZMeDCNatZenV4g4bqDdb2NNxdHBoJwVvKE7k1pSkEY7+QQlK9OkF9CzwcecUcneVg
	HweFR8ZMTIHTCKvDPyeSflJ6E8fD9iuCAFSbBHT1gOPmsICJBCJKVB0SrfI0zNiQggAS70+GcocoX
	JsT1lEnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMEgt-0052wv-IU; Thu, 11 Aug 2022 20:22:03 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMEgo-0052v4-8q
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 20:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660249317; x=1691785317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PaqvzZxRcEr0+CT5UB15A08/nBKKsFBZ3mGE5lOTL8Y=;
  b=gMWNruleG5ze7a3isUZKWx5nhWX8FrdCb95SsHl3ogA/6WWQujg+vUrw
   O7di5DjDYGqvrv4NnxcKbaG5dPf0m/1NJtpEIkum81GzS+TvIA4XR1gpS
   3Vrsvr/HnzrUM7KOVr8UvthFDcYp7k73QZmEbMhHJxFBn7bPOQIdVaWT5
   B7Acptz3CSH7DUMouFPj5tDoCTeakzRbRROK2moyXehJwKO3LzWshn5Wd
   PTCVhNk+IhNkwenpTlwNtQHqlk6dPeoMyLpZNijzJ6Qc7ZDQaDICOyz6M
   xkJJn0bPE8GXQK7+cJlf6cSBWVLsqjDQYVSCk8zSQvMN+YqnDDU4Pg2IN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654531200"; 
   d="scan'208";a="312766144"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 04:21:53 +0800
IronPort-SDR: M2Bkm1BKITCKXNk3OqbO5Tzx/JLAFedLAcQ9TiLaB5P9d7OuIdSLBRi+UjCryJAq2iCryiaOA+
 8ODN7iyjkCO3YNjcN8QEq+KICJoMJoKJJBPYiLjlRn15dEf0uDyz8nyjP+R0szFrWRZXL771QK
 OIaPPKOk1jDS72fzdJL3OS9qMHgV167uO+1MwZBOcAyPFNEvMyhM7i55/o5PWPrCd2+rUktUYD
 SSXll+pu+UUyI001fYvtaHP1yKsyn/Y5ovDFDlLgCe5DG27FRacTfc+qIcWtRa6MKeEMUJeSEJ
 KGY2k2H4c+sSh7O/ARTdLw/r
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 12:37:28 -0700
IronPort-SDR: 6cASlC7kkThIaM4oM2iH7VEiCSw3e/HaJ06nR8DSUYKVLd3ItId70Rh/YiuH2vBoZcNJweTxce
 JLsPk0q+bW25DIcn4u4D3rSwFyxPhuHdD8RzabFvw80EGrtxQCrpopi141IbNjrVvKmmZ6x34R
 Fpo0NAP+j9uDgR3RI0ojr8YRtrBNyCWXX3Jc1YZ3rWiXQtYa1B9KNy+9US7/mJUk7pwkS9liuz
 u75mCAEeAlNxvLMri8nK0zIaWj6dTcRM9d7ftFgrecWTzbW02JyBbJ3HAYQAvyYJWmEqbQFPJA
 1Xo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 13:21:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M3dWP267Rz1RwsC
	for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 13:21:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660249312; x=1662841313; bh=PaqvzZxRcEr0+CT5UB15A08/nBKKsFBZ3mG
	E5lOTL8Y=; b=AMcmyLVPNlo5pzyagRiH4r92Sm7xf3CA8x5ETJMBefVeitp2S+k
	TQj1Do0vLf7eTEAP0V8y1+THKSI7qtu/qnhS7+5fHNb6mkqgpDGhGSJMhHB3L3Lm
	p4iPyrTp0hH17v+rRTt+VbnKvjB13qVFMjC3wGiaOG3B1FqORvjOv/7jCOwz9lk9
	20OKLzKAtkEFsDY444Pd683BQBOEn0JwscfVczAYSurUzTawP2280vxk3AgB0Y9X
	Js8CEyQvmp6ltWsHaRdhR3bewW4vMkoagfLYpzgrn2TaWHoki3jJ6i7qkHtrUULw
	blBhLkVYb+PHZvm2cMqks8VI3eaXcRRlu8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F2sZa9dknggF for <linux-nvme@lists.infradead.org>;
	Thu, 11 Aug 2022 13:21:52 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M3dWL6qzfz1RtVk;
	Thu, 11 Aug 2022 13:21:50 -0700 (PDT)
Message-ID: <01062caf-6504-f223-b9c2-6543a58f7f9d@opensource.wdc.com>
Date: Thu, 11 Aug 2022 13:21:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v10 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
 axboe@kernel.dk, hch@lst.de, agk@redhat.com
Cc: linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
 bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
 pankydev8@gmail.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143046eucas1p2e49a778cff29476c7ebaef1d1c67d86c@eucas1p2.samsung.com>
 <20220811143043.126029-3-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220811143043.126029-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_132158_458910_BF95B776 
X-CRM114-Status: GOOD (  24.52  )
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

On 2022/08/11 7:30, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
> superfluous NULL check for request queue while we are at it.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 43 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ab82d1ff0cce..84e7881262e3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -635,6 +635,11 @@ static inline bool queue_is_mq(struct request_queue *q)
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
> @@ -666,6 +671,20 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  	}
>  }
>  
> +static inline bool bdev_is_zoned(struct block_device *bdev)
> +{
> +	return blk_queue_is_zoned(bdev_get_queue(bdev));
> +}

You changed this too, so drop the current reviewed-by tag please.

For the next round, feel free to add:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

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
> @@ -892,11 +911,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
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
> @@ -1296,25 +1310,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
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

