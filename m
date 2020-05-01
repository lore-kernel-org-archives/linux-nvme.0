Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348CDC4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0356D208C3
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="guPyu+fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WiEbko7rSEZrVxYkVH07BDrGaGbUcj7h/xD3eOlocOo=; b=guPyu+fZs1LGhy
	XQKKKFeVgqXK2lxE5Lkte+bcj1AZ1i82pyd6cwZkECjCFYxmByKUovZI1RiBGdSD1mTgKJgVw/GH6
	fuiFCLGugrNwCyFsm/KKbKyL7nSwZGjO/zhcMJv5o4ZflBu3SNjog8VljjnutlTmza3KW6tjTPy/4
	55DTYSWxxXlaVOXP+0SCkKDmoP0DkawGPSnF+3hHK3JAix/3K/rFzJOw0qe9ZZVJeWSO+1kGUuGwy
	O8gtAUFBPQOcbochmVBlEV978FU5VemNK4+ODOx7ADBeIdGp6nt3z2e5PJxWq8AhdEhf2bOsz8dz8
	5OFCIa6krVAOn7qpvOdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUWcN-0006Gq-Hi; Fri, 01 May 2020 14:26:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUWcJ-0006FY-RN
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 14:26:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3903568D0D; Fri,  1 May 2020 16:26:13 +0200 (CEST)
Date: Fri, 1 May 2020 16:26:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 08/15] nvme-rdma: add metadata/T10-PI support
Message-ID: <20200501142612.GG7197@lst.de>
References: <20200428131135.211521-1-maxg@mellanox.com>
 <20200428131135.211521-9-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428131135.211521-9-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_072616_193178_86C155B9 
X-CRM114-Status: GOOD (  19.88  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 28, 2020 at 04:11:28PM +0300, Max Gurtovoy wrote:
> For capable HCAs (e.g. ConnectX-5/ConnectX-6) this will allow end-to-end
> protection information passthrough and validation for NVMe over RDMA
> transport. Metadata offload support was implemented over the new RDMA
> signature verbs API and it is enabled by per capable controllers.

What do you think about the following changes to keep the churn down
a bit, and to let the compiler optimize out all the integrity code if
not built into the kernel?  The two header changes will need to go
into their own patches of course.

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f13c48359b65c..dc695e9338cb0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -31,12 +31,17 @@ extern unsigned int admin_timeout;
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
-#define  NVME_INLINE_MD_SG_CNT  0
+#define  NVME_INLINE_METADATA_SG_CNT  0
 #else
 #define  NVME_INLINE_SG_CNT  2
-#define  NVME_INLINE_MD_SG_CNT  1
+#define  NVME_INLINE_METADATA_SG_CNT  1
 #endif
 
+#define NVME_RDMA_DATA_SGL_SIZE \
+	(sizeof(struct scatterlist) * NVME_INLINE_SG_CNT)
+#define NVME_RDMA_METADATA_SGL_SIZE \
+	(sizeof(struct scatterlist) * NVME_INLINE_METADATA_SG_CNT)
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e94ef9593f91e..94c11ccdbba1b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -67,9 +67,8 @@ struct nvme_rdma_request {
 	struct ib_cqe		reg_cqe;
 	struct nvme_rdma_queue  *queue;
 	struct nvme_rdma_sgl	data_sgl;
-	/* Metadata (T10-PI) support */
-	struct nvme_rdma_sgl	*md_sgl;
-	bool			use_md;
+	struct nvme_rdma_sgl	*metadata_sgl;
+	bool			use_sig_mr;
 };
 
 enum nvme_rdma_queue_flags {
@@ -285,18 +284,6 @@ static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
 	kfree(req->sqe.data);
 }
 
-static unsigned int nvme_rdma_cmd_size(bool has_md)
-{
-	/*
-	 * nvme rdma command consists of struct nvme_rdma_request, data SGL,
-	 * PI nvme_rdma_sgl struct and then PI SGL.
-	 */
-	return sizeof(struct nvme_rdma_request) +
-	       sizeof(struct scatterlist) * NVME_INLINE_SG_CNT +
-	       has_md * (sizeof(struct nvme_rdma_sgl) +
-			 sizeof(struct scatterlist) * NVME_INLINE_MD_SG_CNT);
-}
-
 static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 		struct request *rq, unsigned int hctx_idx,
 		unsigned int numa_node)
@@ -311,10 +298,6 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 	if (!req->sqe.data)
 		return -ENOMEM;
 
-	/* metadata nvme_rdma_sgl struct is located after command's data SGL */
-	if (queue->pi_support)
-		req->md_sgl = (void *)nvme_req(rq) + nvme_rdma_cmd_size(false);
-
 	req->queue = queue;
 
 	return 0;
@@ -770,7 +753,8 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		set->reserved_tags = 2; /* connect + keep-alive */
 		set->numa_node = nctrl->numa_node;
