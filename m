Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587D6CA0EC4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IOQmlZK1rNrnPUYuJ9SiRnr7Fw55KipOBhTUFmsc2Fw=; b=P4eyJl0ssZ4kwxK3a9FfVbcAzw
	xwe1363zb+Byri7EVkN6uS0g3ZCHqUbViwe0pCidbAJzeAgIwJA/fArFrNEh263+pYFkbFJS24bAt
	mbRukKVZeyOd9FxqOMDhorHG9gtL7zVYYCP/nesydBEkflzE4m5bP9wxVkn+wvRD/E0XWwHuXsmSo
	+kUpttoioeDcpnVFT6CLCfbZhFgZz4JmiOlhglQs2D3GLAKgcz0dYHLcAfcyMg06zt+lBpCGh8+9G
	ZmasKuANYHf04BvFjF4txI8zDwm7Nrv3RzhamZRrBO9T1WcB1h4oZaP5xKnPwORAQ7TgWmhGTsE+D
	7REoRrMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsst-0000000BbRl-1yC0;
	Tue, 12 Aug 2025 17:34:03 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpRc-0000000AywD-2fSb
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:53:41 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDnqqb012173
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=IOQmlZK1rNrnPUYuJ9SiRnr7Fw55KipOBhTUFmsc2Fw=; b=LnL4rTb7Gn6/
	mrtAA5G3SuAXpjshyN8m/MIph86QSNMuqYgztUoASfo6h1uM4YtRjGMqu8kuVWeZ
	ytBa5jEmJxS0Z6boX8EKfmB45PzPn5d7kfzJ8gttn7y16yROhq5X+/RibY7AS8xb
	4/XqdrgGKxn6hoXAaqmCuRO5xMMQZqKl0K5OSrn4ex2F6rrsfAd+dzQMGkWdBp/Q
	3BG5kLU9BlE2WwH09C5qxJK2heaA0pfkAyseEJ6BXwf0wp0xOx/jMKSJWwdkwmXk
	HVop65KI1v2kC9cG27v5885qeS9EFgDbpLM1UE+FgFMvOjxLTsJwQWlpG2vc0zlp
	HsumfE07tw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48g5s6rrwh-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:39 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:18 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E880E8D4082; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 8/8] nvme-pci: convert metadata mapping to dma iter
Date: Tue, 12 Aug 2025 06:52:10 -0700
Message-ID: <20250812135210.4172178-9-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812135210.4172178-1-kbusch@meta.com>
References: <20250812135210.4172178-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vXaOXWactJDy_0px4j6Po8utcqZpp3-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX4DOljUxA/YI9 wzhY8talmeIyrg3PeJh6ubL/NdbJlRMFUwxZsI2SJqr8sH7ZYH6Hu9Ivxk5eET7il1+1UPpw5CT hjyDmcizy7oOHuZP5xUVlLG8Dxos0DP12wcwjkakKejzrjXiFTWiT9+Cs1qN/au0UBCfpu5AWlK
 wTnBry6jQsPE2ncXt9koBpBwNSgdguFWSGWc/ZN8YJcO4ijqe7QBcFIO/XW9OqVB6QO5G/pf4qo PM5j/rl9pdIKqIbkYA0wMsZ4hQhhamPVq/B1BsZqc8cjS98Usxm5vXXmEnCbiCAy3utGL/42yeM uTMQ1vrjwpnepPitywBAx8kbaR/VSN0nxTpi9slu05qcLqYA0m1jcOedzsXEMeq2qQblOfbhpAQ
 x4RQV2qvLwcn5ZmocJ5qgd3voN/21U4YuMcVdtg8MzcFBS+/kH5+X0l8RxDICXHsKtZtuijX
X-Proofpoint-ORIG-GUID: vXaOXWactJDy_0px4j6Po8utcqZpp3-C
X-Authority-Analysis: v=2.4 cv=H4vbw/Yi c=1 sm=1 tr=0 ts=689b4763 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=b4pXc90ez-momG_VimUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065340_686724_99980C7A 
X-CRM114-Status: GOOD (  21.69  )
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
 drivers/nvme/host/pci.c | 170 ++++++++++++++++++++++------------------
 1 file changed, 94 insertions(+), 76 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2b89e74d1fa73..3c9a53ba959c7 100644
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
@@ -713,6 +723,43 @@ static void __nvme_free_sgls(struct request *req, st=
ruct nvme_sgl_desc *sge,
 			le32_to_cpu(sg_list[i].length), dir);
 }
=20
+static void nvme_free_meta_sgls(struct request *req)
+{
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct nvme_sgl_desc *sge =3D iod->meta_descriptor;
+
+	__nvme_free_sgls(req, sge, &sge[1]);
+}
+
+static void nvme_unmap_metadata(struct request *req)
+{
+	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
+	enum dma_data_direction dir =3D rq_dma_dir(req);
+	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
+	struct device *dma_dev =3D nvmeq->dev->dev;
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
+			nvme_free_meta_sgls(req);
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
 static void nvme_free_sgls(struct request *req)
 {
 	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
@@ -1022,70 +1069,72 @@ static blk_status_t nvme_map_data(struct request =
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
@@ -1098,6 +1147,7 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct=
 request *req)
 	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	iod->cmd.common.metadata =3D cpu_to_le64(iod->meta_dma);
+	iod->flags |=3D IOD_SINGLE_META_SEGMENT;
 	return BLK_STS_OK;
 }
=20
@@ -1119,7 +1169,7 @@ static blk_status_t nvme_prep_rq(struct request *re=
q)
 	iod->flags =3D 0;
 	iod->nr_descriptors =3D 0;
 	iod->total_len =3D 0;
-	iod->meta_sgt.nents =3D 0;
+	iod->meta_total_len =3D 0;
=20
 	ret =3D nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
@@ -1230,25 +1280,6 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
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
@@ -3054,7 +3085,6 @@ static int nvme_disable_prepare_reset(struct nvme_d=
ev *dev, bool shutdown)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
-	size_t meta_size =3D sizeof(struct scatterlist) * (NVME_MAX_META_SEGS +=
 1);
 	size_t alloc_size =3D sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
=20
 	dev->dmavec_mempool =3D mempool_create_node(1,
@@ -3063,17 +3093,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_=
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
@@ -3523,7 +3543,6 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
@@ -3587,7 +3606,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->dmavec_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
--=20
2.47.3


