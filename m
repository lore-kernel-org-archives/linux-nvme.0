Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58C2C369C2
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Apr 2025 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/A84X2mGzy52BvrCGfodyp1nyheidua5W39dTn6tWLc=; b=cnxQ8ogvZegfD1+iJTUbUcMVNM
	8cS1Si6lsM+m5amvB7t/buhf9cZR443x3QU1WOqbuq5u641OnDb+PDvFRmAI5a9S5HuaJcz7syyc3
	pRfkILOkqiU2lb8Ku0ek3Jhd1eOp+Aa1s7TUjEGtneCdr6bEbRsrGJlYp/aPINpkLJZ2TvbyY7wJn
	YTnmyna03Dk4SqxZyYBM4nZWXbSIXgSaESYwfMRhDgvcY4XZGtza1NdkzFGwZZRpiH1Pt0ldm+Yct
	Tq/2pQo6H9Q1psADL0SWEWjDxeaNxzRyF9nIy3UHYLUynf9et6CQPKaaEQMm3xN7mCYnZ0D/1tg9C
	WMHAIxIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Xms-00000002mhy-3sl3;
	Sun, 20 Apr 2025 16:44:58 +0000
Received: from mail-qv1-xf64.google.com ([2607:f8b0:4864:20::f64])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Xmq-00000002mhW-1QCo
	for linux-nvme@lists.infradead.org;
	Sun, 20 Apr 2025 16:44:57 +0000
Received: by mail-qv1-xf64.google.com with SMTP id 6a1803df08f44-6ed0d921c6aso4755346d6.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Apr 2025 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745167494; x=1745772294; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/A84X2mGzy52BvrCGfodyp1nyheidua5W39dTn6tWLc=;
        b=HHLpZm/o2vHJl78SMF8OfFnKAU6O/dwo0S8R6LsA9GrFuk31bWTNAg/ZOyzLFImdgK
         Z0vvxsXvidaKuWbzXs4R8CnCOzguxLoMHtRhc4HMW/TWSrkgECtdperswV9Z0HTkQA0I
         sM07vHxkEfk7upjE0Dr9qYuQjcx4J8sVovstyDtzGfji1H2xaymIca7NtUMUhQymPP9Z
         Hh22a1leVO638UonM0UexRi9QpVhUjk3K5vbKraMBsp07uXMksAub+lWVsOrCUaa0FBV
         28B7LuA3Rf7wEa6YKs15UfRFxrK0OASSbnFEVgaexUy3N3hzZPGqSiiTo9P/71ETNqLg
         GxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745167494; x=1745772294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/A84X2mGzy52BvrCGfodyp1nyheidua5W39dTn6tWLc=;
        b=bZVKAFUPnImjN/0/skdSGrZN9WeWJw0rIwiZc/UR/wf8FZlDmKHpTBeJRxs2Gyth9e
         OoA3oGU8u7O9XKUDbsWf1akVnGM0T7rrLksPo4QpR1msUZLiLAgQXZMC1pCzNqCDhZwt
         jQnAWX7Tncq67ydEk3SA1pPERjU7bVaNVrAAXropFFePKpyCc1yHIk0hUhqIQjDFy5Ft
         DNeLLJr8mvlnI8HtjwgWCP8N7fGYCPZj0+bHud8RxBo92lOwn6fv+FhGzi3TrMzAeMNf
         8nPlp6AVscVpEg6gNaeiG5NDgYTEWXQ2CLeFxkjtw+9Dn7F5JX6cFLaAwXL0yvpIJI5d
         ChdA==
X-Forwarded-Encrypted: i=1; AJvYcCVdR33HWHa/XpP299MKVW6Vc5/IcTEIF8A8xBmIgpxYx9ArRGGKvY4dvVQ8R52bK/llO7bSpZFoWgpA@lists.infradead.org
X-Gm-Message-State: AOJu0Yzf/nco2wFKcryle2UZ0yQtXafjSOVIlxTfJHQ29piRBd+pSJ94
	5S9yu+8E5FtjMXenBFXPPVTQzJkDA0bCpuPxx7LmigACp3aUGRjErxn/y/l8IZxh9WWZbewcHMm
	6wajlz4rVnLHj1CFp/tmtFZ9syii7Cy+v
