Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E1DC433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 08:53:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C502068F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 08:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K2e+Fcgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C502068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7rbkrhpKyu3HiRP1DM3k3SjCp1X7jYwUGRgyZMbWNGI=; b=K2e+Fcgq3Mba1Vuok6SSQxlT0
	H0aQa4xWHmCdpVgwfD/9vwGS12bZqfXDtEuFwZ9+4Mc35tKOarKJVQlfu+tgkUj8EjvCg601QL09Y
	bhg2NfVsTt1cI2lgumSpjsmuSy6K9doqabPqxlIAXZYeQ9kFB4Zsryp+6sRjtc4UfYLugTN2o59gV
	K32/Cgd1z8J/0AUC2qbZngJoYcKzxrfwnBqxgq/JFQ8LmZrimsbhFlPBmdt7KZqcWb07M41OtGQXc
	iCel5CM0bvHWBhQbDe8hCWCMBYztROkGF42ywTLciDdRpkZSiOS+cLkvS5sCrJ42xxQDX54Js00Ei
	voWS+mU0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juuDW-0002BE-EU; Mon, 13 Jul 2020 08:53:42 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juuDQ-000293-QP
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 08:53:38 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 13 Jul 2020 11:53:30 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06D8rUVv026435;
 Mon, 13 Jul 2020 11:53:30 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, hch@infradead.org, kbusch@kernel.org,
 yaminf@mellanox.com, linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-rdma: use new shared CQ mechanism
Date: Mon, 13 Jul 2020 11:53:29 +0300
Message-Id: <20200713085330.133842-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200713085330.133842-1-maxg@mellanox.com>
References: <20200713085330.133842-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_045337_189015_7EFDDBC4 
X-CRM114-Status: GOOD (  16.68  )
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
Cc: israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com,
 oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>,
 Or Gerlitz <ogerlitz@mellanox.com>
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
index e881f87..467da08 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -96,6 +96,7 @@ struct nvme_rdma_queue {
 	int			cm_error;
 	struct completion	cm_done;
 	bool			pi_support;
+	int			cq_size;
 };
 
 struct nvme_rdma_ctrl {
@@ -275,6 +276,7 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	init_attr.recv_cq = queue->ib_cq;
 	if (queue->pi_support)
 		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
+	init_attr.qp_context = queue;
 
 	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
 
@@ -409,6 +411,14 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
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
@@ -430,7 +440,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	 * the destruction of the QP shouldn't use rdma_cm API.
 	 */
 	ib_destroy_qp(queue->qp);
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
 			sizeof(struct nvme_completion), DMA_FROM_DEVICE);
@@ -450,13 +460,42 @@ static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev, bool pi_support)
 	return min_t(u32, NVME_RDMA_MAX_SEGMENTS, max_page_list_len - 1);
 }
 
+static int nvme_rdma_create_cq(struct ib_device *ibdev,
+		struct nvme_rdma_queue *queue)
+{
+	int ret, comp_vector, idx = nvme_rdma_queue_idx(queue);
+	enum ib_poll_context poll_ctx;
+
+	/*
+	 * Spread I/O queues completion vectors according their queue index.
+	 * Admin queues can always go on completion vector 0.
+	 */
+	comp_vector = (idx == 0 ? idx : idx - 1) % ibdev->num_comp_vectors;
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
@@ -467,26 +506,12 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	}
 	ibdev = queue->device->dev;
 
-	/*
-	 * Spread I/O queues completion vectors according their queue index.
-	 * Admin queues can always go on completion vector 0.
-	 */
-	comp_vector = (idx == 0 ? idx : idx - 1) % ibdev->num_comp_vectors;
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
@@ -512,7 +537,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	if (ret) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to initialize MR pool sized %d for QID %d\n",
-			queue->queue_size, idx);
+			queue->queue_size, nvme_rdma_queue_idx(queue));
 		goto out_destroy_ring;
 	}
 
@@ -523,7 +548,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		if (ret) {
 			dev_err(queue->ctrl->ctrl.device,
 				"failed to initialize PI MR pool sized %d for QID %d\n",
-				queue->queue_size, idx);
+				queue->queue_size, nvme_rdma_queue_idx(queue));
 			goto out_destroy_mr_pool;
 		}
 	}
@@ -540,7 +565,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 out_destroy_qp:
 	rdma_destroy_qp(queue->cm_id);
 out_destroy_ib_cq:
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 out_put_dev:
 	nvme_rdma_dev_put(queue->device);
 	return ret;
@@ -1163,7 +1188,7 @@ static void nvme_rdma_end_request(struct nvme_rdma_request *req)
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 		const char *op)
 {
-	struct nvme_rdma_queue *queue = cq->cq_context;
+	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
@@ -1706,7 +1731,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
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
