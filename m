Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CEAC4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 16:25:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88952064C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 16:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bbctx55y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88952064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=62J2VG9hQB4qsFw50b2Xb69drx9cV7o1XnFjc/edf9c=; b=bbctx55yjEuoP8
	8WAZ/a1DYO4WVNhJXSaI3qMLRZUJi/4YT9GpkHojw7MdD9eEgb1pqw9VeYVFvXKbSrlzlT0VL7i0p
	PRsGbs7ux9EG6PftBwN3Ag7LjxgZ0406Om6o9yXqaorHcvacCMsebPVCp5AXhhTExG+0MvsNMYOWc
	lhmrBKyspRWhT1gSyPu5ix1WTvESg3qVesRC64ywuNkGt/B5P8XNEnjp5DjRLBkVvx3cIZVe1Hoak
	3+5iwDtytywrKCVx8As+Sak+iHOh2Kibfggga6xIc8on3pbgJ/Fb062mcY45Y1QXJefA4twQLGOxN
	u1WCZftQD5ZneCeAqpoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUYTo-0003lz-PF; Fri, 01 May 2020 16:25:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUYTk-0003kL-Lb
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 16:25:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D48DB68BFE; Fri,  1 May 2020 18:25:29 +0200 (CEST)
Date: Fri, 1 May 2020 18:25:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 14/15] nvmet: add metadata support for block devices
Message-ID: <20200501162529.GE17680@lst.de>
References: <20200428131135.211521-1-maxg@mellanox.com>
 <20200428131135.211521-15-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428131135.211521-15-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_092533_005985_49C5B0CC 
X-CRM114-Status: GOOD (  15.47  )
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

Looks generally good.  _md_ should be renamed to _metadata_, and
I think we can do the SGL allocation a little cleaner.  Please take
a look at the attached diff:

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index c1456ce9a8427..485285c9c8a3c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -884,11 +884,11 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sq = sq;
 	req->ops = ops;
 	req->sg = NULL;
-	req->md_sg = NULL;
+	req->metadata_sg = NULL;
 	req->sg_cnt = 0;
-	req->md_sg_cnt = 0;
+	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
-	req->md_len = 0;
+	req->metadata_len = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
@@ -973,103 +973,92 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 	return true;
 }
 
-void nvmet_req_free_p2pmem_sgls(struct nvmet_req *req)
+static unsigned int nvmet_data_transfer_len(struct nvmet_req *req)
 {
-	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
-	if (req->md_sg)
-		pci_p2pmem_free_sgl(req->p2p_dev, req->md_sg);
+	return req->transfer_len - req->metadata_len;
 }
 
-static int nvmet_req_alloc_p2pmem_sgls(struct nvmet_req *req, int data_len,
-		struct pci_dev *p2p_dev)
+static int nvmet_req_alloc_p2pmem_sgls(struct nvmet_req *req)
 {
-	req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt, data_len);
+	req->sg = pci_p2pmem_alloc_sgl(req->p2p_dev, &req->sg_cnt,
+			nvmet_data_transfer_len(req));
 	if (!req->sg)
 		goto out_err;
 
-	if (req->md_len) {
-		req->md_sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->md_sg_cnt,
-						  req->md_len);
-		if (!req->md_sg)
+	if (req->metadata_len) {
+		req->metadata_sg = pci_p2pmem_alloc_sgl(req->p2p_dev,
+				&req->metadata_sg_cnt, req->metadata_len);
+		if (!req->metadata_sg)
 			goto out_free_sg;
 	}
-	req->p2p_dev = p2p_dev;
 	return 0;
 
 out_free_sg:
-	pci_p2pmem_free_sgl(p2p_dev, req->sg);
+	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
 out_err:
+	req->p2p_dev = NULL;
 	return -ENOMEM;
 }
 
-void nvmet_req_free_mem_sgls(struct nvmet_req *req)
+static bool nvmet_req_find_p2p_dev(struct nvmet_req *req)
 {
-	sgl_free(req->sg);
-	if (req->md_sg)
-		sgl_free(req->md_sg);
+	if (!IS_ENABLED(CONFIG_PCI_P2PDMA))
+		return false;
+
+	if (req->sq->ctrl && req->sq->qid && req->ns) {
+		req->p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
+						 req->ns->nsid);
+		if (req->p2p_dev)
+			return true;
+	}
+
+	req->p2p_dev = NULL;
+	return false;
 }
 
