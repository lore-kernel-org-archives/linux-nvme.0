Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9526DC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=drTK3cYoFuHQLYDYst01XSp8mSZ0HgJyFsfZXir0bg0=; b=tN+5NXUbC1B30L16WQDYzQ2PXx
	mjIsRcyXAob6iBo046eOElFpPFrBiV75cgI1ecaWKQtsdrvPW93VE5+PlwwVaw4ny2TtlfmwNMZMY
	oq45+a3ZukLtT0GagEPyVGqW/VlVrYxljawIjZ7Tay26HEa/o7B5ee6sHCcVGaAhhntitLRu5zRvO
	BDPGO97lPgmBguhFNxNPEvgazOEmlePfHtBL6KIIVjA6rvBgCSyfxn1t0BI3O9BfdDyfm4kwfrnPY
	2UYRiJ2BPjamvRwK3JXuczzmOZ/E8jpQgyO4LAY0S1FmhWWnADB9dYOuxIAQF5WDiw6K1rf2Hmik5
	jaeQMxbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7hI3-002D0Z-IH; Tue, 20 Dec 2022 18:24:35 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7hHz-002Coi-K0
	for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 18:24:33 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKGo7B0031258
	for <linux-nvme@lists.infradead.org>; Tue, 20 Dec 2022 10:24:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=drTK3cYoFuHQLYDYst01XSp8mSZ0HgJyFsfZXir0bg0=;
 b=D7YCadx1FLWWxqtlVUz5l4/3RCDXwEAFHo0UCu8+9DgCT0jmrlqcF5s/EVjnjsCH8WbO
 B0TV1QhUQSTJKLLVPBNitvI9AOkwVYuUcDjppaNIdBoyG4Fp7tqIbr6kh+5eUn1vZFTB
 lxgjVjG9IQqM3hd8fffMwI9ggthpHj5aHil/zQUzljL/HYzTcjCu4u855OZTa6Nct6Ag
 8S5z7RUtM8r9atRQqHqTr5qLp32t8Bws7czCsYh7BcWXtPNtIePjXm0sSw65PgczGlET
 YBMzmLGrqtk3Hlr5Puasy81rrWV0C/TwhrwVR0NB8V0GBAiBSKBFoGWTF8DtrogeHCk1 yg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mk23em2qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 20 Dec 2022 10:24:24 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 10:24:23 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id DD3FCD40AD08; Tue, 20 Dec 2022 10:21:32 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: place chain addresses in iod
Date: Tue, 20 Dec 2022 10:21:31 -0800
Message-ID: <20221220182131.465092-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0TGFpy9VSGGzJBFmIrxOALhYr4Nmjro2
X-Proofpoint-ORIG-GUID: 0TGFpy9VSGGzJBFmIrxOALhYr4Nmjro2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_06,2022-12-20_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_102431_796990_0CD7F400 
X-CRM114-Status: GOOD (  21.11  )
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

The iod space is appended at the end of the preallocate 'struct
request', and padded to the cache line size. This leaves some free
memory (in most kernel configs) up for grabs.

Instead of appending the prp list chaining addresses after the
scatterlist, inline these in the struct nvme_iod. This leaves room for
one more scatterlist element in the mempool for a nice even number: 128.

And without increasing the size of the preallocated requests, we can
hold up to 5 chaining elements, allowing the driver to increase its max
transfer size to 8MB.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 44 ++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 578f384025440..01ec07e04e2c0 100644
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
+#define NVME_MAX_CHAINS	5
=20
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
@@ -232,6 +233,7 @@ struct nvme_iod {
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
+	void *list[NVME_MAX_CHAINS];
 };
=20
 static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
@@ -385,16 +387,6 @@ static int nvme_pci_npages_prp(void)
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
@@ -508,12 +500,6 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hc=
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
@@ -539,7 +525,7 @@ static void nvme_free_prps(struct nvme_dev *dev, stru=
ct request *req)
 	int i;
=20
 	for (i =3D 0; i < iod->nr_allocations; i++) {
-		__le64 *prp_list =3D nvme_pci_iod_list(req)[i];
+		__le64 *prp_list =3D iod->list[i];
 		dma_addr_t next_dma_addr =3D le64_to_cpu(prp_list[last_prp]);
=20
 		dma_pool_free(dev->prp_page_pool, prp_list, dma_addr);
@@ -562,10 +548,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, s=
truct request *req)
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
=20
 	if (iod->nr_allocations =3D=3D 0)
-		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
+		dma_pool_free(dev->prp_small_pool, iod->list[0],
 			      iod->first_dma);
 	else if (iod->use_sgl)
-		dma_pool_free(dev->prp_page_pool, nvme_pci_iod_list(req)[0],
+		dma_pool_free(dev->prp_page_pool, iod->list[0],
 			      iod->first_dma);
 	else
 		nvme_free_prps(dev, req);
@@ -597,7 +583,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 	u64 dma_addr =3D sg_dma_address(sg);
 	int offset =3D dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
-	void **list =3D nvme_pci_iod_list(req);
 	dma_addr_t prp_dma;
 	int nprps, i;
=20
@@ -635,7 +620,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 		iod->nr_allocations =3D -1;
 		return BLK_STS_RESOURCE;
 	}
-	list[0] =3D prp_list;
+	iod->list[0] =3D prp_list;
 	iod->first_dma =3D prp_dma;
 	i =3D 0;
 	for (;;) {
@@ -644,7 +629,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_d=
ev *dev,
 			prp_list =3D dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
 				goto free_prps;
-			list[iod->nr_allocations++] =3D prp_list;
+			iod->list[iod->nr_allocations++] =3D prp_list;
 			prp_list[0] =3D old_prp_list[i - 1];
 			old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
 			i =3D 1;
@@ -726,7 +711,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_d=
ev *dev,
 		return BLK_STS_RESOURCE;
 	}
=20
-	nvme_pci_iod_list(req)[0] =3D sg_list;
+	iod->list[0] =3D sg_list;
 	iod->first_dma =3D sgl_dma;
=20
 	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
@@ -2659,11 +2644,8 @@ static void nvme_release_prp_pools(struct nvme_dev=
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
@@ -3483,9 +3465,9 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) !=3D 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) !=3D 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
-	BUILD_BUG_ON(DIV_ROUND_UP(nvme_pci_npages_prp(), NVME_CTRL_PAGE_SIZE) >
-		     S8_MAX);
 	BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
+	BUILD_BUG_ON(sizeof(struct scatterlist) * NVME_MAX_SEGS > PAGE_SIZE);
+	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_CHAINS);
=20
 	return pci_register_driver(&nvme_driver);
 }
--=20
2.30.2


