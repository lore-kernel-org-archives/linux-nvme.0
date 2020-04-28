Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1941BC83000
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4B8206A1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pysmMMNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4B8206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aK+8C2HlIvBKRGy4sC6qRf1b4YqkPg46cpIuZGea1TY=; b=pysmMMNfGu3rk8
	Tl49WyJVgZ1oWBW/8yohaoBakT7EngRJ3bB9ilBT6oBwa0Y3YH7BQcpVI5IY5XpLkU+eRqLkLl+7x
	fJdRcpGSe4aFNZQcPyix+g3LlP83aWvpmYxVXg/+cTgXWqDVoDjdklxevJCQVSBAWMu0geCQvhxj/
	cQX+Iir+az1nIlhFBuyori0e7c99RRleqXwvPU77idLFG+gWSV9IjWewOM5H8AV1flGR/wImzAEsA
	BoZ0coBBqt10jCrYiOBwNothbGTmO6IZwWG2eK4qcBtl/Ix7aWM3YnCVlE3EOlTnMeUS4CveyLVqh
	UE2yMr5E57DAYg5W/bnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTQ2P-00041Q-CS; Tue, 28 Apr 2020 13:12:37 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTQ1X-0003HY-SJ
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 13:11:48 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 28 Apr 2020 16:11:38 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03SDBZZ9028635;
 Tue, 28 Apr 2020 16:11:38 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 14/15] nvmet: add metadata support for block devices
Date: Tue, 28 Apr 2020 16:11:34 +0300
Message-Id: <20200428131135.211521-15-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200428131135.211521-1-maxg@mellanox.com>
References: <20200428131135.211521-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_061144_338621_BF19CD6F 
X-CRM114-Status: GOOD (  14.05  )
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
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
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
 drivers/nvme/target/core.c        | 90 +++++++++++++++++++++++++++++++--------
 drivers/nvme/target/io-cmd-bdev.c | 85 +++++++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h       |  3 ++
 3 files changed, 159 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a57ab0c..c1456ce 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -884,8 +884,11 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sq = sq;
 	req->ops = ops;
 	req->sg = NULL;
+	req->md_sg = NULL;
 	req->sg_cnt = 0;
+	req->md_sg_cnt = 0;
 	req->transfer_len = 0;
+	req->md_len = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
@@ -970,9 +973,67 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 	return true;
 }
 
