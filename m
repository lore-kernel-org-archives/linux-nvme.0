Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF15E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrM72vDCQvZmy0p1S8PNMOjUtRKWGWti2Vq2kDq5zaY=; b=J26QFCOs8KDtFk5clRURHEsB6g
	LX20gNLX4N31OwMgjZvzgKbe8NhKsfperSPo/SLn8oe9LLevG7MgxY9wo1zoNvsE6Z2aHQheCqpCr
	iTAY1z23kM0VS829Z2iVIrUkgQe1T2joKqyafytQC8NRZmhmlYAqbeu/w467rP6Y6efYec26RygIg
	RO4YLtpPV4L/AwJtEWgRmXb2TYYx1I+tMJyawsn6vFLKGBYzkVbZlm29zIbrudTFZiSzL3Dg8KUJL
	ibg9xhCar6sA7m0oZzuVNte9yC5yJ4UeR3l1DHFqEC1TVQZNQPZ5dRaWpqe87W3gWyEaYvyDgNXGG
	dFzZrLxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AJ-0000000F2jU-3Q1g;
	Sat, 04 Jan 2025 13:26:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AD-0000000F2h5-0vc9
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 13:26:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 625EE5C549D;
	Sat,  4 Jan 2025 13:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5257FC4CED2;
	Sat,  4 Jan 2025 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997160;
	bh=E2AvZuaVVt3QyD9lOW0ANW+D6nr9wEq3tnQpouzbBVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utxHbUAflQo/AnvMyQFHt1NXHhrF2orzzVfqTiHWN9YEWzhU48fmu4oZfXgPn4eCG
	 jQRCVIl/RBrVhPWjG9DPAcPwa/LR67uVPRwCXp8BtyOFbIdsMwoOaCAY8MHv9kDMK9
	 Z7FU45euRTtGYs9H+A1g4AKk/VpwMcn2mg9SC8YNE0d5zjihS+tInn+OySMkcZ2Hiu
	 Mv+gm7xKCtUVf5wi6qbqD1+PB4Q4JJldJHACG+nck3XgWzQMDEtFHzkZwAlRkviouF
	 lqZl/6B1+ZNF0yATttiPOo30xu+QPyWmsldOMNOZuUsZ+waLcXfVCdzubHEdwSNPeS
	 UGZmUgT5SF7zA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Date: Sat,  4 Jan 2025 22:25:20 +0900
Message-ID: <20250104132522.247376-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104132522.247376-1-dlemoal@kernel.org>
References: <20250104132522.247376-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_052601_341580_F0027B4B 
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

queue_attr_store() always freezes a device queue before calling the
attribute store operation. For attributes that control queue limits, the
store operation will also lock the queue limits with a call to
queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
need to issue commands to a device to obtain limit values from the
hardware with the queue limits locked. This creates a potential ABBA
deadlock situation if a user attempts to modify a limit (thus freezing
the device queue) while the device driver starts a revalidation of the
device queue limits.

Avoid such deadlock by introducing the ->store_limit() operation in
struct queue_sysfs_entry and use this operation for all attributes that
modify the device queue limits through the QUEUE_RW_LIMIT_ENTRY() macro
definition. queue_attr_store() is modified to call the ->store_limit()
operation (if it is defined) without the device queue frozen. The device
queue freeze for attributes defining the ->stor_limit() operation is
moved to after the operation completes and is done only around the call
to queue_limits_commit_update().

Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-sysfs.c | 123 ++++++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 767598e719ab..4fc0020c73a5 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -24,6 +24,8 @@ struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
+	ssize_t (*store_limit)(struct gendisk *disk, struct queue_limits *lim,
+			       const char *page, size_t count);
 	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
@@ -154,55 +156,46 @@ QUEUE_SYSFS_SHOW_CONST(write_same_max, 0)
 QUEUE_SYSFS_SHOW_CONST(poll_delay, -1)
 
 static ssize_t queue_max_discard_sectors_store(struct gendisk *disk,
-		const char *page, size_t count)
+		struct queue_limits *lim, const char *page, size_t count)
 {
 	unsigned long max_discard_bytes;
-	struct queue_limits lim;
 	ssize_t ret;
-	int err;
 
 	ret = queue_var_store(&max_discard_bytes, page, count);
 	if (ret < 0)
 		return ret;
 
-	if (max_discard_bytes & (disk->queue->limits.discard_granularity - 1))
+	if (max_discard_bytes & (lim->discard_granularity - 1))
 		return -EINVAL;
 
 	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
 		return -EINVAL;
 
-	lim = queue_limits_start_update(disk->queue);
-	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
-	return ret;
+	lim->max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
+
+	return count;
 }
 
 static ssize_t
-queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count)
+queue_max_sectors_store(struct gendisk *disk, struct queue_limits *lim,
+			const char *page, size_t count)
 {
 	unsigned long max_sectors_kb;
-	struct queue_limits lim;
 	ssize_t ret;
-	int err;
 
 	ret = queue_var_store(&max_sectors_kb, page, count);
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
-	lim.max_user_sectors = max_sectors_kb << 1;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
-	return ret;
+	lim->max_user_sectors = max_sectors_kb << 1;
+
+	return count;
 }
 
