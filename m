From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:22 +0300
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-18-git-send-email-maxg@mellanox.com>

For capable HCAs (e.g. ConnectX-4/ConnectX-5) this will allow end-to-end
protection information passthrough and validation for NVMe over RDMA transport.
Similar to iSER, T10-PI offload support was implemented over RDMA signature
verbs API and is enabled via module parameter. In the future we might want
to add support per controller.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 533 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 490 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 88f2f00..f64a91f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -57,6 +57,7 @@ struct nvme_rdma_qe {
 
 struct nvme_rdma_sgl {
 	struct ib_mr		*mr;
+	struct ib_sge		sge;
 	int			nents;
 	struct ib_reg_wr	reg_wr;
 	struct ib_cqe		reg_cqe;
@@ -65,6 +66,16 @@ struct nvme_rdma_sgl {
 	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
 };
 
+struct nvme_rdma_pi_sgl {
+	struct nvme_rdma_sgl		sgl;
+	struct ib_sig_attrs		sig_attrs;
+	struct ib_sig_handover_wr	sig_wr;
+	struct ib_cqe			sig_cqe;
+	struct ib_cqe			sig_inv_cqe;
+	struct ib_sge			sig_sge;
+	struct ib_mr			*sig_mr;
+};
+
 struct nvme_rdma_queue;
 struct nvme_rdma_request {
 	struct nvme_request	req;
@@ -76,6 +87,10 @@ struct nvme_rdma_request {
 	u32			num_sge;
 	struct nvme_rdma_queue  *queue;
 	struct nvme_rdma_sgl	data_sgl;
+
+	/* T10-PI support */
+	bool			is_protected;
+	struct nvme_rdma_pi_sgl	pi_sgl[];
 };
 
 enum nvme_rdma_queue_flags {
@@ -97,6 +112,7 @@ struct nvme_rdma_queue {
 	struct rdma_cm_id	*cm_id;
 	int			cm_error;
 	struct completion	cm_done;
+	bool			pi_support;
 };
 
 struct nvme_rdma_ctrl {
@@ -122,6 +138,7 @@ struct nvme_rdma_ctrl {
 	struct sockaddr_storage src_addr;
 
 	struct nvme_ctrl	ctrl;
+	bool			pi_support;
 };
 
 static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
@@ -145,6 +162,10 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
 MODULE_PARM_DESC(register_always,
 	 "Use memory registration even for contiguous memory regions");
 
+static bool pi_enable = false;
+module_param_named(pi_enable, pi_enable, bool, 0444);
+MODULE_PARM_DESC(pi_enable, "Enable T10-PI offload support (default:disabled)");
+
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event);
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
@@ -259,6 +280,8 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	init_attr.qp_type = IB_QPT_RC;
 	init_attr.send_cq = queue->ib_cq;
 	init_attr.recv_cq = queue->ib_cq;
+	if (queue->pi_support)
+		init_attr.create_flags |= IB_QP_CREATE_SIGNATURE_EN;
 
 	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
 
@@ -393,6 +416,12 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
 	return NULL;
 }
 
+static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
+{
+	return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+		     ibdev->attrs.max_fast_reg_page_list_len);
+}
+
 static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_device *dev;
@@ -404,6 +433,8 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	dev = queue->device;
 	ibdev = dev->dev;
 
+	if (queue->pi_support)
+		ib_mr_pool_destroy(queue->qp, &queue->qp->sig_mrs);
 	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
 
 	/*
@@ -420,16 +451,11 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	nvme_rdma_dev_put(dev);
 }
 
-static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
-{
-	return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		     ibdev->attrs.max_fast_reg_page_list_len);
-}
-
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct ib_device *ibdev;
-	const int send_wr_factor = 3;			/* MR, SEND, INV */
+	/* (MR, SEND, INV) + MR (prot, sig), INV (prot, sig) for T-10 PI */
+	const int send_wr_factor = (queue->pi_support * 4) + 3;
 	const int cq_factor = send_wr_factor + 1;	/* + RECV */
 	int comp_vector, idx = nvme_rdma_queue_idx(queue);
 	int ret;
@@ -469,20 +495,35 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	}
 
 	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
-			      queue->queue_size,
+			      (queue->pi_support + 1) * queue->queue_size,
 			      IB_MR_TYPE_MEM_REG,
 			      nvme_rdma_get_max_fr_pages(ibdev));
 	if (ret) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to initialize MR pool sized %d for QID %d\n",
