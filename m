Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E1DC369D5
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Apr 2025 02:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YtryNti4mNb9Vw9cFkGEgtmMWf9l9msvOakHCG6EasA=; b=1c61kSSdkFFEbl7TKJXcWCIPZi
	UaDlIbjJgzaucSXfIEZw8a41F7oOjs/NudRgs0U4KIvmGUNSkuO3Zfhtz+8hKZoVxa9qJFI/CrvmV
	ETflv3d9hEwELsu89/l3MoqtOomERKalC3WjaXYIeOWrQq+cDdP51CRFQMDxpOokKDd3gQJMXljoh
	HWW55IAyVFEdD7AjKihJNCBLmJb89smjIkWHm4fD1sG3ax+oWR6go685rc6+O0m5t6M2EA9TV7FnC
	m0lU1h0F3aGLNeRSyQ8nKTni76Y1Rsfdme4AkbpnuXUrGZdJYKupQN4agW3oCXfgd+K623P9HaFgr
	rhFwuUsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxW-00000001Hsr-3lmD;
	Sat, 26 Apr 2025 02:08:02 +0000
Received: from mail-pj1-x1061.google.com ([2607:f8b0:4864:20::1061])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxT-00000001HqG-0CjZ
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 02:08:00 +0000
Received: by mail-pj1-x1061.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so398826a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 19:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745633278; x=1746238078; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtryNti4mNb9Vw9cFkGEgtmMWf9l9msvOakHCG6EasA=;
        b=cZw48ZFZ6+TmbqZfK1pCDLnEVHFhlpypX1KDotx8OALPAMnE4GwYaKXgmm+w/ms7uo
         Aq3GOb0Kc7XPZml2BB/PA89Gj3DZU1u4mGxFzzc+G8TSOkXpii35oZawx21cGlPM0ruh
         qb8t7W9/6OFjYAkehOAvq6g/XgjSlqfT9ycPfLQsp2mgS7neSDzJ5/BDRCpDVplo1rdg
         gBGuXJM1PEfDgEvdmQxQkvqPHK61ls8szLhIBwY/QpuM+8MUKOsqAGbKssNBJtNgkk9B
         9iFB1PrsUUfqADbOLwQRSbhVkRHMUdzgUf4kcGnwGy6HhOtf5N4aHs1NbXHkwVAUKGpV
         xfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745633278; x=1746238078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtryNti4mNb9Vw9cFkGEgtmMWf9l9msvOakHCG6EasA=;
        b=xCS1ySTL7UusSyqLvwyXakcSVYy43355qMYdF/aalK6mM92uXZybGSItO55/9eGh3M
         RHWc8J79+qz2BcI8hl/OW83dAEDtIKImsFWQwI3a4z4+u6moeas0eWRL51cfKba4kRJy
         ExH0f7hlh8hsKOPUNwK3NNvIqs/PpL7AVC5PqllimT3HSU1s3fB03w1FIBcOfonp0/gy
         NaSuFXrivCeP/KnfxRDKLSIJ04uRRjS0lSkB561TPK4E33qWAHa80+IqZ+S4wlePs9uw
         wBxdE6AluytYrPo3wrTF8tkca8XBeJ79uxxpbgsuKntovK5MjBOBUWGtuy6yocAzuHbV
         O1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU3GLlSFfSymdtLFx4IPZmJ79EtKwtc3jxAi1eJuT0gFKBKh9VQ1aljlUnUkPehNs8Qj6UHXB19oRZB@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/SFiK1KIHbAkBVcaxR3zLJbKzsoV+PLfcWaAPlBBBYFu+hbG9
	EeOWgUp6JPK/PUZEXO260ImutEpLjVIiIrWuy7Ehcgq+Hcla4lyJOoum+9ab6U7bjAyCcvpIndn
	9nsqMIYr5WA4yFlAqmKZjHnp59bYvBDtOEm87U6MYwC/M9qPD
