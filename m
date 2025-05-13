Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10285C3ABC9
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B3sVg+Wyd2mPsbf/VpfyyPjS7ykQpMhy0+yAB0/CKUM=; b=0XmM8GYYxtYOieUGQIpVu5cz60
	oRbN+wSX6CmRbdgEinOPsfyMfnDtpDbOmypdkfuKUEYXwjPnJSCI/loTRFr4xyRC8VsqthpkgXH9+
	t4cD5YwgbzDq+ut7+30l7CmRkBq4Iz+x2XdTKCCAhJSm8JMIRj7ALEGU7FIrwkKSTOVvB95ahBetv
	7BR/aoIwSdz8xjjooz+GkyYT1oRYmw5WD4JGyBaZs2X2Gw8W4IzBYCvb9CyC8PN0cFRmoobZw//Tw
	vuBsttOXOZTjeErhHeAXPR9r69bNCyGKMZAq7deaxEwAW5+AwN99HLuBLiKI2GeADdkcyOdHMApic
	vscu2pfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjd1-0000000BZ0n-2FiG;
	Tue, 13 May 2025 07:00:39 +0000
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjcz-0000000BYzR-15KA;
	Tue, 13 May 2025 07:00:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] nvme-pci: remove struct nvme_descriptor
Date: Tue, 13 May 2025 09:00:19 +0200
Message-ID: <20250513070025.830930-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513070025.830930-1-hch@lst.de>
References: <20250513070025.830930-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There is no real point in having a union of two pointer types here, just
use a void pointer as we mix and match types between the arms of the
union between the allocation and freeing side already.

Also rename the nr_allocations field to nr_descriptors to better describe
what it does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[leon: ported forward to include metadata SGL support]
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Tested-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 57 +++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 51430f5e6a66..fe859c31e765 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -44,7 +44,7 @@
 #define NVME_MAX_KB_SZ	8192
 #define NVME_MAX_SEGS	128
 #define NVME_MAX_META_SEGS 15
-#define NVME_MAX_NR_ALLOCATIONS	5
+#define NVME_MAX_NR_DESCRIPTORS	5
 
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
@@ -225,11 +225,6 @@ struct nvme_queue {
 	struct completion delete_done;
 };
 
-union nvme_descriptor {
-	struct nvme_sgl_desc	*sg_list;
-	__le64			*prp_list;
-};
-
 /* bits for iod->flags */
 enum nvme_iod_flags {
 	/* this command has been aborted by the timeout handler */
@@ -238,23 +233,19 @@ enum nvme_iod_flags {
 
 /*
  * The nvme_iod describes the data in an I/O.
- *
- * The sg pointer contains the list of PRP/SGL chunk allocations in addition
- * to the actual struct scatterlist.
  */
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
 	u8 flags;
-	s8 nr_allocations;	/* PRP list pool allocations. 0 means small
-				   pool in use */
+	s8 nr_descriptors;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
 	struct sg_table sgt;
 	struct sg_table meta_sgt;
-	union nvme_descriptor meta_list;
-	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
+	void *meta_descriptor;
+	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 };
 
 static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
@@ -607,8 +598,8 @@ static void nvme_free_prps(struct nvme_queue *nvmeq, struct request *req)
 	dma_addr_t dma_addr = iod->first_dma;
 	int i;
 
-	for (i = 0; i < iod->nr_allocations; i++) {
-		__le64 *prp_list = iod->list[i].prp_list;
+	for (i = 0; i < iod->nr_descriptors; i++) {
+		__le64 *prp_list = iod->descriptors[i];
 		dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
 
 		dma_pool_free(nvmeq->prp_pools.large, prp_list, dma_addr);
@@ -631,11 +622,11 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
 
-	if (iod->nr_allocations == 0)
-		dma_pool_free(nvmeq->prp_pools.small, iod->list[0].sg_list,
+	if (iod->nr_descriptors == 0)
+		dma_pool_free(nvmeq->prp_pools.small, iod->descriptors[0],
 			      iod->first_dma);
-	else if (iod->nr_allocations == 1)
-		dma_pool_free(nvmeq->prp_pools.large, iod->list[0].sg_list,
+	else if (iod->nr_descriptors == 1)
+		dma_pool_free(nvmeq->prp_pools.large, iod->descriptors[0],
 			      iod->first_dma);
 	else
 		nvme_free_prps(nvmeq, req);
@@ -693,18 +684,18 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
 	if (nprps <= (256 / 8)) {
 		pool = nvmeq->prp_pools.small;
-		iod->nr_allocations = 0;
+		iod->nr_descriptors = 0;
 	} else {
 		pool = nvmeq->prp_pools.large;
-		iod->nr_allocations = 1;
+		iod->nr_descriptors = 1;
 	}
 
 	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 	if (!prp_list) {
-		iod->nr_allocations = -1;
+		iod->nr_descriptors = -1;
 		return BLK_STS_RESOURCE;
 	}
-	iod->list[0].prp_list = prp_list;
+	iod->descriptors[0] = prp_list;
 	iod->first_dma = prp_dma;
 	i = 0;
 	for (;;) {
@@ -713,7 +704,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
 				goto free_prps;
-			iod->list[iod->nr_allocations++].prp_list = prp_list;
+			iod->descriptors[iod->nr_descriptors++] = prp_list;
 			prp_list[0] = old_prp_list[i - 1];
 			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
 			i = 1;
@@ -783,19 +774,19 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 
 	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
 		pool = nvmeq->prp_pools.small;
-		iod->nr_allocations = 0;
+		iod->nr_descriptors = 0;
 	} else {
 		pool = nvmeq->prp_pools.large;
-		iod->nr_allocations = 1;
+		iod->nr_descriptors = 1;
 	}
 
 	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
 	if (!sg_list) {
-		iod->nr_allocations = -1;
+		iod->nr_descriptors = -1;
 		return BLK_STS_RESOURCE;
 	}
 
-	iod->list[0].sg_list = sg_list;
+	iod->descriptors[0] = sg_list;
 	iod->first_dma = sgl_dma;
 
 	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
@@ -935,7 +926,7 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
 		goto out_unmap_sg;
 
 	entries = iod->meta_sgt.nents;
-	iod->meta_list.sg_list = sg_list;
+	iod->meta_descriptor = sg_list;
 	iod->meta_dma = sgl_dma;
 
 	cmnd->flags = NVME_CMD_SGL_METASEG;
@@ -991,7 +982,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	blk_status_t ret;
 
 	iod->flags = 0;
-	iod->nr_allocations = -1;
+	iod->nr_descriptors = -1;
 	iod->sgt.nents = 0;
 	iod->meta_sgt.nents = 0;
 
@@ -1117,8 +1108,8 @@ static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
 		return;
 	}
 
-	dma_pool_free(nvmeq->prp_pools.small, iod->meta_list.sg_list,
-		      iod->meta_dma);
+	dma_pool_free(nvmeq->prp_pools.small, iod->meta_descriptor,
+			iod->meta_dma);
 	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
 	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
 }
@@ -3842,7 +3833,7 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
 	BUILD_BUG_ON(sizeof(struct scatterlist) * NVME_MAX_SEGS > PAGE_SIZE);
-	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_ALLOCATIONS);
+	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_DESCRIPTORS);
 
 	return pci_register_driver(&nvme_driver);
 }
-- 
2.47.2


