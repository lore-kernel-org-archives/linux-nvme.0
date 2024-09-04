Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAE1CD4847
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FoFa8fs5unVRZkkpd8ibwCjAksK3vDy7AK9R3Is1ank=; b=CqHncpek30J7SK0vPXD23hOZzf
	lmM2RTezXu08T4LOP7uIcBhZ1xYmRRt26aE79bxMIWIFlUoGaArvr+BB1UurGliRzQzHBrwBlkdtI
	agn03HOjBO3qgmmQbNdt+lTFBqp5AW4qEwQZ/wU8GI896+iguYTiH5Hhi+8xAdRMkXZz8DfvKbRe+
	te0/3qGI/pHS2g1Zrv+J2gKy97Vvto5p3u4TOmY+Sp5E9tNuvETKj86lHobZL8I6jhhWyJ0Y3c6PW
	6I5+stkZGBUmZLpGRiNNBAXreIWNYnGLFAHZpqtOmRET8cLxoBZp7Zysmor44EeWb3hH6NdMFGsB0
	zrCZG/HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutx-00000005db0-2hIp;
	Wed, 04 Sep 2024 18:38:45 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutp-00000005dU0-4AJL
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:41 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484F2nWX018588
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=FoFa8fs5unVRZkkpd8ibwCjAksK3vDy7AK9R3Is1ank=; b=
	Vr7AYBNRrvjZAX80A/YqLclz2C+iKxhK5Z8mXvqZPRqwzHiv7N79UtOsyJMXWmUY
	SDGBmPKuI1wkMFJyMqJKXI7nRth5sa6eQ0CIkHofDS4QIQ04BJIwMJP4JTRb+oxK
	BZRr7K8c8izPAxTrElQyaNMZVgq/yJJOzQ080c8abYIA/X6jd0iFE+RAxNur/ZtB
	a5NiFd4yS3ayOGOUhj8IexAbAqt1VQ1OpLrT6UV6DKRyAlO/fkmB1wQYHtNw10kD
	IkveZXVTHwKTMoIvXrQ0uvJRDPd/J2SMRcTq77v51Dii5vrOMydoUb3O6dZy+V8Z
	JwWLe/bkrSxg3Je1r1digg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41eejbmwuy-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:36 -0700 (PDT)
Received: from twshared1273.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:34 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D597612A1F0A3; Wed,  4 Sep 2024 11:38:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 8/9] nvme-pci: add support for sgl metadata
Date: Wed, 4 Sep 2024 11:38:16 -0700
Message-ID: <20240904183818.713941-9-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nxP2BCDX4EYSoCHKPkk__IsL2_P73vSy
X-Proofpoint-GUID: nxP2BCDX4EYSoCHKPkk__IsL2_P73vSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113838_217278_75BE0CF9 
X-CRM114-Status: GOOD (  22.48  )
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
be possible otherwise.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c |   4 +-
 drivers/nvme/host/nvme.h |   5 ++
 drivers/nvme/host/pci.c  | 129 ++++++++++++++++++++++++++++++++++-----
 include/linux/nvme.h     |   1 +
 4 files changed, 122 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 053d5b4909cda..6a8411ef45f26 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1988,7 +1988,9 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *=
