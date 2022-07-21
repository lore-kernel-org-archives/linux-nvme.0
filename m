Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E855C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f75wDeMZD86AoK+eEym99EwGtymt925y5QmL2xxJWao=; b=LjGzfWsh9J6umspRJX93kSjRu7
	i0vUd51pLPiQrW0X3oXPejpiHUNTB2LLru+7IwZ/Pl9gktckVD77O23D/tNfwlw0+gS8SFBAKR8om
	C/3zZOFwEi5a3EQ34BuEk5wu5wFNquHlRTLjy8JprF3u5QW87Z+ZZXsgX+u5GlGGCDfIgm0xIk9mO
	Tc4q1O8oPTTN28q8Jz9WDwnJDawvr1UZPeNrLXJyGh41koRrrLFNsRvxp/3V5j5FHBJIsHRo2WCiY
	Oy3B9bLP0P/hDgCUwoAQXGC+VmI6G2lMGNncJ//72/ePTahJKoflZfku3AancqOtFGm/nn9qz4orJ
	Qe+PhLQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPcg-000ycU-IN; Thu, 21 Jul 2022 06:25:22 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPcX-000yVa-Tw; Thu, 21 Jul 2022 06:25:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme-rdma: split nvme_rdma_alloc_tagset
Date: Thu, 21 Jul 2022 08:25:05 +0200
Message-Id: <20220721062506.1712176-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721062506.1712176-1-hch@lst.de>
References: <20220721062506.1712176-1-hch@lst.de>
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

Split nvme_rdma_alloc_tagset into one helper for the admin tag_set and
one for the I/O tag set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 92 ++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7d01fb7702842..7f4f80f3b524a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -787,50 +787,54 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
-		bool admin)
+static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct blk_mq_tag_set *set;
+	struct blk_mq_tag_set *set = &ctrl->admin_tag_set;
 	int ret;
 
-	if (admin) {
-		set = &ctrl->admin_tag_set;
-		memset(set, 0, sizeof(*set));
-		set->ops = &nvme_rdma_admin_mq_ops;
-		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
-		set->numa_node = nctrl->numa_node;
-		set->cmd_size = sizeof(struct nvme_rdma_request) +
-				NVME_RDMA_DATA_SGL_SIZE;
-		set->driver_data = ctrl;
-		set->nr_hw_queues = 1;
-		set->timeout = NVME_ADMIN_TIMEOUT;
-		set->flags = BLK_MQ_F_NO_SCHED;
-	} else {
-		set = &ctrl->tag_set;
-		memset(set, 0, sizeof(*set));
-		set->ops = &nvme_rdma_mq_ops;
-		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
-		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_SHOULD_MERGE;
-		set->cmd_size = sizeof(struct nvme_rdma_request) +
-				NVME_RDMA_DATA_SGL_SIZE;
-		if (nctrl->max_integrity_segments)
-			set->cmd_size += sizeof(struct nvme_rdma_sgl) +
-					 NVME_RDMA_METADATA_SGL_SIZE;
-		set->driver_data = ctrl;
-		set->nr_hw_queues = nctrl->queue_count - 1;
-		set->timeout = NVME_IO_TIMEOUT;
-		set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
-	}
-
+	memset(set, 0, sizeof(*set));
+	set->ops = &nvme_rdma_admin_mq_ops;
+	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+	set->reserved_tags = NVMF_RESERVED_TAGS;
+	set->numa_node = nctrl->numa_node;
+	set->cmd_size = sizeof(struct nvme_rdma_request) +
+			NVME_RDMA_DATA_SGL_SIZE;
+	set->driver_data = ctrl;
+	set->nr_hw_queues = 1;
+	set->timeout = NVME_ADMIN_TIMEOUT;
+	set->flags = BLK_MQ_F_NO_SCHED;
 	ret = blk_mq_alloc_tag_set(set);
-	if (ret)
-		return ERR_PTR(ret);
+	if (!ret)
+		ctrl->ctrl.admin_tagset = set;
+	return ret;
+}
 
-	return set;
+static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *nctrl)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int ret;
+
+	memset(set, 0, sizeof(*set));
+	set->ops = &nvme_rdma_mq_ops;
+	set->queue_depth = nctrl->sqsize + 1;
+	set->reserved_tags = NVMF_RESERVED_TAGS;
+	set->numa_node = nctrl->numa_node;
+	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	set->cmd_size = sizeof(struct nvme_rdma_request) +
+			NVME_RDMA_DATA_SGL_SIZE;
+	if (nctrl->max_integrity_segments)
+		set->cmd_size += sizeof(struct nvme_rdma_sgl) +
+				 NVME_RDMA_METADATA_SGL_SIZE;
+	set->driver_data = ctrl;
+	set->nr_hw_queues = nctrl->queue_count - 1;
+	set->timeout = NVME_IO_TIMEOUT;
+	set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
+	ret = blk_mq_alloc_tag_set(set);
+	if (!ret)
+		ctrl->ctrl.tagset = set;
+	return ret;
 }
 
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -882,11 +886,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_free_queue;
 
 	if (new) {
-		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
-		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
-			error = PTR_ERR(ctrl->ctrl.admin_tagset);
+		error = nvme_rdma_alloc_admin_tag_set(&ctrl->ctrl);
+		if (error)
 			goto out_free_async_qe;
-		}
 
 		ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 		if (IS_ERR(ctrl->ctrl.fabrics_q)) {
@@ -969,11 +971,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
-		if (IS_ERR(ctrl->ctrl.tagset)) {
-			ret = PTR_ERR(ctrl->ctrl.tagset);
+		ret = nvme_rdma_alloc_tag_set(&ctrl->ctrl);
+		if (ret)
 			goto out_free_io_queues;
-		}
 
 		ret = nvme_ctrl_init_connect_q(&(ctrl->ctrl));
 		if (ret)
-- 
2.30.2