-static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
+static ssize_t queue_feature_store(struct gendisk *disk,
+		struct queue_limits *lim, const char *page,
 		size_t count, blk_features_t feature)
 {
-	struct queue_limits lim;
 	unsigned long val;
 	ssize_t ret;
 
@@ -210,14 +203,10 @@ static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
 	if (val)
-		lim.features |= feature;
+		lim->features |= feature;
 	else
-		lim.features &= ~feature;
-	ret = queue_limits_commit_update(disk->queue, &lim);
-	if (ret)
-		return ret;
+		lim->features &= ~feature;
 	return count;
 }
 
@@ -228,9 +217,10 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
 		!!(disk->queue->limits.features & _feature));		\
 }									\
 static ssize_t queue_##_name##_store(struct gendisk *disk,		\
+		struct queue_limits *lim,				\
 		const char *page, size_t count)				\
 {									\
-	return queue_feature_store(disk, page, count, _feature);	\
+	return queue_feature_store(disk, lim, page, count, _feature);	\
 }
 
 QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
@@ -267,9 +257,8 @@ static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char *page)
 }
 
 static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
-					       const char *page, size_t count)
+		struct queue_limits *lim, const char *page, size_t count)
 {
-	struct queue_limits lim;
 	unsigned long ios;
 	ssize_t ret;
 
@@ -277,15 +266,10 @@ static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
 	if (ret < 0)
 		return ret;
 
-	lim = queue_limits_start_update(disk->queue);
 	if (ios)
-		lim.flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
+		lim->flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
 	else
-		lim.flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
-
-	ret = queue_limits_commit_update(disk->queue, &lim);
-	if (ret)
-		return ret;
+		lim->flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
 
 	return count;
 }
@@ -391,12 +375,10 @@ static ssize_t queue_wc_show(struct gendisk *disk, char *page)
 	return sysfs_emit(page, "write through\n");
 }
 
-static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
-			      size_t count)
+static ssize_t queue_wc_store(struct gendisk *disk, struct queue_limits *lim,
+			      const char *page, size_t count)
 {
-	struct queue_limits lim;
 	bool disable;
-	int err;
 
 	if (!strncmp(page, "write back", 10)) {
 		disable = false;
@@ -407,14 +389,10 @@ static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
 		return -EINVAL;
 	}
 
-	lim = queue_limits_start_update(disk->queue);
 	if (disable)
-		lim.flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
+		lim->flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
 	else
-		lim.flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
-	err = queue_limits_commit_update(disk->queue, &lim);
-	if (err)
-		return err;
+		lim->flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
 	return count;
 }
 
@@ -439,9 +417,16 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
 	.store		= _prefix##_store,			\
 }
 
+#define QUEUE_RW_LIMIT_ENTRY(_prefix, _name)				\
+static struct queue_sysfs_entry _prefix##_entry = {		\
+	.attr		= { .name = _name, .mode = 0644 },	\
+	.show		= _prefix##_show,			\
+	.store_limit	= _prefix##_store,			\
+}
+
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
-QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
+QUEUE_RW_LIMIT_ENTRY(queue_max_sectors, "max_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
@@ -457,7 +442,7 @@ QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
 QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
 QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
 QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
-QUEUE_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
+QUEUE_RW_LIMIT_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
 QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
@@ -477,11 +462,11 @@ QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
-QUEUE_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
+QUEUE_RW_LIMIT_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
 QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
-QUEUE_RW_ENTRY(queue_wc, "write_cache");
+QUEUE_RW_LIMIT_ENTRY(queue_wc, "write_cache");
 QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
@@ -494,10 +479,10 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 	.show = queue_logical_block_size_show,
 };
 
-QUEUE_RW_ENTRY(queue_rotational, "rotational");
-QUEUE_RW_ENTRY(queue_iostats, "iostats");
-QUEUE_RW_ENTRY(queue_add_random, "add_random");
-QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_LIMIT_ENTRY(queue_rotational, "rotational");
+QUEUE_RW_LIMIT_ENTRY(queue_iostats, "iostats");
+QUEUE_RW_LIMIT_ENTRY(queue_add_random, "add_random");
+QUEUE_RW_LIMIT_ENTRY(queue_stable_writes, "stable_writes");
 
 #ifdef CONFIG_BLK_WBT
 static ssize_t queue_var_store64(s64 *var, const char *page)
@@ -693,9 +678,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
+	struct queue_limits lim = { };
 	ssize_t res;
+	int ret;
 
-	if (!entry->store)
+	if (!entry->store && !entry->store_limit)
 		return -EIO;
 
 	/*
@@ -706,12 +693,30 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->load_module)
 		entry->load_module(disk, page, length);
 
-	blk_mq_freeze_queue(q);
+	if (entry->store) {
+		blk_mq_freeze_queue(q);
+		mutex_lock(&q->sysfs_lock);
+		res = entry->store(disk, page, length);
+		mutex_unlock(&q->sysfs_lock);
+		blk_mq_unfreeze_queue(q);
+		return res;
+	}
+
+	lim = queue_limits_start_update(q);
+
 	mutex_lock(&q->sysfs_lock);
-	res = entry->store(disk, page, length);
+	res = entry->store_limit(disk, &lim, page, length);
 	mutex_unlock(&q->sysfs_lock);
+	if (res < 0) {
+		queue_limits_cancel_update(q);
+		return res;
+	}
+
+	blk_mq_freeze_queue(q);
+	ret = queue_limits_commit_update(disk->queue, &lim);
 	blk_mq_unfreeze_queue(q);
-	return res;
+
+	return ret ? ret : res;
 }
 
 static const struct sysfs_ops queue_sysfs_ops = {
-- 
2.47.1


