Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5DAC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZvB036JNvBvQ600Pbpx68zhFyPkuWhI20PgLeIA6pWs=; b=Vm7Sda7mq/BSuTaZQ9EH/ztwzq
	g2Kye3OzUf+z0q2mqNE3MEXh2rVLH3qtO1arY1pzsIU0DB0n7hVKtNIx/w7/HeYmLywC/5SfCEASB
	4c0Vm/B8kfxuydhuahj4kKc1LCplWGuDfq8NrmG5BZZZPXNT+9qoDllCwX0u5jMi9dfiwJhr3Kz+o
	Luwjvemmjmt9WfAMAxnbmOhx/guIWSk4UhRDdLmIzP7Gn70L/C8N7AlfuFLotB44T6rBCMKbYofbI
	Keuege/Rf8U2mtexuN5CuQw2dLTA+brPS56stgtOgQsf8FxNJ8TyMqhBJorC/nvX5pQLVtQ0S1pyt
	IYKRm93w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7IR0-00000008Ann-2Hdu;
	Tue, 22 Apr 2025 18:33:30 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GM4-00000007sby-02gT
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 16:20:17 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-225887c7265so10098925ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745338815; x=1745943615; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvB036JNvBvQ600Pbpx68zhFyPkuWhI20PgLeIA6pWs=;
        b=XEcXhFTGw8KtkNiFblZsNEA7zusK8uHQkUccCZkG00bohKDSY1Ir6aEDrIHHWXtLXA
         LSbRZikD2qCgXgWrs4CC0uO6/KEAxpVHi9wp4MSyaboktnXkEuo3MHhtSygHL/duDAtz
         w/9k4SZWKsHyjMsxBips/K7rAx5Y4XSs5k7Q9l8i52UHCNeZhOOjIe5UJQZ38KtHmpbH
         kiJm5puIT+cYZO3i9kThBKihe4cIi8AFTVle4tt+2iqORlW2SKsCOqecUkKdvDT9YdOo
         eDxmmVAi3ocMl3K0HeBYMSeO0j1JlK6rs1RIMy54zaevNCLO/+fJiLnIuNRJ68nm3qtm
         769Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338815; x=1745943615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvB036JNvBvQ600Pbpx68zhFyPkuWhI20PgLeIA6pWs=;
        b=rEN4pa19uTyGGNlL2A7VUUS+C5/LEx8yH5O4tI3O19hA7O4/PrsXlVFvMylPIV4hlH
         c9/UpKsg4TgWeD9pTrBfQCCO2/HMTtxInYQV9zq5PQX/lQNApPfFDowr0iwqsWm48ba7
         5fpj+oAbjaMxnUr0skt4/2q/yct33kHVP39/El9RHbwbf+L0Pjuf3SqatkCPjx46Tatf
         qAzsh9U2ZbNbgjEySmNngyUfrq8MXarhY+bY8gzSEs/rFWC2aW2lWEgVK9Ph7mbKtxRL
         XhMSQ/zZdmpfi8wpYRRfqFIS/A20dsCIwCKirFdHEw7iPgjbPWsK/rPquzcmtbsH0qzU
         Jl2g==
X-Forwarded-Encrypted: i=1; AJvYcCXwdA2v82+32qkOcq3MoAPeHTGpst72CZyGi7WYmT/CKbNKQWSxtFhyYZQlhlOhBlCekSfwFqQwE6U+@lists.infradead.org
X-Gm-Message-State: AOJu0YzrtVsO5K2DNOOCxRdQnZ3J1vAlSnt2fZw9zUGNHTPmme6MJeeu
	+zoJoMF1RjCzcIlGFzdn5Eky3sYvIwOAUapb8sOjapauLD+PGrkpuVQBnr6pcv7N15vwDjNw60m
	5FtfXl0H3Rg+DLXXpXomefqFZd7AwPLZh
X-Gm-Gg: ASbGncsG0tZ2suyi4h59CX+fdcNF8Lyhs+yPoCVmqQu4HqXWmAvXOaZsGE1gnjiyWpA
	zen8syJY1DRWwsxdNag6G6RGhcmwu8mH34EZqyHepKoxzBOS9PuDbEn0wWfnU11TXZzHLTwUT85
	IulLjt90V11yHMwUdCIfQeHkfjFCV7U6Wf6zL8Pecx7O+uq2UkAbf0XYVZO1XN+cM1NDEfLM/Oh
	zh9+Hrc5rVWvSpOrSG+++AjMKHP6A5EVfW+BEEJdrvbZ4F+ugcKyyOoW7pySCWnE9a8EO7PL4XK
	7ppCuhS5Zh0bKkz3VjLHOkxWAhhUqQh4PLvUfhbccUM9
