Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E5C3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 16:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DYjk+f6jduaJsArcLwz0wxxTgFrU1lfXg1K772If0u8=; b=nW12+RybeaA+LfpIpq4DmKexKE
	IBPjMplb0e22Ml0Jh9oR/fnQ5GmwfOb6o4loZQAGIMW7WLCKAk6pBJOuSDU1XUVD1QtRP1oD4H205
	cSb/QF5YlnCkh8UDDzM5ShNaS3nRhczcwpfwMFD1lRBn99V2wN0klpXwI++fOhG+SR4/5L7/DP6WW
	5r7Bu1gcjDJmjhkVEFM30a7skwIKlmJ/WFrgKqh8UYdfA2uH2lOi9R5rU8LSgErBY3VmjSRp3SHtr
	v6E/MDCQQQj5Qv72ZSKXeYepNjsKDlyDjfF/XTVHNBo9GXvNF0ThSXFsREVsXc1xzhmaaBFbxTnTP
	2k/VrpTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p82PH-00HDZl-5W; Wed, 21 Dec 2022 16:57:27 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p82PD-00HDW3-QA
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 16:57:25 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BLDYuBM013493
	for <linux-nvme@lists.infradead.org>; Wed, 21 Dec 2022 08:57:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=DYjk+f6jduaJsArcLwz0wxxTgFrU1lfXg1K772If0u8=;
 b=a6f48KeUZfcnSSJI7AvohHNXbXlHj5R8gd+Dmt7aihloelVXpeX5cOQm5gVOt+bO8XYy
 GM8kcXaPOUj2eAphkcKE7Ye8mnqDfqGpkq59apUmJg7ZeMbHvqklPz5ly6imfxvuya39
 ngtFOICFRnjlDqCCxuIBS5yReRnkpzhcryWbi5y26EURTqxJIsuQsCBzfIF8Ik5Hbf/s
 D74jJUHW2jscLxwVVP1RYucyXRv0euuRp4mtx3QBb4Wz/eN5fTqGg2gf51oSYDJgdsx+
 siynKqXzDTC+TnIspiG1gNOfO2kVO3w/LrmZ1sobctYipewb2F/qVPEJViGgicWxEbIL 1w== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3mkd0a269a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 Dec 2022 08:57:19 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 08:57:17 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id EF0EED5018BA; Wed, 21 Dec 2022 08:57:14 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme-pci: place descriptor addresses in iod
Date: Wed, 21 Dec 2022 08:57:14 -0800
Message-ID: <20221221165714.712216-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: V0cXSAkNF1iF-ulidYnpA2EU3WiCPxM9
X-Proofpoint-GUID: V0cXSAkNF1iF-ulidYnpA2EU3WiCPxM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_09,2022-12-21_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_085724_060216_E3F857DA 
X-CRM114-Status: GOOD (  21.99  )
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

The 'struct nvme_iod' space is appended at the end of the preallocated
'struct request', and padded to the cache line size. This leaves some
free memory (in most kernel configs) up for grabs.

Instead of appending the nvme data descriptor addresses after the
scatterlist, inline these for free within struct nvme_iod. There is now
enough space in the mempool for 128 possibe segments.

And without increasing the size of the preallocated requests, we can
hold up to 5 descriptor elements, allowing the driver to increase its
max transfer size to 8MB.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Created a union type for the list elements instead of generic void*.

  Renamed "chains" to nr_allocations.

 drivers/nvme/host/pci.c | 49 +++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 578f384025440..51758fe0a95ee 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -42,8 +42,9 @@
  * These can be higher, but we need to ensure that any command doesn't
  * require an sg allocation that needs more than a page of data.
  */
-#define NVME_MAX_KB_SZ	4096
-#define NVME_MAX_SEGS	127
+#define NVME_MAX_KB_SZ	8192
+#define NVME_MAX_SEGS	128
+#define NVME_MAX_NR_ALLOCATIONS	5
=20
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
@@ -215,6 +216,11 @@ struct nvme_queue {
 	struct completion delete_done;
 };
