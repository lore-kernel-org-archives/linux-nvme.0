Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B2CC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QuitX1f1Nb0FTwlE2z/ckuJpPH+KJiT8dZ6dVs0pcKc=; b=q6Fa3aqLCEYUxQzSfctDJzr5Hd
	laMxBmyxDZAD+2Ot4VOT7pk+3vhToWP2wPERxgeUZZvTIuoK4EflgKimSQPPdrSbT4OWBHr72Zk9Q
	6kmecYBN4OtDMLS/+p+ADvB7gF7dv5ulH5VGy0NZdKmXXDNqMoVcIpSSFkMWPgwdMjigb6t3tNZ9r
	eB/iN3I5Rs98K5xDq+sPC0gmFA2HwheHkZo6WOvMpetBvFx3tA6MnDbKssbUsAgNf9zl57zYd8Vmn
	j0Wy5x6QsevQkOMWw1sngghN59GbvZq2nDnZ1waAa2o/HLhOPeoBEKkxWdwjAybZEkNuoP+ftxxhC
	/xHmz1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagsK-005MCF-AL; Tue, 20 Sep 2022 17:17:36 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagrc-005LhU-IT; Tue, 20 Sep 2022 17:16:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 11/13] nvme-loop: store the generic nvme_ctrl in set->driver_data
Date: Tue, 20 Sep 2022 19:16:09 +0200
Message-Id: <20220920171611.1289361-12-hch@lst.de>
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
 drivers/nvme/target/loop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index ed6d36eb7d295..54578cc18d528 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -204,7 +204,7 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 		struct request *req, unsigned int hctx_idx,
 		unsigned int numa_node)
 {
-	struct nvme_loop_ctrl *ctrl = set->driver_data;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(set->driver_data);
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
 
 	nvme_req(req)->ctrl = &ctrl->ctrl;
@@ -218,7 +218,7 @@ static struct lock_class_key loop_hctx_fq_lock_key;
 static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
-	struct nvme_loop_ctrl *ctrl = data;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(data);
 	struct nvme_loop_queue *queue = &ctrl->queues[hctx_idx + 1];
 
 	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
@@ -238,7 +238,7 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 static int nvme_loop_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
-	struct nvme_loop_ctrl *ctrl = data;
+	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(data);
 	struct nvme_loop_queue *queue = &ctrl->queues[0];
 
 	BUG_ON(hctx_idx != 0);
@@ -357,7 +357,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
-	ctrl->admin_tag_set.driver_data = ctrl;
+	ctrl->admin_tag_set.driver_data = &ctrl->ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
 	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
 	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
@@ -530,7 +530,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
-	ctrl->tag_set.driver_data = ctrl;
+	ctrl->tag_set.driver_data = &ctrl->ctrl;
 	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
 	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
 	ctrl->ctrl.tagset = &ctrl->tag_set;
-- 
2.30.2


