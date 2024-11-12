Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47638D597A7
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 21:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uW3IkRCRr4KUtmnwksvJLXQsm9NAGZEYJ7EjQe0h+5o=; b=s90qdYtd9V3n9hNFOcnXTxb03v
	OROnnRD7yt2W0D2m2cORyWkE2b6szCQlEOKTUNlZlaJ+CXI6LJQ5h0zMQi2FMB1y5mz11D+o3xhHT
	IUtzaT2pS/H4JQ7FSvxQYwalS8tar7mKxVnuIA8QnWv/DN1a8FdCbIsgzR+76g6o3k1aJlCtixqSs
	rixvnwyYJKFNAtCHAn5Bdk7+46BIE99+507rWOjvrabLVSD7ZiylKpEMKOqMPTRC2R5lU5KAABpoI
	R1SM4mPKO+IvgrxlnbToWktFTAIsImggbOA4EOgo0l6FHCZOAS1ax7qOpnc6XwFErmgQq9jHe6dOH
	oPEcegBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAy7t-00000004xdA-0V9b;
	Tue, 12 Nov 2024 21:08:41 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAy5m-00000004xOF-12XQ
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 21:06:31 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJ5KiX016779
	for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2024 13:06:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=uW3IkRCRr4KUtmnwksvJLXQsm9NAGZEYJ7EjQe0h+5o=; b=B6tKRluSW20p
	CdM1bpOm9JkKf7PS+AQvZBW52ck3bDlH3CzbRRcxJXMNabYkrSulmxLerX53pb6b
	we9BHzGI42axsQBzsjszuzF8z7P9Cl/xieGpmCoqJ1sNg0tEuT7pLhvAIUFhUrtW
	4I/Ehc/VSME+7/RoCnx8Pce/eki/pNuurKtynmU40hsIlQWRTycQAFl1cG9adZ4R
	chNKOTTs/hB4UOI1JTaVd5NbyL70cguCxl0G66tb22M69bo23yFwjQV/SIEWZByA
	YlChTZ025TmqvhbYy1lTzoLkLyjT3qxCSXbELuHV23zk7CWDjG+HM2rCwJ3xE4IS
	30rxORRM6w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42v5ar4u7r-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2024 13:06:29 -0800 (PST)
Received: from twshared1117.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 12 Nov 2024 21:06:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 088291502A721; Tue, 12 Nov 2024 13:06:20 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] nvme-pci: add support for sgl metadata
Date: Tue, 12 Nov 2024 13:06:19 -0800
Message-ID: <20241112210620.2650523-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112210620.2650523-1-kbusch@meta.com>
References: <20241112210620.2650523-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4cAmUHhYqBmFS-zEUgGyKLOugsC6d7qa
X-Proofpoint-GUID: 4cAmUHhYqBmFS-zEUgGyKLOugsC6d7qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_130630_440486_528A54DD 
X-CRM114-Status: GOOD (  20.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

Supporting this mode allows merging requests with metadata that wouldn't
be possible otherwise, and creating user space requests that straddle
physically discontiguous pages.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c |   3 +
 drivers/nvme/host/nvme.h |   5 ++
 drivers/nvme/host/pci.c  | 136 ++++++++++++++++++++++++++++++++++-----
 include/linux/nvme.h     |   1 +
 4 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e119ba0f8ab8b..12e5064b9cba0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1985,6 +1985,9 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *=
ctrl,
 	lim->max_segments =3D min_t(u32, USHRT_MAX,
 		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
 	lim->max_integrity_segments =3D ctrl->max_integrity_segments;
+	if (lim->max_integrity_segments > 1 &&
+	    !nvme_ctrl_meta_sgl_supported(ctrl))
+		lim->max_integrity_segments =3D 1;
 	lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
 	lim->max_segment_size =3D UINT_MAX;
 	lim->dma_alignment =3D 3;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 900719c4c70c1..1709fbd30c6dc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1126,6 +1126,11 @@ static inline bool nvme_ctrl_sgl_supported(struct =
nvme_ctrl *ctrl)
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
 }
=20
+static inline bool nvme_ctrl_meta_sgl_supported(struct nvme_ctrl *ctrl)
+{
+	return ctrl->sgls & NVME_CTRL_SGLS_MPTR;
+}
+
 #ifdef CONFIG_NVME_HOST_AUTH
 int __init nvme_init_auth(void);
 void __exit nvme_exit_auth(void);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0aa26a33f2315..919f173043d18 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -43,6 +43,7 @@
  */
 #define NVME_MAX_KB_SZ	8192
 #define NVME_MAX_SEGS	128
+#define NVME_MAX_META_SEGS 15
 #define NVME_MAX_NR_ALLOCATIONS	5
=20
 static int use_threaded_interrupts;
@@ -144,6 +145,7 @@ struct nvme_dev {
 	struct sg_table *hmb_sgt;
=20
 	mempool_t *iod_mempool;
+	mempool_t *iod_meta_mempool;
=20
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
@@ -239,6 +241,8 @@ struct nvme_iod {
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
+	struct sg_table meta_sgt;
+	union nvme_descriptor meta_list;
 	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
 };
=20
@@ -506,6 +510,14 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hc=
tx)
 	spin_unlock(&nvmeq->sq_lock);
 }
