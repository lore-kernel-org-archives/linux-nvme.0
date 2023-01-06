Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C6EC3DA7A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cbq6rYLi6BGsQNYw1xn9N0Gtoa3rFYqqUr6eHvvcb9Y=; b=ucM49ZFcKQ6hmbgkyN9VLYPDVO
	RaHNxrQYGRRtolmRTH14IskO1Wa1EXPjzRTtFXnbTsmrT/BfBYdJTCaX/iIDICOn/Cv1aIUZbAGlp
	+otUgFXfudkPweDKYbvDN2zUN4rDHXedOV4ClBykHEJa6JvTrcI0YJ6kxXg0NybrqBLRBPxircQB8
	e3uDzhgPXC6ztgCwoN+tRsq6EDwPTOdChImwRiRqr5+HfWzy3ESdrhvIwg26ujyxKt++xqf3Zghlp
	kaNoRncOpobnie00m6E6IRzgEuZ1o2KRQKuTVLsq61W6p5QFHP+SDv2v3lGfXlHvinOgslrw/89Kr
	ermoryZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkSw-007c57-AY; Fri, 06 Jan 2023 11:00:50 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDkSs-007c2c-WA
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 11:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002846; x=1704538846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dzMGYcC76vsGLcqnozoVnvpsbbrZPxZlS6l3+6NEWPY=;
  b=a1jbAWUvOaDSWCXwKz6CEMP9zaqu1cWi1LvXwt6zvnwvPto05ztbV3fG
   aBYbu9FrjhZz9icYaaYGgH7hFNE09TcxR1qX1O+xVSmUJ08VDvxymZh5F
   bMXtIDhzVr4sWLX3bThKCSbQ0f1xiAd/Pm9QROKOM+/Us4WuayDk3wtFh
   05fpYAUJE45SxN3yKsrQd0G28qzCHXqlpP6unfKaggjVGJJRZYMQdxKDv
   yjzEqTNZw90xgB/D9mCVCMtsnA0ad1r3pIVQurs3jIBMA4paS/ttgc4AH
   vSWBKJ+uCFBZbc0AvdjaBy3N99iouaosv/8/dS1RFYQmmDDmiFLWSZv2K
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="332176755"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:00:43 +0800
IronPort-SDR: Mtc79hBUq/XX4xJWdVnAznB5wzON5xY8grh0DrhHWXnYpJfzsoeKuebEe7tb7nXsvWWVGaNJQQ
 aff37GO+u8NY7Nmyu73xu5g1RP9Fzpeo1KAn++dg62U9ceUh8pSZIAQq4i7nLELh++xmW1nuYE
 TE+WItRz9gLjHBOo7+Lm4tH6ztI8gFDXIgsVmD7dwtTMrfa0BigdkCxWY0cI99W9Fczf2b9ztr
 p4bQYc8JWCXaVmydbFtnafIJjx0oNsutgCaE9wXE5QVs/QUk76UB28rYOhzm7A+ZQcN27BoD7u
 ads=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:18:38 -0800
IronPort-SDR: ro3KkYMi8OB/atMQRr2cv6556kdY8EvggXJ3nt+zT3sdZu2+TnpOfb6mwy+wFROF6Tw7vAYzTD
 v5sI/aWUtU/2dtQLAiF+/tT4hG43DIbwiO6vQCnfdufX5IMvh3qbtGGFvGoUVPSzqLaHSR6i+Y
 Yoi2LPvOAzy0x9Q7l0u6dfiVf1Rl4XFYBzx2pq+vt6pbNugKw4by1p0TPzjfbRsERa0PtA8jWC
 nrbr11NHXKw0pAKU5NKXyTqha15EcMiUuGaRwHR5V+KzvOOpsKACqEpbHBjXNJIJLtAcKM6FhP
 LQU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:00:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL3b1Jf3z1RwqL
	for <linux-nvme@lists.infradead.org>; Fri,  6 Jan 2023 03:00:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1673002841; x=1675594842; bh=dzMGYcC76vsGLcqnozoVnvpsbbrZPxZlS6l
	3+6NEWPY=; b=bI2spnR+FSiaJZD4rCqOcAS5ZC4aFxAg5nxQYH9ZyzdPB6qzPqK
	qJl9DAxhBKDWf75kvgRz6sFKhkvGo50dpTfOtfOw5I8MQXCgPtZvgnoa/XgMBmkC
	wJHygiz9VZ/Az5WOlI3Sdx7uHm/Ao6zAZDxNQktjEiG78uC3st3QbwZQLWOukKxZ
	DUDsw4M1M3dbDDQNyDNtaAOQjAiUl5Sw1+bS5x7hERVnVcEQQFO1JwIP8BGbgppB
	FOg+lp5YUtPl5ESQQVtmFQMXdwq9uWaQHrrW3FyDCmkFvGTM0kyzMmxZI6O0eUPi
	Qtj2WFVnjNkfsy2c8K9rcPVMSkjP2XxaCmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kl1Y8RH-9L3t for <linux-nvme@lists.infradead.org>;
	Fri,  6 Jan 2023 03:00:41 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL3X00tLz1RvLy;
	Fri,  6 Jan 2023 03:00:39 -0800 (PST)
Message-ID: <32aaa034-dc39-75dd-f4ec-e0e5ef9dd29c@opensource.wdc.com>
Date: Fri, 6 Jan 2023 20:00:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
 bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com>
 <20230106083317.93938-3-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_030047_121527_EBF857BE 
X-CRM114-Status: GOOD (  23.30  )
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

On 1/6/23 17:33, Pankaj Raghav wrote:
> Instead of open coding to check for zone start, add a helper to improve
> readability and store the logic in one place.
> 
> bdev_offset_from_zone_start() will be used later in the series.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c       |  2 +-
>  block/blk-zoned.c      |  4 ++--
>  include/linux/blkdev.h | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9321767470dc..0405b3144e7a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -573,7 +573,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>  	    !bio_zone_is_seq(bio))
>  		return BLK_STS_IOERR;
>  
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index db829401d8d0..614b575be899 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -277,10 +277,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!bdev_is_zone_start(bdev, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0e40b014c40b..04b7cbfd7a2a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -715,6 +715,7 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
>  	return 0;
>  }
> +

whiteline change

>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return 0;
> @@ -1304,6 +1305,23 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>  	return q->limits.chunk_sectors;
>  }
>  
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))

this helper should never be called outside of code supporting zones. So
why this check ?

> +		return 0;
> +
> +	return sec & (bdev_zone_sectors(bdev) - 1);
> +}
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;

Same here.

> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}
> +
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->limits.dma_alignment : 511;

-- 
Damien Le Moal
Western Digital Research