ctrl,
 	lim->max_hw_sectors =3D ctrl->max_hw_sectors;
 	lim->max_segments =3D min_t(u32, USHRT_MAX,
 		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
-	lim->max_integrity_segments =3D ctrl->max_integrity_segments;
+	if (lim->max_integrity_segments > 1 &&
+	    !nvme_ctrl_meta_sgl_supported(ctrl))
+		lim->max_integrity_segments =3D 1;
 	lim->virt_boundary_mask =3D NVME_CTRL_PAGE_SIZE - 1;
 	lim->max_segment_size =3D UINT_MAX;
 	lim->dma_alignment =3D 3;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f900e44243aef..699cc36e596fa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1121,6 +1121,11 @@ static inline bool nvme_ctrl_sgl_supported(struct =
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
index db0144a6bc5db..a0a10451d7da8 100644
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
@@ -143,6 +144,7 @@ struct nvme_dev {
 	bool hmb;
=20
 	mempool_t *iod_mempool;
+	mempool_t *iod_meta_mempool;
=20
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
@@ -237,6 +239,8 @@ struct nvme_iod {
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
+	struct sg_table meta_sgt;
+	union nvme_descriptor meta_list;
 	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
 };
=20
@@ -516,6 +520,11 @@ static inline bool nvme_pci_sgl_capable(struct nvme_=
dev *dev,
 	return sgl_threshold;
 }
=20
+static inline bool nvme_pci_metadata_use_sgls(struct request *req)
+{
+	return blk_rq_integrity_segments(req) > 1;
+}
+
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
 				     int nseg)
 {
@@ -525,6 +534,8 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req,
=20
 	if (!nvme_pci_sgl_capable(dev, req))
 		return false;
+	if (nvme_pci_metadata_use_sgls(req))
+		return true;
 	return avg_seg_size >=3D sgl_threshold;
 }
=20
@@ -834,19 +845,81 @@ static blk_status_t nvme_map_data(struct nvme_dev *=
dev, struct request *req)
 	return __nvme_map_data(dev, req);
 }
=20
-static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct reque=
st *req,
-		struct nvme_command *cmnd)
+static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
+					     struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmnd =3D &iod->cmd.rw;
+	struct nvme_sgl_desc *sg_list;
+	struct scatterlist *sg;
+	unsigned int entries;
+	dma_addr_t sgl_dma;
+	int rc;
+
+	iod->meta_sgt.sgl =3D mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
+	if (!iod->meta_sgt.sgl)
+		return BLK_STS_RESOURCE;
+
+	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
+	iod->meta_sgt.orig_nents =3D blk_rq_map_integrity_sg(req->bio,
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
+	sg =3D iod->meta_sgt.sgl;
+	if (entries =3D=3D 1) {
+		nvme_pci_sgl_set_data(sg_list, sg);
+		return BLK_STS_OK;
+	}
+
+	sgl_dma +=3D sizeof(sizeof(*sg_list));
+	nvme_pci_sgl_set_list(&sg_list[1], sg_list, sg, entries, sgl_dma);
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
+{
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmnd =3D &iod->cmd.rw;
 	struct bio_vec bv =3D rq_integrity_vec(req);
=20
 	iod->meta_dma =3D dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
-	cmnd->rw.metadata =3D cpu_to_le64(iod->meta_dma);
+	cmnd->metadata =3D cpu_to_le64(iod->meta_dma);
 	return BLK_STS_OK;
 }
=20
+static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct reque=
st *req)
+{
+	if (nvme_pci_metadata_use_sgls(req))
+		return nvme_pci_setup_meta_sgls(dev, req);
+	return nvme_pci_setup_meta_mptr(dev, req);
+}
+
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *r=
eq)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
@@ -855,6 +928,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	iod->aborted =3D false;
 	iod->nr_allocations =3D -1;
 	iod->sgt.nents =3D 0;
+	iod->meta_sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -867,7 +941,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev=
, struct request *req)
 	}
=20
 	if (blk_integrity_rq(req)) {
-		ret =3D nvme_map_metadata(dev, req, &iod->cmd);
+		ret =3D nvme_map_metadata(dev, req);
 		if (ret)
 			goto out_unmap_data;
 	}
@@ -971,17 +1045,31 @@ static void nvme_queue_rqs(struct request **rqlist=
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
@@ -2718,6 +2806,7 @@ static void nvme_release_prp_pools(struct nvme_dev =
*dev)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
+	size_t meta_size =3D sizeof(struct scatterlist) * NVME_MAX_META_SEGS + =
1;
 	size_t alloc_size =3D sizeof(struct scatterlist) * NVME_MAX_SEGS;
=20
 	dev->iod_mempool =3D mempool_create_node(1,
@@ -2726,7 +2815,18 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_=
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
@@ -3046,12 +3146,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct =
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
@@ -3155,6 +3250,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->iod_mempool);
+	mempool_destroy(dev->iod_meta_mempool);
 out_release_prp_pools:
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
@@ -3220,6 +3316,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->iod_mempool);
+	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7b2ae2e435447..87ea1673c60b8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -388,6 +388,7 @@ enum {
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	=3D 1 << 5,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	=3D 1 << 7,
 	NVME_CTRL_CTRATT_UUID_LIST		=3D 1 << 9,
+	NVME_CTRL_SGLS_MPTR                     =3D 1 << 18,
 };
=20
 struct nvme_lbaf {
--=20
2.43.5


