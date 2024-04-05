Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50215CD1284
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=66FH8RH2oxLwa792QFQPTtw5Ctx+OM5HqoXbnGjbKg8=; b=sHkya3Lc956VgvlukA7C2TGf/h
	pQo2dWLoxud3gCfVdK+t6PXf2kFzRi4ici4xtJHlmkjVmeDammC6NbLMCtJ7aYp98EzJB9BvV//YQ
	wSjTHo9vkHM4jJYbOZLNWMhEarxGkfX5vLtWh0EgPJzWefaulvmzGvHYlrKaGR2xdhWBhZq4szZpZ
	pmmp97vzmwu7BzzE7oIy2d5Wg9YPfS7wNNmqFhkjfd/WjwyJZSApk6rjakO4OR2wnSglZbC0D+22M
	EENQ3HdXs0+Hd7Mq05Qf6LYUj/3hzeEViKkgCHuMVlj9AbQEyeNh4nZpk+VwfG4KPflD9e7Y5jk7S
	QJD/HSng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSS-00000005LOe-0G1R;
	Fri, 05 Apr 2024 05:49:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPP-00000005BPG-34Cq
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 03CD761767;
	Fri,  5 Apr 2024 04:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8B3C43390;
	Fri,  5 Apr 2024 04:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292154;
	bh=6t2uKnadDY2kbMGbnciF6esBAlnT+cB5PZhf+JXo1Iw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xu/vMxIoG1pizu1nQuRtrbMsJofl9vTQN+Rq1H9AKa7gRzYscnZ5ZBGh4DCeWhhv9
	 KVTZpwIe2QCcKiMcVrVo4Lk9oXnShJ4qfi4IPu5iJ3t4DuRiI4E+LFLGgvkXCWNPor
	 LWYE51UYT5BgzGKNGpFlsHhcCFdDm8dujQsugeA4U9GX4FupWLZ9ijNtLoAVaelUxu
	 ayD0rBlxciaM0wXNC2Hk3vrpKlbJxQ1aS4P1GJbfxaRYfANHD70pZc1GhwDXorXvN3
	 /CG2i5NVFYWo8QgxGHX2n2gDfIFLGnxraHClDiTxK8ZtrFPNNksoVXdy4Z/nH/iU+7
	 Bq9PElIqKItJw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 17/28] null_blk: Introduce fua attribute
Date: Fri,  5 Apr 2024 13:41:56 +0900
Message-ID: <20240405044207.1123462-18-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214236_292295_BFB0FE9B 
X-CRM114-Status: GOOD (  17.17  )
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

Add the fua configfs attribute and module parameter to allow
configuring if the device supports FUA or not. Using this attribute
has an effect on the null_blk device only if memory backing is enabled
together with a write cache (cache_size option).

This new attribute allows configuring a null_blk device with a write
cache but without FUA support. This is convenient to test the block
layer flush machinery.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 drivers/block/null_blk/main.c     | 12 ++++++++++--
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index a5a50ba6ad9f..578660b1ad01 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -225,6 +225,10 @@ static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
 MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
 
+static bool g_fua = true;
+module_param_named(fua, g_fua, bool, 0444);
+MODULE_PARM_DESC(zoned, "Enable/disable FUA support when cache_size is used. Default: true");
+
 static unsigned int g_mbps;
 module_param_named(mbps, g_mbps, uint, 0444);
 MODULE_PARM_DESC(mbps, "Limit maximum bandwidth (in MiB/s). Default: 0 (no limit)");
@@ -446,6 +450,7 @@ NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tags, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
+NULLB_DEVICE_ATTR(fua, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -593,6 +598,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_no_sched,
 	&nullb_device_attr_shared_tags,
 	&nullb_device_attr_shared_tag_bitmap,
+	&nullb_device_attr_fua,
 	NULL,
 };
 
@@ -671,7 +677,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"badblocks,blocking,blocksize,cache_size,"
+			"badblocks,blocking,blocksize,cache_size,fua,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
 			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
 			"poll_queues,power,queue_mode,shared_tag_bitmap,"
@@ -763,6 +769,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->no_sched = g_no_sched;
 	dev->shared_tags = g_shared_tags;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
+	dev->fua = g_fua;
+
 	return dev;
 }
 
@@ -1920,7 +1928,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	if (dev->cache_size > 0) {
 		set_bit(NULLB_DEV_FL_CACHE, &nullb->dev->flags);
-		blk_queue_write_cache(nullb->q, true, true);
+		blk_queue_write_cache(nullb->q, true, dev->fua);
 	}
 
 	nullb->q->queuedata = nullb;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index a9c5df650ddb..3234e6c85eed 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -105,6 +105,7 @@ struct nullb_device {
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tags; /* share tag set between devices for blk-mq */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
+	bool fua; /* Support FUA */
 };
 
 struct nullb {
-- 
2.44.0


