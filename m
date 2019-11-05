Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F6C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD055214B2
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BI0eXyAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD055214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lIbhqyGi7+IH8zbN7xwENLeK9/bWhf7esCZTunQ81ig=; b=BI0eXyAj3P6i/L
	2CbC2b86g/Pcgz2FqDsTaRlnl1scUVryO/XcWGls1BIPCPKkJsmcJyyc6p4rwFpd0QdK9Cn48tPMG
	Dd+CJ0DaAEUsb1Cv6esjI20cTnY81vn10ipF/dYmKWn2VlXN4WvjdjG/am6Wn4beMNyzw3szGGn3m
	uf2x925LrdWL/i698No8hZ6rrELzctV+1FGC82xZ59zlOCFvPGaPQ5ftR1ezoLyJxnFJzUury7uEy
	LuNjm7k4p80D5+nDsB0yV+ib6+fG5QjOvG9K0nGKFA5NfVuWJZtctP0w9YszfwHvTf7ADzymQlDSf
	6Lc5y/z4x6rteiZ1orrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS2f0-0002wG-Uh; Tue, 05 Nov 2019 17:30:30 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS1ZP-0003S4-4g
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 16:20:47 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Nov 2019 18:20:27 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xA5GKQm2013132;
 Tue, 5 Nov 2019 18:20:27 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 05/15] nvme-rdma: Add metadata/T10-PI support
