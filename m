Return-Path: <SRS0=YEyo=W5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3C7C3A59E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 15:01:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB5721744
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ur6IwKpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB5721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=UCJxWJo1b0CvMT4Rk4tEflSj2RgbGIww0yA1l7JEYIo=; b=Ur6
	IwKpAd5nbc9OCnczgD0GCOGvE8q0hm8l+jRRsF/dafO9BTfNhovkT5P0VjIkRnml69CJFACpCcc9Q
	Rn7oNvHY3aly8Hq3vPqaG455Dhu+84kj3aZPWhWAr6B3k/74bp74sDAtmHtJkxidpKGilwIKJiYQY
	u0P8qvihxCc/CDVjcQNJ2PM93En4H1ar1fbmyY8hV4UWQ63+aXHfOcnA43VLxOmmR/fxgwmcCa2IY
	xJmAo2qEZIJwLtildq68dV0qYrGEWKtxvJmE9e/N0YyAhlBrv/FEOdlBHzCg7zebw60yL4ojqbgNW
	wmN4dljMl6Asvo6iuqBQoXu3DP9rBUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4npo-0005HR-32; Mon, 02 Sep 2019 15:01:36 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i4npO-00050V-Sy
 for linux-nvme@lists.infradead.org; Mon, 02 Sep 2019 15:01:14 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 2 Sep 2019 18:01:03 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x82F13nx012407;
 Mon, 2 Sep 2019 18:01:03 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 james.smart@broadcom.com, sagi@grimberg.me
Subject: [PATCH 1/3] nvme: introduce nvme_finish_cmd function
Date: Mon,  2 Sep 2019 18:01:00 +0300
Message-Id: <1567436462-23218-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_080111_335299_34098E49 
X-CRM114-Status: GOOD (  11.82  )
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
Cc: israelr@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This function should be called by every transport during complete callback
upon successful submission of the request. Thus, in case of a failure in
command submission and in case nvme_setup_cmd was called, the transport
should call nvme_cleanup_cmd in the error flow to avoid resource leakage.
Add this logic to all the underlaying transports.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c | 20 +++++++++++++-------
 drivers/nvme/host/fc.c   |  4 ++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  2 +-
 drivers/nvme/host/rdma.c | 12 ++++++------
 drivers/nvme/host/tcp.c  | 11 +++++++++--
 6 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7b..9409427 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -683,13 +683,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 void nvme_cleanup_cmd(struct request *req)
 {
-	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
-	    nvme_req(req)->status == 0) {
-		struct nvme_ns *ns = req->rq_disk->private_data;
-
-		t10_pi_complete(req, ns->pi_type,
-				blk_rq_bytes(req) >> ns->lba_shift);
-	}
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
 		struct nvme_ns *ns = req->rq_disk->private_data;
 		struct page *page = req->special_vec.bv_page;
@@ -702,6 +695,19 @@ void nvme_cleanup_cmd(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 
+void nvme_finish_cmd(struct request *req)
+{
+	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
+	    nvme_req(req)->status == 0) {
+		struct nvme_ns *ns = req->rq_disk->private_data;
+
+		t10_pi_complete(req, ns->pi_type,
+				blk_rq_bytes(req) >> ns->lba_shift);
+	}
+	nvme_cleanup_cmd(req);
+}
+EXPORT_SYMBOL_GPL(nvme_finish_cmd);
+
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd)
 {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 232d8094..dd7fbe2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2152,8 +2152,6 @@ enum {
 				((rq_data_dir(rq) == WRITE) ?
 					DMA_TO_DEVICE : DMA_FROM_DEVICE));
 
-	nvme_cleanup_cmd(rq);
-
 	sg_free_table_chained(&freq->sg_table, SG_CHUNK_SIZE);
 
 	freq->sg_cnt = 0;
@@ -2284,6 +2282,7 @@ enum {
 		if (!(op->flags & FCOP_FLAGS_AEN))
 			nvme_fc_unmap_data(ctrl, op->rq, op);
 
+		nvme_cleanup_cmd(op->rq);
 		nvme_fc_ctrl_put(ctrl);
 
 		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
@@ -2376,6 +2375,7 @@ enum {
 	atomic_set(&op->state, FCPOP_STATE_IDLE);
 
 	nvme_fc_unmap_data(ctrl, rq, op);
+	nvme_finish_cmd(rq);
 	nvme_complete_rq(rq);
 	nvme_fc_ctrl_put(ctrl);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d678fb..11b2f52 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -463,6 +463,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid);
 void nvme_cleanup_cmd(struct request *req);
+void nvme_finish_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 732d5b6..ab3b1c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -920,7 +920,7 @@ static void nvme_pci_complete_rq(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_dev *dev = iod->nvmeq->dev;
 
-	nvme_cleanup_cmd(req);
+	nvme_finish_cmd(req);
 	if (blk_integrity_rq(req))
 		dma_unmap_page(dev->dev, iod->meta_dma,
 			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1a6449b..cd94f8a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1149,7 +1149,6 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 			req->nents, rq_data_dir(rq) ==
 				    WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-	nvme_cleanup_cmd(rq);
 	sg_free_table_chained(&req->sg_table, SG_CHUNK_SIZE);
 }
 
@@ -1748,7 +1747,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
 			     "Failed to map data (%d)\n", err);
-		nvme_cleanup_cmd(rq);
 		goto err;
 	}
 
@@ -1759,18 +1757,19 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr ? &req->reg_wr.wr : NULL);
-	if (unlikely(err)) {
-		nvme_rdma_unmap_data(queue, rq);
-		goto err;
-	}
+	if (unlikely(err))
+		goto err_unmap;
 
 	return BLK_STS_OK;
 
+err_unmap:
+	nvme_rdma_unmap_data(queue, rq);
 err:
 	if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
 	else
 		ret = BLK_STS_IOERR;
+	nvme_cleanup_cmd(rq);
 unmap_qe:
 	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
@@ -1791,6 +1790,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	struct ib_device *ibdev = queue->device->dev;
 
 	nvme_rdma_unmap_data(queue, rq);
+	nvme_finish_cmd(rq);
 	ib_dma_unmap_single(ibdev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
 	nvme_complete_rq(rq);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d..bd00128 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2093,6 +2093,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 
 	ret = nvme_tcp_map_data(queue, rq);
 	if (unlikely(ret)) {
+		nvme_cleanup_cmd(rq);
 		dev_err(queue->ctrl->ctrl.device,
 			"Failed to map data (%d)\n", ret);
 		return ret;
@@ -2101,6 +2102,12 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	return 0;
 }
 
+static void nvme_tcp_complete_rq(struct request *rq)
+{
+	nvme_finish_cmd(rq);
+	nvme_complete_rq(rq);
+}
+
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -2161,7 +2168,7 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 
 static struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
-	.complete	= nvme_complete_rq,
+	.complete	= nvme_tcp_complete_rq,
 	.init_request	= nvme_tcp_init_request,
 	.exit_request	= nvme_tcp_exit_request,
 	.init_hctx	= nvme_tcp_init_hctx,
@@ -2171,7 +2178,7 @@ static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 
 static struct blk_mq_ops nvme_tcp_admin_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
-	.complete	= nvme_complete_rq,
+	.complete	= nvme_tcp_complete_rq,
 	.init_request	= nvme_tcp_init_request,
 	.exit_request	= nvme_tcp_exit_request,
 	.init_hctx	= nvme_tcp_init_admin_hctx,
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
