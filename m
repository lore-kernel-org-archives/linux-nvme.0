Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319A7CA0EE0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bKwUXko3K1u5MXjDz1E8Sh1Z/eECwawVMdShz0+48V4=; b=XWgABm9+7tKpUDUFmiUSlx/jXA
	yiXu8KHTqdk2rrwbEnwka9DOGdDpnY54OwRHQVYOB8fICCdaajAuVZYDm/16DpZF+zM7WbWJvEDxS
	9FmE5zGrS+ak/LwsRGcbN5y3GjcMkpJnY3MuvLBG6EUrW5aZcbyhbgCzbk+uUTWe/ypjOIX/v4TM/
	4F85OsnCxURlow8I4A/Ua/rkQM3stiJ2gDRUz4iE354DzXstUjWP5oVjwo8PeeLlyQmfhkOletfzH
	j4CvLAmhKjZQyCetJSTjHTdl+NziBTuyInNy+jxeuCRqTPw0gkfNkA/uuiV3XiLS9t5bCAzX+4szt
	C4L1lc0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEOC-0000000EOxV-1kbV;
	Wed, 13 Aug 2025 16:31:48 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDVP-0000000ECot-35ix
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:35:12 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFBl0j020987
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:35:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bKwUXko3K1u5MXjDz1E8Sh1Z/eECwawVMdShz0+48V4=; b=oRyi2XBu7Qjl
	nLhhLSeYV0+wzhXgmciFEfPAwRv5xuIQUCan/mraMAYZpj7XWMZ9E+cq+McFDKr/
	zxtOZJPRAqbGOKJQUF+PdFk7/2Q+MSCGIpbnQgfAZQg1CMQY2DxxCnI/dXOb+oYA
	Z94WBXVMzTQQRF7ZtXg23EoBsSBgNd/nR2PTC3wjNqm/khZ3C/vyEK0B1y9VP54r
	i4FhN/+QbEanVa93L9H8gKRFG5wzbbU4VCm0wsrYYg5ykLEVxPKa+pTqV/EFyTIA
	sRy0VeRvXxHgf4DyCvUiDmsn+wik08grCmV0LE2ptDlCvhFJsh56vIEJyL8TOyA5
	hIi+g41djg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gt29hq71-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:35:11 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:35:10 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A20A197CD8C; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 9/9] nvme-pci: convert metadata mapping to dma iter
Date: Wed, 13 Aug 2025 08:31:53 -0700
Message-ID: <20250813153153.3260897-10-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SRQU6_OMQUkwIj3hzV6zrzTiq7psx6u4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfXzTDEHeqdjVei NAA/yiEU+Rfj29pORtSCMOkAyb8i2FIxWCnWtxQKGwrjD5tET333E/C3CoUfwD4eOb7Zl6O2zeq Kv74PEPukvFFvgNZjE0WYsMPDon3oH/lt8IPSMI55bzHObZhfjvSV2mUnUNj22e7+pNXaVVOGy+
 3Kd8p+Zbvvz7hHIL5/2RDzaMdkqWGysDKN38oymQvUHjRq3Z6Lly0ZoLj7xtdhiF0SYgHmF0tGr /VfODair/yUl7kNs7CHG8kXEK574e09onP9REn+903R+H3x5mDyjPznJ2RCCrvQJuKIokZkfBuZ 9yxtmTY56U/y1LGDqoO/DbrycLlHDl1uVWjNiBijU0epSarGdq+sSNoKxOUqcntyrQhT188XKG6
 fIoCikV15VHetDDROeeVy57gjqmpaibWY1SvXJvyvJVWRbarqubFANPVF+SNozLHxrN02EbH
X-Proofpoint-ORIG-GUID: SRQU6_OMQUkwIj3hzV6zrzTiq7psx6u4
X-Authority-Analysis: v=2.4 cv=Oe+YDgTY c=1 sm=1 tr=0 ts=689cb0af cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=b4pXc90ez-momG_VimUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083511_789961_746E7E7A 
X-CRM114-Status: GOOD (  22.05  )
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

