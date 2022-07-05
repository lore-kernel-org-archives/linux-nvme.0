Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1E2C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MR3KpzUQ3tqwz08Anz79CxbV44zaWEnQ0yGEzGaZmwk=; b=Rci8CHfveiVe7MgT0UCwmNfeEm
	3A40Q7PhFb1L5N4fsDoIp3vUduQ/f9NL2AJusqKFgIhOjDPbjfgYOYUPIhWuqFpYWKwzMsZlDy75h
	MQGqK65fW7NFP+JuvYbFuSz2cEYmebRjC+ZaX9Ba+zb03198jP6bJOKLPxu24ngp+3K4o/ViymYjE
	2e49ofsRgMmhuk9nK5bGyMYJfXI3XHUifhtsSMahvTIEhf9qsTKeKNzFpWVlZavCwNgM7CTcQE1Dw
	ACHMhOA/hIwsjP7+DD3BLEkKa7Pbq6PtDloComPdghtBkngkkE47NX0igvt7dlSh7Nlf1yWBZ+oAF
	8s3nxZNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YVR-00E5BB-2f; Tue, 05 Jul 2022 02:41:41 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YVO-00E59O-30
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:41:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988897; x=1688524897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0WVOR2kObukyt6P4nHIcCb2g78T5NJG8PZyFdo+kN0g=;
  b=FrIa6XBJxLZJxs+gt/Clszb2UXI3Ho/wws3uvtsw8XL+46caI57HzOZ/
   z8hFKqk7pcHLj4ozJ541W/yf0nS5r7tbwyCOfSjeu+ehTj93P37J7s+l+
   s2b5o4d4Nptaxn9Egkw6bWiTPIHlx0RFGYx3JD7qZUiyz0Bm/izJI04F1
   N0NC/AsSNbkAv/uGZPjRB1yqSMcxYFXKmZVXg3Kso28x7h/THAzdKPWIp
   acQD5WD2XAG/rdztJ6694115MQRynNaJ5sOJDybXdL3jN/mC6+nfFVMe8
   fjJEaq9ZdQov6Cr5g9TO0MkDeClb+6FRESkuzJY3qXEKBMc+XfxAR5NOs
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="209700403"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:41:34 +0800
IronPort-SDR: OscWg13xuTrP7732+JfWIZJUjuwOI9pgxmJYnMzt8toyRbcIvJnTMBmKJCZ3t16pbrzgfZo2IA
 vWuTlSi/BRtzmDuNBdQph5jlEJx3C7W0ec1Q9ryrPI7zbO7cxo8wXkn3p6KScF1r1vlUKy7AWx
 ofdEbDy9JzCwQhhc+oKOY8A989l6shbqmPc0yrURgcQ2oKtzeCI7tF/Pw4NHI4RQGSVQecDAb0
 scHrthMrfq7IldPiySNLlDpSnzvjRHB627xT4xm6vT+PMBdtPg1LXRAl0MN9r0K9BpOM9ZaZxV
 yJyVm3nFm9nPcUuRQrbutHYt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:03:26 -0700
IronPort-SDR: xnSoqFbqNCfQDiF0xRNrMhgHxoo7B6x7ixHa56HwjPsObGW2l73SL+02b6rkceohMw38TDriJp
 mcFwsRelNUB3pru6SNiI7thxDLLnrQB44+VlPcYIHKWOYBZ5GE4M3HVGH43L35LKk0OwkTKztP
 C+adItiF0l9fA8BB6ggtNYmKt8IoX7MSqlXTWippeHUEw8n9lZ6LtI9O68RzjUXb14i38HThg1
 rq1EwlrZd+Nu8EEsGp8U+coDJAhtdMHtUEoucTjrbVu4/uHHIgt2VVHZX7gR9+5HX3SIZ9zje6
 gUY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:41:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRl25ywRz1Rwnl
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:41:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988894; x=1659580895; bh=0WVOR2kObukyt6P4nHIcCb2g78T5NJG8PZy
	Fdo+kN0g=; b=STy4PWP+fqJ9bFrVqpESifv0DtyGOFCTlPOU2gXrovSRiaYQxi+
	prnu5C3fvoWJN1pBi29Pl9Lo5adPA4GzbuhO3Oj/h6Hq5K/JCooYtm/Lwjk/nnYY
	4s0qGbD7MrmZW1VOwd01Ja+U/FgcsNG5vP1NpZFAkrxPhR1Aa8ACeYgLkNw5D3Om
	xxBJaLP9Ckxhb+OuTQQAc5e6Oc6xiD4EVAuRRpLEhTQDmE9atSHyC77gT3/jATAJ
	K30XL9ntCh1AJFqU4eosmS1zaTA81v9lI3kjzLM2upwAusYcUn8sRay7kWJWROdO
	OhVasYUTS9amm0DWqY9b4EQ8J5EndeQq5+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JHxGQjM1s8ao for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:41:34 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRl10ptgz1RtVk;
	Mon,  4 Jul 2022 19:41:32 -0700 (PDT)