=20
+static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
+					      struct request *req)
+{
+	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
+		return false;
+	return req->nr_integrity_segments > 1;
+}
+
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
 				     int nseg)
 {
@@ -518,6 +530,8 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req,
 		return false;
 	if (!nvmeq->qid)
 		return false;
+	if (nvme_pci_metadata_use_sgls(dev, req))
+		return true;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return false;
 	return true;
@@ -780,7 +794,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 		struct bio_vec bv =3D req_bvec(req);
=20
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			if (!nvme_pci_metadata_use_sgls(dev, req) &&
+			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
 			     bv.bv_len <=3D NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
@@ -824,11 +839,69 @@ static blk_status_t nvme_map_data(struct nvme_dev *=
dev, struct request *req,
 	return ret;
 }
=20
-static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct reque=
st *req,
-		struct nvme_command *cmnd)
+static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
+					     struct request *req)
+{
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmnd =3D &iod->cmd.rw;
+	struct nvme_sgl_desc *sg_list;
+	struct scatterlist *sgl, *sg;
+	unsigned int entries;
+	dma_addr_t sgl_dma;
+	int rc, i;
+
+	iod->meta_sgt.sgl =3D mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
+	if (!iod->meta_sgt.sgl)
+		return BLK_STS_RESOURCE;
+
+	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
+	iod->meta_sgt.orig_nents =3D blk_rq_map_integrity_sg(req,
+							   iod->meta_sgt.sgl);
+	if (!iod->meta_sgt.orig_nents)
+		goto out_free_sg;
+
+	rc =3D dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
+			     DMA_ATTR_NO_WARN);
+	if (rc)
+		goto out_free_sg;
+
+	sg_list =3D dma_pool_alloc(dev->prp_small_pool, GFP_ATOMIC, &sgl_dma);
+	if (!sg_list)
+		goto out_unmap_sg;
+
+	entries =3D iod->meta_sgt.nents;
+	iod->meta_list.sg_list =3D sg_list;
+	iod->meta_dma =3D sgl_dma;
+
+	cmnd->flags =3D NVME_CMD_SGL_METASEG;
+	cmnd->metadata =3D cpu_to_le64(sgl_dma);
+
+	sgl =3D iod->meta_sgt.sgl;
+	if (entries =3D=3D 1) {
+		nvme_pci_sgl_set_data(sg_list, sgl);
+		return BLK_STS_OK;
+	}
+
+	sgl_dma +=3D sizeof(sizeof(*sg_list));
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
+	for_each_sg(sgl, sg, entries, i)
+		nvme_pci_sgl_set_data(&sg_list[i + 1], sg);
+
+	return BLK_STS_OK;
+
+out_unmap_sg:
+	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
+out_free_sg:
+	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
+	return BLK_STS_RESOURCE;
+}
+
+static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_dev *dev,
+					     struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct bio_vec bv =3D rq_integrity_vec(req);
+	struct nvme_command *cmnd =3D &iod->cmd;
=20
 	iod->meta_dma =3D dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
