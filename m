Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB9CC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/d4aLO8J598xWVY+YfAFI5Z8NDWMizl/3Y3tLFJylpo=; b=dXiSI/Uh3cdI8WAuxfgQ6a95iZ
	ouRr8aCRUXyYqRJ1ToMWckCLIpAKAV+rAwdizkX2hpPGqYmIDgmv1OU6uo+8HTwltd71nH3d3OwO5
	iwaEn2Q6BJbVW5CzG/D9Xxvr7+dOKiXUovzyYPOCpOLZ1aLotkiWtaEis1pDKPJ+RwrRtaZWM2jap
	MPI07gdG03Vl7Vkc8cZaGliXHRDp5fV7Ycazxu3/mbSEDzHMsSI1q10pQ0u9IdhcRWHHanEuUE/nX
	LWPjk5zKR3uf+qmZab2IbvWyjxkxEAfVuNHe8CnCUXTBSmQbYBPXWkL81laVvXUE/CLktvajUbMD/
	v0tApIYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagru-005Luk-HS; Tue, 20 Sep 2022 17:17:10 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrT-005LcG-Mq; Tue, 20 Sep 2022 17:16:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 08/13] nvme-fc: store the generic nvme_ctrl in set->driver_data
Date: Tue, 20 Sep 2022 19:16:06 +0200
Message-Id: <20220920171611.1289361-9-hch@lst.de>
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
of using the common tagset init/exit code and use the chance the cleanup
the init_hctx methods a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ee376111f5610..d707cf93f1f4b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1829,7 +1829,7 @@ nvme_fc_exit_request(struct blk_mq_tag_set *set, struct request *rq,
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 
-	return __nvme_fc_exit_request(set->driver_data, op);
+	return __nvme_fc_exit_request(to_fc_ctrl(set->driver_data), op);
 }
 
 static int
@@ -2135,7 +2135,7 @@ static int
 nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 		unsigned int hctx_idx, unsigned int numa_node)
 {
-	struct nvme_fc_ctrl *ctrl = set->driver_data;
+	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(set->driver_data);
 	struct nvme_fcp_op_w_sgl *op = blk_mq_rq_to_pdu(rq);
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_fc_queue *queue = &ctrl->queues[queue_idx];
@@ -2206,36 +2206,28 @@ nvme_fc_term_aen_ops(struct nvme_fc_ctrl *ctrl)
 	}
 }
 
-static inline void
-__nvme_fc_init_hctx(struct blk_mq_hw_ctx *hctx, struct nvme_fc_ctrl *ctrl,
-		unsigned int qidx)
+static inline int
+__nvme_fc_init_hctx(struct blk_mq_hw_ctx *hctx, void *data, unsigned int qidx)
 {
+	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(data);
 	struct nvme_fc_queue *queue = &ctrl->queues[qidx];
 
 	hctx->driver_data = queue;
 	queue->hctx = hctx;
+	return 0;
 }
 
 static int
-nvme_fc_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-		unsigned int hctx_idx)
+nvme_fc_init_hctx(struct blk_mq_hw_ctx *hctx, void *data, unsigned int hctx_idx)
 {
-	struct nvme_fc_ctrl *ctrl = data;
-
-	__nvme_fc_init_hctx(hctx, ctrl, hctx_idx + 1);
-
-	return 0;
+	return __nvme_fc_init_hctx(hctx, data, hctx_idx + 1);
 }
 
 static int
 nvme_fc_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
-	struct nvme_fc_ctrl *ctrl = data;
-
-	__nvme_fc_init_hctx(hctx, ctrl, hctx_idx);
-
-	return 0;
+	return __nvme_fc_init_hctx(hctx, data, hctx_idx);
 }
 
 static void
@@ -2862,7 +2854,7 @@ nvme_fc_complete_rq(struct request *rq)
 
 static void nvme_fc_map_queues(struct blk_mq_tag_set *set)
 {
-	struct nvme_fc_ctrl *ctrl = set->driver_data;
+	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(set->driver_data);
 	int i;
 
 	for (i = 0; i < set->nr_maps; i++) {
@@ -2923,7 +2915,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	ctrl->tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 			    ctrl->lport->ops->fcprqst_priv_sz);
-	ctrl->tag_set.driver_data = ctrl;
+	ctrl->tag_set.driver_data = &ctrl->ctrl;
 	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
 	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
 
@@ -3546,7 +3538,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->admin_tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 			    ctrl->lport->ops->fcprqst_priv_sz);
-	ctrl->admin_tag_set.driver_data = ctrl;
+	ctrl->admin_tag_set.driver_data = &ctrl->ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
 	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
 	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
-- 
2.30.2