X-Gm-Gg: ASbGncsigfhb0SBF89NVHTLxhO6IjkJhgEIUGUQae6Y+YScerHoFGtUnRh/GHJO1ud1
	AcdNPBuUy4aaf3sjcTzyEM6L8eptzDO3YltVq2ppS9WioQ0hF06QqeOhxUyFDtSUtK2TTRsSvIx
	3kXhrfaALcgcQXrdx4UQrGbYM5oYzlnz01AyQbGa+cvbNvQKcUDfsnxSXJzEX45qjPGIfK4+R0Q
	qtAbrSJWSsNIr8DHCnREhad1iB7DsnSWEcHj5D+XAFDqA6b73BEGOXlwy3GG6cdQHvgcSAa4jE3
	n7BbSH2F9rNVp24zsqYc0LriG+4kusMSGpQ1DjeN1ql/
X-Google-Smtp-Source: AGHT+IHrQAkyDb5eM3Lg8+M3NfTDuuSoIW6Y8sEqbett6PQ6lZ5MncKKdQGtalnDilyyX2Vh6a7S5yQEgyOQ
X-Received: by 2002:a05:6214:226d:b0:6e8:f4f9:40e1 with SMTP id 6a1803df08f44-6f2c4388417mr57134066d6.0.1745167494507;
        Sun, 20 Apr 2025 09:44:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f2c2b1dffbsm2182506d6.35.2025.04.20.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 09:44:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6E32F340193;
	Sun, 20 Apr 2025 10:44:53 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 68494E411CC; Sun, 20 Apr 2025 10:44:53 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme/pci: make PRP list DMA pools per-NUMA-node
Date: Sun, 20 Apr 2025 10:44:48 -0600
Message-ID: <20250420164450.1144416-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_094456_525064_A463E2CA 
X-CRM114-Status: GOOD (  22.95  )
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

NVMe commands with more than 4 KB of data allocate PRP list pages from
the per-nvme_device dma_pool prp_page_pool or prp_small_pool. Each call
to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock.
These device-global spinlocks are a significant source of contention
when many CPUs are submitting to the same NVMe devices. On a workload
issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA nodes
to 23 NVMe devices, we observed 2.4% of CPU time spent in
_raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.

Ideally, the dma_pools would be per-hctx to minimize
contention. But that could impose considerable resource costs in a
system with many NVMe devices and CPUs.

As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
nvme_queue to the set of DMA pools corresponding to its device and its
hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
about half, to 1.2%. Preventing the sharing of PRP list pages across
NUMA nodes also makes them cheaper to initialize.

