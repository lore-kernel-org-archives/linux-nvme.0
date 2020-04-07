Return-Path: <SRS0=aJh0=5X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C9C2BB55
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2020 11:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45170206F7
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2020 11:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rvDxvo1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45170206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LHC/yAaIAiTo9qv4QWt8yBNRsX5WvxcQyUvK69dcByU=; b=rvD
	xvo1qFuLjinywfnjPWwM4Ej4dndjmOjjT1yvO4WPUD3/sD3j9cPaZ4arsOznmPSRzcEcG7H1+eH5d
	76gGliZ7q+FwbMVbDjDXRtkIXaWLRZ+tbRJXHfJ8kHth861unYa46kcMO+ylBoFH/BV/yuL3n5UH+
	0QZRAeNMbUXegb4DLSujUGkXDiqsWT0FCWb8RqjTwgcT5K4f0HhIghzwgl9IXPdAlccWjpvt/x2n5
	Cynpet1PC+xiynI+VzjixlNZd76Kb6mAcsiIDemTVGf7+KdIwy7C+ViGQpXjIh5F9QGgX46pkL0Ns
	PlQfIp9iz4NUDeaRp1ekqmfcYzWKXvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLm0E-0004t5-T7; Tue, 07 Apr 2020 11:02:46 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLm0A-0004sX-Av
 for linux-nvme@lists.infradead.org; Tue, 07 Apr 2020 11:02:44 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 7 Apr 2020 14:02:34 +0300
Received: from rsws48.mtr.labs.mlnx (rsws48.mtr.labs.mlnx [10.209.40.48])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 037B2Ygp001269;
 Tue, 7 Apr 2020 14:02:34 +0300
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] nvmet-rdma: Fix double free of rdma queue
Date: Tue,  7 Apr 2020 11:02:28 +0000
Message-Id: <1586257348-16216-1-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_040242_776251_D3A66F5C 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In case rdma accept fails at nvmet_rdma_queue_connect(), release work is
scheduled. Later on, a new RDMA CM event may arrive since we didn't
destroy the cm-id and call nvmet_rdma_queue_connect_fail(), which schedule
another release work. This will cause calling nvmet_rdma_free_queue twice.
To fix this we implicitly destroy the cm_id with non-zero ret code, which
guarantees that new rdma_cm events will not arrive afterwards.
Also add a qp pointer to nvmet_rdma_queue structure, so we can use it when
the cm_id pointer is NULL or was destroyed.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
Changes from v1:
 - Implicitly destroy the cm_id with non-zero ret code
 - Add a qp pointer to nvmet_rdma_queue structure

 drivers/nvme/target/rdma.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a..54b840d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -75,6 +75,7 @@ enum nvmet_rdma_queue_state {
 
 struct nvmet_rdma_queue {
 	struct rdma_cm_id	*cm_id;
+	struct ib_qp		*qp;
 	struct nvmet_port	*port;
 	struct ib_cq		*cq;
 	atomic_t		sq_wr_avail;
@@ -464,7 +465,7 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 	if (ndev->srq)
 		ret = ib_post_srq_recv(ndev->srq, &cmd->wr, NULL);
 	else
-		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, NULL);
+		ret = ib_post_recv(cmd->queue->qp, &cmd->wr, NULL);
 
 	if (unlikely(ret))
 		pr_err("post_recv cmd failed\n");
@@ -503,7 +504,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 	atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
 
 	if (rsp->n_rdma) {
-		rdma_rw_ctx_destroy(&rsp->rw, queue->cm_id->qp,
+		rdma_rw_ctx_destroy(&rsp->rw, queue->qp,
 				queue->cm_id->port_num, rsp->req.sg,
 				rsp->req.sg_cnt, nvmet_data_dir(&rsp->req));
 	}
@@ -587,7 +588,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	WARN_ON(rsp->n_rdma <= 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
-	rdma_rw_ctx_destroy(&rsp->rw, queue->cm_id->qp,
+	rdma_rw_ctx_destroy(&rsp->rw, queue->qp,
 			queue->cm_id->port_num, rsp->req.sg,
 			rsp->req.sg_cnt, nvmet_data_dir(&rsp->req));
 	rsp->n_rdma = 0;
@@ -742,7 +743,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 	}
 
 	if (nvmet_rdma_need_data_in(rsp)) {
-		if (rdma_rw_ctx_post(&rsp->rw, queue->cm_id->qp,
+		if (rdma_rw_ctx_post(&rsp->rw, queue->qp,
 				queue->cm_id->port_num, &rsp->read_cqe, NULL))
 			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
 	} else {
@@ -1025,6 +1026,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 		pr_err("failed to create_qp ret= %d\n", ret);
 		goto err_destroy_cq;
 	}
+	queue->qp = queue->cm_id->qp;
 
 	atomic_set(&queue->sq_wr_avail, qp_attr.cap.max_send_wr);
 
@@ -1053,11 +1055,10 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 
 static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 {
-	struct ib_qp *qp = queue->cm_id->qp;
-
-	ib_drain_qp(qp);
-	rdma_destroy_id(queue->cm_id);
-	ib_destroy_qp(qp);
+	ib_drain_qp(queue->qp);
+	if (queue->cm_id)
+		rdma_destroy_id(queue->cm_id);
+	ib_destroy_qp(queue->qp);
 	ib_free_cq(queue->cq);
 }
 
@@ -1291,9 +1292,12 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
 	if (ret) {
-		schedule_work(&queue->release_work);
-		/* Destroying rdma_cm id is not needed here */
-		return 0;
+		/*
+		 * Don't destroy the cm_id in free path, as we implicitly
+		 * destroy the cm_id here with non-zero ret code.
+		 */
+		queue->cm_id = NULL;
+		goto free_queue;
 	}
 
 	mutex_lock(&nvmet_rdma_queue_mutex);
@@ -1302,6 +1306,8 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 
 	return 0;
 
+free_queue:
+	nvmet_rdma_free_queue(queue);
 put_device:
 	kref_put(&ndev->ref, nvmet_rdma_free_dev);
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
