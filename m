Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1073C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Yqr+3Xrvb1ll46uL0cU/pNzn2Tv6UezC7+rel20kDc=; b=ffAn4Xj8m0r/3uTdSGNW4UgKRh
	QftKfffft4j5vnIJ63C07dYZr0/MtzDortN2PibvcVMKug2b1iWigM2sS+i0AwZgt+SjqS8xH87ey
	sN3BKqANVZ05vBCVHVkUgW8PB+UEdTp1fErD7TgGWkgkrlfAHssB0Js4Tu/P8J1+QaPcpncHZrLHV
	X0jlYBpnsNraVZnbwWxvfPtDLXxt+pO1VWtFE2Wsir+iNXaB90/3SiPKUc01edhIWU5t+qkHCf4Uu
	NyZa3tRzkpNZRVy+B5I0osy7quTHTC54T33g0kJ3GpYzd8t8IBpCEBZ1343hDy7LtRrrJJcJC3HvW
	YsdeVocQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oags7-005M4w-Sa; Tue, 20 Sep 2022 17:17:23 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrW-005Le2-Q7; Tue, 20 Sep 2022 17:16:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 09/13] nvme-fc: use the tagset alloc/free helpers
Date: Tue, 20 Sep 2022 19:16:07 +0200
Message-Id: <20220920171611.1289361-10-hch@lst.de>
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
data instead of the nvme_fc_ctrl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 83 +++++++++---------------------------------
 1 file changed, 17 insertions(+), 66 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d707cf93f1f4b..5d57a042dbcad 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2383,10 +2383,8 @@ nvme_fc_ctrl_free(struct kref *ref)
 		container_of(ref, struct nvme_fc_ctrl, ref);
 	unsigned long flags;
 
-	if (ctrl->ctrl.tagset) {
-		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(&ctrl->tag_set);
-	}
+	if (ctrl->ctrl.tagset)
+		nvme_remove_io_tag_set(&ctrl->ctrl);
 
 	/* remove from rport list */
 	spin_lock_irqsave(&ctrl->rport->lock, flags);
@@ -2394,9 +2392,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
 	nvme_start_admin_queue(&ctrl->ctrl);
-	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
-	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 
 	kfree(ctrl->queues);
 
@@ -2906,32 +2902,16 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	nvme_fc_init_io_queues(ctrl);
 
-	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
-	ctrl->tag_set.ops = &nvme_fc_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
-	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	ctrl->tag_set.cmd_size =
-		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
-			    ctrl->lport->ops->fcprqst_priv_sz);
-	ctrl->tag_set.driver_data = &ctrl->ctrl;
-	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
-	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
-
-	ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
+	ret = nvme_alloc_io_tag_set(&ctrl->ctrl, &ctrl->tag_set,
+			&nvme_fc_mq_ops, BLK_MQ_F_SHOULD_MERGE,
+			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
+				    ctrl->lport->ops->fcprqst_priv_sz));
 	if (ret)
 		return ret;
 
-	ctrl->ctrl.tagset = &ctrl->tag_set;
-
-	ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
-	if (ret)
-		goto out_free_tag_set;
-
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
-		goto out_cleanup_blk_queue;
+		goto out_cleanup_tagset;
 
 	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
@@ -2943,10 +2923,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 
 out_delete_hw_queues:
 	nvme_fc_delete_hw_io_queues(ctrl);
-out_cleanup_blk_queue:
-	blk_mq_destroy_queue(ctrl->ctrl.connect_q);
-out_free_tag_set:
-	blk_mq_free_tag_set(&ctrl->tag_set);
+out_cleanup_tagset:
+	nvme_remove_io_tag_set(&ctrl->ctrl);
 	nvme_fc_free_io_queues(ctrl);
 
 	/* force put free routine to ignore io queues */
@@ -3530,35 +3508,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	nvme_fc_init_queue(ctrl, 0);
 
-	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
-	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->admin_tag_set.cmd_size =
-		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
-			    ctrl->lport->ops->fcprqst_priv_sz);
-	ctrl->admin_tag_set.driver_data = &ctrl->ctrl;
-	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
-	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
-
-	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
+	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
+			&nvme_fc_admin_mq_ops, BLK_MQ_F_NO_SCHED,
+			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
+				    ctrl->lport->ops->fcprqst_priv_sz));
 	if (ret)
 		goto out_free_queues;
-	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
-
-	ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.fabrics_q)) {
-		ret = PTR_ERR(ctrl->ctrl.fabrics_q);
-		goto out_free_admin_tag_set;
-	}
-
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_q)) {
-		ret = PTR_ERR(ctrl->ctrl.admin_q);
-		goto out_cleanup_fabrics_q;
-	}
 
 	/*
 	 * Would have been nice to init io queues tag set as well.
@@ -3569,7 +3524,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
 	if (ret)
-		goto out_cleanup_admin_q;
+		goto out_cleanup_tagset;
 
 	/* at this point, teardown path changes to ref counting on nvme ctrl */
 
@@ -3624,12 +3579,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	return ERR_PTR(-EIO);
 
-out_cleanup_admin_q:
-	blk_mq_destroy_queue(ctrl->ctrl.admin_q);
-out_cleanup_fabrics_q:
-	blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
-out_free_admin_tag_set:
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
+out_cleanup_tagset:
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_queues:
 	kfree(ctrl->queues);
 out_free_ida:
-- 
2.30.2


