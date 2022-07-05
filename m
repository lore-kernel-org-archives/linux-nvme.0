Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20597C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFGbT1o6vMBZQ9GkSLIDGgD6upeS0Et4VWrqvla2XmE=; b=Yz0pLgAynvpWS8WLb7Q+PcPwHz
	S22JYt0iy9JliltYZUpFXYZ1xJJUhZRPyzyZ15kPUMUyVlXVS/lMsfVais/r0gL3qztiQeCZUCE8H
	7Qp0m1Jgr0ewu+m1TkXYO2qvuW4ZGrvJ/3kMVTvWx5smgnrOL0pJe2YYdUfsC8b+EnLSns3FibSlF
	F1irk3ILx/TuwFsDKY6IhuiUnZRTA7obiVAyT5Bop0qe9kNRCS47AA1wWSmJBzS1u/naYL9NOefjj
	VEf87la/o92EAh1h+kn4a6Q9ZCbMqPZJ8d5wJffTWhahdCi5yer9xIoRyZNuiMwVi+SM6EITOJm5I
	XMYjYfnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YeP-00E8mJ-Bq; Tue, 05 Jul 2022 02:50:57 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YeL-00E8kI-Gk
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989453; x=1688525453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YV32qaUBwpXJwemzo0Wv/JfDuW5/GwMliI6E3LKQ3DY=;
  b=pXFv/O2b8l7EJH9TzXsm4MF6z+YnfCz6joY7Vzi7XwH4/uMgg/apFEQu
   cJnU/IgZhcGq58k2DyXEqMWtd6egqp7pyPiYjFwMBKmWgTIdVcMKQm9H7
   ntGM+Il4Fn8RctEB+C0lk2x7hRefXw5AHlLb8AodQ0TI0F+yFnE3qFkiS
   1vmcqpXxglmzlAWmj5o4dBlUyAyWqJfypGKiBb6AUBXBT9/pO4XFUZvWu
   GcUe4vyzFlRsIvhi5d8B6eNL5E+s3cWsgbQh+ivYIGZa5TVJm1HlvkXf8
   WdK7JROhUXWx0YS9OzqRDLIO9yh5fO302lwwdQ8WyMgPGYhAwsIcJf/pu
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="309130555"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:50:51 +0800
IronPort-SDR: P0APW4ckF56pplTZc+TS9Fb9uiz2WWarhN0JwfFVm+0xruuDAvKyTxOGGZYbSHL27KKGpt9Wnz
 pEBoAaSywpj2tSGm+UKAUfU1EcW74+AGlFUxz65Hk2NYMN0GSKBBAk4ob9h/yTS8y97abEGAnV
 y72c7x22YNdV0qb8EmyS2fofjrZcjaRshB32FupPEL7jsdB4oIDonjwgJ0XJl1K8ngv1+768da
 KvQFheH/X3WjJBRpwy972ZqH8vRadeMAg9W6P38Yb8v5Bs/A3OMFFY5l3Q+S7e5bCsfPuWE7vb
 8mk5JTDCIPRRXt9Kp/kOGX2R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:12:43 -0700
IronPort-SDR: SQcvbtW0Ee6z0vE3lQ+Ugpc/Fykwc2Qllql+HjxsArnd0CFcIb6KCmXy7az0yzoVrxUqNNBQrH
 LveMhKnvPVVnjQHRq918+outdin9iiYBNywDqsUaHE1OfpTc7qcDvf32wa5XKVqP9wrEmzAwgX
 Q/xe8w0OQDEYAchbCJ+frQ50Pb++3AljjUOnpfROyR/AxxwJ4Yfro0rhFQZyyslQAoll3qGfEP
 qZfZMGA8zRWybNxsIMVd7ioWq/G6WaWsUykdBuSUkSPJzOhvRs1cKK/p42JfeZcENCgiJWeBjl
 UvY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:50:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRxl33srz1Rwnm
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:50:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656989450; x=1659581451; bh=YV32qaUBwpXJwemzo0Wv/JfDuW5/GwMliI6
	E3LKQ3DY=; b=gNHpX7V4k18wTnKi4ifgMxVtLCAAFg7dSmeEvbQ22F4SWh7RPPS
	2Ujyd42pgkyq9cVXXHjZI9apxvurCff/o1eQyq+FtNfjib1TDTXDM6OL33wSMH/q
	OYfWMI7ThPQmoVPlT9N/o+KebdU6q8LHdEHWNQ8b0GBLS9J+Cwun0/38oLZvcr73
	xsaNUUWhghYAYoqPbpmVO+YMcwnVD8RlCgqB1RnQY8vs7gKrxRAGSHsO8U8lARt1
	nm14YV2vf64HAI4j4RwJ/8gkf2K2+4EJXAMcSskJnoL+HAfS+WgzGljGzU+/qWl5
	PCaljFNegRAx4wcb/96bfnJm9146YAIOUsg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BfFTJCw3WgL0 for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:50:50 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRxj3h60z1RtVk;
	Mon,  4 Jul 2022 19:50:49 -0700 (PDT)
Message-ID: <1c7795a3-4a18-6741-a86b-64f1eee42dbd@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:50:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/17] block: pass a gendisk to blk_queue_max_open_zones
 and blk_queue_max_active_zones
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-13-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_195053_755741_36018E57 
X-CRM114-Status: GOOD (  20.54  )
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
> Switch to a gendisk based API in preparation for moving all zone related
> fields from the request_queue to the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/zoned.c | 4 ++--
>  drivers/nvme/host/zns.c        | 4 ++--
>  drivers/scsi/sd_zbc.c          | 6 +++---
>  include/linux/blkdev.h         | 8 ++++----
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index b47bbd114058d..576ab3ed082a5 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -174,8 +174,8 @@ int null_register_zoned_dev(struct nullb *nullb)
>  	}
>  
>  	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
> -	blk_queue_max_open_zones(q, dev->zone_max_open);
> -	blk_queue_max_active_zones(q, dev->zone_max_active);
> +	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
> +	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
>  
>  	return 0;
>  }
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 0ed15c2fd56de..12316ab51bda6 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -111,8 +111,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  
>  	disk_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> -	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
> -	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> +	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
> +	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);
>  free_data:
>  	kfree(id);
>  	return status;
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 0f5823b674685..b4106f8997342 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -950,10 +950,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>  	if (sdkp->zones_max_open == U32_MAX)
> -		blk_queue_max_open_zones(q, 0);
> +		disk_set_max_open_zones(disk, 0);
>  	else
> -		blk_queue_max_open_zones(q, sdkp->zones_max_open);
> -	blk_queue_max_active_zones(q, 0);
> +		disk_set_max_open_zones(disk, sdkp->zones_max_open);
> +	disk_set_max_active_zones(disk, 0);
>  	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
>  
>  	/*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a14cc3e46e6ad..e32c147f72868 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -698,16 +698,16 @@ static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>  	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
>  }
>  
> -static inline void blk_queue_max_open_zones(struct request_queue *q,
> +static inline void disk_set_max_open_zones(struct gendisk *disk,
>  		unsigned int max_open_zones)
>  {
> -	q->max_open_zones = max_open_zones;
> +	disk->queue->max_open_zones = max_open_zones;
>  }
>  
> -static inline void blk_queue_max_active_zones(struct request_queue *q,
> +static inline void disk_set_max_active_zones(struct gendisk *disk,
>  		unsigned int max_active_zones)
>  {
> -	q->max_active_zones = max_active_zones;
> +	disk->queue->max_active_zones = max_active_zones;
>  }
>  
>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)


-- 
Damien Le Moal
Western Digital Research