-			queue->queue_size, idx);
+			(queue->pi_support + 1) * queue->queue_size, idx);
 		goto out_destroy_ring;
 	}
 
+	if (queue->pi_support) {
+		ret = ib_mr_pool_init(queue->qp, &queue->qp->sig_mrs,
+				queue->queue_size,
+				IB_MR_TYPE_SIGNATURE,
+				2);
+		if (ret) {
+			dev_err(queue->ctrl->ctrl.device,
+			"failed to init sig MR pool sized %d for QID %d\n",
+			queue->queue_size, nvme_rdma_queue_idx(queue));
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
@@ -504,9 +545,11 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 
 	queue = &ctrl->queues[idx];
 	queue->ctrl = ctrl;
+	queue->pi_support = idx && ctrl->pi_support;
 	init_completion(&queue->cm_done);
 
-	if (idx > 0)
+	/* No inline data for Admin queue and T10-PI capabale queues */
+	if (idx > 0 && !queue->pi_support)
 		queue->cmnd_capsule_len = ctrl->ctrl.ioccsz * 16;
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
@@ -706,7 +749,8 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = NUMA_NO_NODE;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
-		set->cmd_size = sizeof(struct nvme_rdma_request);
+		set->cmd_size = sizeof(struct nvme_rdma_request) +
+			(ctrl->pi_support * sizeof(struct nvme_rdma_pi_sgl));
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
@@ -756,6 +800,19 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	ctrl->device = ctrl->queues[0].device;
 
+	/* T10-PI support */
+	if (pi_enable) {
+		if (!(ctrl->device->dev->attrs.device_cap_flags &
+		      IB_DEVICE_SIGNATURE_HANDOVER)) {
+			dev_warn(ctrl->ctrl.device,
+				 "T10-PI requested but not supported on %s, "
+				 "continue without T10-PI\n",
+				 ctrl->device->dev->name);
+			ctrl->pi_support = false;
+		} else {
+			ctrl->pi_support = true;
+		}
+	}
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
 
 	if (new) {
@@ -793,6 +850,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (ilog2(SZ_4K) - 9);
+	if (ctrl->pi_support)
+		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages >> 1;
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
@@ -1020,6 +1079,18 @@ static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
 		nvme_rdma_wr_error(cq, wc, "MEMREG");
 }
 
+static void nvme_rdma_inv_prot_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		nvme_rdma_wr_error(cq, wc, "LOCAL_PROT_INV");
+}
+
+static void nvme_rdma_inv_sig_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		nvme_rdma_wr_error(cq, wc, "LOCAL_SIG_INV");
+}
+
 static void nvme_rdma_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvme_rdma_sgl *sgl =
@@ -1068,6 +1139,13 @@ static void nvme_rdma_unmap_data_sgl(struct nvme_rdma_queue *queue,
 	sg_free_table_chained(&sgl->sg_table, true);
 }
 
+static void nvme_rdma_unmap_integrity_sgl(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_pi_sgl *pi_sgl,
+		struct request *rq)
+{
+	nvme_rdma_unmap_data_sgl(queue, &pi_sgl->sgl, rq);
+}
+
 static void nvme_rdma_unmap_cmd(struct nvme_rdma_queue *queue,
 		struct request *rq)
 {
@@ -1077,6 +1155,19 @@ static void nvme_rdma_unmap_cmd(struct nvme_rdma_queue *queue,
 		return;
 
 	req = blk_mq_rq_to_pdu(rq);
+
+	if (req->is_protected) {
+		ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs,
+			       req->pi_sgl->sig_mr);
+		req->pi_sgl->sig_mr = NULL;
+		if (blk_integrity_rq(rq)) {
+			ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs,
+				       req->pi_sgl->sgl.mr);
+			req->pi_sgl->sgl.mr = NULL;
+			nvme_rdma_unmap_integrity_sgl(queue, req->pi_sgl, rq);
+		}
+	}
+
 	if (req->data_sgl.mr) {
 		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->data_sgl.mr);
 		req->data_sgl.mr = NULL;
