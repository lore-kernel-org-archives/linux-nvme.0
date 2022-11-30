Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63192C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MGYvMXC6BGf2ZjnWqSClf/edCw+b7V7C3X0+LwQwOAs=; b=k6ESsnTS9q7vzPhBCkp6Jg77I6
	esrqXWW4DGgbnMagnsawDEoG1mXan0BwPx1e238jbQ30H2IkkkF3/QnIAYcOHWZdAiEKtO/cfRwNh
	WtJJV3LUbR2tPS9+PJUNjR9OTaavZlh5l17N6RoCHKjsJDW3B9wc1ygOp2diHZLuGbTPUGz/PnX/y
	uuUmpN3oBhjzEjQRmCVAnAWGgLY0L/2IyBovM80jTuwE+1YK7/3RGlNPAPRsD/8cKTey3NL7PNxmM
	Lg7acTpgLKHomUomcUiEJpwUyK4Vr0XNKK2VmQgcAWS4O5m4m+4geJ3RVaBjQu2w1lyWIoVuGQT7P
	vaek6PtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0RMA-001I55-UY; Wed, 30 Nov 2022 17:58:50 +0000
Received: from [2001:4bb8:192:26e7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0R6e-0017XQ-P7; Wed, 30 Nov 2022 17:42:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/5] nvme: consolidate setting the tagset flags
Date: Wed, 30 Nov 2022 18:42:36 +0100
Message-Id: <20221130174240.227616-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130174240.227616-1-hch@lst.de>
References: <20221130174240.227616-1-hch@lst.de>
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

All nvme transports should be using the same flags for their tagsets,
with the exception for the blocking flag that should only be set for
transports that can block in ->queue_rq.

Add a NVME_F_BLOCKING flag to nvme_ctrl_ops to control the blocking
behavior and lift setting the flags into nvme_alloc_{admin,io}_tag_set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c   | 15 +++++++++------
 drivers/nvme/host/fc.c     |  4 ++--
 drivers/nvme/host/nvme.h   |  9 +++++----
 drivers/nvme/host/rdma.c   |  3 +--
 drivers/nvme/host/tcp.c    |  3 +--
 drivers/nvme/target/loop.c |  4 ++--
 6 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b369900928fde..f31586c4689334 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4831,8 +4831,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
 int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
-		const struct blk_mq_ops *ops, unsigned int flags,
-		unsigned int cmd_size)
+		const struct blk_mq_ops *ops, unsigned int cmd_size)
 {
 	int ret;
 
@@ -4842,7 +4841,9 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ctrl->ops->flags & NVME_F_FABRICS)
 		set->reserved_tags = NVMF_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
-	set->flags = flags;
+	set->flags = BLK_MQ_F_NO_SCHED;
+	if (ctrl->ops->flags & NVME_F_BLOCKING)
+		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size;
 	set->driver_data = ctrl;
 	set->nr_hw_queues = 1;
@@ -4890,8 +4891,8 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
 
 int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
-		const struct blk_mq_ops *ops, unsigned int flags,
-		unsigned int nr_maps, unsigned int cmd_size)
+		const struct blk_mq_ops *ops, unsigned int nr_maps,
+		unsigned int cmd_size)
 {
 	int ret;
 
@@ -4900,7 +4901,9 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->queue_depth = ctrl->sqsize + 1;
 	set->reserved_tags = NVMF_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
-	set->flags = flags;
+	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	if (ctrl->ops->flags & NVME_F_BLOCKING)
+		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size,
 	set->driver_data = ctrl;
 	set->nr_hw_queues = ctrl->queue_count - 1;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 60656e7fd945ca..476cd7fa087b5a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2904,7 +2904,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_init_io_queues(ctrl);
 
 	ret = nvme_alloc_io_tag_set(&ctrl->ctrl, &ctrl->tag_set,
-			&nvme_fc_mq_ops, BLK_MQ_F_SHOULD_MERGE, 1,
+			&nvme_fc_mq_ops, 1,
 			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 				    ctrl->lport->ops->fcprqst_priv_sz));
 	if (ret)
@@ -3510,7 +3510,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	nvme_fc_init_queue(ctrl, 0);
 
 	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
-			&nvme_fc_admin_mq_ops, BLK_MQ_F_NO_SCHED,
+			&nvme_fc_admin_mq_ops,
 			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 				    ctrl->lport->ops->fcprqst_priv_sz));
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6c4565435fd90f..6bbb73ef8b2548 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -512,6 +512,8 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
+#define NVME_F_BLOCKING			(1 << 2)
+
 	const struct attribute_group **dev_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
@@ -742,12 +744,11 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended);
 int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
-		const struct blk_mq_ops *ops, unsigned int flags,
-		unsigned int cmd_size);
+		const struct blk_mq_ops *ops, unsigned int cmd_size);
 void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl);
 int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
-		const struct blk_mq_ops *ops, unsigned int flags,
-		unsigned int nr_maps, unsigned int cmd_size);
+		const struct blk_mq_ops *ops, unsigned int nr_maps,
+		unsigned int cmd_size);
 void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cf8f500405b195..bbad26b82b56dd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -798,7 +798,7 @@ static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
 			    NVME_RDMA_METADATA_SGL_SIZE;
 
 	return nvme_alloc_io_tag_set(ctrl, &to_rdma_ctrl(ctrl)->tag_set,
-			&nvme_rdma_mq_ops, BLK_MQ_F_SHOULD_MERGE,
+			&nvme_rdma_mq_ops,
 			ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
 			cmd_size);
 }
@@ -848,7 +848,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (new) {
 		error = nvme_alloc_admin_tag_set(&ctrl->ctrl,
 				&ctrl->admin_tag_set, &nvme_rdma_admin_mq_ops,
-				BLK_MQ_F_NO_SCHED,
 				sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE);
 		if (error)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fa245a50f630b8..7cfc1bc021085f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1858,7 +1858,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (new) {
 		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
 				&nvme_tcp_mq_ops,
-				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING,
 				ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
 				sizeof(struct nvme_tcp_request));
 		if (ret)
@@ -1934,7 +1933,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (new) {
 		error = nvme_alloc_admin_tag_set(ctrl,
 				&to_tcp_ctrl(ctrl)->admin_tag_set,
-				&nvme_tcp_admin_mq_ops, BLK_MQ_F_BLOCKING,
+				&nvme_tcp_admin_mq_ops,
 				sizeof(struct nvme_tcp_request));
 		if (error)
 			goto out_free_queue;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index da32727e6232d8..f2d24b2d992f87 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -353,7 +353,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->ctrl.queue_count = 1;
 
 	error = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
-			&nvme_loop_admin_mq_ops, BLK_MQ_F_NO_SCHED,
+			&nvme_loop_admin_mq_ops,
 			sizeof(struct nvme_loop_iod) +
 			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (error)
@@ -494,7 +494,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 		return ret;
 
 	ret = nvme_alloc_io_tag_set(&ctrl->ctrl, &ctrl->tag_set,
-			&nvme_loop_mq_ops, BLK_MQ_F_SHOULD_MERGE, 1,
+			&nvme_loop_mq_ops, 1,
 			sizeof(struct nvme_loop_iod) +
 			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (ret)
-- 
2.30.2