+void nvmet_req_free_p2pmem_sgls(struct nvmet_req *req)
+{
+	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
+	if (req->md_sg)
+		pci_p2pmem_free_sgl(req->p2p_dev, req->md_sg);
+}
+
+static int nvmet_req_alloc_p2pmem_sgls(struct nvmet_req *req, int data_len,
+		struct pci_dev *p2p_dev)
+{
+	req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt, data_len);
+	if (!req->sg)
+		goto out_err;
+
+	if (req->md_len) {
+		req->md_sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->md_sg_cnt,
+						  req->md_len);
+		if (!req->md_sg)
+			goto out_free_sg;
+	}
+	req->p2p_dev = p2p_dev;
+	return 0;
+
+out_free_sg:
+	pci_p2pmem_free_sgl(p2p_dev, req->sg);
+out_err:
+	return -ENOMEM;
+}
+
+void nvmet_req_free_mem_sgls(struct nvmet_req *req)
+{
+	sgl_free(req->sg);
+	if (req->md_sg)
+		sgl_free(req->md_sg);
+}
+
+static int nvmet_req_alloc_mem_sgls(struct nvmet_req *req, int data_len)
+{
+	req->sg = sgl_alloc(data_len, GFP_KERNEL, &req->sg_cnt);
+	if (unlikely(!req->sg))
+		goto out;
+
+	if (req->md_len) {
+		req->md_sg = sgl_alloc(req->md_len, GFP_KERNEL,
+				       &req->md_sg_cnt);
+		if (unlikely(!req->md_sg))
+			goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	sgl_free(req->sg);
+out:
+	return -ENOMEM;
+}
+
 int nvmet_req_alloc_sgl(struct nvmet_req *req)
 {
 	struct pci_dev *p2p_dev = NULL;
+	int data_len = req->transfer_len - req->md_len;
 
 	if (IS_ENABLED(CONFIG_PCI_P2PDMA)) {
 		if (req->sq->ctrl && req->ns)
@@ -981,37 +1042,32 @@ int nvmet_req_alloc_sgl(struct nvmet_req *req)
 
 		req->p2p_dev = NULL;
 		if (req->sq->qid && p2p_dev) {
-			req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt,
-						       req->transfer_len);
-			if (req->sg) {
-				req->p2p_dev = p2p_dev;
+			int ret = nvmet_req_alloc_p2pmem_sgls(req, data_len,
+							      p2p_dev);
+			if (!ret)
 				return 0;
-			}
 		}
-
-		/*
-		 * If no P2P memory was available we fallback to using
-		 * regular memory
-		 */
 	}
 
-	req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
-	if (unlikely(!req->sg))
-		return -ENOMEM;
-
-	return 0;
+	/*
+	 * If no P2P memory was available/enabled we fallback to using regular
+	 * memory.
+	 */
+	return nvmet_req_alloc_mem_sgls(req, data_len);
 }
 EXPORT_SYMBOL_GPL(nvmet_req_alloc_sgl);
 
 void nvmet_req_free_sgl(struct nvmet_req *req)
 {
 	if (req->p2p_dev)
-		pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
+		nvmet_req_free_p2pmem_sgls(req);
 	else
-		sgl_free(req->sg);
+		nvmet_req_free_mem_sgls(req);
 
 	req->sg = NULL;
+	req->md_sg = NULL;
 	req->sg_cnt = 0;
+	req->md_sg_cnt = 0;
 }
 EXPORT_SYMBOL_GPL(nvmet_req_free_sgl);
 
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index d265cf5..4243156 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -174,6 +174,61 @@ static void nvmet_bio_done(struct bio *bio)
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
+			min_t(unsigned int, req->md_sg_cnt, BIO_MAX_PAGES));
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
@@ -181,9 +236,11 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct scatterlist *sg;
 	struct blk_plug plug;
 	sector_t sector;
-	int op, i;
+	int op, i, rc;
+	struct sg_mapping_iter prot_miter;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_check_transfer_len(req,
+				      nvmet_rw_data_len(req) + req->md_len))
 		return;
 
 	if (!req->sg_cnt) {
@@ -218,11 +275,25 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_opf = op;
 
 	blk_start_plug(&plug);
+	if (req->md_len)
+		sg_miter_start(&prot_miter, req->md_sg, req->md_sg_cnt,
+			       op == REQ_OP_READ ? SG_MITER_FROM_SG :
+						   SG_MITER_TO_SG);
+
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
 			struct bio *prev = bio;
 
+			if (req->md_len) {
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
@@ -236,6 +307,14 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sg_cnt--;
 	}
 
+	if (req->md_len) {
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
@@ -363,6 +442,8 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_bdev_execute_rw;
+		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns))
+			req->md_len = nvmet_rw_md_len(req);
 		return 0;
 	case nvme_cmd_flush:
 		req->execute = nvmet_bdev_execute_flush;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ccdf820..7069520 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -309,6 +309,7 @@ struct nvmet_req {
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
 	struct scatterlist	*sg;
+	struct scatterlist	*md_sg;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
 	union {
 		struct {
@@ -322,8 +323,10 @@ struct nvmet_req {
 		} f;
 	};
 	int			sg_cnt;
+	int			md_sg_cnt;
 	/* data length as parsed from the SGL descriptor: */
 	size_t			transfer_len;
+	size_t			md_len;
 
 	struct nvmet_port	*port;
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