@@ -837,6 +910,13 @@ static blk_status_t nvme_map_metadata(struct nvme_de=
v *dev, struct request *req,
 	return BLK_STS_OK;
 }
=20
+static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct reque=
st *req)
+{
+	if (nvme_pci_metadata_use_sgls(dev, req))
+		return nvme_pci_setup_meta_sgls(dev, req);
+	return nvme_pci_setup_meta_mptr(dev, req);
+}
+
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *r=
eq)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
@@ -845,6 +925,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	iod->aborted =3D false;
 	iod->nr_allocations =3D -1;
 	iod->sgt.nents =3D 0;
+	iod->meta_sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -857,7 +938,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	}
=20
 	if (blk_integrity_rq(req)) {
-		ret =3D nvme_map_metadata(dev, req, &iod->cmd);
+		ret =3D nvme_map_metadata(dev, req);
 		if (ret)
 			goto out_unmap_data;
 	}
@@ -961,17 +1042,31 @@ static void nvme_queue_rqs(struct request **rqlist=
)
 	*rqlist =3D requeue_list;
 }
=20
+static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
+						struct request *req)
+{
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+
+	if (!iod->meta_sgt.nents) {
+		dma_unmap_page(dev->dev, iod->meta_dma,
+			       rq_integrity_vec(req).bv_len,
+			       rq_dma_dir(req));
+		return;
+	}
+
+	dma_pool_free(dev->prp_small_pool, iod->meta_list.sg_list,
+		      iod->meta_dma);
+	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
+	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	struct nvme_dev *dev =3D nvmeq->dev;
=20
-	if (blk_integrity_rq(req)) {
-	        struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len, rq_dma_dir(req));
-	}
+	if (blk_integrity_rq(req))
+		nvme_unmap_metadata(dev, req);
=20
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
@@ -2767,6 +2862,7 @@ static void nvme_release_prp_pools(struct nvme_dev =
*dev)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
+	size_t meta_size =3D sizeof(struct scatterlist) * (NVME_MAX_META_SEGS +=
 1);
 	size_t alloc_size =3D sizeof(struct scatterlist) * NVME_MAX_SEGS;
=20
 	dev->iod_mempool =3D mempool_create_node(1,
@@ -2775,7 +2871,18 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_=
dev *dev)
 			dev_to_node(dev->dev));
 	if (!dev->iod_mempool)
 		return -ENOMEM;
+
+	dev->iod_meta_mempool =3D mempool_create_node(1,
+			mempool_kmalloc, mempool_kfree,
+			(void *)meta_size, GFP_KERNEL,
+			dev_to_node(dev->dev));
+	if (!dev->iod_meta_mempool)
+		goto free;
+
 	return 0;
+free:
+	mempool_destroy(dev->iod_mempool);
+	return -ENOMEM;
 }
=20
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -3107,12 +3214,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct =
pci_dev *pdev,
 	dev->ctrl.max_hw_sectors =3D min_t(u32,
 		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments =3D NVME_MAX_SEGS;
-
-	/*
-	 * There is no support for SGLs for metadata (yet), so we are limited t=
o
-	 * a single integrity segment for the separate metadata pointer.
-	 */
-	dev->ctrl.max_integrity_segments =3D 1;
+	dev->ctrl.max_integrity_segments =3D NVME_MAX_META_SEGS;
 	return dev;
=20
 out_put_device:
@@ -3216,6 +3318,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->iod_mempool);
+	mempool_destroy(dev->iod_meta_mempool);
 out_release_prp_pools:
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
@@ -3281,6 +3384,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->iod_mempool);
+	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0a6e22038ce36..44d7f9e21527c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -389,6 +389,7 @@ enum {
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	=3D 1 << 5,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	=3D 1 << 7,
 	NVME_CTRL_CTRATT_UUID_LIST		=3D 1 << 9,
+	NVME_CTRL_SGLS_MPTR                     =3D 1 << 19,
 };
=20
 struct nvme_lbaf {
--=20
2.43.5


