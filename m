Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD05C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C158720823
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 14:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KFx6nu99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C158720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hypcn6397jq2hLAyn1FDqCjT+4m3XduwglVss7StIIQ=; b=KFx6nu991ZnCF+
	C8Wbz/ffmBJ88HZI0dLCotilYUTqnoM4LjHpPhxZZULpBHYjwqYI24CYb0uLkdgUMFIMlf12UKwV+
	peF9fmxsnKNaMvKeIII4FeIOMC6XhdC+eFiFjNdLsdVGP9B0v/SFmcPscOHHP5W4/EuCngkLWsEUv
	mJsgYAhboVIwL+Hslsi1XjJWAu7F9WtBjcWnu8bMYWDn2+7n3W0cQWAbLyhmrp2rttsIwBOKMS2N/
	0Ic06nZUhmjhtlr8Q53bDyMg0ifG5IvY4WijeT6HKPDHjUu8uVQ9vnhUJOQF9gY8he4UUXSZ2fFhy
	bZnBD4PiMFox+HazpjTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb2vt-00049s-Lv; Tue, 19 May 2020 14:09:25 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb2so-0001QC-Rv
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 14:06:30 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 19 May 2020 17:06:05 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04JE63xw006590;
 Tue, 19 May 2020 17:06:05 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, martin.petersen@oracle.com, jsmart2021@gmail.com,
 axboe@kernel.dk
Subject: [PATCH 15/16] nvmet: add metadata support for block devices
Date: Tue, 19 May 2020 17:06:02 +0300
Message-Id: <20200519140603.166576-16-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519140603.166576-1-maxg@mellanox.com>
References: <20200519140603.166576-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_070615_485003_2531C588 
X-CRM114-Status: GOOD (  14.96  )
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

Allocate the metadata SGL buffers and set metadata fields for the
request. Then create a block IO request for the metadata from the
protection SG list.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/core.c        | 95 ++++++++++++++++++++++++++++-----------
 drivers/nvme/target/io-cmd-bdev.c | 87 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h       |  7 ++-
 drivers/nvme/target/rdma.c        |  4 +-
 4 files changed, 161 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9f6b0f9..4e9a2e7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -886,8 +886,11 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sq = sq;
 	req->ops = ops;
 	req->sg = NULL;
+	req->metadata_sg = NULL;
 	req->sg_cnt = 0;
+	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
+	req->metadata_len = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
@@ -972,50 +975,90 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 	return true;
 }
 
-int nvmet_req_alloc_sgl(struct nvmet_req *req)
+static unsigned int nvmet_data_transfer_len(struct nvmet_req *req)
 {
-	struct pci_dev *p2p_dev = NULL;
+	return req->transfer_len - req->metadata_len;
+}
 
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA)) {
-		if (req->sq->ctrl && req->ns)
-			p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
-						    req->ns->nsid);
+static int nvmet_req_alloc_p2pmem_sgls(struct nvmet_req *req)
+{
+	req->sg = pci_p2pmem_alloc_sgl(req->p2p_dev, &req->sg_cnt,
+			nvmet_data_transfer_len(req));
+	if (!req->sg)
+		goto out_err;
 
-		req->p2p_dev = NULL;
-		if (req->sq->qid && p2p_dev) {
-			req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt,
-						       req->transfer_len);
-			if (req->sg) {
-				req->p2p_dev = p2p_dev;
-				return 0;
-			}
-		}
+	if (req->metadata_len) {
+		req->metadata_sg = pci_p2pmem_alloc_sgl(req->p2p_dev,
+				&req->metadata_sg_cnt, req->metadata_len);
+		if (!req->metadata_sg)
+			goto out_free_sg;
+	}
+	return 0;
+out_free_sg:
+	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
+out_err:
+	return -ENOMEM;
+}
 
-		/*
-		 * If no P2P memory was available we fallback to using
-		 * regular memory
-		 */
+static bool nvmet_req_find_p2p_dev(struct nvmet_req *req)
+{
+	if (!IS_ENABLED(CONFIG_PCI_P2PDMA))
+		return false;
+
+	if (req->sq->ctrl && req->sq->qid && req->ns) {
+		req->p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
+						 req->ns->nsid);
+		if (req->p2p_dev)
+			return true;
 	}
 
-	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
+	req->p2p_dev = NULL;
+	return false;
+}
+
+int nvmet_req_alloc_sgls(struct nvmet_req *req)
+{
+	if (nvmet_req_find_p2p_dev(req) && !nvmet_req_alloc_p2pmem_sgls(req))
+		return 0;
+
+	req->sg = sgl_alloc(nvmet_data_transfer_len(req), GFP_KERNEL,
+			    &req->sg_cnt);
 	if (unlikely(!req->sg))
-		return -ENOMEM;
+		goto out;
+
+	if (req->metadata_len) {
+		req->metadata_sg = sgl_alloc(req->metadata_len, GFP_KERNEL,
+					     &req->metadata_sg_cnt);
+		if (unlikely(!req->metadata_sg))
+			goto out_free;
+	}
 
 	return 0;
+out_free:
+	sgl_free(req->sg);
+out:
+	return -ENOMEM;
 }
-EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
+EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgls);
 
-void nvmet_req_free_sgl(struct nvmet_req *req)
+void nvmet_req_free_sgls(struct nvmet_req *req)
 {
-	if (req->p2p_dev)
+	if (req->p2p_dev) {
 		pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
-	else
+		if (req->metadata_sg)
+			pci_p2pmem_free_sgl(req->p2p_dev, req->metadata_sg);
+	} else {
 		sgl_free(req->sg);
+		if (req->metadata_sg)
+			sgl_free(req->metadata_sg);
+	}
 
 	req->sg = NULL;
+	req->metadata_sg = NULL;
 	req->sg_cnt = 0;
+	req->metadata_sg_cnt = 0;
 }
-EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
+EXPORT_SYMBOL_GPL(nvmet_req_free_sgls);
 
 static inline bool nvmet_cc_en(u32 cc)
 {
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 19b57f6..dab7950 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -169,6 +169,61 @@ static void nvmet_bio_done(struct bio *bio)
 		bio_put(bio);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
+				struct sg_mapping_iter *miter)
+{
+	struct blk_integrity *bi;
+	struct bio_integrity_payload *bip;
+	struct block_device *bdev = req->ns->bdev;
+	int rc;
+	size_t resid, len;
+
+	bi = bdev_get_integrity(bdev);
+	if (unlikely(!bi)) {
+		pr_err("Unable to locate bio_integrity\n");
+		return -ENODEV;
+	}
+
+	bip = bio_integrity_alloc(bio, GFP_NOIO,
+		min_t(unsigned int, req->metadata_sg_cnt, BIO_MAX_PAGES));
+	if (IS_ERR(bip)) {
+		pr_err("Unable to allocate bio_integrity_payload\n");
+		return PTR_ERR(bip);
+	}
+
+	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
+	/* virtual start sector must be in integrity interval units */
+	bip_set_seed(bip, bio->bi_iter.bi_sector >>
+		     (bi->interval_exp - SECTOR_SHIFT));
+
+	resid = bip->bip_iter.bi_size;
+	while (resid > 0 && sg_miter_next(miter)) {
+		len = min_t(size_t, miter->length, resid);
+		rc = bio_integrity_add_page(bio, miter->page, len,
+					    offset_in_page(miter->addr));
+		if (unlikely(rc != len)) {
+			pr_err("bio_integrity_add_page() failed; %d\n", rc);
+			sg_miter_stop(miter);
+			return -ENOMEM;
+		}
+
+		resid -= len;
+		if (len < miter->length)
+			miter->consumed -= miter->length - len;
+	}
+	sg_miter_stop(miter);
+
+	return 0;
+}
+#else
+static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
+				struct sg_mapping_iter *miter)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
@@ -176,9 +231,12 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct scatterlist *sg;
 	struct blk_plug plug;
 	sector_t sector;
-	int op, i;
+	int op, i, rc;
+	struct sg_mapping_iter prot_miter;
+	unsigned int iter_flags;
+	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req, total_len))
 		return;
 
 	if (!req->sg_cnt) {
@@ -190,8 +248,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			op |= REQ_FUA;
+		iter_flags = SG_MITER_TO_SG;
 	} else {
 		op = REQ_OP_READ;
+		iter_flags = SG_MITER_FROM_SG;
 	}
 
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
@@ -213,11 +273,24 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_opf = op;
 
 	blk_start_plug(&plug);
+	if (req->metadata_len)
+		sg_miter_start(&prot_miter, req->metadata_sg,
+			       req->metadata_sg_cnt, iter_flags);
+
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
 			struct bio *prev = bio;
 
+			if (req->metadata_len) {
+				rc = nvmet_bdev_alloc_bip(req, bio,
+							  &prot_miter);
+				if (unlikely(rc)) {
+					bio_io_error(bio);
+					return;
+				}
+			}
+
 			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 			bio_set_dev(bio, req->ns->bdev);
 			bio->bi_iter.bi_sector = sector;
@@ -231,6 +304,14 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sg_cnt--;
 	}
 
+	if (req->metadata_len) {
+		rc = nvmet_bdev_alloc_bip(req, bio, &prot_miter);
+		if (unlikely(rc)) {
+			bio_io_error(bio);
+			return;
+		}
+	}
+
 	submit_bio(bio);
 	blk_finish_plug(&plug);
 }
@@ -358,6 +439,8 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_bdev_execute_rw;
+		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns))
+			req->metadata_len = nvmet_rw_metadata_len(req);
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_bdev_execute_flush;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2986e2c..3f72a17 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -309,6 +309,7 @@ struct nvmet_req {
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
+	struct scatterlist	*metadata_sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
@@ -322,8 +323,10 @@ struct nvmet_req {
 		} f;
 	};
 	int			sg_cnt;
+	int			metadata_sg_cnt;
 	/* data length as parsed from the SGL descriptor: */
 	size_t			transfer_len;
+	size_t			metadata_len;
 
 	struct nvmet_port	*port;
 
@@ -394,8 +397,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len);
 bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
-int nvmet_req_alloc_sgl(struct nvmet_req *req);
-void nvmet_req_free_sgl(struct nvmet_req *req);
+int nvmet_req_alloc_sgls(struct nvmet_req *req);
+void nvmet_req_free_sgls(struct nvmet_req *req);
 
 void nvmet_execute_keep_alive(struct nvmet_req *req);
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 7a90b10..178dbff 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -546,7 +546,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 	}
 
 	if (rsp->req.sg != rsp->cmd->inline_sg)
-		nvmet_req_free_sgl(&rsp->req);
+		nvmet_req_free_sgls(&rsp->req);
 
 	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
 		nvmet_rdma_process_wr_wait_list(queue);
@@ -708,7 +708,7 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	if (!rsp->req.transfer_len)
 		return 0;
 
-	ret = nvmet_req_alloc_sgl(&rsp->req);
+	ret = nvmet_req_alloc_sgls(&rsp->req);
 	if (unlikely(ret < 0))
 		goto error_out;
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
