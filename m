Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8128AC4727E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A4420936
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdgPN/An"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A4420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PfH8/WLVTTS1GuTAH9WRdclPSidD30WiT5q1CDxrDgs=; b=gdgPN/Anho5FoooAEVEHnd6fIg
	VlF8HLH/qSO+MDE9uTKlV05D0sGinSO6aQTvxJ9rEXXDRTcpEzDj8TdnHWmAIqYGRbnvBKKM1SH3S
	0jK1SFu/yaLY8Mwntsr5q4j8QRLGfqqWGYq8SLX7ThpCAyPSaGerHE+eYkF/FzYButX177ZXs6EJ3
	d+J4k6CaUbZWX57x2HeYXj/7TPWGe2DT7jZVfsbvUXf7v9MMD8rrL3ugnv+xqUIOY7vYi1oJwnkOV
	fz7FZKpoDceZ7G6/rXxS7/SWTjs0doDwPOUeAsHpHTU8KLJfOWs6e7u80LIMYUSDyeMQKfpDGM8ha
	t6pJpkWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCx-0003uP-41; Tue, 22 Sep 2020 12:15:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCW-0003nK-Ql
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BA4F0AF0E;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/7] nvme-fc: use feature flag for virtual LLDD
Date: Tue, 22 Sep 2020 14:14:59 +0200
Message-Id: <20200922121501.32851-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200922121501.32851-1-hare@suse.de>
References: <20200922121501.32851-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081517_154581_0B275E8C 
X-CRM114-Status: GOOD (  22.59  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Virtual LLDDs like fcloop don't need to do DMA, but still
might want to expose a device. So add a new feature flag
to mark these LLDDs instead of relying on a non-existing
struct device.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c         | 93 +++++++++++++++++++++++-------------------
 drivers/nvme/target/fcloop.c   |  2 +
 include/linux/nvme-fc-driver.h | 10 +++++
 3 files changed, 64 insertions(+), 41 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e8ef42b9d50c..d30ea7a39183 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -237,6 +237,11 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 static void nvme_fc_handle_ls_rqst_work(struct work_struct *work);
 
 
+static bool nvme_fc_lport_is_physical(struct nvme_fc_lport *lport)
+{
+	return !(lport->ops->port_features & NVME_FCPORTFEAT_VIRTUAL_DMA);
+}
+
 static void
 nvme_fc_free_lport(struct kref *ref)
 {
@@ -427,7 +432,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	list_add_tail(&newrec->port_list, &nvme_fc_lport_list);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
-	if (dev)
+	if (nvme_fc_lport_is_physical(newrec))
 		dma_set_seg_boundary(dev, template->dma_boundary);
 
 	*portptr = &newrec->localport;
@@ -953,40 +958,44 @@ EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_devloss);
  */
 
 static inline dma_addr_t
-fc_dma_map_single(struct device *dev, void *ptr, size_t size,
+fc_dma_map_single(struct nvme_fc_lport *lport, void *ptr, size_t size,
 		enum dma_data_direction dir)
 {
-	return dev ? dma_map_single(dev, ptr, size, dir) : (dma_addr_t)0L;
+	if (nvme_fc_lport_is_physical(lport))
+		return dma_map_single(lport->dev, ptr, size, dir);
+	return (dma_addr_t)0L;
 }
 
 static inline int
-fc_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+fc_dma_mapping_error(struct nvme_fc_lport *lport, dma_addr_t dma_addr)
 {
-	return dev ? dma_mapping_error(dev, dma_addr) : 0;
+	if (nvme_fc_lport_is_physical(lport))
+		return dma_mapping_error(lport->dev, dma_addr);
+	return 0;
 }
 
 static inline void
-fc_dma_unmap_single(struct device *dev, dma_addr_t addr, size_t size,
+fc_dma_unmap_single(struct nvme_fc_lport *lport, dma_addr_t addr, size_t size,
 	enum dma_data_direction dir)
 {
-	if (dev)
-		dma_unmap_single(dev, addr, size, dir);
+	if (nvme_fc_lport_is_physical(lport))
+		dma_unmap_single(lport->dev, addr, size, dir);
 }
 
 static inline void
-fc_dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
-		enum dma_data_direction dir)
+fc_dma_sync_single_for_cpu(struct nvme_fc_lport *lport, dma_addr_t addr,
+	size_t size, enum dma_data_direction dir)
 {
-	if (dev)
-		dma_sync_single_for_cpu(dev, addr, size, dir);
+	if (nvme_fc_lport_is_physical(lport))
+		dma_sync_single_for_cpu(lport->dev, addr, size, dir);
 }
 
 static inline void
-fc_dma_sync_single_for_device(struct device *dev, dma_addr_t addr, size_t size,
-		enum dma_data_direction dir)
+fc_dma_sync_single_for_device(struct nvme_fc_lport *lport, dma_addr_t addr,
+	size_t size, enum dma_data_direction dir)
 {
-	if (dev)
-		dma_sync_single_for_device(dev, addr, size, dir);
+	if (nvme_fc_lport_is_physical(lport))
+		dma_sync_single_for_device(lport->dev, addr, size, dir);
 }
 
 /* pseudo dma_map_sg call */
@@ -1008,18 +1017,20 @@ fc_map_sg(struct scatterlist *sg, int nents)
 }
 
 static inline int
-fc_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+fc_dma_map_sg(struct nvme_fc_lport *lport, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir)
 {
-	return dev ? dma_map_sg(dev, sg, nents, dir) : fc_map_sg(sg, nents);
+	if (nvme_fc_lport_is_physical(lport))
+		return dma_map_sg(lport->dev, sg, nents, dir);
+	return fc_map_sg(sg, nents);
 }
 
 static inline void
-fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+fc_dma_unmap_sg(struct nvme_fc_lport *lport, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir)
 {
-	if (dev)
-		dma_unmap_sg(dev, sg, nents, dir);
+	if (nvme_fc_lport_is_physical(lport))
+		dma_unmap_sg(lport->dev, sg, nents, dir);
 }
 
 /* *********************** FC-NVME LS Handling **************************** */
@@ -1049,7 +1060,7 @@ __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
 
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	fc_dma_unmap_single(rport->dev, lsreq->rqstdma,
+	fc_dma_unmap_single(rport->lport, lsreq->rqstdma,
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
@@ -1077,10 +1088,10 @@ __nvme_fc_send_ls_req(struct nvme_fc_rport *rport,
 	INIT_LIST_HEAD(&lsop->lsreq_list);
 	init_completion(&lsop->ls_done);
 
-	lsreq->rqstdma = fc_dma_map_single(rport->dev, lsreq->rqstaddr,
+	lsreq->rqstdma = fc_dma_map_single(rport->lport, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
 				  DMA_BIDIRECTIONAL);
-	if (fc_dma_mapping_error(rport->dev, lsreq->rqstdma)) {
+	if (fc_dma_mapping_error(rport->lport, lsreq->rqstdma)) {
 		ret = -EFAULT;
 		goto out_putrport;
 	}
@@ -1107,7 +1118,7 @@ __nvme_fc_send_ls_req(struct nvme_fc_rport *rport,
 	lsop->req_queued = false;
 	list_del(&lsop->lsreq_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
-	fc_dma_unmap_single(rport->dev, lsreq->rqstdma,
+	fc_dma_unmap_single(rport->lport, lsreq->rqstdma,
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 out_putrport:
@@ -1465,9 +1476,9 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	list_del(&lsop->lsrcv_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	fc_dma_sync_single_for_cpu(lport->dev, lsop->rspdma,
+	fc_dma_sync_single_for_cpu(lport, lsop->rspdma,
 				sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
-	fc_dma_unmap_single(lport->dev, lsop->rspdma,
+	fc_dma_unmap_single(lport, lsop->rspdma,
 			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
 
 	kfree(lsop);
@@ -1483,7 +1494,7 @@ nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
 	struct fcnvme_ls_rqst_w0 *w0 = &lsop->rqstbuf->w0;
 	int ret;
 
-	fc_dma_sync_single_for_device(lport->dev, lsop->rspdma,
+	fc_dma_sync_single_for_device(lport, lsop->rspdma,
 				  sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
 
 	ret = lport->ops->xmt_ls_rsp(&lport->localport, &rport->remoteport,
@@ -1761,10 +1772,10 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	lsop->rqstbuf = (union nvmefc_ls_requests *)&lsop[1];
 	lsop->rspbuf = (union nvmefc_ls_responses *)&lsop->rqstbuf[1];
 
-	lsop->rspdma = fc_dma_map_single(lport->dev, lsop->rspbuf,
+	lsop->rspdma = fc_dma_map_single(lport, lsop->rspbuf,
 					sizeof(*lsop->rspbuf),
 					DMA_TO_DEVICE);
-	if (fc_dma_mapping_error(lport->dev, lsop->rspdma)) {
+	if (fc_dma_mapping_error(lport, lsop->rspdma)) {
 		dev_info(lport->dev,
 			"RCV %s LS failed: DMA mapping failure\n",
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
@@ -1793,7 +1804,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	return 0;
 
 out_unmap:
-	fc_dma_unmap_single(lport->dev, lsop->rspdma,
+	fc_dma_unmap_single(lport, lsop->rspdma,
 			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
 out_free:
 	kfree(lsop);
@@ -1810,9 +1821,9 @@ static void
 __nvme_fc_exit_request(struct nvme_fc_ctrl *ctrl,
 		struct nvme_fc_fcp_op *op)
 {
-	fc_dma_unmap_single(ctrl->lport->dev, op->fcp_req.rspdma,
+	fc_dma_unmap_single(ctrl->lport, op->fcp_req.rspdma,
 				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
-	fc_dma_unmap_single(ctrl->lport->dev, op->fcp_req.cmddma,
+	fc_dma_unmap_single(ctrl->lport, op->fcp_req.cmddma,
 				sizeof(op->cmd_iu), DMA_TO_DEVICE);
 
 	atomic_set(&op->state, FCPOP_STATE_UNINIT);
@@ -1936,7 +1947,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 
 	opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
 
-	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
+	fc_dma_sync_single_for_cpu(ctrl->lport, op->fcp_req.rspdma,
 				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
 
 	if (opstate == FCPOP_STATE_ABORTED)
@@ -2073,19 +2084,19 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	else
 		cmdiu->rsv_cat = fccmnd_set_cat_admin(0);
 
-	op->fcp_req.cmddma = fc_dma_map_single(ctrl->lport->dev,
+	op->fcp_req.cmddma = fc_dma_map_single(ctrl->lport,
 				&op->cmd_iu, sizeof(op->cmd_iu), DMA_TO_DEVICE);
-	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.cmddma)) {
+	if (fc_dma_mapping_error(ctrl->lport, op->fcp_req.cmddma)) {
 		dev_err(ctrl->dev,
 			"FCP Op failed - cmdiu dma mapping failed.\n");
 		ret = -EFAULT;
 		goto out_on_error;
 	}
 
-	op->fcp_req.rspdma = fc_dma_map_single(ctrl->lport->dev,
+	op->fcp_req.rspdma = fc_dma_map_single(ctrl->lport,
 				&op->rsp_iu, sizeof(op->rsp_iu),
 				DMA_FROM_DEVICE);
-	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.rspdma)) {
+	if (fc_dma_mapping_error(ctrl->lport, op->fcp_req.rspdma)) {
 		dev_err(ctrl->dev,
 			"FCP Op failed - rspiu dma mapping failed.\n");
 		ret = -EFAULT;
@@ -2485,7 +2496,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 
 	op->nents = blk_rq_map_sg(rq->q, rq, freq->sg_table.sgl);
 	WARN_ON(op->nents > blk_rq_nr_phys_segments(rq));
-	freq->sg_cnt = fc_dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
+	freq->sg_cnt = fc_dma_map_sg(ctrl->lport, freq->sg_table.sgl,
 				op->nents, rq_dma_dir(rq));
 	if (unlikely(freq->sg_cnt <= 0)) {
 		sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
@@ -2508,7 +2519,7 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 	if (!freq->sg_cnt)
 		return;
 
-	fc_dma_unmap_sg(ctrl->lport->dev, freq->sg_table.sgl, op->nents,
+	fc_dma_unmap_sg(ctrl->lport, freq->sg_table.sgl, op->nents,
 			rq_dma_dir(rq));
 
 	sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
@@ -2609,7 +2620,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		}
 	}
 
-	fc_dma_sync_single_for_device(ctrl->lport->dev, op->fcp_req.cmddma,
+	fc_dma_sync_single_for_device(ctrl->lport, op->fcp_req.cmddma,
 				  sizeof(op->cmd_iu), DMA_TO_DEVICE);
 
 	atomic_set(&op->state, FCPOP_STATE_ACTIVE);
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2ccb941efb21..7dab98545979 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1026,6 +1026,8 @@ static struct nvme_fc_port_template fctemplate = {
 	.remote_priv_sz		= sizeof(struct fcloop_rport),
 	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
+	/* optional features */
+	.port_features		= NVME_FCPORTFEAT_VIRTUAL_DMA,
 };
 
 static struct nvmet_fc_target_template tgttemplate = {
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 675c7ef6df17..17cf967484b2 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -334,6 +334,11 @@ struct nvme_fc_remote_port {
 	enum nvme_fc_obj_state port_state;
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
+/* Port Features (Bit fields) LLDD supports */
+enum {
+	NVME_FCPORTFEAT_VIRTUAL_DMA = (1 << 0),
+		/* Bit 0: Virtual LLDD with no DMA support */
+};
 
 /**
  * struct nvme_fc_port_template - structure containing static entrypoints and
@@ -470,6 +475,8 @@ struct nvme_fc_remote_port {
  *       memory area solely for the of the LLDD and its location is
  *       specified by the fcp_request->private pointer.
  *       Value is Mandatory. Allowed to be zero.
+ *
+ * @port_features: Optional feature for the LLDD
  */
 struct nvme_fc_port_template {
 	/* initiator-based functions */
@@ -508,6 +515,9 @@ struct nvme_fc_port_template {
 	u32	remote_priv_sz;
 	u32	lsrqst_priv_sz;
 	u32	fcprqst_priv_sz;
+
+	/* Optional port features */
+	u32	port_features;
 };
 
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
