Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7685FC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f8Y8bygAD9Ehvq2xN8OXaqYAZBEof9X+ioMBMICI8H8=; b=dYHAauPNDGc7W/zCwZbJCNla96
	8u+/9/JiOAMT7X5wrK//IjRDrm7kFAIv9K3tP+xG2EN+QmixbqofApFIqKlHo3EONIEdg3+N4IXnb
	hhLDTDmhb0lECcr4v9tnSESR9M8pC8hJTfzngDHdJQVZkz3uRHSBGK4SVeXOOBmPQE9gg2Sn7vLfV
	q4sZiVXhck5fxIG60LnN8ECsaL81H6qIMpUACjTErR4dGE2aL3pLCb+/kIwHtNz7NyHMwWB+23V8N
	HMzYnBrhQ3On2FkkeBclMw4yX6sVYrS/RCMwTI4tOIbEI/QKCVXNRaBRXXLk6nccUMXMXVAwSBv1H
	BlozGWrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagsS-005MHH-Ce; Tue, 20 Sep 2022 17:17:44 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrf-005LjS-Mg; Tue, 20 Sep 2022 17:16:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 12/13] nvme-loop: use the tagset alloc/free helpers
Date: Tue, 20 Sep 2022 19:16:10 +0200
Message-Id: <20220920171611.1289361-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920171611.1289361-1-hch@lst.de>
References: <20220920171611.1289361-1-hch@lst.de>
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

Use the common helpers to allocate and free the tagsets.  To make this
work the generic nvme_ctrl now needs to be stored in the hctx private
data instead of the nvme_loop_ctrl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/loop.c | 83 +++++++++-----------------------------
 1 file changed, 19 insertions(+), 64 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 54578cc18d528..b45fe3adf015f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -266,9 +266,7 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 	if (!test_and_clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags))
 		return;
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
-	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
-	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
 
 static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
@@ -282,10 +280,8 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
 
-	if (nctrl->tagset) {
-		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(&ctrl->tag_set);
-	}
+	if (nctrl->tagset)
+		nvme_remove_io_tag_set(nctrl);
 	kfree(ctrl->queues);
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
@@ -350,52 +346,31 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
 	int error;
 
-	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
-	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
-	ctrl->admin_tag_set.driver_data = &ctrl->ctrl;
-	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
-	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
-
 	ctrl->queues[0].ctrl = ctrl;
 	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq);
 	if (error)
 		return error;
 	ctrl->ctrl.queue_count = 1;
 
-	error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
+	error = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
+			&nvme_loop_admin_mq_ops, BLK_MQ_F_NO_SCHED,
+			sizeof(struct nvme_loop_iod) +
+			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (error)
 		goto out_free_sq;
-	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
-
-	ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.fabrics_q)) {
-		error = PTR_ERR(ctrl->ctrl.fabrics_q);
-		goto out_free_tagset;
-	}
 
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_q)) {
-		error = PTR_ERR(ctrl->ctrl.admin_q);
-		goto out_cleanup_fabrics_q;
-	}
 	/* reset stopped state for the fresh admin queue */
 	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
 
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_tagset;
 
 	set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 
 	error = nvme_enable_ctrl(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_tagset;
 
 	ctrl->ctrl.max_hw_sectors =
 		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
@@ -404,17 +379,13 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_cleanup_tagset;
 
 	return 0;
 
-out_cleanup_queue:
+out_cleanup_tagset:
 	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
-	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
-out_cleanup_fabrics_q:
-	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
-out_free_tagset:
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_sq:
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	return error;
@@ -522,37 +493,21 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
-	ctrl->tag_set.ops = &nvme_loop_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
-	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
-	ctrl->tag_set.driver_data = &ctrl->ctrl;
-	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
-	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
-	ctrl->ctrl.tagset = &ctrl->tag_set;
-
-	ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
+	ret = nvme_alloc_io_tag_set(&ctrl->ctrl, &ctrl->tag_set,
+			&nvme_loop_mq_ops, BLK_MQ_F_SHOULD_MERGE,
+			sizeof(struct nvme_loop_iod) +
+			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (ret)
 		goto out_destroy_queues;
 
-	ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
-	if (ret)
-		goto out_free_tagset;
-
 	ret = nvme_loop_connect_io_queues(ctrl);
 	if (ret)
-		goto out_cleanup_connect_q;
+		goto out_cleanup_tagset;
 
 	return 0;
 
-out_cleanup_connect_q:
-	blk_mq_destroy_queue(ctrl->ctrl.connect_q);
-out_free_tagset:
-	blk_mq_free_tag_set(&ctrl->tag_set);
+out_cleanup_tagset:
+	nvme_remove_io_tag_set(&ctrl->ctrl);
 out_destroy_queues:
 	nvme_loop_destroy_io_queues(ctrl);
 	return ret;
-- 
2.30.2


