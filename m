Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03641CCA479
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iO3uuTmubOAewFYYRQ5JSqFkGuzP3+gcL4K3IaYogMc=; b=kyKQdB5kC+2twOHskVb1uvzCpg
	v6QfRcluagpDUxM2A90JtaK58zY7/0nuU90p/uz+FnHfpatCvttkmH1iVEbNfVocRsa8NjP9wZJSR
	mryv5IVNsur3mYl+bZOB31bIo0MT3mktqDQeINzC01QeRR2KfxPmZDFsB14awhEZsyHFBn6OBpCCL
	m2D4LbZXPyFDT8xMR0Gs1Uzy1Ulupd7+rGksKXAsndsSndwyEYqHVeMQjpHL0o/R8Ornoth5TyhQ1
	jPRhn2CTQTYB3rqg0Dq5rzy2wV60U7b3qbb8Mp304GLp6vQcT4J27INGiLahRiLgOkRWEroc4ijfo
	2UQh9znw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YW8-00E5Y2-RJ; Tue, 05 Jul 2022 02:42:24 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YW4-00E5WL-BP
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988940; x=1688524940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2wSTglPxExF3q9V48KFVckZugab/uZjKO2SeFC9RfmI=;
  b=cLaMcN49ZnC/Q8zUSu1bbbc8RRxq2u3IWtaul84l7k1v2HqxGkJPwPZL
   q+JJ4YA5laUfKhXu3QaERi+Lu5NKBeFaVkg6vygZ2IUebI7s+KTNXZxCc
   S6Ggj22H83hIwT29BJre8jG7v7A61tW8ONSAvzDWxX7Bg5uSfxNHKY60K
   eZjFyIfCnNKi6tzvaq2ehnLcjIRqao3Nbvq9qGSlhKQf3WGkx1eSvbdrE
   VRxTrLlIMNo7KLJVSmZ8OpGuDGcADWmyJDL5mFvvuKGiygIzK6a4MDRfB
   MF5h6ojLMljwN9ZhWsTu5yzin8vTU4sF+KEwmqqQJUOy6StgSlvytKI2F
   w==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="309130108"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:42:19 +0800
IronPort-SDR: /iQifoVRO4FcM/QuC5H0Esq843VcOpt5jiFKGbPHUcxMJddT8cw4eH9DkMlsYCcfYbmTr+uDQw
 j95pthkuXM/4Q3Uo+5M8DFxMuFAha9crQn4IBx57ZNgYa7w6Ojy+qGwQH4cfI3y3Ac//NaqEFK
 MnUmvwfNff1GTMNNm1U1Q2ddtrf5gYknmqKwzaWmZG1S95pUXpnT28yAFh13Tkz11yVDOg5MwU
 iiPBMGSA5vIZulZ5to1PtiyhDHrFnmTN76O60K5Zz13gvDluFUXo7kU03neZ+DGyFotP414FEH
 VSLmfcBmbxi1z5GTuwy2juCn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:04:11 -0700
IronPort-SDR: od9HGJX1rDqyXncl40Bc2SWxMOydEnoPm7F+Xil+BDX2QilHR4bg5KutD4W8mh65g/kTnhjIT7
 5MOrVO+C8k/qWdPgh00wjU4KGU2e3Q7jI8fK0Ngy6SoKXo66T/e0V9sQcUQFri9WOJW/GYTaWi
 wnDGb2USYrAPyYAYWPuTWXKNyFRTavpoGY9h4bLKfnMHyWFmjlih9uf+j0XAbPooN77LykrjqN
 3lCGdPmBmp+Wnkqocq4TG9jz77mymIw6rLHQN0vUSpxlFhU82JSTqCwOivKo+jVNAKsYoXy8sd
 9J8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:42:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRlv4Gtwz1Rwnl
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:42:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988939; x=1659580940; bh=2wSTglPxExF3q9V48KFVckZugab/uZjKO2S
	eFC9RfmI=; b=FhilygavoFIJwURqIZIJu1RX+UW9fB3hWYD8CVRA93ld508a8WD
	9tvR5ICW5QEmOmErD1h7SU2mJlrlGCNkMAfJ4wTaQ8LuVAbeVUW6A5bar1olpmj6
	JEmIMn59dKSOWiwEdsLRslTtqTbzkCmDRUzJ6tpxWhcGwZiIviWhzHD97HRSSBK8
	i9kmnnmfwu9uWo99PFPrb+sesnxyI0i3A9wsRaQmt0Ro8/Hmrum30ybpvpOkFs1q
	dHGwvMjw1NXO5gpEgsUXsaCtczOgu/TSlu3eU+gkyvxdu+X0bb9a2LVrSkbOKii+
	q5JYoeDlibeVluzqnVc937BRE+dCvP/0z+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2LCy7EGDzbFe for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:42:19 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRlt1FH1z1RtVk;
	Mon,  4 Jul 2022 19:42:18 -0700 (PDT)
Message-ID: <1b49bf54-4272-b550-b1f8-4f5a46e2575a@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:42:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/17] block: pass a gendisk to
 blk_queue_free_zone_bitmaps
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-11-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_194220_548731_C8BE512D 
X-CRM114-Status: GOOD (  21.95  )
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
>  block/blk-zoned.c | 8 +++++---
>  block/blk.h       | 4 ++--
>  block/genhd.c     | 2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 5a97b48102221..9085f9fb3ab42 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -449,8 +449,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>  	return ret;
>  }
>  
> -void blk_queue_free_zone_bitmaps(struct request_queue *q)
> +void disk_free_zone_bitmaps(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
> +
>  	kfree(q->conv_zones_bitmap);
>  	q->conv_zones_bitmap = NULL;
>  	kfree(q->seq_zones_wlock);
> @@ -612,7 +614,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>  		ret = 0;
>  	} else {
>  		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
> -		blk_queue_free_zone_bitmaps(q);
> +		disk_free_zone_bitmaps(disk);
>  	}
>  	blk_mq_unfreeze_queue(q);
>  
> @@ -628,7 +630,7 @@ void disk_clear_zone_settings(struct gendisk *disk)
>  
>  	blk_mq_freeze_queue(q);
>  
> -	blk_queue_free_zone_bitmaps(q);
> +	disk_free_zone_bitmaps(disk);
>  	blk_queue_flag_clear(QUEUE_FLAG_ZONE_RESETALL, q);
>  	q->required_elevator_features &= ~ELEVATOR_F_ZBD_SEQ_WRITE;
>  	q->nr_zones = 0;
> diff --git a/block/blk.h b/block/blk.h
> index 7482a3a441dd9..b71e22c97d773 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -405,10 +405,10 @@ static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
>  #endif
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> -void blk_queue_free_zone_bitmaps(struct request_queue *q);
> +void disk_free_zone_bitmaps(struct gendisk *disk);
>  void disk_clear_zone_settings(struct gendisk *disk);
>  #else
> -static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
> +static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
>  static inline void disk_clear_zone_settings(struct gendisk *disk) {}
>  #endif
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index d0bdeb93e922c..9d30f159c59ac 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1165,7 +1165,7 @@ static void disk_release(struct device *dev)
>  
>  	disk_release_events(disk);
>  	kfree(disk->random);
> -	blk_queue_free_zone_bitmaps(disk->queue);
> +	disk_free_zone_bitmaps(disk);
>  	xa_destroy(&disk->part_tbl);
>  
>  	disk->queue->disk = NULL;


-- 
Damien Le Moal
Western Digital Research

