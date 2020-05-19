Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8BBC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:08:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE92220823
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DsfuKXvC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f51rRTnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE92220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qDr2K3ZATRZ/myl/zxvdRw5Spzfp+vMGDvcmvu3rf4s=; b=DsfuKXvCDmstTW
	jNSz7JO3JVfxyz3pQ1/ZVAI7CWT8F6QbpZVLZo7JGmGP46ftSWOHHFCBT/VpvSYC+VZhDXN3OUqxq
	34G4OlQvuTGy+RCPpQe+O0lF9QFnCKi0NNo0PXbmY1qrhFOCRsbTu3Pifjcq/jM5I3PME76PEQPRZ
	M10etIOI9Z0ZYcO6fU/5r1ca9qR29zURP+UfdSZmA9nn0XT93WP2g+FrvLJUiFDo0OGrP5Vag6VGy
	7m0hw1fbUXEMtaZ+zIAysU4RcFGAA6mdPig/Pqy6bLYcPHnDtnEtcqL5l4bPRHUgWy5FqsSJMvxRI
	OXXHPI6ob4bVaBviHwJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb2vE-0003Xo-LY; Tue, 19 May 2020 14:08:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2sz-0001Z6-Vq
 for linux-nvme@bombadil.infradead.org; Tue, 19 May 2020 14:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=gC1MKj3fFl8a8zZyaEgknWvDVvk3Pfhbr6JsqiFbBaI=; b=f51rRTnxT+NGuFf5QQbPqE21+E
 nK8s1GpGw9jHZTQpx/vOV/k4KEl7VOFBAMBd9RCdYA22yhd69alZOc4SYrBNv5PMqM5MGzGDTVdhi
 rkTqG5Yl6nj+cXjV202soqKCKo33Y1AMDA2LQzPZv43VuSN/+/Vyu0MabJvG3ENL+a1BNTVeY/6OK
 calB5glux0+L0RxOog7RB1yzg4fpzPD9oqchzETdA2GNAa7b/tFCBBVuTTzbl3FvQEi5STs7n9jXJ
 YchOR2mmjwKwVI4jS2lqjQM1KHbmU/zKC/62wN8ri+DYY3ks5lJhTKYpiP5yPOxXVZC0JbBbZMsx3
 9Y+cQIng==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2so-0004Wa-ET
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 14:06:23 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 19 May 2020 17:06:05 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04JE63xx006590;
 Tue, 19 May 2020 17:06:05 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, jsmart2021@gmail.com,
 axboe@kernel.dk
Subject: [PATCH 16/16] nvmet-rdma: add metadata/T10-PI support
Date: Tue, 19 May 2020 17:06:03 +0300
Message-Id: <20200519140603.166576-17-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519140603.166576-1-maxg@mellanox.com>
References: <20200519140603.166576-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_150616_510666_782CCF80 
X-CRM114-Status: GOOD (  21.21  )
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, Max Gurtovoy <maxg@mellanox.com>,
 nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

For capable HCAs (e.g. ConnectX-5/ConnectX-6) this will allow end-to-end
protection information passthrough and validation for NVMe over RDMA
transport. Metadata support was implemented over the new RDMA signature
verbs API.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/rdma.c | 234 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 215 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 178dbff..d514178 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -33,6 +33,7 @@
 
 /* Assume mpsmin == device_page_size == 4KB */
 #define NVMET_RDMA_MAX_MDTS			8
+#define NVMET_RDMA_MAX_METADATA_MDTS		5
 
 struct nvmet_rdma_srq;
 
