Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7E0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hfy1sfOnu+JkLj/hjcCzSQ4HMfHRx72LM92lBEqRgi4=; b=GvaEgR4VfGskzjJXjElAA369oD
	YqY4sz0wFkrB6AbYb/v7RHalmIUVo5l9tbM2ZRaXKVpA2WVGNrMH0/aqqLe3SqGeDy/gZ7yu+ddoI
	BA8AmzOaS9//ytiVRXEwm94QPTi2j+HOWnbHCl3ccF+Ut/c3zOfT5rT85kILaWK4LnXMRh1G6K4So
	uF5RFt3Te7h+YGCygWPcvjV149OVG1aYB8WS6r/K4nR5+3QdXK7S4V40GO2B3DAq6SLY/J28NJL9e
	HzYYUCsisN9fdV1B+AgJYRnLUpW37kq78920PA0RO+Txr2EvL8QytOv7HNNzt73jJUZzmVkavjBbk
	zdZYjlmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Yhe-00E9lD-N9; Tue, 05 Jul 2022 02:54:18 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Yhb-00E9k6-Qk
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:54:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989653; x=1688525653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DgyUmRlHS/Rk0yqEUio5fJI7r/pAqiGKnmFyxkXId7g=;
  b=STBVaf4r8lpCbghC1LaHqr55P4q+bJ/ER7AiLRzIm4iyINgELTFOaTDK
   TfJPS5+Sy2EINFRg3nETKWoWaNmjIEjtAymQhlvQT4hwTzd+C2m7gg3SN
   3dd7bJgTjxKYqMcnY0/po3DJZlDNOTS56Zv2wVgFFjb2aMUFQQeC4lj5E
   sW8UnaeQVEm/OW1XJLDZGhFoHJjDZjoC7gT2TQHU2BZdl9fejgb0Wx6RU
   2k95mT78cgmw8S8UYCQmKn4NmqIyHam06/cn6OCRuR4DbmWppFN/gCyyd
   ygH5AU24/spUt6Hk6muTGHVQd+UOewaEpOg2yoJjkXC/AaIy21/XmNZ0K
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="204808227"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:54:13 +0800
IronPort-SDR: WAH2d6MW7zuN7s/F+3ZmeeKtP82xeyey/yVgtOg84qeQV7Me1ryePzlH1KopkUAfzzaWih18uK
 x0LOl3jjRGXTHq6D2mreW507otEhDnZ0U0zmdXKhan8Y6X7u8fCpvbkjLE55N+TwvvyIHaTiO8
 MSWnuQqeSnRUpjKL4GKFZC+0/4/bPCCRE/hZgxqwIq/JyUdKEqV7Rgxgy0pubM43VkNNZsD9qa
 +qyFQyNnbBGX5jf964FaP5VYzOL8vIBT/Ooc0D8583flFaJXzTYANWyzOQ4KnfGoYoVdjRUtT0
 kNo20Z1ll08sezrymBcXBUcX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:16:06 -0700
IronPort-SDR: IUJ0PClgUcbLJmFiVUL/xgXniTxaeEbtRoGE4TFE7LA+tIy1lz9rLrWwA63aQLDWY3RH1dfr5Y
 YTXInBxqvcA67mQMnYsQxy061f0i0fpbhSIVoRQYiFWCEiV9U6ZoWlQvTpxPBEqLqEzMDUXcoK
 bAIaBW8Nb0PjBx74GUktOXVzSqkZKSCNH0CqCUnZbv18TopMT0jHwHm3muXkIfOk4yEOH5zJBD
 MYs7SjQ2R9K+992Vysb/dL6uPhG7fIaxjbMcRNihGTNrjcX99akUTDBdZSYUbrz4ohwd+aNnZM
 NRU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:54:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcS1f5GPPz1Rwnl
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:54:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656989654; x=1659581655; bh=DgyUmRlHS/Rk0yqEUio5fJI7r/pAqiGKnmF
	yxkXId7g=; b=ssZPPrKfdI3B1LfXHffYuj+M/OzJTWGgAj+yXV7CgWBCe4Vd8QW
	NmimtYJGUb6NMvBmAhWOcPPLx5IdEN4g1sXCyrq8gdpejaspZRFr3UIDe6aV9zGj
	EnFmL+QLdrq1qgpe/SL1scm5nTRiM86IgDxHV7TcUp7Cd6bTdIB2ZmZxKNohIQQP
	6XE512Ms43V2EE+RVs1M0If4Mp7cB9Bzmn7KoxhyK15KeP4t7QXUEWfSaAsI22D3
	bZybmwOKVfX9aaqVVnWc9cdAggHv6GuFn5pUpklufGxO/5upoGeilNcuHtvyC5Yl
	HDFHCQuBOFHqxHlukt3K2L/0oQAO9qphoyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Lrl8uGBDW5OO for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:54:14 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcS1d2xSKz1RtVk;
	Mon,  4 Jul 2022 19:54:13 -0700 (PDT)
Message-ID: <95cab434-b11c-fd49-5b4e-5e80b5850030@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:54:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 14/17] block: use bdev based helpers in blkdev_zone_mgmt /
 blkdev_zone_mgmt_all
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-15-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_195415_918747_26A8BB02 
X-CRM114-Status: GOOD (  19.49  )
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
> Use the bdev based helpers instead of the queue based ones to clean up
> the code a bit and prepare for storing all zone related fields in
> struct gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-zoned.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 836b96ebfdc04..ee8752f083a94 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -190,8 +190,8 @@ int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
>  			 gfp_t gfp_mask)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
> -	sector_t capacity = get_capacity(bdev->bd_disk);
> -	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +	sector_t capacity = bdev_nr_sectors(bdev);
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
>  	unsigned long *need_reset;
>  	struct bio *bio = NULL;
>  	sector_t sector = 0;
> @@ -262,8 +262,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  		     gfp_t gfp_mask)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
> -	sector_t zone_sectors = blk_queue_zone_sectors(q);
> -	sector_t capacity = get_capacity(bdev->bd_disk);
> +	sector_t zone_sectors = bdev_zone_sectors(bdev);
> +	sector_t capacity = bdev_nr_sectors(bdev);
>  	sector_t end_sector = sector + nr_sectors;
>  	struct bio *bio = NULL;
>  	int ret = 0;


-- 
Damien Le Moal
Western Digital Research

