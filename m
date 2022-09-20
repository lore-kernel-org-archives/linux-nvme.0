Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63347C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHeSKufaBRlKo3zX79pbW5QPnK2usifVm+Ty6B1GE3A=; b=Sh/uRJJv9fJ9aqLpn5ZjW4i116
	5LitnnXY4TMiFbDGZvpEIOEDtpO5LU7V7q7/w/LJIRU5pJu9D8WFncL1WtIYegK+R406tf1apkp8t
	GISxgbSN1J0x/1+oWI9izapbypQ1oU06EYtQIqOMO6FVKfdqiPDfclggzBXrEOWjE0UM4OT3WyI6+
	j6ya9gse8VJ33xpis9+y42mWTHSIeJ3HHdVS6SXgKz+dYtqP2jiLRJATrMa6zto2AZmkq+7M9EZuj
	wdOo0zYGfQzsJI1eeh68FZkhXLavAkDGx6j5n4Vukrj5DMSSYHzMfUE+7bgCcTzJEgdX0rNOtEx3D
	UbRVL/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagri-005Lmn-Qf; Tue, 20 Sep 2022 17:16:59 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrN-005LZA-R0; Tue, 20 Sep 2022 17:16:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 06/13] nvme-rdma: use the tagset alloc/free helpers
Date: Tue, 20 Sep 2022 19:16:04 +0200
Message-Id: <20220920171611.1289361-7-hch@lst.de>
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
data instead of the nvme_rdma_ctrl.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 133 ++++++++++-----------------------------
 1 file changed, 34 insertions(+), 99 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8bc2930fd496e..5ad0ab2853a49 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -788,64 +788,21 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *nctrl)
+static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
 {
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct blk_mq_tag_set *set = &ctrl->admin_tag_set;
-	int ret;
+	unsigned int cmd_size = sizeof(struct nvme_rdma_request) +
+				NVME_RDMA_DATA_SGL_SIZE;
 
-	memset(set, 0, sizeof(*set));
-	set->ops = &nvme_rdma_admin_mq_ops;
-	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = nctrl->numa_node;
-	set->cmd_size = sizeof(struct nvme_rdma_request) +
-			NVME_RDMA_DATA_SGL_SIZE;
-	set->driver_data = &ctrl->ctrl;
-	set->nr_hw_queues = 1;
-	set->timeout = NVME_ADMIN_TIMEOUT;
-	set->flags = BLK_MQ_F_NO_SCHED;
-	ret = blk_mq_alloc_tag_set(set);
-	if (!ret)
-		ctrl->ctrl.admin_tagset = set;
-	return ret;
-}
-
-static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *nctrl)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct blk_mq_tag_set *set = &ctrl->tag_set;
-	int ret;
+	if (ctrl->max_integrity_segments)
+		cmd_size += sizeof(struct nvme_rdma_sgl) +
+			    NVME_RDMA_METADATA_SGL_SIZE;
 
