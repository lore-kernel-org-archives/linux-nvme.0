Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DE7C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFF09RodBGszoxgqFpTBoQhMknReU4aJkDPvrzly1Tg=; b=hve1tGe1Ujpt3AUhS+NFsV315N
	gI2Oyb//FDajVWEEgEA6oE0bmkS0QL7LbQ3y1XGhOKUt+iPOw/OBxuwRgFVGwbeM43HPDypvD1fpd
	goD/MoyRIGHLsFZhGPb+zSrYX6WRQtJNeddlGrXRp2ZuqBrLMrcoMJsIkZUUnz0ia1maT6dqkFO9i
	C1KgJaj4YdSQPPqmUobVifIHsuNBoWI66VGJwQFE2lR+UI23gXBcTFUiW7aabAThlxYsF76V8Yh8O
	VGPah/KtpMwFY1eYHHj8e2WU8WgfY6PP490bQf7xXKcJ/4d4/eoXrfqFHeZQCrnYcUOD9AQnslbev
	W6qjgdDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjd3-0000000BZ1Z-0XjY;
	Tue, 13 May 2025 07:00:41 +0000
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjd1-0000000BZ0b-2EfV;
	Tue, 13 May 2025 07:00:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/7] nvme-pci: rename the descriptor pools
Date: Tue, 13 May 2025 09:00:20 +0200
Message-ID: <20250513070025.830930-5-hch@lst.de>
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