-		set->cmd_size = nvme_rdma_cmd_size(false);
+		set->cmd_size = sizeof(struct nvme_rdma_request) +
+				NVME_RDMA_DATA_SGL_SIZE;
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
 		set->timeout = ADMIN_TIMEOUT;
@@ -783,7 +767,10 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
-		set->cmd_size = nvme_rdma_cmd_size(nctrl->pi_capable);
+		set->cmd_size = sizeof(struct nvme_rdma_request) +
+				NVME_RDMA_DATA_SGL_SIZE;
+		if (nctrl->pi_capable)
+			set->cmd_size += NVME_RDMA_METADATA_SGL_SIZE;
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
@@ -1199,15 +1186,9 @@ static int nvme_rdma_inv_rkey(struct nvme_rdma_queue *queue,
 	return ib_post_send(queue->qp, &wr, NULL);
 }
 
-static void nvme_rdma_mr_pool_put(struct ib_qp *qp,
-		struct nvme_rdma_request *req)
+static inline bool nvme_rdma_use_sig_mr(struct nvme_rdma_request *req)
 {
-	if (req->use_md)
-		ib_mr_pool_put(qp, &qp->sig_mrs, req->mr);
-	else
-		ib_mr_pool_put(qp, &qp->rdma_mrs, req->mr);
-
-	req->mr = NULL;
+	return IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && req->use_sig_mr;
 }
 
 static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
@@ -1216,19 +1197,25 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
+	struct list_head *pool = &queue->qp->rdma_mrs;
 
 	if (!blk_rq_nr_phys_segments(rq))
 		return;
 
 	if (blk_integrity_rq(rq)) {
-		ib_dma_unmap_sg(ibdev, req->md_sgl->sg_table.sgl,
-				req->md_sgl->nents, rq_dma_dir(rq));
-		sg_free_table_chained(&req->md_sgl->sg_table,
-				      NVME_INLINE_MD_SG_CNT);
+		ib_dma_unmap_sg(ibdev, req->metadata_sgl->sg_table.sgl,
+				req->metadata_sgl->nents, rq_dma_dir(rq));
+		sg_free_table_chained(&req->metadata_sgl->sg_table,
+				      NVME_INLINE_METADATA_SG_CNT);
 	}
 
-	if (req->mr)
-		nvme_rdma_mr_pool_put(queue->qp, req);
+	if (nvme_rdma_use_sig_mr(req))
+		pool = &queue->qp->sig_mrs;
+
+	if (req->mr) {
+		ib_mr_pool_put(queue->qp, pool, req->mr);
+		req->mr = NULL;
+	}
 
 	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
 			rq_dma_dir(rq));
@@ -1283,15 +1270,59 @@ static int nvme_rdma_map_sg_single(struct nvme_rdma_queue *queue,
 	return 0;
 }
 
+static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, struct nvme_command *c,
+		int count)
+{
+	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+	int nr;
+
+	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
+	if (WARN_ON_ONCE(!req->mr))
+		return -EAGAIN;
+
+	/*
+	 * Align the MR to a 4K page size to match the ctrl page size and
+	 * the block virtual boundary.
+	 */
+	nr = ib_map_mr_sg(req->mr, req->data_sgl.sg_table.sgl, count, 0, SZ_4K);
+	if (unlikely(nr < count)) {
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+		req->mr = NULL;
+		if (nr < 0)
+			return nr;
+		return -EINVAL;
+	}
+
+	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
+
+	req->reg_cqe.done = nvme_rdma_memreg_done;
+	memset(&req->reg_wr, 0, sizeof(req->reg_wr));
+	req->reg_wr.wr.opcode = IB_WR_REG_MR;
+	req->reg_wr.wr.wr_cqe = &req->reg_cqe;
+	req->reg_wr.wr.num_sge = 0;
+	req->reg_wr.mr = req->mr;
+	req->reg_wr.key = req->mr->rkey;
+	req->reg_wr.access = IB_ACCESS_LOCAL_WRITE |
+			     IB_ACCESS_REMOTE_READ |
+			     IB_ACCESS_REMOTE_WRITE;
+
+	sg->addr = cpu_to_le64(req->mr->iova);
+	put_unaligned_le24(req->mr->length, sg->length);
+	put_unaligned_le32(req->mr->rkey, sg->key);
+	sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
+			NVME_SGL_FMT_INVALIDATE;
+
+	return 0;
+}
+
 static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
 		struct nvme_command *cmd, struct ib_sig_domain *domain,
 		u16 control)
 {
 	domain->sig_type = IB_SIG_TYPE_T10_DIF;
 	domain->sig.dif.bg_type = IB_T10DIF_CRC;
-#ifdef CONFIG_BLK_DEV_INTEGRITY
 	domain->sig.dif.pi_interval = 1 << bi->interval_exp;
-#endif
 	domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
 	domain->sig.dif.apptag_check_mask = 0xffff;
 	domain->sig.dif.app_escape = true;
@@ -1335,26 +1366,34 @@ static void nvme_rdma_sig_done(struct ib_cq *cq, struct ib_wc *wc)
 		nvme_rdma_wr_error(cq, wc, "SIG");
 }
 
