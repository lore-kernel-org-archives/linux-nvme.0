Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8966FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oNiYszQW/TQfBic+mGxHxq1oJXjEvQcX20TEEkP/Y1s=; b=xXTj+RKMU6tqm/0gkdc7e3TdaZ
	5otI87B8XemAzEIleqgIjBTrnvVpGLAAv9iVfqO55iC474oK5YYxsKCIf1g059u8jzRXTYsWgWDl3
	A+8H1RmN8PqNw1l5dl22dHdJnHKmWJWEK3LmjsJO8wpVL8ma2AsOSWvddGHbptOTc8LYuVNq0T/Ak
	FKaPcq0ocntBCxhGbC18XJQ0fIuu7aN5yLK7izMWEPLhdHrDCJjqGzK0373GBeJKpeduDOrue7//v
	XbHNs0LWvyN+ZAX08HtyRcT35A+4f+BtTkbraniXvuezO227o1VgO/Mi7g69QPMt9ddZfXslLUFNZ
	vO9Bf7UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqbFZ-0088Nt-Nd; Mon, 16 May 2022 13:59:05 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqbB7-0085s4-GU
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 13:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652709269; x=1684245269;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xnJmZYtrUHPz/1pW+2iKsxdcyh17EmGmxKC7iEmOkHc=;
 b=d9e789STh5dQWVsE5F4kz2L/z1GZNdmWurbfZ23UVK5tJq9deKqW29zq
 rSbh0cuqnt66L6PubYADZ2sbbiGmQbCGS8pn0VJRAR7FRuKnZ4n4LZNAR
 fMnom/udq3dGHiccoUdKlbrwDnBsnY8x+hExDk3PmqBuUniQpZlnSLFJx
 UjoP04tXw8FK3fT26pdndj+DiZh5wlVzNhZwt8vxBUYeCRwOepIP8QGbL
 9V4EPaGH3BDfopljRhYWBK/QgGLZ429IHBbYQpaRXeZXZoVtVt/CpsZhq
 AXsBheNG55gdrx3HR124rDUqYbm4v915PqaZ9aaF+V0Qa0NK+ywEr/jf5 g==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; d="scan'208";a="304657531"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 21:54:24 +0800
IronPort-SDR: ia/ctxZ1vWKqyhSC5vAL82dX/CKw6H+phuxHNs+j0TdUYswgLXNhU6xFGoAkcY2rCp2oFxdHCk
 T4D4ER+IqGk/T7Z8QBbC8fnVzHp/0XCKYbKJiryjXEryt476EBj9xg/TdOq1+g9JSI2X6vqZKG
 Cum7hptmtjtwikYRtAhv3z6fdZvebRB8gs/ExqLVUjQ6k2gZtB6oaY4twqvXAh3vdvUrg1iKK9
 BC2al3MFLSez9ysTk9oRIOJfyQfeXAa5XSfLFwRM996HTpXTAtnp9AURJh9idsnwKrhNJdA/Ww
 Yyjh9gsTULQOUIMTFdtP39ek
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2022 06:20:03 -0700
IronPort-SDR: XhRBloa9ztFCTet3pDl6uWli8OWcy9aS4DYzr6QOZThjCKTPc7xfpkPueto+P4RJ9zku+tJxEP
 fEpat0DPEPqTTqsSS/bSM5QuFLqQXx9bUFpS/z12D2UKYgP6RRRVtypKD7A7ru8TKBpKXldymq
 hM58AvIAABNdyCYN1fEOt7PL0+mgFVNVXzIE3RALPwqFjBOg37H8xpPluUryZfEuxaYKJIfHOK
 mbEZ861RO3uqAgsiJRtSI4id9pR8yjDk/QdktFTk3JtRajKYEpSO5utWy0XEq8sNk1XrUcZMkX
 OfQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 May 2022 06:54:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L212P0T0Zz1Rvlx
 for <linux-nvme@lists.infradead.org>; Mon, 16 May 2022 06:54:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1652709259; x=1655301260; bh=xnJmZYtrUHPz/1pW+2iKsxdcyh17EmGmxKC
 7iEmOkHc=; b=UUHn+1Vyu14CMfOaCMgXraCj/MTu6WqTYOUVrT+4PUwPlX5ziiU
 pSIvphH10gCc67fVq3XGywhvUeUqkqYl3C+JIeYNZL256XrllrM58UhqzOZaujF3
 cbmBklJPJrOqfUwuSurt8JpO1UwMmikJGH4hvh5Qwx4pN/E2XnvxaPmNybMpFT83
 xSpG9RchPPentNTApEt/m2/xRnaVgRJJKjnepi11fq5V05sUwhnpCcvU0f61+fwA
 S+fDCn+IEtVKy285CWS8em7niz60i9Y+TCt+uHgrHXnSyVIC4Q8Mw6/XAy+RhYGq
 bnKvHkQ9zRQTWYTH/DZejGfNQWFm7h+DJZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id G5we2k-qX8aI for <linux-nvme@lists.infradead.org>;
 Mon, 16 May 2022 06:54:19 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L212D5R0Cz1Rvlc;
 Mon, 16 May 2022 06:54:12 -0700 (PDT)
Message-ID: <487c9368-36fe-25ec-7a76-f6aa50c4d3d5@opensource.wdc.com>
Date: Mon, 16 May 2022 15:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 01/13] block: make blkdev_nr_zones and
 blk_queue_zone_no generic for npo2 zsze
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
 naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com, snitzer@kernel.org,
 dsterba@suse.com, jaegeuk@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 jonathan.derrick@linux.dev, bvanassche@acm.org,
 Keith Busch <kbusch@kernel.org>, gost.dev@samsung.com,
 linux-nvme@lists.infradead.org, Johannes Thumshirn <jth@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 Alasdair Kergon <agk@redhat.com>, matias.bjorling@wdc.com,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 dm-devel@redhat.com, jiangbo.365@bytedance.com,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
 Chris Mason <clm@fb.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe@eucas1p1.samsung.com>
 <20220516133921.126925-2-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_065429_685939_E72E7170 
X-CRM114-Status: GOOD (  24.87  )
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

On 2022/05/16 15:39, Pankaj Raghav wrote:
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
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-zoned.c      | 13 ++++++++++---
>  include/linux/blkdev.h |  8 +++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8..140230134 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -111,16 +111,23 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>   * blkdev_nr_zones - Get number of zones
>   * @disk:	Target gendisk
>   *
> - * Return the total number of zones of a zoned block device.  For a block
> - * device without zone capabilities, the number of zones is always 0.
> + * Return the total number of zones of a zoned block device, including the
> + * eventual small last zone if present. For a block device without zone
> + * capabilities, the number of zones is always 0.
>   */
>  unsigned int blkdev_nr_zones(struct gendisk *disk)
>  {
>  	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
> +	sector_t capacity = get_capacity(disk);
>  
>  	if (!blk_queue_is_zoned(disk->queue))
>  		return 0;
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >>
> +		       ilog2(zone_sectors);

Why the line break here ? This fits on one line, no ?

> +
> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>  }
>  EXPORT_SYMBOL_GPL(blkdev_nr_zones);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1b24c1fb3..22fe512ee 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -675,9 +675,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  					     sector_t sector)
>  {
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +
>  	if (!blk_queue_is_zoned(q))
>  		return 0;
> -	return sector >> ilog2(q->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>  }
>  
>  static inline bool blk_queue_zone_is_seq(struct request_queue *q,


-- 
Damien Le Moal
Western Digital Research