=20
+union nvme_descriptor {
+	struct nvme_sgl_desc	*sg_list;
+	__le64			*prp_list;
+};
+
 /*
  * The nvme_iod describes the data in an I/O.
  *
@@ -232,6 +238,7 @@ struct nvme_iod {
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
+	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
 };
=20
 static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
@@ -385,16 +392,6 @@ static int nvme_pci_npages_prp(void)
 	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
 }
=20
-/*
- * Calculates the number of pages needed for the SGL segments. For examp=
le a 4k
- * page can accommodate 256 SGL descriptors.
- */
-static int nvme_pci_npages_sgl(void)
-{
-	return DIV_ROUND_UP(NVME_MAX_SEGS * sizeof(struct nvme_sgl_desc),
-			NVME_CTRL_PAGE_SIZE);
-}
-
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -508,12 +505,6 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hc=
tx)
 	spin_unlock(&nvmeq->sq_lock);
 }
=20
-static void **nvme_pci_iod_list(struct request *req)
-{
-	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
-	return (void **)(iod->sgt.sgl + blk_rq_nr_phys_segments(req));
-}
-
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
 				     int nseg)
 {
@@ -539,7 +530,7 @@ static void nvme_free_prps(struct nvme_dev *dev, stru=
ct request *req)
 	int i;
=20
 	for (i =3D 0; i < iod->nr_allocations; i++) {
-		__le64 *prp_list =3D nvme_pci_iod_list(req)[i];
+		__le64 *prp_list =3D iod->list[i].prp_list;
 		dma_addr_t next_dma_addr =3D le64_to_cpu(prp_list[last_prp]);
=20
 		dma_pool_free(dev->prp_page_pool, prp_list, dma_addr);
@@ -562,10 +553,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct request *req)
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
=20
 	if (iod->nr_allocations =3D=3D 0)
-		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
+		dma_pool_free(dev->prp_small_pool, iod->list[0].sg_list,
 			      iod->first_dma);
 	else if (iod->use_sgl)
-		dma_pool_free(dev->prp_page_pool, nvme_pci_iod_list(req)[0],
+		dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
 			      iod->first_dma);
 	else
 		nvme_free_prps(dev, req);
@@ -597,7 +588,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 	u64 dma_addr =3D sg_dma_address(sg);
 	int offset =3D dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
-	void **list =3D nvme_pci_iod_list(req);
 	dma_addr_t prp_dma;
 	int nprps, i;
=20
@@ -635,7 +625,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 		iod->nr_allocations =3D -1;
 		return BLK_STS_RESOURCE;
 	}
-	list[0] =3D prp_list;
+	iod->list[0].prp_list =3D prp_list;
 	iod->first_dma =3D prp_dma;
 	i =3D 0;
 	for (;;) {
@@ -644,7 +634,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
 				goto free_prps;
-			list[iod->nr_allocations++] =3D prp_list;
+			iod->list[iod->nr_allocations++].prp_list =3D prp_list;
 			prp_list[0] =3D old_prp_list[i - 1];
 			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
 			i =3D 1;
@@ -726,7 +716,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_d=
ev *dev,
 		return BLK_STS_RESOURCE;
 	}
=20
-	nvme_pci_iod_list(req)[0] =3D sg_list;
+	iod->list[0].sg_list =3D sg_list;
 	iod->first_dma =3D sgl_dma;
=20
 	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
@@ -2659,11 +2649,8 @@ static void nvme_release_prp_pools(struct nvme_dev=
 *dev)
=20
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
-	size_t npages =3D max(nvme_pci_npages_prp(), nvme_pci_npages_sgl());
-	size_t alloc_size =3D sizeof(__le64 *) * npages +
-			    sizeof(struct scatterlist) * NVME_MAX_SEGS;
+	size_t alloc_size =3D sizeof(struct scatterlist) * NVME_MAX_SEGS;
=20
-	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
 	dev->iod_mempool =3D mempool_create_node(1,
 			mempool_kmalloc, mempool_kfree,
 			(void *)alloc_size, GFP_KERNEL,
@@ -3483,9 +3470,9 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) !=3D 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
-	BUILD_BUG_ON(DIV_ROUND_UP(nvme_pci_npages_prp(), NVME_CTRL_PAGE_SIZE) >
-		     S8_MAX);
 	BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
+	BUILD_BUG_ON(sizeof(struct scatterlist) * NVME_MAX_SEGS > PAGE_SIZE);
+	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS);
=20
 	return pci_register_driver(&nvme_driver);
 }
--=20
2.30.2


