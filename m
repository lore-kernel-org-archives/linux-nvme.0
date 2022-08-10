Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A39C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5fitZb6WYX8CXf1V0pqYnzRoZUlkQ3gSYOdPD4UNRM=; b=zg4iKfLVMLSbTQz0umViweGEE7
	hqwqBoSEjhXo/mV3SpGngeXVTvB86iRf/WmGDi974Bb4DcsPg5/Ezedw3mIyZP8Vw8BZtrAvq4VXs
	q08Wp+XGL0PShe7lHz43+Pdfx1pZOPh4n04yZazvELSkfqLumjPUUKTs663CbgrgfEtMQoEjhFsKP
	daq+MXxaWE1MxAoWCW9qOs1yHPhze4ideWg8SV+7G4dBkXeh/tVNXWgdj9EKO9OhdkbVGi6YwojqJ
	VAESAlR4myQeKjUcxX9GRvR+beAe2ijXqJZWBW69Pj/shs7o/gMugkleQN5JtHRj0uHkclVBmVbaS
	geuIhl8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLoub-00D3Kk-J0; Wed, 10 Aug 2022 16:50:30 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLouW-00D3Cs-WB
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 16:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660150224; x=1691686224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MPhBPhAk4HW37DruWZIta9vgWfqSrvKcKI7Hck6kxrg=;
  b=CcpJ1wcR+Bae544V9z9fBdAjO1HPC2VCNpjiZSJbMl8kRY7NMp/Lb7Ab
   r1GCiBzj6HS9sMiaP3mfy0fD4w1gL4SORfbozQglTEqQQ9y27z6ssMmpo
   W/lEfqpiUkXof/IUOOS0Z5L70ME3xdgFMSJnXmvte/sTr5QB45AIdLdpF
   YCyNqWecAxKnM6TprzZtFgRnjbRduyNWnkYbsVMMZo4suMiQ/9I79+BTI
   lq77yI+B8bQ59FpLDMVYQN+7DswBRAhs4+XGFh9Oy82x8jX+oxqubkFnP
   sijzED4FaVLElC4qsVIrtFsN5T99sghVGCestnTKXFNIDrRAEP+7uk5aw
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="213382755"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 00:50:14 +0800
IronPort-SDR: 4JLDRAdUwDU34jFvYPpC6iQ+fjdb06VeXjijBjHgDFHbqBe00kFfsRTk/mGnK9H+hi/fCvh8ae
 LFWBqYRZSqYMemIL8X6AHFqtJF7e3IxI+Pa3x23litQD8yq3xgLUNQDLwZR19g63chxBm5B7U3
 hyMGGJkIP+/JTwGH1ZQKtr+xNeoOu83liPCQWa0pNzE/KD1HurleInzg7rt6Y3EVze+w8bq7XK
 EmmOOvczId5YVTXU5Ep++lc4kpfq7Svb/cscG/w5Ihr/X7d8QxGpE8d1x9ASQq1CZnnV6nueji
 pBSnRSBzIY5GMNP5yxd8eIt6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:11:09 -0700
IronPort-SDR: gc3RscKwPtaU7DhHE7Evt3gpmmCY/vhDlbHkrFRnjbLAs9Pq2eMdivecUwjlfv2mo+lGQzjuB2
 cGqCZ7TDrrsdOsBi1YNyK66oe2p3+qOqJ5ZvhAKIlU0MTz5QRkWe0A+SXbYd15hKpZd4YDVZtz
 GvzQLluGtrns4o4goXyH5rtTDgklk7K70DTJlwSLC5Gy10Ht3Lc1SbKqNfI3KLVUNWnXxTMiPm
 fdI7JMYOnv4/kKXnqXl6gG0C46+o6CUCQhqXhGcv+iXalnbDPLe65HvgYz6XcK9G65EUY/TPEa
 yZI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:50:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2wsd5SDWz1Rws7
	for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 09:50:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660150212; x=1662742213; bh=MPhBPhAk4HW37DruWZIta9vgWfqSrvKcKI7
	Hck6kxrg=; b=Hus+eB7k8UsnGk3IrIrjCE803v/xkjX6BsuABSkqcW3s0ul8lt0
	Z/JpUwIzXwz4s1+dDJELUqxf6Kd1b+InfY59QBO9Wj/h2ODDQIsphLl5y8jYrqDe
	Y+13rfSUz26uDXpAgSZysJQBgAcIpSF60W4xbva8IBIb7JUaAfGbFDIv4KgL2mcE
	IL4IS1hxRHtu356kOnM0+AxxCNrReglKYk3AtQApx4NvwIdwk3knKGJoFX0xjw+K
	LNmhTt6/TygfFwH9uAesFy1U9pRnvXMwoJ5apvOALGePuIH9yvYKCNMReClcM9wr
	1+IhP8ZvTdrEPu+YsIpXAOkKFxaEURpZD3A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g9_SwLeZ1AWC for <linux-nvme@lists.infradead.org>;
	Wed, 10 Aug 2022 09:50:12 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2wsb51npz1RtVk;
	Wed, 10 Aug 2022 09:50:11 -0700 (PDT)
Message-ID: <700a5080-aea2-1a56-6bac-bebb03be8b47@opensource.wdc.com>
Date: Wed, 10 Aug 2022 09:50:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
 hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 bvanassche@acm.org
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803@eucas1p1.samsung.com>
 <20220803094801.177490-3-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_095025_215558_A8D8C536 
X-CRM114-Status: GOOD (  23.81  )
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

On 2022/08/03 2:47, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 48 +++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ab82d1ff0cce..22f97427b60b 100644
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
> @@ -666,6 +671,25 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  	}
>  }
>  
> +static inline bool bdev_is_zoned(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return blk_queue_is_zoned(q);

As noted with the comment in bdev_get_queue(), q is never null. So this all
could be simplified to:

	return blk_queue_is_zoned(bdev_get_queue(bdev));

This could be done in a separate patch, or here as well.

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
> @@ -892,11 +916,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
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
> @@ -1296,25 +1315,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
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