-static int nvmet_req_alloc_mem_sgls(struct nvmet_req *req, int data_len)
+int nvmet_req_alloc_sgl(struct nvmet_req *req)
 {
-	req->sg = sgl_alloc(data_len, GFP_KERNEL, &req->sg_cnt);
+	if (nvmet_req_find_p2p_dev(req) && nvmet_req_alloc_p2pmem_sgls(req))
+		return 0;
+
+	req->sg = sgl_alloc(nvmet_data_transfer_len(req), GFP_KERNEL,
+			    &req->sg_cnt);
 	if (unlikely(!req->sg))
 		goto out;
 
-	if (req->md_len) {
-		req->md_sg = sgl_alloc(req->md_len, GFP_KERNEL,
-				       &req->md_sg_cnt);
-		if (unlikely(!req->md_sg))
+	if (req->metadata_len) {
+		req->metadata_sg = sgl_alloc(req->metadata_len, GFP_KERNEL,
+				       &req->metadata_sg_cnt);
+		if (unlikely(!req->metadata_sg))
 			goto out_free;
 	}
 
 	return 0;
-
 out_free:
 	sgl_free(req->sg);
 out:
 	return -ENOMEM;
 }
+EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgls);
 
-int nvmet_req_alloc_sgl(struct nvmet_req *req)
+void nvmet_req_free_sgls(struct nvmet_req *req)
 {
-	struct pci_dev *p2p_dev = NULL;
-	int data_len = req->transfer_len - req->md_len;
-
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA)) {
-		if (req->sq->ctrl && req->ns)
-			p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
-						    req->ns->nsid);
-
-		req->p2p_dev = NULL;
-		if (req->sq->qid && p2p_dev) {
-			int ret = nvmet_req_alloc_p2pmem_sgls(req, data_len,
-							      p2p_dev);
-			if (!ret)
-				return 0;
-		}
+	if (req->p2p_dev) {
+		pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
+		if (req->metadata_sg)
+			pci_p2pmem_free_sgl(req->p2p_dev, req->metadata_sg);
+	} else {
+		sgl_free(req->sg);
+		if (req->metadata_sg)
+			sgl_free(req->metadata_sg);
 	}
 
-	/*
-	 * If no P2P memory was available/enabled we fallback to using regular
-	 * memory.
-	 */
-	return nvmet_req_alloc_mem_sgls(req, data_len);
-}
-EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
-
-void nvmet_req_free_sgl(struct nvmet_req *req)
-{
-	if (req->p2p_dev)
-		nvmet_req_free_p2pmem_sgls(req);
-	else
-		nvmet_req_free_mem_sgls(req);
-
 	req->sg = NULL;
-	req->md_sg = NULL;
+	req->metadata_sg = NULL;
 	req->sg_cnt = 0;
-	req->md_sg_cnt = 0;
+	req->metadata_sg_cnt = 0;
 }
-EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
+EXPORT_SYMBOL_GPL(nvmet_req_free_sgls);
 
 static inline bool nvmet_cc_en(u32 cc)
 {
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 4243156146b92..02ce6df8877b8 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -191,7 +191,7 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 	}
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO,
-			min_t(unsigned int, req->md_sg_cnt, BIO_MAX_PAGES));
+		min_t(unsigned int, req->metadata_sg_cnt, BIO_MAX_PAGES));
 	if (IS_ERR(bip)) {
 		pr_err("Unable to allocate bio_integrity_payload\n");
 		return PTR_ERR(bip);
@@ -238,9 +238,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector_t sector;
 	int op, i, rc;
 	struct sg_mapping_iter prot_miter;
+	unsigned int iter_flags;
+	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
 
-	if (!nvmet_check_transfer_len(req,
-				      nvmet_rw_data_len(req) + req->md_len))
+	if (!nvmet_check_transfer_len(req, total_len))
 		return;
 
 	if (!req->sg_cnt) {
@@ -252,8 +253,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			op |= REQ_FUA;
+		iter_flags = SG_MITER_TO_SG;
 	} else {
 		op = REQ_OP_READ;
+		iter_flags = SG_MITER_FROM_SG;
 	}
 
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
@@ -275,17 +278,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_opf = op;
 
 	blk_start_plug(&plug);
-	if (req->md_len)
-		sg_miter_start(&prot_miter, req->md_sg, req->md_sg_cnt,
-			       op == REQ_OP_READ ? SG_MITER_FROM_SG :
-						   SG_MITER_TO_SG);
+	if (req->metadata_len)
+		sg_miter_start(&prot_miter, req->metadata_sg,
+				req->metadata_sg_cnt, iter_flags);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
 			struct bio *prev = bio;
 
-			if (req->md_len) {
+			if (req->metadata_len) {
 				rc = nvmet_bdev_alloc_bip(req, bio,
 							  &prot_miter);
 				if (unlikely(rc)) {
@@ -307,7 +309,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sg_cnt--;
 	}
 
-	if (req->md_len) {
+	if (req->metadata_len) {
 		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
 		if (unlikely(rc)) {
 			bio_io_error(bio);
@@ -443,7 +445,7 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write:
 		req->execute = nvmet_bdev_execute_rw;
 		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns))
-			req->md_len = nvmet_rw_md_len(req);
+			req->metadata_len = nvmet_rw_metadata_len(req);
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_bdev_execute_flush;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 706952032ef8f..237707e72120d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -309,7 +309,7 @@ struct nvmet_req {
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
-	struct scatterlist	*md_sg;
+	struct scatterlist	*metadata_sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
@@ -323,10 +323,10 @@ struct nvmet_req {
 		} f;
 	};
 	int			sg_cnt;
-	int			md_sg_cnt;
+	int			metadata_sg_cnt;
 	/* data length as parsed from the SGL descriptor: */
 	size_t			transfer_len;
-	size_t			md_len;
+	size_t			metadata_len;
 
 	struct nvmet_port	*port;
 
@@ -397,8 +397,8 @@ void nvmet_req_uninit(struct nvmet_req *req);
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
-int nvmet_req_alloc_sgl(struct nvmet_req *req);
-void nvmet_req_free_sgl(struct nvmet_req *req);
+int nvmet_req_alloc_sgls(struct nvmet_req *req);
+void nvmet_req_free_sgls(struct nvmet_req *req);
 
 void nvmet_execute_keep_alive(struct nvmet_req *req);
 
@@ -517,7 +517,7 @@ static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 			req->ns->blksize_shift;
 }
 
-static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
+static inline u32 nvmet_rw_metadata_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) *
 			req->ns->metadata_size;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f4a4721774a80..b62a56959b0ce 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -613,7 +613,7 @@ static void nvmet_rdma_set_sig_attrs(struct nvmet_req *req,
 		control &= ~NVME_RW_PRINFO_PRACT;
 		cmd->rw.control = cpu_to_le16(control);
 		/* PI is added by the HW */
-		req->transfer_len += req->md_len;
+		req->transfer_len += req->metadata_len;
 	} else {
 		/* for WRITE_PASS/READ_PASS both wire/memory domains exist */
 		nvmet_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control);
@@ -635,10 +635,10 @@ static int nvmet_rdma_rw_ctx_init(struct nvmet_rdma_rsp *rsp, u64 addr, u32 key,
 	struct nvmet_req *req = &rsp->req;
 	int ret;
 
-	if (req->md_len)
+	if (req->metadata_len)
 		ret = rdma_rw_ctx_signature_init(&rsp->rw, cm_id->qp,
-			cm_id->port_num, req->sg, req->sg_cnt, req->md_sg,
-			req->md_sg_cnt, sig_attrs, addr, key,
+			cm_id->port_num, req->sg, req->sg_cnt, req->metadata_sg,
+			req->metadata_sg_cnt, sig_attrs, addr, key,
 			nvmet_data_dir(req));
 	else
 		ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
@@ -653,10 +653,10 @@ static void nvmet_rdma_rw_ctx_destroy(struct nvmet_rdma_rsp *rsp)
 	struct rdma_cm_id *cm_id = rsp->queue->cm_id;
 	struct nvmet_req *req = &rsp->req;
 
-	if (req->md_len)
+	if (req->metadata_len)
 		rdma_rw_ctx_destroy_signature(&rsp->rw, cm_id->qp,
-			cm_id->port_num, req->sg, req->sg_cnt, req->md_sg,
-			req->md_sg_cnt, nvmet_data_dir(req));
+			cm_id->port_num, req->sg, req->sg_cnt, req->metadata_sg,
+			req->metadata_sg_cnt, nvmet_data_dir(req));
 	else
 		rdma_rw_ctx_destroy(&rsp->rw, cm_id->qp, cm_id->port_num,
 				    req->sg, req->sg_cnt, nvmet_data_dir(req));
@@ -672,7 +672,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 		nvmet_rdma_rw_ctx_destroy(rsp);
 
 	if (rsp->req.sg != rsp->cmd->inline_sg)
-		nvmet_req_free_sgl(&rsp->req);
+		nvmet_req_free_sgls(&rsp->req);
 
 	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
 		nvmet_rdma_process_wr_wait_list(queue);
@@ -725,7 +725,7 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 	}
 
 	if (nvmet_rdma_need_data_out(rsp)) {
-		if (rsp->req.md_len)
+		if (rsp->req.metadata_len)
 			first_wr = rdma_rw_ctx_wrs(&rsp->rw, cm_id->qp,
 					cm_id->port_num, &rsp->write_cqe, NULL);
 		else
@@ -770,7 +770,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	if (rsp->req.md_len)
+	if (rsp->req.metadata_len)
 		status = nvmet_rdma_check_pi_status(rsp->rw.reg->mr);
 	nvmet_rdma_rw_ctx_destroy(rsp);
 
@@ -889,10 +889,10 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	if (!rsp->req.transfer_len)
 		return 0;
 
-	if (rsp->req.md_len)
+	if (rsp->req.metadata_len)
 		nvmet_rdma_set_sig_attrs(&rsp->req, &sig_attrs);
 
-	ret = nvmet_req_alloc_sgl(&rsp->req);
+	ret = nvmet_req_alloc_sgls(&rsp->req);
 	if (unlikely(ret < 0))
 		goto error_out;
 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
