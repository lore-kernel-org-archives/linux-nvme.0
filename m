Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C2CC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 11:17:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269A320722
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WqWMLJua";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="izsE4d/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269A320722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=27Pv775jDLKij4ThWO0axntBIE6+/EYr+tMBSSph+84=; b=WqWMLJuaI8xX3JaPQT25i+glm
	92/Z3jUIAmGeAxzq555o6urvJI65t1hUwtc9AMtxycqRmryFBBNkkJTuOxoF+FS4tr3snsODpdAe9
	jTjWz/AlFGJ3m/Up+IbJwS+DHsNn3Tfmv80SFxPYTHfEOp+KcMTkicdn+qSpZd/T4HwEphTQB432t
	Zy17KvDt/ZRMAwSBR9yJSNuqSYEKNKB1fWZKnKEptbXy1/tHXBJxjdriM6n5uSV9A+R/7Knt5rQ+I
	CXvMQKmVze60ibTPq7Rx/nVwWAThH7tz00MtM1vAceZ+QoammoSgEK5u9ketRDgM6i2mIOxQ+SXpn
	/ifgnVJaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqajc-00035r-0s; Wed, 01 Jul 2020 11:17:00 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqajZ-00035J-3w
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 11:16:58 +0000
Received: by mail-ej1-x644.google.com with SMTP id w16so24146667ejj.5
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w5k0/vPEZeTqwY5SXJ0/YDPUmmXWJlzEh3JyeTs1JGI=;
 b=izsE4d/MxGx5PCBufUvd6Yby0hi5tUgK41AM6BrSGZML4kl+Q5GVb4kIosbzdcdZ6Q
 y8jEE9b2jt4DcXdhclUnQjFSOLyQBgnTCrK34sqvoKQzYD+kh1INlDOXUSg1UvK8N3ov
 FiBhVLW6YBYsHLL1g4yLijqhLct2dO+rIAAA+zcFY0UkZ6L8f/wicU9arfRCoPZ5mkbB
 J/GTwRbSYp7WPzfl5x0GKHQD94hEVEc7/ENiN/lCY6K4WGIYlSVAoxHxjQDq/1/as9A4
 w40i1d0DkjwdoCdX+GTg9zDJporiggTqcGdLE8cR3LxyfnzW2Lzx2O5/5BFiWOLQBS6p
 i1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w5k0/vPEZeTqwY5SXJ0/YDPUmmXWJlzEh3JyeTs1JGI=;
 b=lJNSAfNWEsrDwD4/egDMEnE8q3MWYF82u2VLWtGhfy3GSpA9pIg4VnsuavVLLWFU/C
 JlepSnT3iiXPAYWCko95AuQBpJOMBi0bVGVCBAU/LG5G3xRACAcf4ozpE+uwwvRVJ0Tg
 KNRgWReY7Vju6HaB2BMo+gR2KF5CwMCSgnIpof7G29LUDGWRudht6dXgwIDjgtKWNQte
 4GQzZD2aRaGtBITifFTgz/KpB0Q6TWJGNCTIc+DnjPZvsLbfvMCva7L1oU5Yv9KVMeEm
 sO+w/bSKfeG4f02ds3UjW/v2RbY2vEyRP83VgH+syhhBU1rTnvx6MyVapCt+mq2o6bFm
 ubXQ==
X-Gm-Message-State: AOAM532VWi/DjYJJZ365zD99NwNeMbS/sLzRV8/xJOwiBFWBnWSTi16k
 vsKJEV3vYJuKmjMyOqPdE2xLPg==
X-Google-Smtp-Source: ABdhPJyDtq06fyfgH0Hy0pHn1yaEw14o/ndhRf2GJZrvJwMnQIZ0MHbpzMb8C5Fkuj+N4bF92wEkyg==
X-Received: by 2002:a17:906:2616:: with SMTP id
 h22mr22010171ejc.154.1593602214045; 
 Wed, 01 Jul 2020 04:16:54 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id b14sm3081906ejg.18.2020.07.01.04.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 04:16:53 -0700 (PDT)
Date: Wed, 1 Jul 2020 13:16:52 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 2/2] block: add max_active_zones to blk-sysfs
Message-ID: <20200701111330.3vpivrovh3i46maa@mpHalley.local>
References: <20200616102546.491961-1-niklas.cassel@wdc.com>
 <20200616102546.491961-3-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616102546.491961-3-niklas.cassel@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_071657_303800_B170E3B2 