They are used for both PRPs and SGLs, and we use descriptor elsewhere
when referring to their allocations, so use that name here as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 84 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fe859c31e765..773a2e625657 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -113,7 +113,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
-struct nvme_prp_dma_pools {
+struct nvme_descriptor_pools {
 	struct dma_pool *large;
 	struct dma_pool *small;
 };
@@ -166,7 +166,7 @@ struct nvme_dev {
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
-	struct nvme_prp_dma_pools prp_pools[];
+	struct nvme_descriptor_pools descriptor_pools[];
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -196,7 +196,7 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
  */
 struct nvme_queue {
 	struct nvme_dev *dev;
-	struct nvme_prp_dma_pools prp_pools;
+	struct nvme_descriptor_pools descriptor_pools;
 	spinlock_t sq_lock;
 	void *sq_cmds;
 	 /* only used for poll queues: */
@@ -400,46 +400,44 @@ static int nvme_pci_npages_prp(void)
 	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
 }
 
-static struct nvme_prp_dma_pools *
-nvme_setup_prp_pools(struct nvme_dev *dev, unsigned numa_node)
+static struct nvme_descriptor_pools *
+nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
 {
-	struct nvme_prp_dma_pools *prp_pools = &dev->prp_pools[numa_node];
+	struct nvme_descriptor_pools *pools = &dev->descriptor_pools[numa_node];
 	size_t small_align = 256;
 
-	if (prp_pools->small)
-		return prp_pools; /* already initialized */
+	if (pools->small)
+		return pools; /* already initialized */
 
-	prp_pools->large = dma_pool_create_node("prp list page", dev->dev,
-						NVME_CTRL_PAGE_SIZE,
-						NVME_CTRL_PAGE_SIZE, 0,
-						numa_node);
-	if (!prp_pools->large)
+	pools->large = dma_pool_create_node("nvme descriptor page", dev->dev,
+			NVME_CTRL_PAGE_SIZE, NVME_CTRL_PAGE_SIZE, 0, numa_node);
+	if (!pools->large)
 		return ERR_PTR(-ENOMEM);
 
 	if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
 		small_align = 512;
 
 	/* Optimisation for I/Os between 4k and 128k */
-	prp_pools->small = dma_pool_create_node("prp list 256", dev->dev,
-						256, small_align, 0, numa_node);
-	if (!prp_pools->small) {
-		dma_pool_destroy(prp_pools->large);
-		prp_pools->large = NULL;
+	pools->small = dma_pool_create_node("nvme descriptor 256", dev->dev,
+			256, small_align, 0, numa_node);
+	if (!pools->small) {
+		dma_pool_destroy(pools->large);
+		pools->large = NULL;
 		return ERR_PTR(-ENOMEM);
 	}
 
-	return prp_pools;
+	return pools;
 }
 
-static void nvme_release_prp_pools(struct nvme_dev *dev)
+static void nvme_release_descriptor_pools(struct nvme_dev *dev)
 {
 	unsigned i;
 
 	for (i = 0; i < nr_node_ids; i++) {
-		struct nvme_prp_dma_pools *prp_pools = &dev->prp_pools[i];
+		struct nvme_descriptor_pools *pools = &dev->descriptor_pools[i];
 
-		dma_pool_destroy(prp_pools->large);
-		dma_pool_destroy(prp_pools->small);
+		dma_pool_destroy(pools->large);
+		dma_pool_destroy(pools->small);
 	}
 }
 
@@ -448,16 +446,16 @@ static int nvme_init_hctx_common(struct blk_mq_hw_ctx *hctx, void *data,
 {
 	struct nvme_dev *dev = to_nvme_dev(data);
 	struct nvme_queue *nvmeq = &dev->queues[qid];
-	struct nvme_prp_dma_pools *prp_pools;
+	struct nvme_descriptor_pools *pools;
 	struct blk_mq_tags *tags;
 
 	tags = qid ? dev->tagset.tags[qid - 1] : dev->admin_tagset.tags[0];
 	WARN_ON(tags != hctx->tags);
-	prp_pools = nvme_setup_prp_pools(dev, hctx->numa_node);
-	if (IS_ERR(prp_pools))
-		return PTR_ERR(prp_pools);
+	pools = nvme_setup_descriptor_pools(dev, hctx->numa_node);
+	if (IS_ERR(pools))
+		return PTR_ERR(pools);
 
-	nvmeq->prp_pools = *prp_pools;
+	nvmeq->descriptor_pools = *pools;
 	hctx->driver_data = nvmeq;
 	return 0;
 }
@@ -602,7 +600,8 @@ static void nvme_free_prps(struct nvme_queue *nvmeq, struct request *req)
 		__le64 *prp_list = iod->descriptors[i];
 		dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
 
-		dma_pool_free(nvmeq->prp_pools.large, prp_list, dma_addr);
+		dma_pool_free(nvmeq->descriptor_pools.large, prp_list,
+				dma_addr);
 		dma_addr = next_dma_addr;
 	}
 }
@@ -623,11 +622,11 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
 
 	if (iod->nr_descriptors == 0)
-		dma_pool_free(nvmeq->prp_pools.small, iod->descriptors[0],
-			      iod->first_dma);
+		dma_pool_free(nvmeq->descriptor_pools.small,
+				iod->descriptors[0], iod->first_dma);
 	else if (iod->nr_descriptors == 1)
-		dma_pool_free(nvmeq->prp_pools.large, iod->descriptors[0],
-			      iod->first_dma);
+		dma_pool_free(nvmeq->descriptor_pools.large,
+				iod->descriptors[0], iod->first_dma);
 	else
 		nvme_free_prps(nvmeq, req);
 	mempool_free(iod->sgt.sgl, dev->iod_mempool);
@@ -683,10 +682,10 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 
 	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
 	if (nprps <= (256 / 8)) {
-		pool = nvmeq->prp_pools.small;
+		pool = nvmeq->descriptor_pools.small;
 		iod->nr_descriptors = 0;
 	} else {
-		pool = nvmeq->prp_pools.large;
+		pool = nvmeq->descriptor_pools.large;
 		iod->nr_descriptors = 1;
 	}
 
@@ -773,10 +772,10 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 	}
 
 	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
-		pool = nvmeq->prp_pools.small;
+		pool = nvmeq->descriptor_pools.small;
 		iod->nr_descriptors = 0;
 	} else {
-		pool = nvmeq->prp_pools.large;
+		pool = nvmeq->descriptor_pools.large;
 		iod->nr_descriptors = 1;
 	}
 
@@ -921,7 +920,8 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
 	if (rc)
 		goto out_free_sg;
 
-	sg_list = dma_pool_alloc(nvmeq->prp_pools.small, GFP_ATOMIC, &sgl_dma);
+	sg_list = dma_pool_alloc(nvmeq->descriptor_pools.small, GFP_ATOMIC,
+			&sgl_dma);
 	if (!sg_list)
 		goto out_unmap_sg;
 
@@ -1108,7 +1108,7 @@ static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
 		return;
 	}
 
-	dma_pool_free(nvmeq->prp_pools.small, iod->meta_descriptor,
+	dma_pool_free(nvmeq->descriptor_pools.small, iod->meta_descriptor,
 			iod->meta_dma);
 	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
 	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
@@ -3214,8 +3214,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
-	dev = kzalloc_node(sizeof(*dev) + nr_node_ids * sizeof(*dev->prp_pools),
-			   GFP_KERNEL, node);
+	dev = kzalloc_node(sizeof(*dev) + nr_node_ids *
+			sizeof(*dev->descriptor_pools), GFP_KERNEL, node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
@@ -3432,7 +3432,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_free_queues(dev, 0);
 	mempool_destroy(dev->iod_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
-	nvme_release_prp_pools(dev);
+	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
 }
-- 
2.47.2


