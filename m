Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D21C83F22
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1shkp6UCLOwL2RFUBjtzlk1c80X6CyZZgu5IGWDOIQ=; b=3BFNbylp87keZUuzVIHdTAJpM6
	X7bz8mn2KKW6pW3COIUKvtRgtwA+CDdEOkXY+UAiQ6SFr40uvqZWC6YQkI9XocflyQdU5d2mk8J2a
	m79seUglqNYlUdt/jkQYMZmwNA5dmqB5+RPLUexlACsout6pzeUTupGUEUeno5PZgeORY5kOa0YzI
	yZNflVdPxfuRIA5s0uRmV1oITkw3D3CjLcrFi33e1XaECaHMKWk3km2AecxNlDXhP7pb5EvuZNBYZ
	rSuLjRtqwPzInzN+1JQGARlQw2wU88zRekTvY3koVr/DUcO8qqGbJToRu0iLsblhGp6DdpJVVbsV/
	fN1XMeSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3V-0000000Fc8J-1BgK;
	Sun, 20 Jul 2025 18:46:37 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ19-0000000Fbs9-2aSs
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:12 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 56K90DGA022250
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=f1shkp6UCLOwL2RFUBjtzlk1c80X6CyZZgu5IGWDOIQ=; b=VdDa3yG9M+Lk
	u40C0wbpZo/2zlJIjRwE0Xcew99t05Gj+31DHkiEWolM1BJGpQvFNAmLQqptum3e
	eP6DL3ohbJfHq9oFaceJzSLhTB3UN+TNuFiIoAOjhrTL/8s6MP1O2PSdWydOMX0y
	iCyEj8bTkJD+Qzy6Jq7inGOnRjd66ykDjWi8oh5s8PahAOcxITItBncOE0EWbKXl
	3gtt92NR6KVgWk98KZxlPZnzvxWsyT7QjerEJxnHlgxhdN2xyV9p8JajMrhff3Si
	N2yHg//xfFrPW4qf1PhDg2PF9oIAegZhJ9cTESH9BQNkPqTFefvRpdraGEwthkiX
	nEQNGQlp9Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4806vk5u5m-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:10 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:44:00 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 64E66178C79C; Sun, 20 Jul 2025 11:40:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 7/7] nvme: convert metadata mapping to dma iter
Date: Sun, 20 Jul 2025 11:40:40 -0700
Message-ID: <20250720184040.2402790-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720184040.2402790-1-kbusch@meta.com>
References: <20250720184040.2402790-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=demA3WXe c=1 sm=1 tr=0 ts=687d38fa cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=-iySqVERyTxLP5fm-OMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX1YG5zdNliUAO y6MTdj13z92rRoyPXXp5wTyodE529jCctfVP2QR7a9NNQOyltfnpbDBw0n3TS+Po3EQTvJgOzk5 N4SixeHXFYBg0owkJGvClI7pSZqgzzgM4cVCJHkYpw9oSZ6iyU+JxPql/OcdmXayVWQLurhKV4d
 u5qQTweqlZvQq2xU+vf8Iev4X0M9lNhQTE4dCDaw9zZfKGHWwG1mRmgdWi83OirKsVSYPy2I85y TfylkNPoEBfwSmz4cQ6q5bQeBDs2Ic7cSPu7zYsnqDhileJ2ivQJYdLPt4GerHWHcPhiDDwweqs DyOoMJQu4mgHdH6dbqnvP45QjTCoVynTCUVafl2YlJrEfvYtWl9Lj6t1UJ/ryh7MLZyaGn+sKty
 U7SeP21lNwYKzkQsTgSDD8vMQIe9pl5RsTYinnM6+4AiIiz2xKPVVk9xQ0Np4ghOB7teus8X
X-Proofpoint-ORIG-GUID: L2DgjqLC1lgxHtPa_Kf82J4atyF3fElu
X-Proofpoint-GUID: L2DgjqLC1lgxHtPa_Kf82J4atyF3fElu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114411_778417_C99587A7 
X-CRM114-Status: GOOD (  17.44  )
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
---
 drivers/nvme/host/pci.c | 126 ++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 64 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cefa8344f670..248093976a04e 100644
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
@@ -264,6 +262,9 @@ enum nvme_iod_flags {
=20
 	/* DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
 	IOD_P2P_BUS_ADDR	=3D 1U << 3,
+
+	/* Metadata DMA mapped with PCI_P2PDMA_MAP_BUS_ADDR */
+	IOD_META_P2P_BUS_ADDR	=3D 1U << 4,
 };