-static void nvme_rdma_set_pi_wr(struct nvme_rdma_request *req,
-				struct nvme_command *c)
+static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_request *req, struct nvme_command *c,
+		int count, int pi_count)
 {
+	struct nvme_rdma_sgl *sgl = &req->data_sgl;
 	struct ib_sig_attrs *sig_attrs = req->mr->sig_attrs;
 	struct ib_reg_wr *wr = &req->reg_wr;
 	struct request *rq = blk_mq_rq_from_pdu(req);
 	struct bio *bio = rq->bio;
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+	int nr;
 
-	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
-		return;
+	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->sig_mrs);
+	if (WARN_ON_ONCE(!req->mr))
+		return -EAGAIN;
 
-	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_disk), c, sig_attrs);
+	nr = ib_map_mr_sg_pi(req->mr, sgl->sg_table.sgl, count, 0,
+			     req->metadata_sgl->sg_table.sgl, pi_count, 0,
+			     SZ_4K);
+	if (unlikely(nr))
+		goto mr_put;
 
+	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_disk), c, sig_attrs);
 	nvme_rdma_set_prot_checks(c, &sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
 
 	req->reg_cqe.done = nvme_rdma_sig_done;
-
 	memset(wr, 0, sizeof(*wr));
 	wr->wr.opcode = IB_WR_REG_MR_INTEGRITY;
 	wr->wr.wr_cqe = &req->reg_cqe;
@@ -1370,69 +1409,10 @@ static void nvme_rdma_set_pi_wr(struct nvme_rdma_request *req,
 	put_unaligned_le24(req->mr->length, sg->length);
 	put_unaligned_le32(req->mr->rkey, sg->key);
 	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
-}
-
-static void nvme_rdma_set_reg_wr(struct nvme_rdma_request *req,
-				 struct nvme_command *c)
-{
-	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
-
-	req->reg_cqe.done = nvme_rdma_memreg_done;
-
-	memset(&req->reg_wr, 0, sizeof(req->reg_wr));
-	req->reg_wr.wr.opcode = IB_WR_REG_MR;
-	req->reg_wr.wr.wr_cqe = &req->reg_cqe;
-	req->reg_wr.wr.num_sge = 0;
-	req->reg_wr.mr = req->mr;
-	req->reg_wr.key = req->mr->rkey;
-	req->reg_wr.access = IB_ACCESS_LOCAL_WRITE |
-			     IB_ACCESS_REMOTE_READ |
-			     IB_ACCESS_REMOTE_WRITE;
-
-	sg->addr = cpu_to_le64(req->mr->iova);
-	put_unaligned_le24(req->mr->length, sg->length);
-	put_unaligned_le32(req->mr->rkey, sg->key);
-	sg->type = (NVME_KEY_SGL_FMT_DATA_DESC << 4) |
-			NVME_SGL_FMT_INVALIDATE;
-}
-
-static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
-		struct nvme_rdma_request *req, struct nvme_command *c,
-		int count, int pi_count)
-{
-	struct nvme_rdma_sgl *sgl = &req->data_sgl;
-	int nr;
-
-	if (req->use_md) {
-		req->mr = ib_mr_pool_get(queue->qp, &queue->qp->sig_mrs);
-		if (WARN_ON_ONCE(!req->mr))
-			return -EAGAIN;
-
-		nr = ib_map_mr_sg_pi(req->mr, sgl->sg_table.sgl, count, 0,
-				     req->md_sgl->sg_table.sgl, pi_count, 0,
-				     SZ_4K);
-		if (unlikely(nr))
-			goto mr_put;
-
-		nvme_rdma_set_pi_wr(req, c);
-	} else {
-		req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
-		if (WARN_ON_ONCE(!req->mr))
-			return -EAGAIN;
-		/*
-		 * Align the MR to a 4K page size to match the ctrl page size
-		 * and the block virtual boundary.
-		 */
-		nr = ib_map_mr_sg(req->mr, sgl->sg_table.sgl, count, 0, SZ_4K);
-		if (unlikely(nr < count))
-			goto mr_put;
-
-		nvme_rdma_set_reg_wr(req, c);
-	}
-
 	return 0;
 mr_put:
-	nvme_rdma_mr_pool_put(queue->qp, req);
+	ib_mr_pool_put(queue->qp, &queue->qp->sig_mrs, req->mr);
+	req->mr = NULL;
 	if (nr < 0)
 		return nr;
 	return -EINVAL;
@@ -1473,28 +1453,35 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	}
 
 	if (blk_integrity_rq(rq)) {
-		req->md_sgl->sg_table.sgl =
-			(struct scatterlist *)(req->md_sgl + 1);
-		ret = sg_alloc_table_chained(&req->md_sgl->sg_table,
+		req->metadata_sgl = (void *)nvme_req(rq) +
+			sizeof(struct nvme_rdma_request) +
+			NVME_RDMA_DATA_SGL_SIZE;
+		req->metadata_sgl->sg_table.sgl =
+			(struct scatterlist *)(req->metadata_sgl + 1);
+		ret = sg_alloc_table_chained(&req->metadata_sgl->sg_table,
 				blk_rq_count_integrity_sg(rq->q, rq->bio),
-				req->md_sgl->sg_table.sgl,
-				NVME_INLINE_MD_SG_CNT);
+				req->metadata_sgl->sg_table.sgl,
+				NVME_INLINE_METADATA_SG_CNT);
 		if (unlikely(ret)) {
 			ret = -ENOMEM;
 			goto out_unmap_sg;
 		}
 
-		req->md_sgl->nents = blk_rq_map_integrity_sg(rq->q, rq->bio,
-					req->md_sgl->sg_table.sgl);
-		pi_count = ib_dma_map_sg(ibdev, req->md_sgl->sg_table.sgl,
-					 req->md_sgl->nents, rq_dma_dir(rq));
+		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq->q,
+				rq->bio, req->metadata_sgl->sg_table.sgl);
+		pi_count = ib_dma_map_sg(ibdev, req->metadata_sgl->sg_table.sgl,
+				req->metadata_sgl->nents, rq_dma_dir(rq));
 		if (unlikely(pi_count <= 0)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
 	}
 
