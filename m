Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11A7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ymm3wyyQU/f98UpsMV6/TYOxxEyJJf95N3d4ZYbGS/U=; b=B0WhkrGLLkVCBH5pP4kk+btcFH
	xGjl2THmabTxbuNrxS5nMZK/gJ5CnWbFisjfLP+BVEbZ+H2Ao90A6PLKA1UoiuRPTu1CS6g7s+lkj
	VxzaZYTmwmzTS4LOogYSPimBkAsQQ1xifLJNcAU3lU0AM5ctf98UF83QZk84r+80eiide6VOkKGoU
	lGYLMOHY0B6P7sydyEey/+Fn9bMN0JF4M5FsMzqk/CrXXSsY2qUXUeStUPMqZsokkq3ZhwVDAaCOo
	eA6KMiVPbSCFpTlLpGu2rf/ddQcmOw5sOl87ZwxR8s5oRrMhkYIfExknQwDCt5CHWcT4LIeqi+uC9
	aAU7t5tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YWy-00E5ww-F4; Tue, 05 Jul 2022 02:43:16 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YWu-00E5tw-6U
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988991; x=1688524991;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7LA9SQImgeYrqqDEiYiBB+QWxnWC2bVZYdvpTVv3KnI=;
  b=WuXsIyMrWR/NYSeQCtQ6cVOHudMIXSiP+0Iise/aF2Tm+K/u/V8tEzWU
   cJ8DDUi3vcCBlyN16fPPZgt4ZjzyArMi2H29RlrgHplUNdsBkFcX4R6DM
   PkBHy9qREvA7QLgkzoUZXsHitel+/llJ8qxXwMOMsa3/bzvKsF5oeC1rO
   xQl3XmprxYN9h7ects8WjJQ4F76VwuO5a7Ev409NqMHFtW6bsVYtQzpN7
   RSYew848fi52bCAk3koI7ltG1yzPdXMVrsGz/q9mJfWyymss3hWCnnzCT
   +VeH5YM3VvNAuYqSgIkL73F3BfVwXhNeWenMiMX7exRRsbK/ZVbHqazru
   g==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="203466930"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:43:08 +0800
IronPort-SDR: pJqx0b7Svm83Fm4gKPr93I5fZFvh8m8Y4VsVzjzx+RC945GsOHWEV+KPxl4kJLsEk0b5CDmz1L
 wmyA1vjt3tYChBrADM0jPDRlPs25D/jS85JCatonDximxUzPwkC1DOx5/Xm3QIHCy6KhyQdIQk
 6gWY6sJw4nFgp72TQ+dJ9dnAMVhoTKsnoECxsVU57V7euFuCiyfEFQkcWdmc8LIovIHavksvdH
 ZEiEddoAeLS9zEUViY/nT3uqmiQvR6rABKNTfPYKfJ4mWBa9MuOsxtXjI4QpjIpBc6b0/1SBJc
 gSVnSzx1tnRCNgho+k9vxtaa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:05:00 -0700
IronPort-SDR: SNWudiBVTydVURGGNyx/w4y/p4jFOERr2Cikfcm12S8RVobWTXUqFH43HSg7gNMCQw++rAOGG+
 cWVGKfi80mG/DXGuFEDvJN/V/Yxq+L21Hh/WWIAiU4zqK+J8k2kfusn8j8RP0ayUwbWZH/6KoX
 Sw+OTEfakrmAZ2TbPYqS3mgQC8vST4MzpnBEBGFu3KM0Q+TXWF6vc/MQhpi0iHNgko2W3p3/+G
 7vlWzZdKomwJJFOuGV96wtwI1P4Zix8Rv7OGUC+9yOWVVJAmC6QrOYpC/5fs+B2KpgA8XslEw6
 Q8U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:43:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRmr5ZWbz1Rwnm
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:43:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988988; x=1659580989; bh=7LA9SQImgeYrqqDEiYiBB+QWxnWC2bVZYdv
	pTVv3KnI=; b=a+QizpO/JOniekL0zkhYaUKKg2JzJkuBuEsVuklvHfyJ5LPxDlL
	rHO5CeFx+nzK2UkFmSpLX+IJKTSBALvwSYxQsXB+B73v04PLPpekm1+lrpwKuwJy
	38v88BUd8yxIwJyM96Ornr0z3ziZTsB43FDUb9RZule4IU8YfpCl9l5uUVkUQVd2
	PqTZ8RZppuqN1+xIGy6Xl24CjojBD3gIPOX/5YIllqINM+YPVYlMifLZMoUk/CYv
	zIjH/LcGCueZaW0hVKHz6X/6oE5CWLUqqWjQkHsO1MBOxJT1vAv+uWP4QIGlP1Yp
	YKlN3v79AL+lLZAkd1esA/eecOgqvoNKOeg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7QiOU-zmbPFe for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:43:08 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRmq1bd3z1RtVk;
	Mon,  4 Jul 2022 19:43:07 -0700 (PDT)
Message-ID: <c8f470fd-be57-8d04-cce3-30c4701f8864@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:43:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/17] block: remove queue_max_open_zones and
 queue_max_active_zones
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-12-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_194312_370624_798582B8 
X-CRM114-Status: GOOD (  20.85  )
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
> Always use the bdev based helpers instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


> ---
>  block/blk-sysfs.c      |  4 ++--
>  include/linux/blkdev.h | 37 ++++++++++---------------------------
>  2 files changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 7590810cf13fc..5ce72345ac666 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -330,12 +330,12 @@ static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
>  
>  static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
>  {
> -	return queue_var_show(queue_max_open_zones(q), page);
> +	return queue_var_show(bdev_max_open_zones(q->disk->part0), page);
>  }
>  
>  static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
>  {
> -	return queue_var_show(queue_max_active_zones(q), page);
> +	return queue_var_show(bdev_max_active_zones(q->disk->part0), page);
>  }
>  
>  static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ddf8353488fc8..a14cc3e46e6ad 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -704,21 +704,22 @@ static inline void blk_queue_max_open_zones(struct request_queue *q,
>  	q->max_open_zones = max_open_zones;
>  }
>  
> -static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> -{
> -	return q->max_open_zones;
> -}
> -
>  static inline void blk_queue_max_active_zones(struct request_queue *q,
>  		unsigned int max_active_zones)
>  {
>  	q->max_active_zones = max_active_zones;
>  }
>  
> -static inline unsigned int queue_max_active_zones(const struct request_queue *q)
> +static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
> +{
> +	return bdev->bd_disk->queue->max_open_zones;
> +}
> +
> +static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
>  {
> -	return q->max_active_zones;
> +	return bdev->bd_disk->queue->max_active_zones;
>  }
> +
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  {
> @@ -734,11 +735,11 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  {
>  	return 0;
>  }
> -static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> +static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return 0;
>  }
> -static inline unsigned int queue_max_active_zones(const struct request_queue *q)
> +static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
>  {
>  	return 0;
>  }
> @@ -1316,24 +1317,6 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>  	return 0;
>  }
>  
> -static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return queue_max_open_zones(q);
> -	return 0;
> -}
> -
> -static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return queue_max_active_zones(q);
> -	return 0;
> -}
> -
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research

