Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F66C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9q0d/mfOI6cotsCSNwjQV8SyH3XpuqKmdmVzf6mCd84=; b=d7FSPVJjRPy7yz6+bSB6CQjw2P
	08DkiOg1PcZhz0XPk9sEAERCTAVot3bjhWLZnQDE8sGyRBcXb6766eg0Hghz+vITbazuNPsZn3jK1
	mytP0RJ3eztfflxkv8+W4Uu6YH1voVVSuX3njwW5MFbBAuTRJg7s3I44kwm+C4AiLWRub2Q2zi3jg
	PnmeO1x4XwzusxVWitpXPLKDhECZEc447BBf/xF0pDRH6wHS70We3d6gi71p2ZnY+NlGI9grqcAKG
	yPQ5Kv1H1JBHnyIW+RJMjRF5HIywitKRH+bCR7zMM65ETXBRA/S2KBU6DnUilA374TNnPekmozEHM
	UjvsiMvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrQ-005Lb9-Cc; Tue, 20 Sep 2022 17:16:40 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrB-005LUK-DF; Tue, 20 Sep 2022 17:16:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 03/13] nvme-tcp: store the generic nvme_ctrl in set->driver_data
Date: Tue, 20 Sep 2022 19:16:01 +0200
Message-Id: <20220920171611.1289361-4-hch@lst.de>
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
 drivers/nvme/host/tcp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a749ef63afee..863e985085d4d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -465,7 +465,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 		struct request *rq, unsigned int hctx_idx,
 		unsigned int numa_node)
 {
-	struct nvme_tcp_ctrl *ctrl = set->driver_data;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(set->driver_data);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_tcp_cmd_pdu *pdu;
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
@@ -489,7 +489,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
-	struct nvme_tcp_ctrl *ctrl = data;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(data);
 	struct nvme_tcp_queue *queue = &ctrl->queues[hctx_idx + 1];
 
 	hctx->driver_data = queue;
@@ -499,7 +499,7 @@ static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 static int nvme_tcp_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
-	struct nvme_tcp_ctrl *ctrl = data;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(data);
 	struct nvme_tcp_queue *queue = &ctrl->queues[0];
 
 	hctx->driver_data = queue;
@@ -1700,7 +1700,7 @@ static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *nctrl)
 	set->numa_node = nctrl->numa_node;
 	set->flags = BLK_MQ_F_BLOCKING;
 	set->cmd_size = sizeof(struct nvme_tcp_request);
-	set->driver_data = ctrl;
+	set->driver_data = &ctrl->ctrl;
 	set->nr_hw_queues = 1;
 	set->timeout = NVME_ADMIN_TIMEOUT;
 	ret = blk_mq_alloc_tag_set(set);
@@ -1722,7 +1722,7 @@ static int nvme_tcp_alloc_tag_set(struct nvme_ctrl *nctrl)
 	set->numa_node = nctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 	set->cmd_size = sizeof(struct nvme_tcp_request);
-	set->driver_data = ctrl;
+	set->driver_data = &ctrl->ctrl;
 	set->nr_hw_queues = nctrl->queue_count - 1;
 	set->timeout = NVME_IO_TIMEOUT;
 	set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
@@ -2486,7 +2486,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 {
-	struct nvme_tcp_ctrl *ctrl = set->driver_data;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(set->driver_data);
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 
 	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
-- 
2.30.2


