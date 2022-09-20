Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8BCC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4scbWAs4RAiKjLz4QiL1BRdY9zXNpLFRNlaM7uUEOyA=; b=Ynhe9UAwdXaHH47sJuXcfiYAc3
	CcF84y0E8iJUnNXqdfUeUDxLVzw8BVgDhvdBkTDeph9Ue8BEvgL94FYilQZ0lpN/hfkh/jGYYezVx
	3L9ThoxPMN+Q/Rl34fzIZr5jcW37a+7DZKnyOgkZjwr0ZcEoApworVcIxpEJ2cLzPpSK80oFddLNU
	gMrZcAoyouKgj7LDwJmB7b2Y2a+nGOzlohSL3NetJbBWcHcsxCnP4SRBrbzy8NDiIT0lUvMTleX7T
	bGBU7b88byw4qHlqDPR57bOSKfvkMdUxc3Pz+rbSzJwpqRh0h0A5rfT7Jq99WA2yl3vmJPHA9GyN7
	f2CypYtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrc-005Lih-MF; Tue, 20 Sep 2022 17:16:52 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrK-005LXQ-Jj; Tue, 20 Sep 2022 17:16:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 05/13] nvme-rdma: store the generic nvme_ctrl in set->driver_data
Date: Tue, 20 Sep 2022 19:16:03 +0200
Message-Id: <20220920171611.1289361-6-hch@lst.de>
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

Point the private data to the generic controller structure in preparation
of using the common tagset init/exit code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4c6df34f9d7ac..8bc2930fd496e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -295,7 +295,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 		struct request *rq, unsigned int hctx_idx,
 		unsigned int numa_node)
 {
-	struct nvme_rdma_ctrl *ctrl = set->driver_data;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(set->driver_data);
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_rdma_queue *queue = &ctrl->queues[queue_idx];
@@ -320,7 +320,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 static int nvme_rdma_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
-	struct nvme_rdma_ctrl *ctrl = data;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(data);
 	struct nvme_rdma_queue *queue = &ctrl->queues[hctx_idx + 1];
 
 	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
@@ -332,7 +332,7 @@ static int nvme_rdma_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 static int nvme_rdma_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
-	struct nvme_rdma_ctrl *ctrl = data;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(data);
 	struct nvme_rdma_queue *queue = &ctrl->queues[0];
 
 	BUG_ON(hctx_idx != 0);
@@ -801,7 +801,7 @@ static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *nctrl)
 	set->numa_node = nctrl->numa_node;
 	set->cmd_size = sizeof(struct nvme_rdma_request) +
 			NVME_RDMA_DATA_SGL_SIZE;
-	set->driver_data = ctrl;
+	set->driver_data = &ctrl->ctrl;
 	set->nr_hw_queues = 1;
 	set->timeout = NVME_ADMIN_TIMEOUT;
 	set->flags = BLK_MQ_F_NO_SCHED;
@@ -828,7 +828,7 @@ static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *nctrl)
 	if (nctrl->max_integrity_segments)
 		set->cmd_size += sizeof(struct nvme_rdma_sgl) +
 				 NVME_RDMA_METADATA_SGL_SIZE;
-	set->driver_data = ctrl;
+	set->driver_data = &ctrl->ctrl;
 	set->nr_hw_queues = nctrl->queue_count - 1;
 	set->timeout = NVME_IO_TIMEOUT;
 	set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
@@ -2206,7 +2206,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 
 static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
-	struct nvme_rdma_ctrl *ctrl = set->driver_data;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(set->driver_data);
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 
 	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
-- 
2.30.2