Date: Tue,  5 Nov 2019 18:20:16 +0200
Message-Id: <20191105162026.183901-7-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105162026.183901-1-maxg@mellanox.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_082039_864084_9026A5DA 
X-CRM114-Status: GOOD (  18.46  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For capable HCAs (e.g. ConnectX-4/ConnectX-5) this will allow end-to-end
protection information passthrough and validation for NVMe over RDMA
transport. Metadata offload support was implemented over the new RDMA
signature verbs API and it is enabled per controller by using nvme-cli.

usage example:
nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/rdma.c | 346 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 298 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 05f2dfa..16263b8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -48,6 +48,12 @@ struct nvme_rdma_qe {
 	u64			dma;
 };
 
+struct nvme_rdma_sgl {
+	int			nents;
+	struct sg_table		sg_table;
+	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+};
+
 struct nvme_rdma_queue;
 struct nvme_rdma_request {
 	struct nvme_request	req;
@@ -58,12 +64,14 @@ struct nvme_rdma_request {
 	refcount_t		ref;
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
 	u32			num_sge;
-	int			nents;
 	struct ib_reg_wr	reg_wr;
 	struct ib_cqe		reg_cqe;
 	struct nvme_rdma_queue  *queue;
-	struct sg_table		sg_table;
-	struct scatterlist	first_sgl[];
+	/* T10-PI support */
+	bool			is_protected;
+
+	struct nvme_rdma_sgl	data_sgl;
+	struct nvme_rdma_sgl	pi_sgl[];
 };
 
 enum nvme_rdma_queue_flags {
@@ -85,6 +93,7 @@ struct nvme_rdma_queue {
 	struct rdma_cm_id	*cm_id;
 	int			cm_error;
 	struct completion	cm_done;
+	bool			pi_support;
 };
 
 struct nvme_rdma_ctrl {
@@ -112,6 +121,7 @@ struct nvme_rdma_ctrl {
 	struct nvme_ctrl	ctrl;
 	bool			use_inline_data;
 	u32			io_queues[HCTX_MAX_TYPES];
+	bool			pi_support;
 };
 
 static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
@@ -269,6 +279,8 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	init_attr.qp_type = IB_QPT_RC;
 	init_attr.send_cq = queue->ib_cq;
 	init_attr.recv_cq = queue->ib_cq;
+	if (queue->pi_support)
+		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
 
 	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
 
@@ -408,6 +420,8 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	dev = queue->device;
 	ibdev = dev->dev;
 
+	if (queue->pi_support)
+		ib_mr_pool_destroy(queue->qp, &queue->qp->sig_mrs);
 	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
 
 	/*
@@ -424,10 +438,14 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	nvme_rdma_dev_put(dev);
 }
 
-static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
+static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev, bool pi_support)
 {
-	return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		     ibdev->attrs.max_fast_reg_page_list_len - 1);
+	if (pi_support)
+		return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+			     ibdev->attrs.max_pi_fast_reg_page_list_len - 1);
+	else
+		return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+			     ibdev->attrs.max_fast_reg_page_list_len - 1);
 }
 
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
@@ -484,7 +502,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	 * misaligned we'll end up using two entries for a single data page,
 	 * so one additional entry is required.
 	 */
-	pages_per_mr = nvme_rdma_get_max_fr_pages(ibdev) + 1;
+	pages_per_mr = nvme_rdma_get_max_fr_pages(ibdev, queue->pi_support) + 1;
 	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
 			      queue->queue_size,
 			      IB_MR_TYPE_MEM_REG,
@@ -496,10 +514,24 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		goto out_destroy_ring;
 	}
 
+	if (queue->pi_support) {
+		ret = ib_mr_pool_init(queue->qp, &queue->qp->sig_mrs,
+				      queue->queue_size, IB_MR_TYPE_INTEGRITY,
+				      pages_per_mr, pages_per_mr);
+		if (ret) {
+			dev_err(queue->ctrl->ctrl.device,
+				"failed to initialize PI MR pool sized %d for QID %d\n",
+				queue->queue_size, idx);
+			goto out_destroy_mr_pool;
+		}
+	}
+
 	set_bit(NVME_RDMA_Q_TR_READY, &queue->flags);
 
 	return 0;
 
+out_destroy_mr_pool:
+	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
 out_destroy_ring:
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
 			    sizeof(struct nvme_completion), DMA_FROM_DEVICE);
@@ -521,6 +553,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 
 	queue = &ctrl->queues[idx];
 	queue->ctrl = ctrl;
+	queue->pi_support = idx && ctrl->pi_support;
 	init_completion(&queue->cm_done);
 
 	if (idx > 0)
@@ -730,8 +763,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		set->reserved_tags = 2; /* connect + keep-alive */
 		set->numa_node = nctrl->numa_node;
-		set->cmd_size = sizeof(struct nvme_rdma_request) +
-			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->cmd_size = sizeof(struct nvme_rdma_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
 		set->timeout = ADMIN_TIMEOUT;
@@ -745,7 +777,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
-			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+			(ctrl->pi_support * sizeof(struct nvme_rdma_sgl));
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
@@ -787,7 +819,22 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	ctrl->device = ctrl->queues[0].device;
 	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
 
-	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
+	/* T10-PI support */
+	if (ctrl->ctrl.opts->pi_enable) {
+		if (!(ctrl->device->dev->attrs.device_cap_flags &
+		      IB_DEVICE_INTEGRITY_HANDOVER)) {
+			dev_warn(ctrl->ctrl.device,
+				 "T10-PI requested but not supported on %s, continue without T10-PI\n",
+				 ctrl->device->dev->name);
+			ctrl->pi_support = false;
+			ctrl->ctrl.opts->pi_enable = false;
+		} else {
+			ctrl->pi_support = true;
+		}
+	}
+
+	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
+							ctrl->pi_support);
 
 	/*
 	 * Bind the async event SQE DMA mapping to the admin queue lifetime.
@@ -829,6 +876,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
 	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
+	if (ctrl->pi_support)
+		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
 
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
@@ -1154,13 +1203,24 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_nr_phys_segments(rq))
 		return;
 
+	if (blk_integrity_rq(rq)) {
+		ib_dma_unmap_sg(ibdev, req->pi_sgl->sg_table.sgl,
+			req->pi_sgl->nents, rq_dma_dir(rq));
+		sg_free_table_chained(&req->pi_sgl->sg_table, SG_CHUNK_SIZE);
+	}
+
 	if (req->mr) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+		if (req->is_protected)
+			ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
+		else
+			ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs,
+				       req->mr);
 		req->mr = NULL;
 	}
 
-	ib_dma_unmap_sg(ibdev, req->sg_table.sgl, req->nents, rq_dma_dir(rq));
-	sg_free_table_chained(&req->sg_table, SG_CHUNK_SIZE);
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl,
+			req->data_sgl.nents, rq_dma_dir(rq));
+	sg_free_table_chained(&req->data_sgl.sg_table, SG_CHUNK_SIZE);
 }
 
 static int nvme_rdma_set_sg_null(struct nvme_command *c)
@@ -1179,7 +1239,7 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
 		int count)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
-	struct scatterlist *sgl = req->sg_table.sgl;
+	struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
 	struct ib_sge *sge = &req->sge[1];
 	u32 len = 0;
 	int i;
@@ -1204,40 +1264,115 @@ static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 {
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 
-	sg->addr = cpu_to_le64(sg_dma_address(req->sg_table.sgl));
-	put_unaligned_le24(sg_dma_len(req->sg_table.sgl), sg->length);
+	sg->addr = cpu_to_le64(sg_dma_address(req->data_sgl.sg_table.sgl));
+	put_unaligned_le24(sg_dma_len(req->data_sgl.sg_table.sgl), sg->length);
 	put_unaligned_le32(queue->device->pd->unsafe_global_rkey, sg->key);
 	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
 	return 0;
 }
 
-static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
-		struct nvme_rdma_request *req, struct nvme_command *c,
-		int count)
+static void nvme_rdma_set_diff_domain(struct nvme_command *cmd, struct bio *bio,
+		struct ib_sig_domain *domain, struct request *rq)
 {
-	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
-	int nr;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
+	struct nvme_ns *ns = rq->rq_disk->private_data;
 
-	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
-	if (WARN_ON_ONCE(!req->mr))
-		return -EAGAIN;
+	WARN_ON(bi == NULL);
+
+	domain->sig_type = IB_SIG_TYPE_T10_DIF;
+	domain->sig.dif.bg_type = IB_T10DIF_CRC;
+	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
+	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
 
 	/*
-	 * Align the MR to a 4K page size to match the ctrl page size and
-	 * the block virtual boundary.
+	 * At the moment we hard code those, but in the future
+	 * we will take them from cmd.
 	 */
-	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, SZ_4K);
-	if (unlikely(nr < count)) {
-		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
-		req->mr = NULL;
-		if (nr < 0)
-			return nr;
-		return -EINVAL;
+	domain->sig.dif.apptag_check_mask = 0xffff;
+	domain->sig.dif.app_escape = true;
+	domain->sig.dif.ref_escape = true;
+	if (ns->pi_type != NVME_NS_DPS_PI_TYPE3)
+		domain->sig.dif.ref_remap = true;
+}
+
+static void nvme_rdma_set_sig_attrs(struct bio *bio,
+		struct ib_sig_attrs *sig_attrs, struct nvme_command *c,
+		struct request *rq)
+{
+	u16 control = le16_to_cpu(c->rw.control);
+
+	memset(sig_attrs, 0, sizeof(*sig_attrs));
+
+	if (control & NVME_RW_PRINFO_PRACT) {
+		/* for WRITE_INSERT/READ_STRIP no memory domain */
+		sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
+		nvme_rdma_set_diff_domain(c, bio, &sig_attrs->wire, rq);
+		/* Clear the PRACT bit since HCA will generate/verify the PI */
+		control &= ~NVME_RW_PRINFO_PRACT;
+		c->rw.control = cpu_to_le16(control);
+	} else {
+		/* for WRITE_PASS/READ_PASS both wire/memory domains exist */
+		nvme_rdma_set_diff_domain(c, bio, &sig_attrs->wire, rq);
+		nvme_rdma_set_diff_domain(c, bio, &sig_attrs->mem, rq);
 	}
+}
+
+static void nvme_rdma_set_prot_checks(struct nvme_command *cmd, u8 *mask)
+{
+	*mask = 0;
+	if (le16_to_cpu(cmd->rw.control) & NVME_RW_PRINFO_PRCHK_REF)
+		*mask |= IB_SIG_CHECK_REFTAG;
+	if (le16_to_cpu(cmd->rw.control) & NVME_RW_PRINFO_PRCHK_GUARD)
+		*mask |= IB_SIG_CHECK_GUARD;
+}
+
+static void nvme_rdma_sig_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		nvme_rdma_wr_error(cq, wc, "SIG");
+}
+
+static void nvme_rdma_set_pi_wr(struct nvme_rdma_request *req,
+				struct nvme_command *c)
+{
+	struct ib_sig_attrs *sig_attrs = req->mr->sig_attrs;
+	struct ib_reg_wr *wr = &req->reg_wr;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	struct bio *bio = rq->bio;
+	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+
+	nvme_rdma_set_sig_attrs(bio, sig_attrs, c, rq);
+
+	nvme_rdma_set_prot_checks(c, &sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
 
+	req->reg_cqe.done = nvme_rdma_sig_done;
+
+	memset(wr, 0, sizeof(*wr));
+	wr->wr.opcode = IB_WR_REG_MR_INTEGRITY;
+	wr->wr.wr_cqe = &req->reg_cqe;
+	wr->wr.num_sge = 0;
+	wr->wr.send_flags = 0;
+	wr->mr = req->mr;
+	wr->key = req->mr->rkey;
+	wr->access = IB_ACCESS_LOCAL_WRITE |
+		     IB_ACCESS_REMOTE_READ |
+		     IB_ACCESS_REMOTE_WRITE;
+
+	sg->addr = cpu_to_le64(req->mr->iova);
+	put_unaligned_le24(req->mr->length, sg->length);
+	put_unaligned_le32(req->mr->rkey, sg->key);
+	sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_INVALIDATE;
+}
+
+static void nvme_rdma_set_reg_wr(struct nvme_rdma_request *req,
+				 struct nvme_command *c)
+{
+	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+
 	req->reg_cqe.done = nvme_rdma_memreg_done;
+
 	memset(&req->reg_wr, 0, sizeof(req->reg_wr));
 	req->reg_wr.wr.opcode = IB_WR_REG_MR;
 	req->reg_wr.wr.wr_cqe = &req->reg_cqe;
@@ -1253,8 +1388,52 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	put_unaligned_le32(req->mr->rkey, sg->key);
 	sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
 			NVME_SGL_FMT_INVALIDATE;
+}
+
+static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, struct nvme_command *c,
+		int count, int pi_count)
+{
+	struct nvme_rdma_sgl *sgl = &req->data_sgl;
+	int nr;
+
+	if (req->is_protected) {
+		req->mr = ib_mr_pool_get(queue->qp, &queue->qp->sig_mrs);
+		if (WARN_ON_ONCE(!req->mr))
+			return -EAGAIN;
+
+		nr = ib_map_mr_sg_pi(req->mr, sgl->sg_table.sgl, count, 0,
+				     req->pi_sgl->sg_table.sgl, pi_count, 0,
+				     SZ_4K);
+		if (unlikely(nr))
+			goto mr_put;
+
+		nvme_rdma_set_pi_wr(req, c);
+	} else {
+		req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
+		if (WARN_ON_ONCE(!req->mr))
+			return -EAGAIN;
+		/*
+		 * Align the MR to a 4K page size to match the ctrl page size
+		 * and the block virtual boundary.
+		 */
+		nr = ib_map_mr_sg(req->mr, sgl->sg_table.sgl, count, 0, SZ_4K);
+		if (unlikely(nr < count))
+			goto mr_put;
+
+		nvme_rdma_set_reg_wr(req, c);
+	}
 
 	return 0;
+mr_put:
+	if (req->is_protected)
+		ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
+	else
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+	req->mr = NULL;
+	if (nr < 0)
+		return nr;
+	return -EINVAL;
 }
 
 static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