Link: https://lists.infradead.org/pipermail/linux-nvme/2025-April/055376.html
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/pci.c | 140 +++++++++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 59 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..a07815574e93 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -110,21 +110,25 @@ struct nvme_queue;
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
+struct nvme_prp_dma_pools {
+	struct dma_pool *large;
+	struct dma_pool *small;
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
 struct nvme_dev {
 	struct nvme_queue *queues;
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
 	struct device *dev;
-	struct dma_pool *prp_page_pool;
-	struct dma_pool *prp_small_pool;
+	struct nvme_prp_dma_pools prp_pools[MAX_NUMNODES];
 	unsigned online_queues;
 	unsigned max_qid;
 	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
 	u32 q_depth;
@@ -189,10 +193,11 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
  */
 struct nvme_queue {
 	struct nvme_dev *dev;
+	struct nvme_prp_dma_pools prp_pools;
 	spinlock_t sq_lock;
 	void *sq_cmds;
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	struct nvme_completion *cqes;
@@ -408,17 +413,66 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 	hctx->driver_data = nvmeq;
 	return 0;
 }
 
+static struct nvme_prp_dma_pools *
+nvme_setup_prp_pools(struct nvme_dev *dev, unsigned numa_node)
+{
+	struct nvme_prp_dma_pools *prp_pools = &dev->prp_pools[numa_node];
+	size_t small_align = 256;
+
+	if (prp_pools->small)
+		return prp_pools; /* already initialized */
+
+	prp_pools->large = dma_pool_create("prp list page", dev->dev,
+						NVME_CTRL_PAGE_SIZE,
+						NVME_CTRL_PAGE_SIZE, 0);
+	if (!prp_pools->large)
+		return ERR_PTR(-ENOMEM);
+
+	if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
+		small_align = 512;
+
+	/* Optimisation for I/Os between 4k and 128k */
+	prp_pools->small = dma_pool_create("prp list 256", dev->dev,
+						256, small_align, 0);
+	if (!prp_pools->small) {
+		dma_pool_destroy(prp_pools->large);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return prp_pools;
+}
+
+static void nvme_release_prp_pools(struct nvme_dev *dev)
+{
+	struct nvme_prp_dma_pools *pools_end = dev->prp_pools + MAX_NUMNODES;
+	struct nvme_prp_dma_pools *prp_pools;
+
+	for (prp_pools = dev->prp_pools; prp_pools < pools_end; prp_pools++) {
+		if (!prp_pools->small)
+			continue;
+
+		dma_pool_destroy(prp_pools->large);
+		dma_pool_destroy(prp_pools->small);
+	}
+}
+
 static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 			  unsigned int hctx_idx)
 {
 	struct nvme_dev *dev = to_nvme_dev(data);
 	struct nvme_queue *nvmeq = &dev->queues[hctx_idx + 1];
+	struct nvme_prp_dma_pools *prp_pools;
 
 	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
+	prp_pools = nvme_setup_prp_pools(dev, hctx->numa_node);
+	if (IS_ERR(prp_pools))
+		return PTR_ERR(prp_pools);
+
+	nvmeq->prp_pools = *prp_pools;
 	hctx->driver_data = nvmeq;
 	return 0;
 }
 
 static int nvme_pci_init_request(struct blk_mq_tag_set *set,
@@ -535,27 +589,28 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return nvme_req(req)->flags & NVME_REQ_USERCMD;
 	return true;
 }
 
-static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
+static void nvme_free_prps(struct nvme_queue *nvmeq, struct request *req)
 {
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	dma_addr_t dma_addr = iod->first_dma;
 	int i;
 
 	for (i = 0; i < iod->nr_allocations; i++) {
 		__le64 *prp_list = iod->list[i].prp_list;
 		dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
 
-		dma_pool_free(dev->prp_page_pool, prp_list, dma_addr);
+		dma_pool_free(nvmeq->prp_pools.large, prp_list, dma_addr);
 		dma_addr = next_dma_addr;
 	}
 }
 
-static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
+static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_queue *nvmeq,
+			    struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	if (iod->dma_len) {
 		dma_unmap_page(dev->dev, iod->first_dma, iod->dma_len,
@@ -566,17 +621,17 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	WARN_ON_ONCE(!iod->sgt.nents);
 
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
 
 	if (iod->nr_allocations == 0)
-		dma_pool_free(dev->prp_small_pool, iod->list[0].sg_list,
+		dma_pool_free(nvmeq->prp_pools.small, iod->list[0].sg_list,
 			      iod->first_dma);
 	else if (iod->nr_allocations == 1)
-		dma_pool_free(dev->prp_page_pool, iod->list[0].sg_list,
+		dma_pool_free(nvmeq->prp_pools.large, iod->list[0].sg_list,
 			      iod->first_dma);
 	else
-		nvme_free_prps(dev, req);
+		nvme_free_prps(nvmeq, req);
 	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 }
 
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 {
@@ -590,11 +645,11 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
 			sg_dma_len(sg));
 	}
 }
 
-static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
+static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 		struct request *req, struct nvme_rw_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
 	int length = blk_rq_payload_bytes(req);
@@ -626,14 +681,14 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		goto done;
 	}
 
 	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
 	if (nprps <= (256 / 8)) {
-		pool = dev->prp_small_pool;
+		pool = nvmeq->prp_pools.small;
 		iod->nr_allocations = 0;
 	} else {
-		pool = dev->prp_page_pool;
+		pool = nvmeq->prp_pools.large;
 		iod->nr_allocations = 1;
 	}
 
 	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 	if (!prp_list) {
@@ -671,11 +726,11 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 done:
 	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sgt.sgl));
 	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
 	return BLK_STS_OK;
 free_prps:
-	nvme_free_prps(dev, req);
+	nvme_free_prps(nvmeq, req);
 	return BLK_STS_RESOURCE;
 bad_sgl:
 	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
 			"Invalid SGL for payload:%d nents:%d\n",
 			blk_rq_payload_bytes(req), iod->sgt.nents);
@@ -696,11 +751,11 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->addr = cpu_to_le64(dma_addr);
 	sge->length = cpu_to_le32(entries * sizeof(*sge));
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
-static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
+static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 		struct request *req, struct nvme_rw_command *cmd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
@@ -716,14 +771,14 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		nvme_pci_sgl_set_data(&cmd->dptr.sgl, sg);
 		return BLK_STS_OK;
 	}
 
 	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