-	memset(set, 0, sizeof(*set));
-	set->ops = &nvme_rdma_mq_ops;
-	set->queue_depth = nctrl->sqsize + 1;
-	set->reserved_tags = NVMF_RESERVED_TAGS;
-	set->numa_node = nctrl->numa_node;
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	set->cmd_size = sizeof(struct nvme_rdma_request) +
-			NVME_RDMA_DATA_SGL_SIZE;
-	if (nctrl->max_integrity_segments)
-		set->cmd_size += sizeof(struct nvme_rdma_sgl) +
-				 NVME_RDMA_METADATA_SGL_SIZE;
-	set->driver_data = &ctrl->ctrl;
-	set->nr_hw_queues = nctrl->queue_count - 1;
-	set->timeout = NVME_IO_TIMEOUT;
-	set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
-	ret = blk_mq_alloc_tag_set(set);
-	if (!ret)
-		ctrl->ctrl.tagset = set;
-	return ret;
+	return nvme_alloc_io_tag_set(ctrl, &to_rdma_ctrl(ctrl)->tag_set,
+			&nvme_rdma_mq_ops, BLK_MQ_F_SHOULD_MERGE, cmd_size);
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
-		bool remove)
+static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 {
-	if (remove) {
-		blk_mq_destroy_queue(ctrl->ctrl.admin_q);
-		blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
-		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
-	}
 	if (ctrl->async_event_sqe.data) {
 		cancel_work_sync(&ctrl->ctrl.async_event_work);
 		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
@@ -887,26 +844,19 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_free_queue;
 
 	if (new) {
-		error = nvme_rdma_alloc_admin_tag_set(&ctrl->ctrl);
+		error = nvme_alloc_admin_tag_set(&ctrl->ctrl,
+				&ctrl->admin_tag_set, &nvme_rdma_admin_mq_ops,
+				BLK_MQ_F_NO_SCHED,
+				sizeof(struct nvme_rdma_request) +
+				NVME_RDMA_DATA_SGL_SIZE);
 		if (error)
 			goto out_free_async_qe;
 
-		ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-		if (IS_ERR(ctrl->ctrl.fabrics_q)) {
-			error = PTR_ERR(ctrl->ctrl.fabrics_q);
-			goto out_free_tagset;
-		}
-
-		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-		if (IS_ERR(ctrl->ctrl.admin_q)) {
-			error = PTR_ERR(ctrl->ctrl.admin_q);
-			goto out_cleanup_fabrics_q;
-		}
 	}
 
 	error = nvme_rdma_start_queue(ctrl, 0);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_remove_admin_tag_set;
 
 	error = nvme_enable_ctrl(&ctrl->ctrl);
 	if (error)
@@ -933,15 +883,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 out_stop_queue:
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
-out_cleanup_queue:
+out_remove_admin_tag_set:
 	if (new)
-		blk_mq_destroy_queue(ctrl->ctrl.admin_q);
-out_cleanup_fabrics_q:
-	if (new)
-		blk_mq_destroy_queue(ctrl->ctrl.fabrics_q);
-out_free_tagset:
-	if (new)
-		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_async_qe:
 	if (ctrl->async_event_sqe.data) {
 		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
@@ -953,16 +897,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	return error;
 }
 
-static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
-		bool remove)
-{
-	if (remove) {
-		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(ctrl->ctrl.tagset);
-	}
-	nvme_rdma_free_io_queues(ctrl);
-}
-
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -975,10 +909,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		ret = nvme_rdma_alloc_tag_set(&ctrl->ctrl);
 		if (ret)
 			goto out_free_io_queues;
-
-		ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
-		if (ret)
-			goto out_free_tag_set;
 	}
 
 	/*
@@ -989,7 +919,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
 	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
 	if (ret)
-		goto out_cleanup_connect_q;
+		goto out_cleanup_tagset;
 
 	if (!new) {
 		nvme_start_queues(&ctrl->ctrl);
@@ -1022,13 +952,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	nvme_stop_queues(&ctrl->ctrl);
 	nvme_sync_io_queues(&ctrl->ctrl);
 	nvme_rdma_stop_io_queues(ctrl);
-out_cleanup_connect_q:
+out_cleanup_tagset:
 	nvme_cancel_tagset(&ctrl->ctrl);
 	if (new)
-		blk_mq_destroy_queue(ctrl->ctrl.connect_q);
-out_free_tag_set:
-	if (new)
-		blk_mq_free_tag_set(ctrl->ctrl.tagset);
+		nvme_remove_io_tag_set(&ctrl->ctrl);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
@@ -1041,9 +968,11 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (remove)
+	if (remove) {
 		nvme_start_admin_queue(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl, remove);
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
+	}
+	nvme_rdma_destroy_admin_queue(ctrl);
 }
 
 static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
@@ -1055,9 +984,11 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		nvme_cancel_tagset(&ctrl->ctrl);
-		if (remove)
+		if (remove) {
 			nvme_start_queues(&ctrl->ctrl);
-		nvme_rdma_destroy_io_queues(ctrl, remove);
+			nvme_remove_io_tag_set(&ctrl->ctrl);
+		}
+		nvme_rdma_free_io_queues(ctrl);
 	}
 }
 
@@ -1179,14 +1110,18 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		nvme_cancel_tagset(&ctrl->ctrl);
-		nvme_rdma_destroy_io_queues(ctrl, new);
+		if (new)
+			nvme_remove_io_tag_set(&ctrl->ctrl);
+		nvme_rdma_free_io_queues(ctrl);
 	}
 destroy_admin:
 	nvme_stop_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl, new);
+	if (new)
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
+	nvme_rdma_destroy_admin_queue(ctrl);
 	return ret;
 }
 
-- 
2.30.2