X-CRM114-Status: GOOD (  22.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 16.06.2020 12:25, Niklas Cassel wrote:
>Add a new max_active zones definition in the sysfs documentation.
>This definition will be common for all devices utilizing the zoned block
>device support in the kernel.
>
>Export max_active_zones according to this new definition for NVMe Zoned
>Namespace devices, ZAC ATA devices (which are treated as SCSI devices by
>the kernel), and ZBC SCSI devices.
>
>Add the new max_active_zones struct member to the request_queue, rather
>than as a queue limit, since this property cannot be split across stacking
>drivers.
>
>For SCSI devices, even though max active zones is not part of the ZBC/ZAC
>spec, export max_active_zones as 0, signifying "no limit".
>
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>---
> Documentation/block/queue-sysfs.rst |  7 +++++++
> block/blk-sysfs.c                   | 14 +++++++++++++-
> drivers/nvme/host/zns.c             |  1 +
> drivers/scsi/sd_zbc.c               |  1 +
> include/linux/blkdev.h              | 20 ++++++++++++++++++++
> 5 files changed, 42 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
>index f01cf8530ae4..f261a5c84170 100644
>--- a/Documentation/block/queue-sysfs.rst
>+++ b/Documentation/block/queue-sysfs.rst
>@@ -117,6 +117,13 @@ Maximum number of elements in a DMA scatter/gather list with integrity
> data that will be submitted by the block layer core to the associated
> block driver.
>
>+max_active_zones (RO)
>+---------------------
>+For zoned block devices (zoned attribute indicating "host-managed" or
>+"host-aware"), the sum of zones belonging to any of the zone states:
>+EXPLICIT OPEN, IMPLICIT OPEN or CLOSED, is limited by this value.
>+If this value is 0, there is no limit.
>+
> max_open_zones (RO)
> -------------------
> For zoned block devices (zoned attribute indicating "host-managed" or
>diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>index fa42961e9678..624bb4d85fc7 100644
>--- a/block/blk-sysfs.c
>+++ b/block/blk-sysfs.c
>@@ -310,6 +310,11 @@ static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
> 	return queue_var_show(queue_max_open_zones(q), page);
> }
>
>+static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
>+{
>+	return queue_var_show(queue_max_active_zones(q), page);
>+}
>+
> static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
> {
> 	return queue_var_show((blk_queue_nomerges(q) << 1) |
>@@ -677,6 +682,11 @@ static struct queue_sysfs_entry queue_max_open_zones_entry = {
> 	.show = queue_max_open_zones_show,
> };
>
>+static struct queue_sysfs_entry queue_max_active_zones_entry = {
>+	.attr = {.name = "max_active_zones", .mode = 0444 },
>+	.show = queue_max_active_zones_show,
>+};
>+
> static struct queue_sysfs_entry queue_nomerges_entry = {
> 	.attr = {.name = "nomerges", .mode = 0644 },
> 	.show = queue_nomerges_show,
>@@ -776,6 +786,7 @@ static struct attribute *queue_attrs[] = {
> 	&queue_zoned_entry.attr,
> 	&queue_nr_zones_entry.attr,
> 	&queue_max_open_zones_entry.attr,
>+	&queue_max_active_zones_entry.attr,
> 	&queue_nomerges_entry.attr,
> 	&queue_rq_affinity_entry.attr,
> 	&queue_iostats_entry.attr,
>@@ -803,7 +814,8 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
> 		(!q->mq_ops || !q->mq_ops->timeout))
> 			return 0;
>
>-	if (attr == &queue_max_open_zones_entry.attr &&
>+	if ((attr == &queue_max_open_zones_entry.attr ||
>+	     attr == &queue_max_active_zones_entry.attr) &&
> 	    !blk_queue_is_zoned(q))
> 		return 0;
>
>diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>index af156529f3b6..502070763266 100644
>--- a/drivers/nvme/host/zns.c
>+++ b/drivers/nvme/host/zns.c
>@@ -83,6 +83,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> 	q->limits.zoned = BLK_ZONED_HM;
> 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>+	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> free_data:
> 	kfree(id);
> 	return status;
>diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
>index aa3564139b40..d8b2c49d645b 100644
>--- a/drivers/scsi/sd_zbc.c
>+++ b/drivers/scsi/sd_zbc.c
>@@ -721,6 +721,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
> 		blk_queue_max_open_zones(q, 0);
> 	else
> 		blk_queue_max_open_zones(q, sdkp->zones_max_open);
>+	blk_queue_max_active_zones(q, 0);
> 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
>
> 	/* READ16/WRITE16 is mandatory for ZBC disks */
>diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>index 2f332f00501d..3776140f8f20 100644
>--- a/include/linux/blkdev.h
>+++ b/include/linux/blkdev.h
>@@ -521,6 +521,7 @@ struct request_queue {
> 	unsigned long		*conv_zones_bitmap;
> 	unsigned long		*seq_zones_wlock;
> 	unsigned int		max_open_zones;
>+	unsigned int		max_active_zones;
> #endif /* CONFIG_BLK_DEV_ZONED */

Looking a second time at these patches, wouldn't it make sense to move
this to queue_limits?

Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