@@ -60,6 +61,7 @@ struct nvmet_rdma_rsp {
 	struct nvmet_rdma_queue	*queue;
 
 	struct ib_cqe		read_cqe;
+	struct ib_cqe		write_cqe;
 	struct rdma_rw_ctx	rw;
 
 	struct nvmet_req	req;
@@ -161,6 +163,7 @@ struct nvmet_rdma_device {
 static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
+static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
 static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
 static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
@@ -423,6 +426,9 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 
 	/* Data In / RDMA READ */
 	r->read_cqe.done = nvmet_rdma_read_data_done;
+	/* Data Out / RDMA WRITE */
+	r->write_cqe.done = nvmet_rdma_write_data_done;
+
 	return 0;
 
 out_free_rsp:
@@ -532,6 +538,129 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 	spin_unlock(&queue->rsp_wr_wait_lock);
 }
 
+static u16 nvmet_rdma_check_pi_status(struct ib_mr *sig_mr)
+{
+	struct ib_mr_status mr_status;
+	int ret;
+	u16 status = 0;
+
+	ret = ib_check_mr_status(sig_mr, IB_MR_CHECK_SIG_STATUS, &mr_status);
+	if (ret) {
+		pr_err("ib_check_mr_status failed, ret %d\n", ret);
+		return NVME_SC_INVALID_PI;
+	}
+
+	if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
+		switch (mr_status.sig_err.err_type) {
+		case IB_SIG_BAD_GUARD:
+			status = NVME_SC_GUARD_CHECK;
+			break;
+		case IB_SIG_BAD_REFTAG:
+			status = NVME_SC_REFTAG_CHECK;
+			break;
+		case IB_SIG_BAD_APPTAG:
+			status = NVME_SC_APPTAG_CHECK;
+			break;
+		}
+		pr_err("PI error found type %d expected 0x%x vs actual 0x%x\n",
+		       mr_status.sig_err.err_type,
+		       mr_status.sig_err.expected,
+		       mr_status.sig_err.actual);
+	}
+
+	return status;
+}
+
+static void nvmet_rdma_set_sig_domain(struct blk_integrity *bi,
+		struct nvme_command *cmd, struct ib_sig_domain *domain,
+		u16 control, u8 pi_type)
+{
+	domain->sig_type = IB_SIG_TYPE_T10_DIF;
+	domain->sig.dif.bg_type = IB_T10DIF_CRC;
+	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
+	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
+	if (control & NVME_RW_PRINFO_PRCHK_REF)
+		domain->sig.dif.ref_remap = true;
+
+	domain->sig.dif.app_tag = le16_to_cpu(cmd->rw.apptag);
+	domain->sig.dif.apptag_check_mask = le16_to_cpu(cmd->rw.appmask);
+	domain->sig.dif.app_escape = true;
+	if (pi_type == NVME_NS_DPS_PI_TYPE3)
+		domain->sig.dif.ref_escape = true;
+}
+
+static void nvmet_rdma_set_sig_attrs(struct nvmet_req *req,
+				     struct ib_sig_attrs *sig_attrs)
+{
+	struct nvme_command *cmd = req->cmd;
+	u16 control = le16_to_cpu(cmd->rw.control);
+	u8 pi_type = req->ns->pi_type;
+	struct blk_integrity *bi;
+
+	bi = bdev_get_integrity(req->ns->bdev);
+
+	memset(sig_attrs, 0, sizeof(*sig_attrs));
+
+	if (control & NVME_RW_PRINFO_PRACT) {
+		/* for WRITE_INSERT/READ_STRIP no wire domain */
+		sig_attrs->wire.sig_type = IB_SIG_TYPE_NONE;
+		nvmet_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control,
+					  pi_type);
+		/* Clear the PRACT bit since HCA will generate/verify the PI */
+		control &= ~NVME_RW_PRINFO_PRACT;
+		cmd->rw.control = cpu_to_le16(control);
+		/* PI is added by the HW */
+		req->transfer_len += req->metadata_len;
+	} else {
+		/* for WRITE_PASS/READ_PASS both wire/memory domains exist */
+		nvmet_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control,
+					  pi_type);
+		nvmet_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control,
+					  pi_type);
+	}
+
+	if (control & NVME_RW_PRINFO_PRCHK_REF)
+		sig_attrs->check_mask |= IB_SIG_CHECK_REFTAG;
+	if (control & NVME_RW_PRINFO_PRCHK_GUARD)
+		sig_attrs->check_mask |= IB_SIG_CHECK_GUARD;
+	if (control & NVME_RW_PRINFO_PRCHK_APP)
+		sig_attrs->check_mask |= IB_SIG_CHECK_APPTAG;
+}
+
+static int nvmet_rdma_rw_ctx_init(struct nvmet_rdma_rsp *rsp, u64 addr, u32 key,
+				  struct ib_sig_attrs *sig_attrs)
+{
+	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+	struct nvmet_req *req = &rsp->req;
+	int ret;
+
+	if (req->metadata_len)
+		ret = rdma_rw_ctx_signature_init(&rsp->rw, cm_id->qp,
+			cm_id->port_num, req->sg, req->sg_cnt,
+			req->metadata_sg, req->metadata_sg_cnt, sig_attrs,
+			addr, key, nvmet_data_dir(req));
+	else
+		ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
+				       req->sg, req->sg_cnt, 0, addr, key,
+				       nvmet_data_dir(req));
+
+	return ret;
+}
+
+static void nvmet_rdma_rw_ctx_destroy(struct nvmet_rdma_rsp *rsp)
+{
+	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+	struct nvmet_req *req = &rsp->req;
+
+	if (req->metadata_len)
+		rdma_rw_ctx_destroy_signature(&rsp->rw, cm_id->qp,
+			cm_id->port_num, req->sg, req->sg_cnt,
+			req->metadata_sg, req->metadata_sg_cnt,
+			nvmet_data_dir(req));
+	else
+		rdma_rw_ctx_destroy(&rsp->rw, cm_id->qp, cm_id->port_num,
+				    req->sg, req->sg_cnt, nvmet_data_dir(req));
+}
 
 static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 {
@@ -539,11 +668,8 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 
 	atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
 
-	if (rsp->n_rdma) {
-		rdma_rw_ctx_destroy(&rsp->rw, queue->qp,
-				queue->cm_id->port_num, rsp->req.sg,
-				rsp->req.sg_cnt, nvmet_data_dir(&rsp->req));
-	}
+	if (rsp->n_rdma)
+		nvmet_rdma_rw_ctx_destroy(rsp);
 
 	if (rsp->req.sg != rsp->cmd->inline_sg)
 		nvmet_req_free_sgls(&rsp->req);
@@ -598,11 +724,16 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 		rsp->send_wr.opcode = IB_WR_SEND;
 	}
 