Message-ID: <612f6e15-ea72-374a-9eba-d3a13a63ee00@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:41:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/17] block: pass a gendisk to blk_queue_set_zoned
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-9-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_194138_209801_3E34A839 
X-CRM114-Status: GOOD (  27.28  )
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
> Prepare for storing the zone related field in struct gendisk instead
> of struct request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-settings.c           | 9 +++++----
>  block/partitions/core.c        | 2 +-
>  drivers/block/null_blk/zoned.c | 2 +-
>  drivers/nvme/host/zns.c        | 2 +-
>  drivers/scsi/sd.c              | 6 +++---
>  drivers/scsi/sd_zbc.c          | 2 +-
>  include/linux/blkdev.h         | 2 +-
>  7 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 6ccceb421ed2f..35b7bba306a83 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -893,18 +893,19 @@ static bool disk_has_partitions(struct gendisk *disk)
>  }
>  
>  /**
> - * blk_queue_set_zoned - configure a disk queue zoned model.
> + * disk_set_zoned - configure the zoned model for a disk
>   * @disk:	the gendisk of the queue to configure
>   * @model:	the zoned model to set
>   *
> - * Set the zoned model of the request queue of @disk according to @model.
> + * Set the zoned model of @disk to @model.
> + *
>   * When @model is BLK_ZONED_HM (host managed), this should be called only
>   * if zoned block device support is enabled (CONFIG_BLK_DEV_ZONED option).
>   * If @model specifies BLK_ZONED_HA (host aware), the effective model used
>   * depends on CONFIG_BLK_DEV_ZONED settings and on the existence of partitions
>   * on the disk.
>   */
> -void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
> +void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  {
>  	struct request_queue *q = disk->queue;
>  
> @@ -948,7 +949,7 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  		blk_queue_clear_zone_settings(q);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
> +EXPORT_SYMBOL_GPL(disk_set_zoned);
>  
>  int bdev_alignment_offset(struct block_device *bdev)
>  {
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 7dc487f5b03cd..1a45b1dd64918 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -330,7 +330,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	case BLK_ZONED_HA:
>  		pr_info("%s: disabling host aware zoned block device support due to partitions\n",
>  			disk->disk_name);
> -		blk_queue_set_zoned(disk, BLK_ZONED_NONE);
> +		disk_set_zoned(disk, BLK_ZONED_NONE);
>  		break;
>  	case BLK_ZONED_NONE:
>  		break;
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 2fdd7b20c224e..b47bbd114058d 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -159,7 +159,7 @@ int null_register_zoned_dev(struct nullb *nullb)
>  	struct nullb_device *dev = nullb->dev;
>  	struct request_queue *q = nullb->q;
>  
> -	blk_queue_set_zoned(nullb->disk, BLK_ZONED_HM);
> +	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>  
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4ef..0ed15c2fd56de 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -109,7 +109,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  		goto free_data;
>  	}
>  
> -	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
> +	disk_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>  	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index cb587e488601c..eb02d939dd448 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2934,15 +2934,15 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>  
>  	if (sdkp->device->type == TYPE_ZBC) {
>  		/* Host-managed */
> -		blk_queue_set_zoned(sdkp->disk, BLK_ZONED_HM);
> +		disk_set_zoned(sdkp->disk, BLK_ZONED_HM);
>  	} else {
>  		sdkp->zoned = zoned;
>  		if (sdkp->zoned == 1) {
>  			/* Host-aware */
> -			blk_queue_set_zoned(sdkp->disk, BLK_ZONED_HA);
> +			disk_set_zoned(sdkp->disk, BLK_ZONED_HA);
>  		} else {
>  			/* Regular disk or drive managed disk */
> -			blk_queue_set_zoned(sdkp->disk, BLK_ZONED_NONE);
> +			disk_set_zoned(sdkp->disk, BLK_ZONED_NONE);
>  		}
>  	}
>  
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 6acc4f406eb8c..0f5823b674685 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -929,7 +929,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
>  		/*
>  		 * This can happen for a host aware disk with partitions.
>  		 * The block device zone model was already cleared by
> -		 * blk_queue_set_zoned(). Only free the scsi disk zone
> +		 * disk_set_zoned(). Only free the scsi disk zone
>  		 * information and exit early.
>  		 */
>  		sd_zbc_free_zone_info(sdkp);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b9baee910b825..ddf8353488fc8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -291,7 +291,7 @@ struct queue_limits {
>  typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
>  			       void *data);
>  
> -void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
> +void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  


-- 
Damien Le Moal
Western Digital Research

