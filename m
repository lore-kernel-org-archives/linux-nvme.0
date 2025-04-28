Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E96BC369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJmjFdFzskpzrYnSZcLgkxLxNuKuWaa99jy2gXqX8o4=; b=UJoRQi8y1/C/XcpTg7aeSRxW0M
	u8dE9ec3yFG9uTiQ4sibSeAmfsn/SS+BtW8TcaI4AQt1z2506wRKPOwtGbiD6hplgsBqvx9uBeEDF
	5KrpEFbv97yA4ZtKgVx1gnrQO+01zNMoUwVsYFPN4aN92/P+jzssEhtmSVNj4ftUanQ93dRZpE53x
	AJGH1eNLFD25CF55kXrKuVvYtDZNloWZ/DZ2zr43vQFGKxrVJPA4DBEXPbHwwOG7faHK7/WqwOJpa
	RFRdHLfHUorpQjW6pTKWnagyL+u5deR3ECruZRZ6V49uCXbF6SYT6iE7iHAw30bIzP2l8E5FRWAOl
	SkQYLzgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9OAr-00000006L81-0HUm;
	Mon, 28 Apr 2025 13:05:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Kik-00000005ayh-22cM
	for linux-nvme@bombadil.infradead.org;
	Mon, 28 Apr 2025 09:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tJmjFdFzskpzrYnSZcLgkxLxNuKuWaa99jy2gXqX8o4=; b=WkBd7gkvIJAUmzUdPQlXbzs0+v
	7XK57ktGAmkSMGN2fn44ol6C9g6ij69ScfocBDlVffI/mSdWb+4/vDqmRf/ti3IZ4UGVxE8dExUSc
	e1nRRyYYTOWKYKAkgzF8VPpYwt+lM6pSsFMBDlPMBnG3Us/G5IrQZ6EHgiTknp61TYo/YuTIBY3kw
	epirN7xrAYLAnqlfwW8mstmcn++WBdivUoFFR43T+cMmvi9i43FjFnoxkHZ3nlVmYlE95nbg0oEVj
	rRIBI6JtcjEMPTXItZgqShuXcmiCzONeZUACOtCKJ1L2QKobYxA9OXtcIDldzO29adWpTkqs66ksT
	0rznPmzw==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9Kih-0000000CdHZ-0a0h
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:24:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B9B604A943;
	Mon, 28 Apr 2025 09:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E77C4CEE9;
	Mon, 28 Apr 2025 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745832249;
	bh=o9rUJvhmsdRR03YWE52xBlknh79MIWTsCmYUjg7Cbqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltrLv3YB0fnSj7N1PfR4mUaSmfOQaR15pMstnUdv3blO6wa7TLBiupO1Qc9uTWN/D
	 qL+Dmw0jaiH/F6BDohX9UQbeve9saTFctay+nWuJmg3kPhQBkYu5ai/9vrvFW5M0MT
	 jt7zztCyEcSj/YyXMxnnO/gFuND0R6EdJ8q4A3kUfd4+Sa5OSwKuHZD3FtoKTvChVU
	 xbVgHwQ1XYVasCaroM1RE0VY4rdG9FRfHhGx0Smf61xyRArCRJ5fe+VCTHRPBaQzEp
	 u2o8MiK33JiaLeDxoJ1LBaOJ0MElGPSOJm1lzFyZkvvzDK1Q9Ei4V7lveThmLGVJ57
	 8zI62VvtG9iuA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v10 22/24] nvme-pci: use a better encoding for small prp pool allocations
Date: Mon, 28 Apr 2025 12:22:28 +0300
Message-ID: <e34650ec5a9de3f30079aa432dffa663298f67e7.1745831017.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745831017.git.leon@kernel.org>
References: <cover.1745831017.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_102411_638392_F996B501 
X-CRM114-Status: GOOD (  25.11  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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

From: Christoph Hellwig <hch@lst.de>

There is plenty of unused space in the iod next to nr_descriptors.
Add a separate flag to encode that the transfer is using the full
page sized pool, and use a normal 0..n count for the number of
descriptors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jens Axboe <axboe@kernel.dk>
[ Leon: changed original bool variable to be flag as was proposed by Kanchan ]
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 94 ++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 638e759b29ad..270fb5146b5b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -44,6 +44,7 @@
 #define NVME_MAX_SEGS	128
 #define NVME_MAX_META_SEGS 15
 #define NVME_MAX_NR_DESCRIPTORS	5
+#define NVME_SMALL_DESCRIPTOR_SIZE 256
 
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
@@ -219,6 +220,10 @@ struct nvme_queue {
 	struct completion delete_done;
 };
 
+enum {
+	IOD_LARGE_DESCRIPTORS = 1 << 0, /* uses the full page sized descriptor pool */
+};
+
 /*
  * The nvme_iod describes the data in an I/O.
  */
@@ -226,8 +231,8 @@ struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
 	bool aborted;
-	/* # of PRP/SGL descriptors: (0 for small pool) */
-	s8 nr_descriptors;
+	u8 nr_descriptors;	/* # of PRP/SGL descriptors */
+	u8 flags;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
@@ -529,13 +534,27 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 	return true;
 }
 