Aligns data and metadata to the similar dma mapping scheme and removes
one more user of the scatter-gather dma mapping.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 163 +++++++++++++++++++++-------------------
 1 file changed, 87 insertions(+), 76 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e12d47fecc584..d8a9dee55de33 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -172,9 +172,7 @@ struct nvme_dev {
 	u32 last_ps;
 	bool hmb;
 	struct sg_table *hmb_sgt;
-
 	mempool_t *dmavec_mempool;
-	mempool_t *iod_meta_mempool;
=20
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
@@ -264,6 +262,12 @@ enum nvme_iod_flags {
=20
 	/* DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
 	IOD_P2P_BUS_ADDR	=3D 1U << 3,
+
+	/* Metadata DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
+	IOD_META_P2P_BUS_ADDR	=3D 1U << 4,
+
+	/* Metadata using non-coalesced MPTR */
+	IOD_SINGLE_META_SEGMENT	=3D 1U << 5,
 };
=20
 struct nvme_dma_vec {
@@ -287,7 +291,8 @@ struct nvme_iod {
 	unsigned int nr_dma_vecs;
=20
 	dma_addr_t meta_dma;
-	struct sg_table meta_sgt;
+	unsigned int meta_total_len;
+	struct dma_iova_state meta_dma_state;
 	struct nvme_sgl_desc *meta_descriptor;
 };
=20
@@ -644,6 +649,11 @@ static inline struct dma_pool *nvme_dma_pool(struct =
nvme_queue *nvmeq,
 	return nvmeq->descriptor_pools.large;
 }
=20
+static inline bool nvme_pci_cmd_use_meta_sgl(struct nvme_command *cmd)
+{
+	return (cmd->common.flags & NVME_CMD_SGL_ALL) =3D=3D NVME_CMD_SGL_METAS=
EG;
+}
+
 static inline bool nvme_pci_cmd_use_sgl(struct nvme_command *cmd)
 {
 	return cmd->common.flags &
@@ -712,6 +722,36 @@ static void nvme_free_sgls(struct request *req, stru=
ct nvme_sgl_desc *sge,
 			le32_to_cpu(sg_list[i].length), dir);
 }
=20
+static void nvme_unmap_metadata(struct request *req)
+{
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	enum dma_data_direction dir =3D rq_dma_dir(req);
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct device *dma_dev =3D nvmeq->dev->dev;
+	struct nvme_sgl_desc *sge =3D iod->meta_descriptor;
+
+	if (iod->flags & IOD_SINGLE_META_SEGMENT) {
+		dma_unmap_page(dma_dev, iod->meta_dma,
+			       rq_integrity_vec(req).bv_len,
+			       rq_dma_dir(req));
+		return;
+	}
+
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
+				iod->meta_total_len,
+				iod->flags & IOD_META_P2P_BUS_ADDR)) {
+		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
+			nvme_free_sgls(req, sge, &sge[1]);
+		else
+			dma_unmap_page(dma_dev, iod->meta_dma,
+				       iod->meta_total_len, dir);
+	}
+
+	if (iod->meta_descriptor)
+		dma_pool_free(nvmeq->descriptor_pools.small,
+			      iod->meta_descriptor, iod->meta_dma);
+}
+
 static void nvme_unmap_data(struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
@@ -1013,70 +1053,72 @@ static blk_status_t nvme_map_data(struct request =
*req)
 	return nvme_pci_setup_data_prp(req, &iter);
 }
