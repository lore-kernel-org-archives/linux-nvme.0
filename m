Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA55C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lyBgny2owanKpSK297XC+SuygGQevv1e+zn1E24si/Y=; b=RVDNCk5Lj43mkd2dDLy3gcRsH2
	40T1cZ3sxHtsMUInTtmy1veiL6wUb8pu3bj5yF/oLjp0YVOMfv/DhoPWl7Vo8dhSOSd+cQFT4EmQ2
	+jz0XevAFvkg44VadXH7im1hRy2cvm+tCqtjHFqqd5VxzmoR1bKe9cuGR3vOMpiJ1eC2ylMu4G3dP
	nTtrTSrMVT8YM8iAOC70rz73erkKxsiAW63gv9P75MPQO1qT1fQh79QudoizzNrtVEC1wQgspg7bZ
	eBNfIJlhwH5vw1qnM19MdlSZTh3potDN1JUrLCvRgKO2p1La9poranqOI3dqK0PBrPvLAI9dXj/if
	pb5Yw+uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlvXL-006m02-8S; Tue, 03 May 2022 16:38:07 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlvXI-006lyt-Bg
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 16:38:05 +0000
Received: by mail-pf1-f170.google.com with SMTP id i24so15160194pfa.7
 for <linux-nvme@lists.infradead.org>; Tue, 03 May 2022 09:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lyBgny2owanKpSK297XC+SuygGQevv1e+zn1E24si/Y=;
 b=z1lt34DWLn4nv26way3as5zZS8q+qSK0PBax2Ad6jrfPxpJkY8K+hyF3FM4ZeQn8Zh
 T0hs4rITSGT4b3YYokztS3XujrnBdceqsQBgAg13lGstPYfXo/aA1tdhCCdbNeHtXkin
 z71A5Ec3jb8148mzlYr/HS2eL7fH6CvyZaaM3ZpP3u/Wzm+FtoAKjxe+rLX+9QgYUuSe
 zYfFb1gRnytjM4Y9VFkrdxZia1YFSq++q/lhjIDyeSHpY2xL+OEP8uc6qG4nZErwLHwi
 nz0dKXp8jO5g7Bowgt3XWw9/yn99l92NzO1CwmORuXa3ChNJakz2aOXCL5gWZoTChL65
 7ArQ==
X-Gm-Message-State: AOAM530nPZnaI62z8fbJRkSIcmLeWpj6o2YEodh1de+TIcm5QwtjWeSn
 6Mhrx7KEz9o1rzG8kmqyiA2fFd4mL0Q=
X-Google-Smtp-Source: ABdhPJzonovBzoV4fwi9NXoKhV1eYPIxcI7yjfJw6mLDHLxG6LjY81SsAeWrZCq7zhToKZSiSL9kvA==
X-Received: by 2002:a63:5020:0:b0:39e:5d26:4316 with SMTP id
 e32-20020a635020000000b0039e5d264316mr14532146pgb.294.1651595882292; 
 Tue, 03 May 2022 09:38:02 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a170903125100b0015e8d4eb27bsm6564629plh.197.2022.05.03.09.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 09:38:01 -0700 (PDT)
Message-ID: <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
Date: Tue, 3 May 2022 09:37:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
 dsterba@suse.com, johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 jiangbo.365@bytedance.com, linux-fsdevel@vger.kernel.org,
 matias.bjorling@wdc.com, linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
 <20220427160255.300418-2-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_093804_451509_9103383F 
X-CRM114-Status: GOOD (  20.82  )
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

On 4/27/22 09:02, Pankaj Raghav wrote:
> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/blk-zoned.c      | 8 +++++++-
>   include/linux/blkdev.h | 8 +++++++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8838..1dff4a8bd51d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -117,10 +117,16 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>   unsigned int blkdev_nr_zones(struct gendisk *disk)
>   {
>   	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
> +	sector_t capacity = get_capacity(disk);
>   
>   	if (!blk_queue_is_zoned(disk->queue))
>   		return 0;
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >>
> +		       ilog2(zone_sectors);
> +
> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>   }
>   EXPORT_SYMBOL_GPL(blkdev_nr_zones);

Does anyone need support for more than 4 billion sectors per zone? If 
not, do_div() should be sufficient.

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 60d016138997..c4e4c7071b7b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>   static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>   					     sector_t sector)
>   {
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +
>   	if (!blk_queue_is_zoned(q))
>   		return 0;
> -	return sector >> ilog2(q->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>   }

Same comment here.

Thanks,

Bart.

