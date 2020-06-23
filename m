Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83630C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:55:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8CB20723
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QoULpJFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8CB20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UbN0wdjNaCCCDtjGgNlnBfVrSZwZS9NK470CFbv5Log=; b=QoULpJFac9YKBmghWEoFgrG3x
	IY3QPE2W2zaK74uKsPx6rSLXlaw6n0ojtLfAM2uuI/CG06abAAPbQe+cmo3/K/OTgyKFftN6H6aOH
	sp7kcVJd0SMKrS7BEx0as4kwVjLujKOO216xwyHsIoESp6hu9gaILc5CLsy8hQ16TEqgeiFz2PfoE
	i/Qz7rcvzpeYUHoHcpecwlDe/ADYpKhwzCcRj5PJdaedJPRNCVeadpUU23GfyVtBjgBr/HcEOHlQL
	BvbIXxFkrg3Hxo9c9ky6PofGQt2wwFvnJMJlQDmdbUR+/WkO7/qEmy6Oe+oum0CC63qXenOPsh1sk
	SNDz2PxmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnkL5-00034o-Si; Tue, 23 Jun 2020 14:55:55 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnkKk-0002z1-OU
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 14:55:37 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 23 Jun 2020 17:55:26 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05NEtP7h026949;
 Tue, 23 Jun 2020 17:55:25 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de
Subject: [PATCH 1/3] nvme-rdma: use new shared CQ mechanism
Date: Tue, 23 Jun 2020 17:55:23 +0300
Message-Id: <20200623145525.1586-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200623145525.1586-1-maxg@mellanox.com>
References: <20200623145525.1586-1-maxg@mellanox.com>
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yaminf@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, jgg@nvidia.com, Max Gurtovoy <maxg@mellanox.com>,
 ogerlitz@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Yamin Friedman <yaminf@mellanox.com>

Has the driver use shared CQs providing ~10%-20% improvement as seen in
the patch introducing shared CQs. Instead of opening a CQ for each QP
per controller connected, a CQ for each QP will be provided by the RDMA
core driver that will be shared between the QPs on that core reducing
interrupt overhead.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 77 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f8f856d..f5d6a57 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -96,6 +96,7 @@ struct nvme_rdma_queue {
 	int			cm_error;
 	struct completion	cm_done;
 	bool			pi_support;
+	int			cq_size;
 };
 
 struct nvme_rdma_ctrl {
@@ -274,6 +275,7 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	init_attr.recv_cq = queue->ib_cq;
 	if (queue->pi_support)
 		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
+	init_attr.qp_context = queue;
 
 	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
 
@@ -408,6 +410,14 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
 	return NULL;
 }
 
+static void nvme_rdma_free_cq(struct nvme_rdma_queue *queue)
+{
+	if (nvme_rdma_poll_queue(queue))
+		ib_free_cq(queue->ib_cq);
+	else
+		ib_cq_pool_put(queue->ib_cq, queue->cq_size);
+}
+
 static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_device *dev;
@@ -429,7 +439,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	 * the destruction of the QP shouldn't use rdma_cm API.
 	 */
 	ib_destroy_qp(queue->qp);
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
 			sizeof(struct nvme_completion), DMA_FROM_DEVICE);
@@ -449,13 +459,42 @@ static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev, bool pi_support)
 	return min_t(u32, NVME_RDMA_MAX_SEGMENTS, max_page_list_len - 1);
 }
 
+static int nvme_rdma_create_cq(struct ib_device *ibdev,
+				struct nvme_rdma_queue *queue)
+{
+	int ret, comp_vector, idx = nvme_rdma_queue_idx(queue);
+	enum ib_poll_context poll_ctx;
+
+	/*
+	 * Spread I/O queues completion vectors according their queue index.
+	 * Admin queues can always go on completion vector 0.
+	 */
+	comp_vector = idx == 0 ? idx : idx - 1;
+
+	/* Polling queues need direct cq polling context */
+	if (nvme_rdma_poll_queue(queue)) {
+		poll_ctx = IB_POLL_DIRECT;
+		queue->ib_cq = ib_alloc_cq(ibdev, queue, queue->cq_size,
+					   comp_vector, poll_ctx);
+	} else {
+		poll_ctx = IB_POLL_SOFTIRQ;
+		queue->ib_cq = ib_cq_pool_get(ibdev, queue->cq_size,
+					      comp_vector, poll_ctx);
+	}
+
+	if (IS_ERR(queue->ib_cq)) {
+		ret = PTR_ERR(queue->ib_cq);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct ib_device *ibdev;
 	const int send_wr_factor = 3;			/* MR, SEND, INV */
 	const int cq_factor = send_wr_factor + 1;	/* + RECV */
-	int comp_vector, idx = nvme_rdma_queue_idx(queue);
-	enum ib_poll_context poll_ctx;
 	int ret, pages_per_mr;
 
 	queue->device = nvme_rdma_find_get_device(queue->cm_id);
@@ -466,26 +505,12 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	}
 	ibdev = queue->device->dev;
 
-	/*
-	 * Spread I/O queues completion vectors according their queue index.
-	 * Admin queues can always go on completion vector 0.
-	 */
-	comp_vector = idx == 0 ? idx : idx - 1;
-
-	/* Polling queues need direct cq polling context */
-	if (nvme_rdma_poll_queue(queue))
-		poll_ctx = IB_POLL_DIRECT;
-	else
-		poll_ctx = IB_POLL_SOFTIRQ;
-
 	/* +1 for ib_stop_cq */
-	queue->ib_cq = ib_alloc_cq(ibdev, queue,
-				cq_factor * queue->queue_size + 1,
-				comp_vector, poll_ctx);
-	if (IS_ERR(queue->ib_cq)) {
-		ret = PTR_ERR(queue->ib_cq);
+	queue->cq_size = cq_factor * queue->queue_size + 1;
+
+	ret = nvme_rdma_create_cq(ibdev, queue);
+	if (ret)
 		goto out_put_dev;
-	}
 
 	ret = nvme_rdma_create_qp(queue, send_wr_factor);
 	if (ret)
@@ -511,7 +536,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	if (ret) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to initialize MR pool sized %d for QID %d\n",
-			queue->queue_size, idx);
+			queue->queue_size, nvme_rdma_queue_idx(queue));
 		goto out_destroy_ring;
 	}
 
@@ -522,7 +547,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		if (ret) {
 			dev_err(queue->ctrl->ctrl.device,
 				"failed to initialize PI MR pool sized %d for QID %d\n",
-				queue->queue_size, idx);
+				queue->queue_size, nvme_rdma_queue_idx(queue));
 			goto out_destroy_mr_pool;
 		}
 	}
@@ -539,7 +564,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 out_destroy_qp:
 	rdma_destroy_qp(queue->cm_id);
 out_destroy_ib_cq:
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 out_put_dev:
 	nvme_rdma_dev_put(queue->device);
 	return ret;
@@ -1152,7 +1177,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 		const char *op)
 {
-	struct nvme_rdma_queue *queue = cq->cq_context;
+	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
@@ -1705,7 +1730,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvme_rdma_qe *qe =
 		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
-	struct nvme_rdma_queue *queue = cq->cq_context;
+	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct ib_device *ibdev = queue->device->dev;
 	struct nvme_completion *cqe = qe->data;
 	const size_t len = sizeof(struct nvme_completion);
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