-	if (nvmet_rdma_need_data_out(rsp))
-		first_wr = rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
-				cm_id->port_num, NULL, &rsp->send_wr);
-	else
+	if (nvmet_rdma_need_data_out(rsp)) {
+		if (rsp->req.metadata_len)
+			first_wr = rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
+					cm_id->port_num, &rsp->write_cqe, NULL);
+		else
+			first_wr = rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
+					cm_id->port_num, NULL, &rsp->send_wr);
+	} else {
 		first_wr = &rsp->send_wr;
+	}
 
 	nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
 
@@ -621,15 +752,14 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, read_cqe);
 	struct nvmet_rdma_queue *queue = cq->cq_context;
+	u16 status = 0;
 
 	WARN_ON(rsp->n_rdma <= 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
-	rdma_rw_ctx_destroy(&rsp->rw, queue->qp,
-			queue->cm_id->port_num, rsp->req.sg,
-			rsp->req.sg_cnt, nvmet_data_dir(&rsp->req));
 	rsp->n_rdma = 0;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+		nvmet_rdma_rw_ctx_destroy(rsp);
 		nvmet_req_uninit(&rsp->req);
 		nvmet_rdma_release_rsp(rsp);
 		if (wc->status != IB_WC_WR_FLUSH_ERR) {
@@ -640,7 +770,58 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	rsp->req.execute(&rsp->req);
+	if (rsp->req.metadata_len)
+		status = nvmet_rdma_check_pi_status(rsp->rw.reg->mr);
+	nvmet_rdma_rw_ctx_destroy(rsp);
+
+	if (unlikely(status))
+		nvmet_req_complete(&rsp->req, status);
+	else
+		rsp->req.execute(&rsp->req);
+}
+
+static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct nvmet_rdma_rsp *rsp =
+		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, write_cqe);
+	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
+	u16 status;
+
+	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
+		return;
+
+	WARN_ON(rsp->n_rdma <= 0);
+	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
+	rsp->n_rdma = 0;
+
+	if (unlikely(wc->status != IB_WC_SUCCESS)) {
+		nvmet_rdma_rw_ctx_destroy(rsp);
+		nvmet_req_uninit(&rsp->req);
+		nvmet_rdma_release_rsp(rsp);
+		if (wc->status != IB_WC_WR_FLUSH_ERR) {
+			pr_info("RDMA WRITE for CQE 0x%p failed with status %s (%d).\n",
+				wc->wr_cqe, ib_wc_status_msg(wc->status),
+				wc->status);
+			nvmet_rdma_error_comp(queue);
+		}
+		return;
+	}
+
+	/*
+	 * Upon RDMA completion check the signature status
+	 * - if succeeded send good NVMe response
+	 * - if failed send bad NVMe response with appropriate error
+	 */
+	status = nvmet_rdma_check_pi_status(rsp->rw.reg->mr);
+	if (unlikely(status))
+		rsp->req.cqe->status = cpu_to_le16(status << 1);
+	nvmet_rdma_rw_ctx_destroy(rsp);
+
+	if (unlikely(ib_post_send(cm_id->qp, &rsp->send_wr, NULL))) {
+		pr_err("sending cmd response failed\n");
+		nvmet_rdma_release_rsp(rsp);
+	}
 }
 
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
@@ -697,9 +878,9 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 		struct nvme_keyed_sgl_desc *sgl, bool invalidate)
 {
-	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
 	u64 addr = le64_to_cpu(sgl->addr);
 	u32 key = get_unaligned_le32(sgl->key);
+	struct ib_sig_attrs sig_attrs;
 	int ret;
 
 	rsp->req.transfer_len = get_unaligned_le24(sgl->length);
@@ -708,13 +889,14 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	if (!rsp->req.transfer_len)
 		return 0;
 
+	if (rsp->req.metadata_len)
+		nvmet_rdma_set_sig_attrs(&rsp->req, &sig_attrs);
+
 	ret = nvmet_req_alloc_sgls(&rsp->req);
 	if (unlikely(ret < 0))
 		goto error_out;
 
-	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
-			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
-			nvmet_data_dir(&rsp->req));
+	ret = nvmet_rdma_rw_ctx_init(rsp, addr, key, &sig_attrs);
 	if (unlikely(ret < 0))
 		goto error_out;
 	rsp->n_rdma += ret;