X-Gm-Gg: ASbGncvbfNP1PfzzzNdy2++S9prMVylbhvx6odlOoHLdJs01Ow3A8kYl1YZ7RRP8wSt
	VdYMiIb5A6KNw1zuxFYGbydB5X9zVM6lsmqA1SY3xOMcejbEbFfUSNVA63+GXPkZiBqQwAkcKpK
	TgAVSBby8GWP0ntJwU3DHA/PJnQMnKmc7xht9kXjH+fockpyii4E4C1nM+mmKfo8e93EGeKOVqk
	JB0vVBTrG1ktTpsco9Qza0BBkx1bYwTGYQXiDNspeQW1OXFHsQbTgWVX5WhSPngz8146K5tNQAK
	vNksPmj/otGeSvgH7C7iaJ+M2EihEA==
X-Google-Smtp-Source: AGHT+IGQw/DW4cFmCJsmHjYH9tz1RQXJliW+ZULdfddljyIF3JXD9G+xXh7u+PeZ37ioicNVEnunHxNSbQbH
X-Received: by 2002:a17:90b:1a8a:b0:305:5f25:59ad with SMTP id 98e67ed59e1d1-309f7eb325amr2191425a91.7.1745633277977;
        Fri, 25 Apr 2025 19:07:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22db5221459sm2178125ad.121.2025.04.25.19.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 19:07:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 51E7A340231;
	Fri, 25 Apr 2025 20:07:57 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4F72FE41C66; Fri, 25 Apr 2025 20:07:57 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v6 3/3] nvme/pci: make PRP list DMA pools per-NUMA-node
Date: Fri, 25 Apr 2025 20:06:36 -0600
Message-ID: <20250426020636.34355-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250426020636.34355-1-csander@purestorage.com>
References: <20250426020636.34355-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_190759_089852_96EF11F5 
X-CRM114-Status: GOOD (  24.36  )
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

NVMe commands with over 8 KB of discontiguous data allocate PRP list
pages from the per-nvme_device dma_pool prp_page_pool or prp_small_pool.
Each call to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool
spinlock. These device-global spinlocks are a significant source of
contention when many CPUs are submitting to the same NVMe devices. On a
workload issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2
NUMA nodes to 23 NVMe devices, we observed 2.4% of CPU time spent in
_raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.

Ideally, the dma_pools would be per-hctx to minimize contention. But
that could impose considerable resource costs in a system with many NVMe
devices and CPUs.

As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
nvme_queue to the set of DMA pools corresponding to its device and its
hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
about half, to 1.2%. Preventing the sharing of PRP list pages across
NUMA nodes also makes them cheaper to initialize.

Link: https://lore.kernel.org/linux-nvme/CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com/T/#u
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 144 +++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 642890ddada5..2c554bb7f984 100644
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
@@ -395,18 +401,67 @@ static int nvme_pci_npages_prp(void)
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
+	prp_pools->large = dma_pool_create_node("prp list page", dev->dev,
+						NVME_CTRL_PAGE_SIZE,
+						NVME_CTRL_PAGE_SIZE, 0,
+						numa_node);
+	if (!prp_pools->large)
+		return ERR_PTR(-ENOMEM);
+
+	if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
+		small_align = 512;
+
+	/* Optimisation for I/Os between 4k and 128k */
+	prp_pools->small = dma_pool_create_node("prp list 256", dev->dev,
+						256, small_align, 0, numa_node);
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
@@ -536,27 +591,28 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
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
@@ -567,17 +623,17 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
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
@@ -591,11 +647,11 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
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
@@ -627,14 +683,14 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
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
@@ -672,11 +728,11 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
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
@@ -697,11 +753,11 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
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
@@ -717,14 +773,14 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
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
@@ -784,16 +840,16 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
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
@@ -824,13 +880,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
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
@@ -841,10 +897,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
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
@@ -864,11 +921,11 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
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
@@ -946,11 +1003,11 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 
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
 
@@ -1036,10 +1093,11 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 		nvme_submit_cmds(nvmeq, &submit_list);
 	*rqlist = requeue_list;
 }
 
 static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
+						struct nvme_queue *nvmeq,
 						struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	if (!iod->meta_sgt.nents) {
@@ -1047,11 +1105,11 @@ static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
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
 
@@ -1059,14 +1117,14 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
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
@@ -2839,39 +2897,10 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
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
 
@@ -3182,11 +3211,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
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
 
@@ -3257,17 +3287,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
@@ -3339,12 +3365,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


