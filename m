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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A56DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 08:53:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675BE2068F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 08:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CMMDMNwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675BE2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lzz23J5Dnss1Vk99FnArkWQved3wUtkYDJ3I/DU6pbM=; b=CMMDMNwt4Z2x3jj9lOTEw6Y3l
	CUV+qnYSUjrfsmdMPh5d2gDjYM7EpGTjFUzwtMC+Zk81InriBlE4PeBOzRvONtCWyJJXaEVOKKGnN
	pyijriyEOsVFmYaef77ptQGesxzaVS/clhCzsktAPQsnK7Vj61heT+1ivtp0UyzwGhPZ2kYzHQom3
	KMi2NbfiN9xaMBdnby/3Hfj1sYgKhNXk3szsZFULaq07b680g8pzSD8Tf74CqhMwLcD6evIFFtzVB
	MGyGgH1Kfs3L597becKUA+u7aeasFz656+3WKLb8qQNzWzSNz6n6DsebytHeZe4dwz2bGwB5FRpKA
	5qPiStI1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juuDV-0002An-5B; Mon, 13 Jul 2020 08:53:41 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juuDQ-000292-Qw
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 08:53:38 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 13 Jul 2020 11:53:30 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06D8rUVw026435;
 Mon, 13 Jul 2020 11:53:30 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, hch@infradead.org, kbusch@kernel.org,
 yaminf@mellanox.com, linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet-rdma: use new shared CQ mechanism
Date: Mon, 13 Jul 2020 11:53:30 +0300
Message-Id: <20200713085330.133842-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200713085330.133842-1-maxg@mellanox.com>
References: <20200713085330.133842-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_045337_198424_3BC5F88E 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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

Has the driver use shared CQs providing ~10%-20% improvement when
multiple disks are used. Instead of opening a CQ for each QP per
controller, a CQ for each core will be provided by the RDMA core driver
that will be shared between the QPs on that core reducing interrupt
overhead.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/rdma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6731e03..3ccb592 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -752,7 +752,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, read_cqe);
-	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 	u16 status = 0;
 
 	WARN_ON(rsp->n_rdma <= 0);
@@ -1008,7 +1008,7 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
 		container_of(wc->wr_cqe, struct nvmet_rdma_cmd, cqe);
-	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 	struct nvmet_rdma_rsp *rsp;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
@@ -1258,9 +1258,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	 */
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
-	queue->cq = ib_alloc_cq(ndev->device, queue,
-			nr_cqe + 1, queue->comp_vector,
-			IB_POLL_WORKQUEUE);
+	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+				   queue->comp_vector, IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
@@ -1322,7 +1321,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 err_destroy_qp:
 	rdma_destroy_qp(queue->cm_id);
 err_destroy_cq:
-	ib_free_cq(queue->cq);
+	ib_cq_pool_put(queue->cq, nr_cqe + 1);
 	goto out;
 }
 
@@ -1332,7 +1331,8 @@ static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 	if (queue->cm_id)
 		rdma_destroy_id(queue->cm_id);
 	ib_destroy_qp(queue->qp);
-	ib_free_cq(queue->cq);
+	ib_cq_pool_put(queue->cq, queue->recv_queue_size + 2 *
+		       queue->send_queue_size + 1);
 }
 
 static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