@@ -1136,11 +1227,13 @@ static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 
 static int nvme_rdma_map_mr_sg(struct nvme_rdma_queue *queue,
 			       struct list_head *mr_pool,
-			       struct nvme_rdma_sgl *sgl, int nents)
+			       struct nvme_rdma_sgl *sgl,
+			       int nents, struct ib_send_wr *last)
 {
 	struct scatterlist *sg = sgl->sg_table.sgl;
 	struct ib_reg_wr *reg_wr = &sgl->reg_wr;
 	struct ib_cqe *reg_cqe = &sgl->reg_cqe;
+	struct ib_sge *sge = &sgl->sge;
 	int nr;
 
 	sgl->mr = ib_mr_pool_get(queue->qp, mr_pool);
@@ -1173,26 +1266,230 @@ static int nvme_rdma_map_mr_sg(struct nvme_rdma_queue *queue,
 			 IB_ACCESS_REMOTE_READ |
 			 IB_ACCESS_REMOTE_WRITE;
 
+	sge->lkey = sgl->mr->lkey;
+	sge->addr = sgl->mr->iova;
+	sge->length = sgl->mr->length;
+
+	if (last)
+		last->next = &reg_wr->wr;
+
 	return 0;
 }
 
+static void nvme_rdma_set_diff_domain(struct nvme_command *cmd,
+		struct bio *bio,
+		struct ib_sig_attrs *sig_attrs,
+		struct ib_sig_domain *domain, struct request *rq)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
+	struct nvme_ns *ns = rq->rq_disk->private_data;
+
+	WARN_ON(bi == NULL);
+
+	domain->sig_type = IB_SIG_TYPE_T10_DIF;
+	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
+	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
+
+	/*
+	 * At the moment we hard code those, but in the future
+	 * we will take them from cmd.
+	 */
+	domain->sig.dif.apptag_check_mask = 0xffff;
+	domain->sig.dif.app_escape = true;
+	domain->sig.dif.ref_escape = true;
+	if (ns->pi_type != NVME_NS_DPS_PI_TYPE3)
+		domain->sig.dif.ref_remap = true;
+}
+
+static int nvme_rdma_set_sig_attrs(struct bio *bio,
+		struct ib_sig_attrs *sig_attrs, struct nvme_command *c,
+		struct request *rq)
+{
+	u16 control = le16_to_cpu(c->rw.control);
+
+	if (control & NVME_RW_PRINFO_PRACT) {
+		/* for WRITE_INSERT/READ_STRIP no memory domain */
+		sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
+		nvme_rdma_set_diff_domain(c, bio, sig_attrs, &sig_attrs->wire, rq);
+		sig_attrs->wire.sig.dif.bg_type = IB_T10DIF_CRC;
+		/* Clear the PRACT bit since HCA will generate/verify the PI */
+		control &= ~NVME_RW_PRINFO_PRACT;
+		c->rw.control = cpu_to_le16(control);
+	} else {
+		/* for WRITE_PASS/READ_PASS both wire/memory domains exist */
+		nvme_rdma_set_diff_domain(c, bio, sig_attrs, &sig_attrs->wire, rq);
+		sig_attrs->wire.sig.dif.bg_type = IB_T10DIF_CRC;
+		nvme_rdma_set_diff_domain(c, bio, sig_attrs, &sig_attrs->mem, rq);
+		sig_attrs->mem.sig.dif.bg_type = IB_T10DIF_CRC;
+	}
+
+	return 0;
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
+static int nvme_rdma_map_sig_mr_sg(struct nvme_rdma_queue *queue,
+			struct list_head *mr_pool,
+			struct nvme_rdma_request *req,
+			struct nvme_command *c,
+			struct ib_send_wr *last)
+{
+	struct nvme_rdma_pi_sgl *pi_sgl = req->pi_sgl;
+	struct ib_sig_attrs *sig_attrs = &pi_sgl->sig_attrs;
+	struct ib_cqe *cqe = &pi_sgl->sig_cqe;
+	struct ib_cqe *inv_cqe = &pi_sgl->sig_inv_cqe;
+	struct ib_sig_handover_wr *wr = &pi_sgl->sig_wr;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	struct bio *bio = rq->bio;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_disk);
+	int ret;
+
+	pi_sgl->sig_mr = ib_mr_pool_get(queue->qp, mr_pool);
+	if (WARN_ON_ONCE(!pi_sgl->sig_mr))
+		return -EAGAIN;
+
+	memset(sig_attrs, 0, sizeof(*sig_attrs));
+
+	ret = nvme_rdma_set_sig_attrs(bio, sig_attrs, c, rq);
+	if (unlikely(ret))
+		goto put_sig_mr;
+
+	nvme_rdma_set_prot_checks(c, &sig_attrs->check_mask);
+
+	ib_update_fast_reg_key(pi_sgl->sig_mr, ib_inc_rkey(pi_sgl->sig_mr->rkey));
+
+	cqe->done = nvme_rdma_sig_done;
+	inv_cqe->done = nvme_rdma_inv_sig_rkey_done;
+
+	memset(wr, 0, sizeof(*wr));
+	wr->wr.opcode = IB_WR_REG_SIG_MR;
+	wr->wr.wr_cqe = cqe;
+	wr->wr.sg_list = &req->data_sgl.sge;
+	wr->wr.num_sge = 1;
+	wr->wr.send_flags = 0;
+	wr->sig_attrs = sig_attrs;
+	wr->sig_mr = pi_sgl->sig_mr;
+	if (blk_integrity_rq(rq))
+		wr->prot = &pi_sgl->sgl.sge;
+	else
+		wr->prot = NULL;
+	wr->access_flags = IB_ACCESS_LOCAL_WRITE |
+			   IB_ACCESS_REMOTE_READ |
+			   IB_ACCESS_REMOTE_WRITE;
+
+	pi_sgl->sig_sge.lkey = pi_sgl->sig_mr->lkey;
+	pi_sgl->sig_sge.addr = 0;
+	pi_sgl->sig_sge.length = blk_rq_bytes(rq) +
+		bi->tuple_size * (blk_rq_bytes(rq) >> bi->interval_exp);
+
+	if (last)
+		last->next = &wr->wr;
+
+	return 0;
+
+put_sig_mr:
+	ib_mr_pool_put(queue->qp, mr_pool, pi_sgl->sig_mr);
+	return ret;
+}
+
 static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_request *req, struct nvme_command *c,