@@ -1263,6 +1442,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
+	int pi_count = 0;
 	int count, ret;
 
 	req->num_sge = 1;
@@ -1273,23 +1453,44 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_nr_phys_segments(rq))
 		return nvme_rdma_set_sg_null(c);
 
-	req->sg_table.sgl = req->first_sgl;
-	ret = sg_alloc_table_chained(&req->sg_table,
-			blk_rq_nr_phys_segments(rq), req->sg_table.sgl,
-			SG_CHUNK_SIZE);
+	req->data_sgl.sg_table.sgl = req->data_sgl.first_sgl;
+	ret = sg_alloc_table_chained(&req->data_sgl.sg_table,
+			blk_rq_nr_phys_segments(rq),
+			req->data_sgl.sg_table.sgl, SG_CHUNK_SIZE);
 	if (ret)
 		return -ENOMEM;
 
-	req->nents = blk_rq_map_sg(rq->q, rq, req->sg_table.sgl);
+	req->data_sgl.nents = blk_rq_map_sg(rq->q, rq,
+					    req->data_sgl.sg_table.sgl);
 
-	count = ib_dma_map_sg(ibdev, req->sg_table.sgl, req->nents,
-			      rq_dma_dir(rq));
+	count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
+			      req->data_sgl.nents, rq_dma_dir(rq));
 	if (unlikely(count <= 0)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
 
-	if (count <= dev->num_inline_segments) {
+	if (blk_integrity_rq(rq)) {
+		req->pi_sgl->sg_table.sgl = req->pi_sgl->first_sgl;
+		ret = sg_alloc_table_chained(&req->pi_sgl->sg_table,
+				blk_rq_count_integrity_sg(rq->q, rq->bio),
+				req->pi_sgl->sg_table.sgl, SG_CHUNK_SIZE);
+		if (unlikely(ret)) {
+			ret = -ENOMEM;
+			goto out_unmap_sg;
+		}
+
+		req->pi_sgl->nents = blk_rq_map_integrity_sg(rq->q, rq->bio,
+					req->pi_sgl->sg_table.sgl);
+		pi_count = ib_dma_map_sg(ibdev, req->pi_sgl->sg_table.sgl,
+				req->pi_sgl->nents, rq_dma_dir(rq));
+		if (unlikely(pi_count <= 0)) {
+			ret = -EIO;
+			goto out_free_pi_table;
+		}
+	}
+
+	if (count <= dev->num_inline_segments && !req->is_protected) {
 		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
 		    queue->ctrl->use_inline_data &&
 		    blk_rq_payload_bytes(rq) <=
@@ -1304,17 +1505,25 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		}
 	}
 
-	ret = nvme_rdma_map_sg_fr(queue, req, c, count);
+	ret = nvme_rdma_map_sg_fr(queue, req, c, count, pi_count);
 out:
 	if (unlikely(ret))
-		goto out_unmap_sg;
+		goto out_unmap_pi_sg;
 
 	return 0;
 
+out_unmap_pi_sg:
+	if (blk_integrity_rq(rq))
+		ib_dma_unmap_sg(ibdev, req->pi_sgl->sg_table.sgl,
+				req->pi_sgl->nents, rq_dma_dir(rq));
+out_free_pi_table:
+	if (blk_integrity_rq(rq))
+		sg_free_table_chained(&req->pi_sgl->sg_table, SG_CHUNK_SIZE);
 out_unmap_sg:
-	ib_dma_unmap_sg(ibdev, req->sg_table.sgl, req->nents, rq_dma_dir(rq));
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl,
+			req->data_sgl.nents, rq_dma_dir(rq));
 out_free_table:
-	sg_free_table_chained(&req->sg_table, SG_CHUNK_SIZE);
+	sg_free_table_chained(&req->data_sgl.sg_table, SG_CHUNK_SIZE);
 	return ret;
 }
 
@@ -1754,6 +1963,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
+	req->is_protected = false;
+	if (nvme_rdma_queue_idx(queue) && queue->pi_support) {
+		if (c->common.opcode == nvme_cmd_write ||
+		    c->common.opcode == nvme_cmd_read)
+			req->is_protected = nvme_ns_has_pi(ns);
+	}
+
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -1794,12 +2010,46 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
 	return ib_process_cq_direct(queue->ib_cq, -1);
 }
 
+static void nvme_rdma_check_pi_status(struct nvme_rdma_request *req)
+{
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	struct ib_mr_status mr_status;
+	int ret;
+
+	ret = ib_check_mr_status(req->mr, IB_MR_CHECK_SIG_STATUS, &mr_status);
+	if (ret) {
+		pr_err("ib_check_mr_status failed, ret %d\n", ret);
+		nvme_req(rq)->status = NVME_SC_INVALID_PI;
+		return;
+	}
+
+	if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
+		switch (mr_status.sig_err.err_type) {
+		case IB_SIG_BAD_GUARD:
+			nvme_req(rq)->status = NVME_SC_GUARD_CHECK;
+			break;
+		case IB_SIG_BAD_REFTAG:
+			nvme_req(rq)->status = NVME_SC_REFTAG_CHECK;
+			break;
+		case IB_SIG_BAD_APPTAG:
+			nvme_req(rq)->status = NVME_SC_APPTAG_CHECK;
+			break;
+		}
+		pr_err("PI error found type %d expected 0x%x vs actual 0x%x\n",
+		       mr_status.sig_err.err_type, mr_status.sig_err.expected,
+		       mr_status.sig_err.actual);
+	}
+}
+
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
 	struct ib_device *ibdev = queue->device->dev;
 
+	if (req->is_protected)
+		nvme_rdma_check_pi_status(req);
+
 	nvme_rdma_unmap_data(queue, rq);
 	ib_dma_unmap_single(ibdev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
@@ -1919,7 +2169,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS,
+	.flags			= NVME_F_FABRICS | NVME_F_METADATA_SUPPORTED,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
@@ -2063,7 +2313,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS,
+			  NVMF_OPT_TOS | NVMF_OPT_PI_ENABLE,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