-	if (count <= dev->num_inline_segments && !req->use_md) {
+	if (nvme_rdma_use_sig_mr(req)) {
+		ret = nvme_rdma_map_sg_pi(queue, req, c, count, pi_count);
+		goto out;
+	}
+	if (count <= dev->num_inline_segments) {
 		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
 		    queue->ctrl->use_inline_data &&
 		    blk_rq_payload_bytes(rq) <=
@@ -1509,7 +1496,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		}
 	}
 
-	ret = nvme_rdma_map_sg_fr(queue, req, c, count, pi_count);
+	ret = nvme_rdma_map_sg_fr(queue, req, c, count);
 out:
 	if (unlikely(ret))
 		goto out_unmap_pi_sg;
@@ -1518,12 +1505,12 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 out_unmap_pi_sg:
 	if (blk_integrity_rq(rq))
-		ib_dma_unmap_sg(ibdev, req->md_sgl->sg_table.sgl,
-				req->md_sgl->nents, rq_dma_dir(rq));
+		ib_dma_unmap_sg(ibdev, req->metadata_sgl->sg_table.sgl,
+				req->metadata_sgl->nents, rq_dma_dir(rq));
 out_free_pi_table:
 	if (blk_integrity_rq(rq))
-		sg_free_table_chained(&req->md_sgl->sg_table,
-				      NVME_INLINE_MD_SG_CNT);
+		sg_free_table_chained(&req->metadata_sgl->sg_table,
+				      NVME_INLINE_METADATA_SG_CNT);
 out_unmap_sg:
 	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
 			rq_dma_dir(rq));
@@ -1976,9 +1963,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	if (c->common.opcode == nvme_cmd_write ||
-	    c->common.opcode == nvme_cmd_read)
-		req->use_md = queue->pi_support && nvme_ns_has_pi(ns);
+	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+	    queue->pi_support && nvme_ns_has_pi(ns) &&
+	    (c->common.opcode == nvme_cmd_write ||
+	     c->common.opcode == nvme_cmd_read))
+		req->use_sig_mr = true;
+	else
+		req->use_sig_mr = false;
 
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
@@ -2060,7 +2051,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	struct nvme_rdma_queue *queue = req->queue;
 	struct ib_device *ibdev = queue->device->dev;
 
-	if (req->use_md)
+	if (nvme_rdma_use_sig_mr(req))
 		nvme_rdma_check_pi_status(req);
 
 	nvme_rdma_unmap_data(queue, rq);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 058d895544c75..841858150ab7a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -169,8 +169,6 @@ struct disk_part_tbl {
 struct disk_events;
 struct badblocks;
 
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-
 struct blk_integrity {
 	const struct blk_integrity_profile	*profile;
 	unsigned char				flags;
@@ -179,8 +177,6 @@ struct blk_integrity {
 	unsigned char				tag_size;
 };
 
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
-
 struct gendisk {
 	/* major, first_minor and minors are input parameters only,
 	 * don't use directly.  Use disk_devt() and disk_max_parts().

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