=20
 struct nvme_dma_vec {
@@ -279,15 +280,17 @@ struct nvme_iod {
 	struct nvme_command cmd;
 	u8 flags;
 	u8 nr_descriptors;
+	u8 nr_meta_descriptors;
=20
 	unsigned int total_len;
+	unsigned int meta_total_len;
 	struct dma_iova_state dma_state;
+	struct dma_iova_state meta_dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 	struct nvme_dma_vec *dma_vecs;
 	unsigned int nr_dma_vecs;
=20
 	dma_addr_t meta_dma;
-	struct sg_table meta_sgt;
 	struct nvme_sgl_desc *meta_descriptor;
 };
=20
@@ -644,6 +647,11 @@ static inline struct dma_pool *nvme_dma_pool(struct =
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
@@ -1014,70 +1022,53 @@ static blk_status_t nvme_map_data(struct request =
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
-
-	iod->meta_sgt.sgl =3D mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
-	if (!iod->meta_sgt.sgl)
-		return BLK_STS_RESOURCE;
+	int i =3D 0;
=20
-	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
-	iod->meta_sgt.orig_nents =3D blk_rq_map_integrity_sg(req,
-							   iod->meta_sgt.sgl);
-	if (!iod->meta_sgt.orig_nents)
-		goto out_free_sg;
+	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
+						&iod->meta_dma_state, &iter))
+		return iter.status;
=20
-	rc =3D dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc)
-		goto out_free_sg;
+	if (iter.p2pdma.map =3D=3D PCI_P2PDMA_MAP_BUS_ADDR)
+		iod->flags |=3D IOD_META_P2P_BUS_ADDR;
+	else if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
+		entries =3D 1;
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
=20
 	iod->cmd.common.flags =3D NVME_CMD_SGL_METASEG;
 	iod->cmd.common.metadata =3D cpu_to_le64(sgl_dma);
=20
-	sgl =3D iod->meta_sgt.sgl;
 	if (entries =3D=3D 1) {
-		nvme_pci_sgl_set_data_sg(sg_list, sgl);
+		iod->meta_total_len =3D iter.len;
+		nvme_pci_sgl_set_data(sg_list, &iter);
+		iod->nr_meta_descriptors =3D 0;
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
+	iod->nr_meta_descriptors =3D i;
+	return iter.status;
 }
=20
 static blk_status_t nvme_pci_setup_meta_mptr(struct request *req)
@@ -1090,6 +1081,7 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct=
 request *req)
 	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
+	iod->nr_meta_descriptors =3D 0;
 	return BLK_STS_OK;
 }
=20
@@ -1111,7 +1103,6 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->flags =3D 0;
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
-	iod->meta_sgt.nents =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -1222,23 +1213,43 @@ static void nvme_queue_rqs(struct rq_list *rqlist=
)
 	*rqlist =3D requeue_list;
 }
=20
+static void nvme_free_meta_sgls(struct nvme_iod *iod, struct device *dma=
_dev,
+				enum dma_data_direction dir)
+{
+	struct nvme_sgl_desc *sg_list =3D iod->meta_descriptor;
+	int i;
+
+	if (!iod->nr_meta_descriptors) {
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list->addr),
+				le32_to_cpu(sg_list->length), dir);
+		return;
+	}
+
+	for (i =3D 1; i <=3D iod->nr_meta_descriptors; i++)
+		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
+				le32_to_cpu(sg_list[i].length), dir);
+}
+
 static __always_inline void nvme_unmap_metadata(struct request *req)
 {
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
-	struct nvme_dev *dev =3D nvmeq->dev;
+	enum dma_data_direction dir =3D rq_dma_dir(req);
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct device *dma_dev =3D nvmeq->dev->dev;
=20
-	if (!iod->meta_sgt.nents) {
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len,
-			       rq_dma_dir(req));
+	if (!nvme_pci_cmd_use_meta_sgl(&iod->cmd)) {
+		dma_unmap_page(dma_dev, iod->meta_dma,
+			       rq_integrity_vec(req).bv_len, dir);
 		return;
 	}
=20
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
+				iod->meta_total_len,
+				iod->flags & IOD_META_P2P_BUS_ADDR))
+		nvme_free_meta_sgls(iod, dma_dev, dir);
+
 	dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor,
 			iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
 }
=20
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
@@ -3046,7 +3057,6 @@ static int nvme_disable_prepare_reset(struct nvme_d=
ev *dev, bool shutdown)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
-	size_t meta_size =3D sizeof(struct scatterlist) * (NVME_MAX_META_SEGS +=
 1);
 	size_t alloc_size =3D sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
=20
 	dev->dmavec_mempool =3D mempool_create_node(1,
@@ -3055,17 +3065,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_=
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
@@ -3515,7 +3515,6 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
@@ -3579,7 +3578,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
--=20
2.47.1