-		pool = dev->prp_small_pool;
+		pool = nvmeq->prp_pools.small;
 		iod->nr_allocations = 0;
 	} else {
-		pool = dev->prp_page_pool;
+		pool = nvmeq->prp_pools.large;
 		iod->nr_allocations = 1;
 	}
 
 	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
 	if (!sg_list) {
@@ -783,16 +838,16 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
-		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
 			if (!nvme_pci_metadata_use_sgls(dev, req) &&
 			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
@@ -823,13 +878,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 			ret = BLK_STS_TARGET;
 		goto out_free_sg;
 	}
 
 	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
-		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
+		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
 	else
-		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
+		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);
 	if (ret != BLK_STS_OK)
 		goto out_unmap_sg;
 	return BLK_STS_OK;
 
 out_unmap_sg:
@@ -840,10 +895,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 }
 
 static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
 					     struct request *req)
 {
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_rw_command *cmnd = &iod->cmd.rw;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sgl, *sg;
 	unsigned int entries;
@@ -863,11 +919,11 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
 	rc = dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
 			     DMA_ATTR_NO_WARN);
 	if (rc)
 		goto out_free_sg;
 
-	sg_list = dma_pool_alloc(dev->prp_small_pool, GFP_ATOMIC, &sgl_dma);
+	sg_list = dma_pool_alloc(nvmeq->prp_pools.small, GFP_ATOMIC, &sgl_dma);
 	if (!sg_list)
 		goto out_unmap_sg;
 
 	entries = iod->meta_sgt.nents;
 	iod->meta_list.sg_list = sg_list;
@@ -945,11 +1001,11 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 
 	nvme_start_request(req);
 	return BLK_STS_OK;
 out_unmap_data:
 	if (blk_rq_nr_phys_segments(req))
-		nvme_unmap_data(dev, req);
+		nvme_unmap_data(dev, req->mq_hctx->driver_data, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
 }
 
@@ -1035,10 +1091,11 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 		nvme_submit_cmds(nvmeq, &submit_list);
 	*rqlist = requeue_list;
 }
 
 static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
+						struct nvme_queue *nvmeq,
 						struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	if (!iod->meta_sgt.nents) {
@@ -1046,11 +1103,11 @@ static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
 			       rq_integrity_vec(req).bv_len,
 			       rq_dma_dir(req));
 		return;
 	}
 
-	dma_pool_free(dev->prp_small_pool, iod->meta_list.sg_list,
+	dma_pool_free(nvmeq->prp_pools.small, iod->meta_list.sg_list,
 		      iod->meta_dma);
 	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
 	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
 }
 
@@ -1058,14 +1115,14 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 
 	if (blk_integrity_rq(req))
-		nvme_unmap_metadata(dev, req);
+		nvme_unmap_metadata(dev, nvmeq, req);
 
 	if (blk_rq_nr_phys_segments(req))
-		nvme_unmap_data(dev, req);
+		nvme_unmap_data(dev, nvmeq, req);
 }
 
 static void nvme_pci_complete_rq(struct request *req)
 {
 	nvme_pci_unmap_rq(req);
@@ -2838,39 +2895,10 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 		return -EBUSY;
 	nvme_dev_disable(dev, shutdown);
 	return 0;
 }
 
-static int nvme_setup_prp_pools(struct nvme_dev *dev)
-{
-	size_t small_align = 256;
-
-	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
-						NVME_CTRL_PAGE_SIZE,
-						NVME_CTRL_PAGE_SIZE, 0);
-	if (!dev->prp_page_pool)
-		return -ENOMEM;
-
-	if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
-		small_align = 512;
-
-	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, small_align, 0);
-	if (!dev->prp_small_pool) {
-		dma_pool_destroy(dev->prp_page_pool);
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-static void nvme_release_prp_pools(struct nvme_dev *dev)
-{
-	dma_pool_destroy(dev->prp_page_pool);
-	dma_pool_destroy(dev->prp_small_pool);
-}
-
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
 	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
 	size_t alloc_size = sizeof(struct scatterlist) * NVME_MAX_SEGS;
 
@@ -3256,17 +3284,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	result = nvme_dev_map(dev);
 	if (result)
 		goto out_uninit_ctrl;
 
-	result = nvme_setup_prp_pools(dev);
-	if (result)
-		goto out_dev_unmap;
-
 	result = nvme_pci_alloc_iod_mempool(dev);
 	if (result)
-		goto out_release_prp_pools;
+		goto out_dev_unmap;
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	result = nvme_pci_enable(dev);
 	if (result)
@@ -3338,12 +3362,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
 	mempool_destroy(dev->iod_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
-out_release_prp_pools:
-	nvme_release_prp_pools(dev);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
 	nvme_uninit_ctrl(&dev->ctrl);
 out_put_ctrl:
-- 
2.45.2