-		int nents)
+		int nents, int prot_nents)
 {
 	struct nvme_rdma_sgl *sgl = &req->data_sgl;
+	struct ib_send_wr *last;
+	struct ib_sge *sge;
+	u32 rkey;
 	int ret;
 
-	ret = nvme_rdma_map_mr_sg(queue, &queue->qp->rdma_mrs, sgl, nents);
+	ret = nvme_rdma_map_mr_sg(queue, &queue->qp->rdma_mrs, sgl, nents, NULL);
 	if (unlikely(ret))
 		return -EAGAIN;
 
 	sgl->inv_cqe.done = nvme_rdma_inv_rkey_done;
+	last = &sgl->reg_wr.wr;
+
+	if (req->is_protected) {
+		if (prot_nents) {
+			ret = nvme_rdma_map_mr_sg(queue, &queue->qp->rdma_mrs, &req->pi_sgl->sgl,
+						  prot_nents, last);
+			if (unlikely(ret)) {
+				ret = -EAGAIN;
+				goto put_mr;
+			}
+
+			req->pi_sgl->sgl.inv_cqe.done = nvme_rdma_inv_prot_rkey_done;
+			last = &req->pi_sgl->sgl.reg_wr.wr;
+		}
 
-	nvme_rdma_set_keyed_sgl(sgl->mr->iova, sgl->mr->length, sgl->mr->rkey,
+		ret = nvme_rdma_map_sig_mr_sg(queue, &queue->qp->sig_mrs, req,
+					      c, last);
+		if (unlikely(ret)) {
+			ret = -EAGAIN;
+			goto put_prot_mr;
+		}
+
+		sge = &req->pi_sgl->sig_sge;
+		rkey = req->pi_sgl->sig_mr->rkey;
+	} else {
+		sge = &sgl->sge;
+		rkey = sgl->mr->rkey;
+	}
+
+	nvme_rdma_set_keyed_sgl(sge->addr, sge->length, rkey,
 				c, true);
 
 	return 0;
+put_prot_mr:
+	if (prot_nents) {
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->pi_sgl->sgl.mr);
+		req->pi_sgl->sgl.mr = NULL;
+	}
+put_mr:
+	ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, sgl->mr);
+	sgl->mr = NULL;
+	return ret;
+}
+
+static int nvme_rdma_map_integrity_sgl(struct nvme_rdma_pi_sgl *pi_sgl,
+		struct request *rq, struct ib_device *ibdev, int *count)
+{
+	int ret;
+
+	pi_sgl->sgl.sg_table.sgl = pi_sgl->sgl.first_sgl;
+	ret = sg_alloc_table_chained(&pi_sgl->sgl.sg_table,
+			blk_rq_count_integrity_sg(rq->q, rq->bio),
+			pi_sgl->sgl.sg_table.sgl);
+	if (unlikely(ret))
+		return -ENOMEM;
+
+	pi_sgl->sgl.nents = blk_rq_map_integrity_sg(rq->q, rq->bio,
+				pi_sgl->sgl.sg_table.sgl);
+	*count = ib_dma_map_sg(ibdev, pi_sgl->sgl.sg_table.sgl, pi_sgl->sgl.nents,
+			rq_data_dir(rq) == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (unlikely(*count <= 0)) {
+		ret = -EIO;
+		goto out_free_table;
+	}
+
+	return ret;
+
+out_free_table:
+	sg_free_table_chained(&pi_sgl->sgl.sg_table, true);
+	return ret;
 }
 
 static int nvme_rdma_map_data_sgl(struct nvme_rdma_sgl *sgl,
@@ -1224,9 +1521,9 @@ static int nvme_rdma_map_data_sgl(struct nvme_rdma_sgl *sgl,
 
 static int nvme_rdma_map_rq(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_request *req, struct request *rq,
-		struct nvme_command *c, int nents)
+		struct nvme_command *c, int nents, int prot_nents)
 {
-	if (nents == 1) {
+	if (nents == 1 && !req->is_protected) {
 		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
 		    blk_rq_payload_bytes(rq) <=	nvme_rdma_inline_data_size(queue))
 			return nvme_rdma_map_sg_inline(queue, req, c);
@@ -1234,7 +1531,7 @@ static int nvme_rdma_map_rq(struct nvme_rdma_queue *queue,
 			return nvme_rdma_map_sg_single(queue, req, c);
 	}
 
-	return nvme_rdma_map_sg_fr(queue, req, c, nents);
+	return nvme_rdma_map_sg_fr(queue, req, c, nents, prot_nents);
 }
 
 static int nvme_rdma_setup_cmd(struct nvme_rdma_queue *queue,
@@ -1244,6 +1541,7 @@ static int nvme_rdma_setup_cmd(struct nvme_rdma_queue *queue,
 	struct nvme_rdma_sgl *sgl = &req->data_sgl;
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
+	int prot_count = 0;
 	int count, ret;
 
 	req->num_sge = 1;
@@ -1258,12 +1556,21 @@ static int nvme_rdma_setup_cmd(struct nvme_rdma_queue *queue,
 	if (unlikely(ret))
 		return ret;
 
-	ret = nvme_rdma_map_rq(queue, req, rq, c, count);
+	if (blk_integrity_rq(rq)) {
+		ret = nvme_rdma_map_integrity_sgl(req->pi_sgl, rq, ibdev, &prot_count);
+		if (ret < 0)
+			goto out_unmap_data_sgl;
+	}
+
+	ret = nvme_rdma_map_rq(queue, req, rq, c, count, prot_count);
 	if (unlikely(ret))
-		goto out_unmap_data_sgl;
+		goto out_unmap_integrity_sgl;
 
 	return 0;
 
+out_unmap_integrity_sgl:
+	if (blk_integrity_rq(rq))
+		nvme_rdma_unmap_integrity_sgl(queue, req->pi_sgl, rq);
 out_unmap_data_sgl:
 	nvme_rdma_unmap_data_sgl(queue, sgl, rq);
 	return ret;
@@ -1288,7 +1595,7 @@ static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 
 static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
 		struct nvme_rdma_qe *qe, struct ib_sge *sge, u32 num_sge,
-		struct ib_send_wr *first)
+		struct ib_send_wr *first, struct ib_send_wr *last)
 {
 	struct ib_send_wr wr, *bad_wr;
 	int ret;
@@ -1305,7 +1612,7 @@ static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
 	wr.send_flags = IB_SEND_SIGNALED;
 
 	if (first)
-		first->next = &wr;
+		last->next = &wr; /* we need to add WR to last configured WR */
 	else
 		first = &wr;
 
@@ -1381,16 +1688,115 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 	ib_dma_sync_single_for_device(dev, sqe->dma, sizeof(*cmd),
 			DMA_TO_DEVICE);
 
-	ret = nvme_rdma_post_send(queue, sqe, &sge, 1, NULL);
+	ret = nvme_rdma_post_send(queue, sqe, &sge, 1, NULL, NULL);
 	WARN_ON_ONCE(ret);
 }
 
+static int nvme_rdma_local_invalidate_keys(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, u32 sig_rkey, u32 prot_rkey,
+		u32 data_rkey)
+{
+	struct request *rq;
+	int ret = 0;
+
+	if (sig_rkey) {
+		ret = nvme_rdma_inv_rkey(queue, sig_rkey,
+					 &req->pi_sgl->sig_inv_cqe);
+		if (unlikely(ret < 0)) {
+			dev_err(queue->ctrl->ctrl.device,
+				"Queueing INV SIG WR for rkey %#x failed (%d)\n",
+				sig_rkey, ret);
+			/* fail with DNR on posting local inv failure */
+			rq = blk_mq_rq_from_pdu(req);
+			nvme_req(rq)->status = NVME_SC_INTERNAL | NVME_SC_DNR;
+			ret = -EINVAL;
+		}
+	}
+	if (prot_rkey) {
+		ret = nvme_rdma_inv_rkey(queue, prot_rkey,
+					 &req->pi_sgl->sgl.inv_cqe);
+		if (unlikely(ret < 0)) {
+			dev_err(queue->ctrl->ctrl.device,
+				"Queueing INV PROT WR for rkey %#x failed (%d)\n",
+				prot_rkey, ret);
+			/* fail with DNR on posting local inv failure */
+			rq = blk_mq_rq_from_pdu(req);
+			nvme_req(rq)->status = NVME_SC_INTERNAL | NVME_SC_DNR;
+			ret = -EINVAL;
+		}
+	}
+	if (data_rkey) {
+		ret = nvme_rdma_inv_rkey(queue, data_rkey,
+					 &req->data_sgl.inv_cqe);
+		if (unlikely(ret < 0)) {
+			dev_err(queue->ctrl->ctrl.device,
+				"Queueing INV WR for rkey %#x failed (%d)\n",
+				data_rkey, ret);
+			/* fail with DNR on posting local inv failure */
+			rq = blk_mq_rq_from_pdu(req);
+			nvme_req(rq)->status = NVME_SC_INTERNAL | NVME_SC_DNR;
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int nvme_rdma_invalidate_req(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, struct ib_wc *wc)
+{
+	u32 rkey;
+	int ret;
+
+	if (req->is_protected) {
+		rkey = req->pi_sgl->sig_mr->rkey;
+		if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
+			if (unlikely(wc->ex.invalidate_rkey != rkey)) {
+				dev_err(queue->ctrl->ctrl.device,
+					"Bogus remote invalidation for rkey %#x\n",
+					rkey);
+				ret = -EINVAL;
+				goto out_error_recovery;
+			} else {
+				rkey = 0; /* no need to invalidate this key */
+			}
+		}
+		ret = nvme_rdma_local_invalidate_keys(queue, req, rkey,
+				req->pi_sgl->sgl.mr ? req->pi_sgl->sgl.mr->rkey : 0,
+				req->data_sgl.mr ? req->data_sgl.mr->rkey : 0);
+		if (unlikely(ret))
+			goto out_error_recovery;
+	} else if (req->data_sgl.mr) {
+		rkey = req->data_sgl.mr->rkey;
+		if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
+			if (unlikely(wc->ex.invalidate_rkey != rkey)) {
+				dev_err(queue->ctrl->ctrl.device,
+					"Bogus remote invalidation for rkey %#x\n",
+					rkey);
+				ret = -EINVAL;
+				goto out_error_recovery;
+			} else {
+				return 1; /* This will indicate that we should complete the cmd */
+			}
+		} else {
+			ret = nvme_rdma_local_invalidate_keys(queue, req, 0, 0, rkey);
+			if (unlikely(ret))
+				goto out_error_recovery;
+		}
+	}
+
+	return 0;
+
+out_error_recovery:
+	nvme_rdma_error_recovery(queue->ctrl);
+	return ret;
+}
+
 static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		struct nvme_completion *cqe, struct ib_wc *wc, int tag)
 {
 	struct request *rq;
 	struct nvme_rdma_request *req;
-	struct nvme_rdma_sgl *sgl;
 	int ret = 0;
 
 	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
@@ -1405,25 +1811,12 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 
 	req->status = cqe->status;
 	req->result = cqe->result;
-	sgl = &req->data_sgl;
 
-	if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
-		if (unlikely(wc->ex.invalidate_rkey != sgl->mr->rkey)) {
-			dev_err(queue->ctrl->ctrl.device,
-				"Bogus remote invalidation for rkey %#x\n",
-				sgl->mr->rkey);
-			nvme_rdma_error_recovery(queue->ctrl);
+	if (req->data_sgl.mr || req->is_protected) {
+		if (!nvme_rdma_invalidate_req(queue, req, wc)) {
+			/* the local invalidation completion will end the request */
+			return 0;
 		}
-	} else if (sgl->mr) {
-		ret = nvme_rdma_inv_rkey(queue, sgl->mr->rkey, &sgl->inv_cqe);
-		if (unlikely(ret < 0)) {
-			dev_err(queue->ctrl->ctrl.device,
-				"Queueing INV WR for rkey %#x failed (%d)\n",
-				sgl->mr->rkey, ret);
-			nvme_rdma_error_recovery(queue->ctrl);
-		}
-		/* the local invalidation completion will end the request */
-		return 0;
 	}
 
 	if (refcount_dec_and_test(&req->ref)) {
@@ -1669,6 +2062,17 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 }
 
 static inline struct ib_send_wr *
+nvme_rdma_last_wr(struct nvme_rdma_request *req)
+{
+	if (req->is_protected)
+		return &req->pi_sgl->sig_wr.wr;
+	else if (req->data_sgl.mr)
+		return &req->data_sgl.reg_wr.wr;
+
+	return NULL;
+}
+
+static inline struct ib_send_wr *
 nvme_rdma_first_wr(struct nvme_rdma_request *req)
 {
 	if (req->data_sgl.mr)
@@ -1707,6 +2111,12 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
+	if (nvme_rdma_queue_idx(queue)) {
+		if (c->common.opcode == nvme_cmd_write ||
+		    c->common.opcode == nvme_cmd_read)
+			req->is_protected = nvme_ns_has_pi(ns);
+	}
+
 	err = nvme_rdma_setup_cmd(queue, rq, c);
 	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -1721,7 +2131,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
-				  nvme_rdma_first_wr(req));
+				  nvme_rdma_first_wr(req),
+				  nvme_rdma_last_wr(req));
 	if (unlikely(err)) {
 		nvme_rdma_unmap_cmd(queue, rq);
 		goto err;
@@ -1755,10 +2166,46 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return found;
 }
 
+static void
+nvme_rdma_check_pi_status(struct nvme_rdma_request *req)
+{
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	struct ib_mr_status mr_status;
+	int ret;
+
+	ret = ib_check_mr_status(req->pi_sgl->sig_mr, IB_MR_CHECK_SIG_STATUS,
+				 &mr_status);
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
+		       mr_status.sig_err.err_type,
+		       mr_status.sig_err.expected,
+		       mr_status.sig_err.actual);
+	}
+}
+
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (req->is_protected)
+		nvme_rdma_check_pi_status(req);
 	nvme_rdma_unmap_cmd(req->queue, rq);
 	nvme_complete_rq(rq);
 }
@@ -1861,7 +2308,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS,
+	.flags			= NVME_F_FABRICS | NVME_F_METADATA_SUPPORTED,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-- 
1.8.3.1
