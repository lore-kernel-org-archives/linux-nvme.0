Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6876EC77B7F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 06:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8m5caDZ4W6dfO5td0ROHEYPLUja7MZNHiJF25dacNc=; b=fzvkbxh2CcaaziosvJMtCrIZZZ
	KUD5OpHCdYKbGJu2EUIPGhF6UDa/nouzeoINgJzFIf/3YsuYehERLxpEq8Il/8aFJPhokcU6aaV8w
	7EErbHiiZtUwatvSrRX2biVaR/eDCaV1C+Qj66bYOlKuA1Tb5tjchLT/5J/tLOBEh74njEeNR7qOK
	41J5mMQlgghGPl0O4TncP+ogR2aJCiGn1HYqo1hxGVg41oTvZ4itWzysDMkxYV0epOsmcd4+dMjHB
	7q5QFOJIm1hoHGTvBeWYGaSQp7nYujCKsBZ1yhggZnsLfrZugFv6rk7R2gb11mbhw0fCGoxtiQo+p
	fw1GwWjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYov-00000000oUZ-0Jt3;
	Thu, 29 Aug 2024 06:39:49 +0000
Received: from [2001:4bb8:2c1:ef51:b1e3:1751:33fd:c3bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYhB-00000000n0H-11zW;
	Thu, 29 Aug 2024 06:31:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Martin Wilck <mwilck@suse.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme: split out a nvme_update_ns_info_mpath helper
Date: Thu, 29 Aug 2024 09:31:28 +0300
Message-ID: <20240829063142.2048109-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829063142.2048109-1-hch@lst.de>
References: <20240829063142.2048109-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a separate helper to update the multipath disk information to
declutter nvme_update_ns_info.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 84 +++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 73968130f50926..51cb3b001b3757 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2095,6 +2095,48 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id,
 	lim->chunk_sectors = iob;
 }
 
+/*
+ * The queue_limits structure mixes values that are the hardware limitations for
+ * bio splitting with what is the device configuration.
+ *
+ * For NVMe the device configuration can change after e.g. a Format command, and
+ * we really want to pick up the new format value here.  But we must still stack
+ * the queue limits to the least common denominator for multipathing to split
+ * the bios properly.
+ *
+ * To work around this, we explicitly set the device configuration to the values
+ * that we just queried, but stack the splitting limits in to make sure we still
+ * obey possibly lower limitations of other controllers.
+ */
+static int nvme_update_ns_info_mpath(struct nvme_ns *ns,
+		struct nvme_ns_info *info, bool unsupported)
+{
+	struct queue_limits *ns_lim = &ns->disk->queue->limits;
+	struct gendisk *disk = ns->head->disk;
+	struct queue_limits lim;
+	int ret;
+
+	blk_mq_freeze_queue(disk->queue);
+	lim = queue_limits_start_update(disk->queue);
+	lim.logical_block_size = ns_lim->logical_block_size;
+	lim.physical_block_size = ns_lim->physical_block_size;
+	lim.io_min = ns_lim->io_min;
+	lim.io_opt = ns_lim->io_opt;
+	queue_limits_stack_bdev(&lim, ns->disk->part0, 0, disk->disk_name);
+	if (unsupported)
+		disk->flags |= GENHD_FL_HIDDEN;
+	else
+		nvme_init_integrity(disk, ns->head, &lim);
+	ret = queue_limits_commit_update(disk->queue, &lim);
+
+	set_capacity_and_notify(disk, get_capacity(ns->disk));
+	set_disk_ro(disk, nvme_ns_is_readonly(ns, info));
+	nvme_mpath_revalidate_paths(ns);
+	blk_mq_unfreeze_queue(disk->queue);
+
+	return ret;
+}
+
 static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2251,46 +2293,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		ret = 0;
 	}
 
-	if (!ret && nvme_ns_head_multipath(ns->head)) {
-		struct queue_limits *ns_lim = &ns->disk->queue->limits;
-		struct queue_limits lim;
-
-		blk_mq_freeze_queue(ns->head->disk->queue);
-		/*
-		 * queue_limits mixes values that are the hardware limitations
-		 * for bio splitting with what is the device configuration.
-		 *
-		 * For NVMe the device configuration can change after e.g. a
-		 * Format command, and we really want to pick up the new format
-		 * value here.  But we must still stack the queue limits to the
-		 * least common denominator for multipathing to split the bios
-		 * properly.
-		 *
-		 * To work around this, we explicitly set the device
-		 * configuration to those that we just queried, but only stack
-		 * the splitting limits in to make sure we still obey possibly
-		 * lower limitations of other controllers.
-		 */
-		lim = queue_limits_start_update(ns->head->disk->queue);
-		lim.logical_block_size = ns_lim->logical_block_size;
-		lim.physical_block_size = ns_lim->physical_block_size;
-		lim.io_min = ns_lim->io_min;
-		lim.io_opt = ns_lim->io_opt;
-		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
-					ns->head->disk->disk_name);
-		if (unsupported)
-			ns->head->disk->flags |= GENHD_FL_HIDDEN;
-		else
-			nvme_init_integrity(ns->head->disk, ns->head, &lim);
-		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
-
-		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns);
-
-		blk_mq_unfreeze_queue(ns->head->disk->queue);
-	}
-
+	if (nvme_ns_head_multipath(ns->head) && !ret)
+		ret = nvme_update_ns_info_mpath(ns, info, unsupported);
 	return ret;
 }
 
-- 
2.43.0