@@ -1108,6 +1290,9 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 		qp_attr.cap.max_recv_sge = 1 + ndev->inline_page_count;
 	}
 
+	if (queue->port->pi_enable && queue->host_qid)
+		qp_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
+
 	ret = rdma_create_qp(queue->cm_id, ndev->pd, &qp_attr);
 	if (ret) {
 		pr_err("failed to create_qp ret= %d\n", ret);
@@ -1226,6 +1411,7 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 		struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event)
 {
+	struct nvmet_rdma_port *port = cm_id->context;
 	struct nvmet_rdma_queue *queue;
 	int ret;
 
@@ -1252,6 +1438,7 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
+	queue->port = port->nport;
 
 	spin_lock_init(&queue->state_lock);
 	queue->state = NVMET_RDMA_Q_CONNECTING;
@@ -1369,7 +1556,6 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event)
 {
-	struct nvmet_rdma_port *port = cm_id->context;
 	struct nvmet_rdma_device *ndev;
 	struct nvmet_rdma_queue *queue;
 	int ret = -EINVAL;
@@ -1385,7 +1571,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		ret = -ENOMEM;
 		goto put_device;
 	}
-	queue->port = port->nport;
 
 	if (queue->host_qid == 0) {
 		/* Let inflight controller teardown complete */
@@ -1657,6 +1842,14 @@ static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
 		goto out_destroy_id;
 	}
 
+	if (port->nport->pi_enable &&
+	    !(cm_id->device->attrs.device_cap_flags &
+	      IB_DEVICE_INTEGRITY_HANDOVER)) {
+		pr_err("T10-PI is not supported for %pISpcs\n", addr);
+		ret = -EINVAL;
+		goto out_destroy_id;
+	}
+
 	port->cm_id = cm_id;
 	return 0;
 
@@ -1766,6 +1959,8 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 
 static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 {
+	if (ctrl->pi_support)
+		return NVMET_RDMA_MAX_METADATA_MDTS;
 	return NVMET_RDMA_MAX_MDTS;
 }
 
@@ -1774,6 +1969,7 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 	.type			= NVMF_TRTYPE_RDMA,
 	.msdbd			= 1,
 	.has_keyed_sgls		= 1,
+	.metadata_support	= 1,
 	.add_port		= nvmet_rdma_add_port,
 	.remove_port		= nvmet_rdma_remove_port,
 	.queue_response		= nvmet_rdma_queue_response,
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