-static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
+static inline struct dma_pool *nvme_dma_pool(struct nvme_dev *dev,
+		struct nvme_iod *iod)
+{
+	if (iod->flags & IOD_LARGE_DESCRIPTORS)
+		return dev->prp_page_pool;
+	return dev->prp_small_pool;
+}
+
+static void nvme_free_descriptors(struct nvme_dev *dev, struct request *req)
 {
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	dma_addr_t dma_addr = iod->first_dma;
 	int i;
 
+	if (iod->nr_descriptors == 1) {
+		dma_pool_free(nvme_dma_pool(dev, iod), iod->descriptors[0],
+				dma_addr);
+		return;
+	}
+
 	for (i = 0; i < iod->nr_descriptors; i++) {
 		__le64 *prp_list = iod->descriptors[i];
 		dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
@@ -558,15 +577,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	WARN_ON_ONCE(!iod->sgt.nents);
 
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
-
-	if (iod->nr_descriptors == 0)
-		dma_pool_free(dev->prp_small_pool, iod->descriptors[0],
-			      iod->first_dma);
-	else if (iod->nr_descriptors == 1)
-		dma_pool_free(dev->prp_page_pool, iod->descriptors[0],
-			      iod->first_dma);
-	else
-		nvme_free_prps(dev, req);
+	nvme_free_descriptors(dev, req);
 	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 }
 
@@ -588,7 +599,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		struct request *req, struct nvme_rw_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct dma_pool *pool;
 	int length = blk_rq_payload_bytes(req);
 	struct scatterlist *sg = iod->sgt.sgl;
 	int dma_len = sg_dma_len(sg);
@@ -596,7 +606,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
 	dma_addr_t prp_dma;
-	int nprps, i;
+	int i;
 
 	length -= (NVME_CTRL_PAGE_SIZE - offset);
 	if (length <= 0) {
@@ -618,27 +628,23 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		goto done;
 	}
 
-	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
-	if (nprps <= (256 / 8)) {
-		pool = dev->prp_small_pool;
-		iod->nr_descriptors = 0;
-	} else {
-		pool = dev->prp_page_pool;
-		iod->nr_descriptors = 1;
-	}
+	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) >
+	    NVME_SMALL_DESCRIPTOR_SIZE / sizeof(__le64))
+		iod->flags |= IOD_LARGE_DESCRIPTORS;
 
-	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
-	if (!prp_list) {
-		iod->nr_descriptors = -1;
+	prp_list = dma_pool_alloc(nvme_dma_pool(dev, iod), GFP_ATOMIC,
+			&prp_dma);
+	if (!prp_list)
 		return BLK_STS_RESOURCE;
-	}
-	iod->descriptors[0] = prp_list;
+	iod->descriptors[iod->nr_descriptors++] = prp_list;
 	iod->first_dma = prp_dma;
 	i = 0;
 	for (;;) {
 		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
 			__le64 *old_prp_list = prp_list;
-			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
+
+			prp_list = dma_pool_alloc(dev->prp_page_pool,
+					GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
 				goto free_prps;
 			iod->descriptors[iod->nr_descriptors++] = prp_list;
@@ -665,7 +671,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
 	return BLK_STS_OK;
 free_prps:
-	nvme_free_prps(dev, req);
+	nvme_free_descriptors(dev, req);
 	return BLK_STS_RESOURCE;
 bad_sgl:
 	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
@@ -694,7 +700,6 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		struct request *req, struct nvme_rw_command *cmd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sg = iod->sgt.sgl;
 	unsigned int entries = iod->sgt.nents;
@@ -709,21 +714,13 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		return BLK_STS_OK;
 	}
 
-	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
-		pool = dev->prp_small_pool;
-		iod->nr_descriptors = 0;
-	} else {
-		pool = dev->prp_page_pool;
-		iod->nr_descriptors = 1;
-	}
+	if (entries > NVME_SMALL_DESCRIPTOR_SIZE / sizeof(*sg_list))
+		iod->flags |= IOD_LARGE_DESCRIPTORS;
 
-	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
-	if (!sg_list) {
-		iod->nr_descriptors = -1;
+	sg_list = dma_pool_alloc(nvme_dma_pool(dev, iod), GFP_ATOMIC, &sgl_dma);
+	if (!sg_list)
 		return BLK_STS_RESOURCE;
-	}
-
-	iod->descriptors[0] = sg_list;
+	iod->descriptors[iod->nr_descriptors++] = sg_list;
 	iod->first_dma = sgl_dma;
 
 	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
@@ -915,7 +912,8 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	blk_status_t ret;
 
 	iod->aborted = false;
-	iod->nr_descriptors = -1;
+	iod->nr_descriptors = 0;
+	iod->flags = 0;
 	iod->sgt.nents = 0;
 	iod->meta_sgt.nents = 0;
 
@@ -2833,7 +2831,7 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
-	size_t small_align = 256;
+	size_t small_align = NVME_SMALL_DESCRIPTOR_SIZE;
 
 	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
 						NVME_CTRL_PAGE_SIZE,
@@ -2841,12 +2839,14 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 	if (!dev->prp_page_pool)
 		return -ENOMEM;
 
+	BUILD_BUG_ON(NVME_SMALL_DESCRIPTOR_SIZE != 256);
 	if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
-		small_align = 512;
+		small_align *= 2;
 
 	/* Optimisation for I/Os between 4k and 128k */
 	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, small_align, 0);
+					      NVME_SMALL_DESCRIPTOR_SIZE,
+					      small_align, 0);
 	if (!dev->prp_small_pool) {
 		dma_pool_destroy(dev->prp_page_pool);
 		return -ENOMEM;
-- 
2.49.0


