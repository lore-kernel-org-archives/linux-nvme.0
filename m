Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4797C761AE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 06:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2vYqkuo5T8qmkEaPLzMEVGWWiu77p3ejhaMORULmL4=; b=OncIBNdfDSrlW/HUDaqG9nrmtk
	2aWCctFg4PI8gB9A11nUeXY4abVlI9ZmOPMHT4dZsegFSapYIGAlkSGlom6re9R2lkoxhI9E0TeLV
	6Kq67HDqjSsLxqFniw7/osqnt6DVnfUtGUFwfsJCZE1iuf6ZdNMNDF6Ekhk/pPS/Gc4fp2XzNh2Bc
	LsKJFN/lJL+psnkONgiZxhDlRzmGtB5ugLbnnW+AreeddJtpUaVBiHHD0NRyBnimd/VXPTndRLlcU
	i8Z1gTDH8KVTSUzW2Tt2C5Np1VfWe2GVaU8oHK7oazI1l9v9Lu4poWGyq2nOk3/CMiDKxj2Gv28HA
	vIv23CGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYox-00000000oW4-0s2q;
	Thu, 29 Aug 2024 06:39:51 +0000
Received: from [2001:4bb8:2c1:ef51:b1e3:1751:33fd:c3bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYhJ-00000000n1g-1V5r;
	Thu, 29 Aug 2024 06:31:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Martin Wilck <mwilck@suse.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: freeze both the ns and multipath queues whe updating queue limits
Date: Thu, 29 Aug 2024 09:31:30 +0300
Message-ID: <20240829063142.2048109-4-hch@lst.de>
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

We really should not have any I/O outstanding while updating the queue
limits, as that could introduce inconsistencies between the multipath
and underlying nodes.  So always freeze the multipath node first and then
the underlying one, matching the order in nvme_passthru_start.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 81d2a09dd00f30..0f01a0bf976fd3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2095,6 +2095,24 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id,
 	lim->chunk_sectors = iob;
 }
 
+/*
+ * Freeze all I/O for a namespace, including clearing out anything on the
+ * multipath node.
+ */
+static void nvme_ns_freeze(struct nvme_ns *ns)
+{
+	if (nvme_ns_head_multipath(ns->head))
+		blk_mq_freeze_queue(ns->head->disk->queue);
+	blk_mq_freeze_queue(ns->disk->queue);
+}
+
+static void nvme_ns_unfreeze(struct nvme_ns *ns)
+{
+	blk_mq_unfreeze_queue(ns->disk->queue);
+	if (nvme_ns_head_multipath(ns->head))
+		blk_mq_unfreeze_queue(ns->head->disk->queue);
+}
+
 /*
  * The queue_limits structure mixes values that are the hardware limitations for
  * bio splitting with what is the device configuration.
@@ -2116,7 +2134,8 @@ static int nvme_update_ns_info_mpath(struct nvme_ns *ns,
 	struct queue_limits lim;
 	int ret;
 
-	blk_mq_freeze_queue(disk->queue);
+	WARN_ON_ONCE(disk->queue->mq_freeze_depth < 1);
+
 	lim = queue_limits_start_update(disk->queue);
 	lim.logical_block_size = ns_lim->logical_block_size;
 	lim.physical_block_size = ns_lim->physical_block_size;
@@ -2132,7 +2151,6 @@ static int nvme_update_ns_info_mpath(struct nvme_ns *ns,
 	set_capacity_and_notify(disk, get_capacity(ns->disk));
 	set_disk_ro(disk, nvme_ns_is_readonly(ns, info));
 	nvme_mpath_revalidate_paths(ns);
-	blk_mq_unfreeze_queue(disk->queue);
 
 	return ret;
 }
@@ -2143,7 +2161,7 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	struct queue_limits lim;
 	int ret;
 
-	blk_mq_freeze_queue(ns->disk->queue);
+	nvme_ns_freeze(ns);
 	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
@@ -2154,11 +2172,11 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	ns->disk->flags |= GENHD_FL_HIDDEN;
 	set_bit(NVME_NS_READY, &ns->flags);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
+	if (nvme_ns_head_multipath(ns->head))
+		ret = nvme_update_ns_info_mpath(ns, info, true);
 
 out_unfreeze:
-	blk_mq_unfreeze_queue(ns->disk->queue);
-	if (nvme_ns_head_multipath(ns->head) && !ret)
-		ret = nvme_update_ns_info_mpath(ns, info, true);
+	nvme_ns_unfreeze(ns);
 	return ret;
 }
 
@@ -2204,7 +2222,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
-	blk_mq_freeze_queue(ns->disk->queue);
+	nvme_ns_freeze(ns);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
@@ -2236,7 +2254,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
-		blk_mq_unfreeze_queue(ns->disk->queue);
+		nvme_ns_unfreeze(ns);
 		goto out;
 	}
 
@@ -2254,7 +2272,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 done:
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
-	blk_mq_unfreeze_queue(ns->disk->queue);
+	if (nvme_ns_head_multipath(ns->head))
+		ret = nvme_update_ns_info_mpath(ns, info, unsupported);
+	nvme_ns_unfreeze(ns);
 
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = blk_revalidate_disk_zones(ns->disk);
@@ -2266,9 +2286,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 out:
 	kfree(nvm);
 	kfree(id);
-
-	if (nvme_ns_head_multipath(ns->head) && !ret)
-		ret = nvme_update_ns_info_mpath(ns, info, unsupported);
 	return ret;
 }
 
-- 
2.43.0