X-Google-Smtp-Source: AGHT+IEntikAq4E8wqFy+9cA1Fo3EPq1pdfHtjlFkpfKaSGCsCneevUePhkF9udDnkG+bEvf/tA/W3RdZ0Kr
X-Received: by 2002:a17:902:ebc1:b0:220:cddb:5918 with SMTP id d9443c01a7336-22c5369584dmr91862205ad.9.1745338815036;
        Tue, 22 Apr 2025 09:20:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c50cf152fsm5243295ad.54.2025.04.22.09.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:20:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5664C340363;
	Tue, 22 Apr 2025 10:20:14 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 53D82E41D06; Tue, 22 Apr 2025 10:20:14 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 2/2] nvme/pci: make PRP list DMA pools per-NUMA-node
Date: Tue, 22 Apr 2025 10:19:59 -0600
Message-ID: <20250422161959.1958205-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250422161959.1958205-1-csander@purestorage.com>
References: <20250422161959.1958205-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_092016_054316_AECDB506 
X-CRM114-Status: GOOD (  24.77  )
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

Link: https://lore.kernel.org/linux-nvme/CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com/T/#u
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 143 +++++++++++++++++++++++-----------------
 1 file changed, 83 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 642890ddada5..cbd7734922f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -16,10 +16,11 @@
 #include <linux/kstrtox.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/nodemask.h>
 #include <linux/once.h>
 #include <linux/pci.h>
 #include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
@@ -110,21 +111,24 @@ struct nvme_queue;
 
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
 	unsigned online_queues;
 	unsigned max_qid;
 	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
 	u32 q_depth;
@@ -160,10 +164,11 @@ struct nvme_dev {
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
+	struct nvme_prp_dma_pools prp_pools[];
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp, NVME_PCI_MIN_QUEUE_SIZE,
@@ -189,10 +194,11 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
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
@@ -395,18 +401,66 @@ static int nvme_pci_npages_prp(void)
 	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
 	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
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
+		prp_pools->large = NULL;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return prp_pools;
+}
+
+static void nvme_release_prp_pools(struct nvme_dev *dev)
+{
+	unsigned i;
+
+	for (i = 0; i < nr_node_ids; i++) {
+		struct nvme_prp_dma_pools *prp_pools = &dev->prp_pools[i];
+
+		dma_pool_destroy(prp_pools->large);
+		dma_pool_destroy(prp_pools->small);
+	}
+}
+
 static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data, unsigned qid)
 {
 	struct nvme_dev *dev = to_nvme_dev(data);
 	struct nvme_queue *nvmeq = &dev->queues[qid];
+	struct nvme_prp_dma_pools *prp_pools;
 	struct blk_mq_tags *tags;
 
 	tags = qid ? dev->tagset.tags[qid - 1] : dev->admin_tagset.tags[0];
 	WARN_ON(tags != hctx->tags);
+	prp_pools = nvme_setup_prp_pools(dev, hctx->numa_node);
+	if (IS_ERR(prp_pools))
+		return PTR_ERR(prp_pools);
+
+	nvmeq->prp_pools = *prp_pools;
 	hctx->driver_data = nvmeq;
 	return 0;
 }
 
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -536,27 +590,28 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
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
@@ -567,17 +622,17 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
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
@@ -591,11 +646,11 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
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
@@ -627,14 +682,14 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
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
@@ -672,11 +727,11 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
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
@@ -697,11 +752,11 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
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
@@ -717,14 +772,14 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
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
@@ -784,16 +839,16 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
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
@@ -824,13 +879,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
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
@@ -841,10 +896,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
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
@@ -864,11 +920,11 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
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
@@ -946,11 +1002,11 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 
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
 
@@ -1036,10 +1092,11 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 		nvme_submit_cmds(nvmeq, &submit_list);
 	*rqlist = requeue_list;
 }
 
 static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
+						struct nvme_queue *nvmeq,
 						struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	if (!iod->meta_sgt.nents) {
@@ -1047,11 +1104,11 @@ static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
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
 
@@ -1059,14 +1116,14 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
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
@@ -2839,39 +2896,10 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
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
 
@@ -3182,11 +3210,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	unsigned long quirks = id->driver_data;
 	int node = dev_to_node(&pdev->dev);
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
-	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
+	dev = kzalloc_node(sizeof(*dev) + nr_node_ids * sizeof(*dev->prp_pools),
+			   GFP_KERNEL, node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
 
@@ -3257,17 +3286,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
@@ -3339,12 +3364,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