=20
-static void nvme_pci_sgl_set_data_sg(struct nvme_sgl_desc *sge,
-		struct scatterlist *sg)
-{
-	sge->addr =3D cpu_to_le64(sg_dma_address(sg));
-	sge->length =3D cpu_to_le32(sg_dma_len(sg));
-	sge->type =3D NVME_SGL_FMT_DATA_DESC << 4;
-}
-
 static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 {
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
+	unsigned int entries =3D req->nr_integrity_segments;
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev =3D nvmeq->dev;
 	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sgl, *sg;
-	unsigned int entries;
+	struct blk_dma_iter iter;
 	dma_addr_t sgl_dma;
-	int rc, i;
+	int i =3D 0;
=20
-	iod->meta_sgt.sgl =3D mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
-	if (!iod->meta_sgt.sgl)
-		return BLK_STS_RESOURCE;
+	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
+						&iod->meta_dma_state, &iter))
+		return iter.status;
=20
-	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
-	iod->meta_sgt.orig_nents =3D blk_rq_map_integrity_sg(req,
-							   iod->meta_sgt.sgl);
-	if (!iod->meta_sgt.orig_nents)
-		goto out_free_sg;
+	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		iod->flags |=3D IOD_META_P2P_BUS_ADDR;
+	else if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
+		entries =3D 1;
=20
-	rc =3D dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc)
-		goto out_free_sg;
+	/*
+	 * The NVMe MPTR descriptor has an implicit length that the host and
+	 * device must agree on to avoid data/memory corruption. We trust the
+	 * kernel allocated correctly based on the format's parameters, so use
+	 * the more efficient MPTR to avoid extra dma pool allocations for the
+	 * SGL indirection.
+	 *
+	 * But for user commands, we don't necessarily know what they do, so
+	 * the driver can't validate the metadata buffer size. The SGL
+	 * descriptor provides an explicit length, so we're relying on that
+	 * mechanism to catch any misunderstandings between the application and
+	 * device.
+	 */
+	if (entries =3D=3D 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD)) {
+		iod->cmd.common.metadata =3D cpu_to_le64(iter.addr);
+		iod->meta_total_len =3D iter.len;
+		iod->meta_dma =3D iter.addr;
+		iod->meta_descriptor =3D NULL;
+		return BLK_STS_OK;
+	}
=20
 	sg_list =3D dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATOMIC,
 			&sgl_dma);
 	if (!sg_list)
-		goto out_unmap_sg;
+		return BLK_STS_RESOURCE;
=20
-	entries =3D iod->meta_sgt.nents;
 	iod->meta_descriptor =3D sg_list;
 	iod->meta_dma =3D sgl_dma;
-
 	iod->cmd.common.flags =3D NVME_CMD_SGL_METASEG;
 	iod->cmd.common.metadata =3D cpu_to_le64(sgl_dma);
-
-	sgl =3D iod->meta_sgt.sgl;
 	if (entries =3D=3D 1) {
-		nvme_pci_sgl_set_data_sg(sg_list, sgl);
+		iod->meta_total_len =3D iter.len;
+		nvme_pci_sgl_set_data(sg_list, &iter);
 		return BLK_STS_OK;
 	}
=20
 	sgl_dma +=3D sizeof(*sg_list);
-	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
-	for_each_sg(sgl, sg, entries, i)
-		nvme_pci_sgl_set_data_sg(&sg_list[i + 1], sg);
-
-	return BLK_STS_OK;
+	do {
+		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		iod->meta_total_len +=3D iter.len;
+	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
=20
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-	return BLK_STS_RESOURCE;
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);
+	if (unlikely(iter.status))
+		nvme_unmap_metadata(req);
+	return iter.status;
 }
=20
 static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
@@ -1089,6 +1131,7 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct=
 request *req)
 	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
+	iod->flags |=3D IOD_SINGLE_META_SEGMENT;
 	return BLK_STS_OK;
 }
=20
@@ -1110,7 +1153,7 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->flags =3D 0;
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
-	iod->meta_sgt.nents =3D 0;
+	iod->meta_total_len =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -1221,25 +1264,6 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 	*rqlist =3D requeue_list;
 }
=20
-static __always_inline void nvme_unmap_metadata(struct request *req)
-{
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
-
-	if (!iod->meta_sgt.nents) {
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len,
-			       rq_dma_dir(req));
-		return;
-	}
-
-	dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor,
-			iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-}
-
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	if (blk_integrity_rq(req))
@@ -3045,7 +3069,6 @@ static int nvme_disable_prepare_reset(struct nvme_d=
ev *dev, bool shutdown)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
-	size_t meta_size =3D sizeof(struct scatterlist) * (NVME_MAX_META_SEGS +=
 1);
 	size_t alloc_size =3D sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
=20
 	dev->dmavec_mempool =3D mempool_create_node(1,
@@ -3054,17 +3077,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_=
dev *dev)
 			dev_to_node(dev->dev));
 	if (!dev->dmavec_mempool)
 		return -ENOMEM;
-
-	dev->iod_meta_mempool =3D mempool_create_node(1,
-			mempool_kmalloc, mempool_kfree,
-			(void *)meta_size, GFP_KERNEL,
-			dev_to_node(dev->dev));
-	if (!dev->iod_meta_mempool)
-		goto free;
 	return 0;
-free:
-	mempool_destroy(dev->dmavec_mempool);
-	return -ENOMEM;
 }
=20
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -3514,7 +3527,6 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
@@ -3578,7 +3590,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
--=20
2.47.3


