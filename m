Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF60AC83F07
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZUQRwYhb/ZykvL/nRdtL4JQYk+Edm5nb1PWYEDpasY=; b=Wr+ab4Zzmu2+F8Run9SnUmpVS9
	8ERxKYCA6aIHy7RIFIMrQ7oc12yx6fTL9BFPyWsGUDSuK1lI43VrGx4zsdlN1MFE6/pItKG3F3M4q
	MpI8hc/swMdVfwbTap0g6Sz8ydag0x0FCxO0A1lXRpDeHLxEZNe8SLnWeuP5OZDyhmtsHRWdxUoi0
	L1bnSRboq/0ECGERCsONG0k+zjMjDmnCFRg7sTPSHbR9fhcK9M+VWVNkD4G2qviH/fZcvr6epn9Tr
	ytNZkgdqA+dPxQrPgJf+oK5INuO7A9EmT0iDQjI6w57/qaiwZ1C3r/N0Ikjtxq9N4Bn98oiO04Pwh
	2eqG01dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYn2F-00000002k2b-0785;
	Mon, 07 Jul 2025 14:41:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYmr2-00000002i5s-08On
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 14:30:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 699594441B;
	Mon,  7 Jul 2025 14:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6547C4CEE3;
	Mon,  7 Jul 2025 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751898599;
	bh=W7OMulYsdkMvVQonvMBY/Y63DL1pHZW/EvGAPrdfPYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqBWq4BNgjPAVdmrcgVQDz61YCoy4vezIqgtWVqy//4arTH5NjHDYEUcBi+o5Wd8s
	 W5czz4aHWmsr/bBtfyR50ozHMhEKqS3weCm2O2wsGsy4T6nATXsBLM+HFbos2ARgN3
	 uO6TGmdGTcXcH0jn0tlTubVYWjzB7ZHmOKB36yAdFRBhtCk3a6eNL4zIS7YOpxuoiZ
	 d5G1Y3yt9x36/AJAodlF24j8R2noAqeM0GDqXC9x+FHKirsFTV3TX7Cd5oASybqaB1
	 nwrUQXsWkX0iMqEBZZwzJDePPO9X+nJHQqgqrD4CuutdqNUK4rgTdw1Ty2RuS7praD
	 5k8Jrpt6DUa0w==
Date: Mon, 7 Jul 2025 08:29:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, ben.copeland@linaro.org,
	leon@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <aGvZ5Xk5L66sNWJL@kbusch-mbp>
References: <20250707125223.3022531-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707125223.3022531-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_073000_123954_291B6C68 
X-CRM114-Status: GOOD (  35.82  )
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

On Mon, Jul 07, 2025 at 02:52:23PM +0200, Christoph Hellwig wrote:
> While the reconstruction is easy and works fine for the SGL path, where
> the on the wire representation maps 1:1 to DMA mappings, the code to
> reconstruct the DMA mapping ranges from PRPs can't always work, as a
> given PRP layout can come from different DMA mappings, and the current
> code doesn't even always get that right.

Given it works fine for SGL, how do you feel about unconditionally
creating an NVMe SGL, and then call some "nvme_sgl_to_prp()" helper only
when needed? This means we only have one teardown path that matches the
setup. 

This is something I hacked up over the weekend. It's only lightly
tested, and I know there's a bug somewhere here with the chainging, but
it's a start.

---
 drivers/nvme/host/pci.c | 342 +++++++++++++++++++++++++--------------------------------
 1 file changed, 150 insertions(+), 192 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 10aa04879d6996..7ef56775e3be9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -41,7 +41,7 @@
  * Arbitrary upper bound.
  */
 #define NVME_MAX_BYTES		SZ_8M
-#define NVME_MAX_NR_DESCRIPTORS	5
+#define NVME_MAX_NR_DESCRIPTORS	6
 
 /*
  * For data SGLs we support a single descriptors worth of SGL entries.
@@ -70,7 +70,7 @@
 	(NVME_MAX_BYTES + 2 * (NVME_CTRL_PAGE_SIZE - 1))
 
 static_assert(MAX_PRP_RANGE / NVME_CTRL_PAGE_SIZE <=
-	(1 /* prp1 */ + NVME_MAX_NR_DESCRIPTORS * PRPS_PER_PAGE));
+	(1 /* prp1 */ + (NVME_MAX_NR_DESCRIPTORS - 1) * PRPS_PER_PAGE));
 
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
@@ -273,6 +273,7 @@ struct nvme_iod {
 	unsigned int total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
+	struct nvme_sgl_desc sgl;
 
 	dma_addr_t meta_dma;
 	struct nvme_sgl_desc *meta_descriptor;
@@ -644,99 +645,61 @@ static inline dma_addr_t nvme_pci_first_desc_dma_addr(struct nvme_command *cmd)
 	return le64_to_cpu(cmd->common.dptr.prp2);
 }
 
-static void nvme_free_descriptors(struct request *req)
+static void nvme_free_descriptors(struct request *req, struct nvme_iod *iod)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	dma_addr_t dma_addr = nvme_pci_first_desc_dma_addr(&iod->cmd);
-	int i;
+	struct dma_pool *pool;
+	dma_addr_t dma_addr;
+	int i = 0;
 
-	if (iod->nr_descriptors == 1) {
-		dma_pool_free(nvme_dma_pool(nvmeq, iod), iod->descriptors[0],
-				dma_addr);
-		return;
+	if (iod->sgl.type == NVME_SGL_FMT_LAST_SEG_DESC << 4) {
+		struct nvme_sgl_desc *sg_list = iod->descriptors[0];
+		unsigned int dma_len = le32_to_cpu(iod->sgl.length);
+		unsigned int nr_entries = dma_len / sizeof(*sg_list);
+
+		if (nr_entries <= NVME_SMALL_POOL_SIZE / sizeof(__le64))
+			pool = nvmeq->descriptor_pools.small;
+		else
+			pool = nvmeq->descriptor_pools.large;
+
+		dma_addr = le64_to_cpu(iod->sgl.addr);
+		dma_pool_free(pool, iod->descriptors[i++], dma_addr);
 	}
 
-	for (i = 0; i < iod->nr_descriptors; i++) {
+	pool = nvme_dma_pool(nvmeq, iod);
+	for (; i < iod->nr_descriptors; i++) {
 		__le64 *prp_list = iod->descriptors[i];
 		dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
 
-		dma_pool_free(nvmeq->descriptor_pools.large, prp_list,
-				dma_addr);
+		dma_pool_free(pool, prp_list, dma_addr);
 		dma_addr = next_dma_addr;
 	}
 }
 
-static void nvme_free_prps(struct request *req)
+static void nvme_free_sgls(struct request *req, struct nvme_iod *iod)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	struct device *dma_dev = nvmeq->dev->dev;
+	unsigned int dma_len = le32_to_cpu(iod->sgl.length);
 	enum dma_data_direction dir = rq_dma_dir(req);
-	int length = iod->total_len;
-	dma_addr_t dma_addr;
-	int i, desc;
-	__le64 *prp_list;
-	u32 dma_len;
-
-	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
-	dma_len = min_t(u32, length,
-		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
-	length -= dma_len;
-	if (!length) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		return;
-	}
-
-	if (length <= NVME_CTRL_PAGE_SIZE) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
-		dma_unmap_page(dma_dev, dma_addr, length, dir);
-		return;
-	}
-
-	i = 0;
-	desc = 0;
-	prp_list = iod->descriptors[desc];
-	do {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
-			prp_list = iod->descriptors[++desc];
-			i = 0;
-		}
-
-		dma_addr = le64_to_cpu(prp_list[i++]);
-		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
-		length -= dma_len;
-	} while (length);
-}
-
-static void nvme_free_sgls(struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct device *dma_dev = nvmeq->dev->dev;
-	dma_addr_t sqe_dma_addr = le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
-	unsigned int sqe_dma_len = le32_to_cpu(iod->cmd.common.dptr.sgl.length);
-	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
-	enum dma_data_direction dir = rq_dma_dir(req);
 
-	if (iod->nr_descriptors) {
-		unsigned int nr_entries = sqe_dma_len / sizeof(*sg_list), i;
+	if (iod->sgl.type == NVME_SGL_FMT_LAST_SEG_DESC << 4) {
+		struct nvme_sgl_desc *sg_list = iod->descriptors[0];
+		unsigned int i, nr_entries = dma_len / sizeof(*sg_list);
 
 		for (i = 0; i < nr_entries; i++)
 			dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
 				le32_to_cpu(sg_list[i].length), dir);
 	} else {
-		dma_unmap_page(dma_dev, sqe_dma_addr, sqe_dma_len, dir);
+		dma_unmap_page(dma_dev, le64_to_cpu(iod->sgl.addr), dma_len, dir);
 	}
 }
 
 static void nvme_unmap_data(struct request *req)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct device *dma_dev = nvmeq->dev->dev;
 
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
@@ -747,137 +710,116 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
 
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
-		if (nvme_pci_cmd_use_sgl(&iod->cmd))
-			nvme_free_sgls(req);
-		else
-			nvme_free_prps(req);
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len))
+		nvme_free_sgls(req, iod);
+	if (iod->nr_descriptors)
+		nvme_free_descriptors(req, iod);
+}
+
+static blk_status_t nvme_pci_setup_prp_list(dma_addr_t dma_addr,
+				unsigned int dma_len, unsigned int *index,
+				__le64 **pprp_list, struct nvme_iod *iod,
+				struct nvme_queue *nvmeq)
+{
+	__le64 *prp_list = *pprp_list;
+	int i = *index;
+
+	for (;;) {
+		unsigned int prp_len = min(dma_len, NVME_CTRL_PAGE_SIZE);
+
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+			__le64 *old_prp_list = prp_list;
+			dma_addr_t prp_list_dma;
+
+			BUG_ON(iod->nr_descriptors >= NVME_MAX_NR_DESCRIPTORS);
+			prp_list = dma_pool_alloc(nvmeq->descriptor_pools.large,
+						  GFP_ATOMIC, &prp_list_dma);
+			if (!prp_list)
+				return BLK_STS_RESOURCE;
+
+			iod->descriptors[iod->nr_descriptors++] = prp_list;
+			prp_list[0] = old_prp_list[i - 1];
+			old_prp_list[i - 1] = cpu_to_le64(prp_list_dma);
+			i = 1;
+		}
+
+		prp_list[i++] = cpu_to_le64(dma_addr);
+		dma_len -= prp_len;
+		if (dma_len == 0)
+			break;
+		dma_addr += prp_len;
 	}
 
-	if (iod->nr_descriptors)
-		nvme_free_descriptors(req);
+	*index = i;
+	*pprp_list = prp_list;
+	return BLK_STS_OK;
 }
 
-static blk_status_t nvme_pci_setup_data_prp(struct request *req,
-		struct blk_dma_iter *iter)
+static blk_status_t nvme_pci_sgl_to_prp(struct request *req,
+					struct nvme_iod *iod)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	unsigned int length = blk_rq_payload_bytes(req);
+	unsigned int dma_len, prp_len, entries, j, i = 0;
 	dma_addr_t prp1_dma, prp2_dma = 0;
-	unsigned int prp_len, i;
+	struct nvme_sgl_desc *sg_list;
+	struct dma_pool *pool;
+	dma_addr_t dma_addr;
 	__le64 *prp_list;
+	blk_status_t ret;
 
-	/*
-	 * PRP1 always points to the start of the DMA transfers.
-	 *
-	 * This is the only PRP (except for the list entries) that could be
-	 * non-aligned.
-	 */
-	prp1_dma = iter->addr;
-	prp_len = min(length, NVME_CTRL_PAGE_SIZE -
-			(iter->addr & (NVME_CTRL_PAGE_SIZE - 1)));
-	iod->total_len += prp_len;
-	iter->addr += prp_len;
-	iter->len -= prp_len;
-	length -= prp_len;
-	if (!length)
-		goto done;
-
-	if (!iter->len) {
-		if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
-				&iod->dma_state, iter)) {
-			if (WARN_ON_ONCE(!iter->status))
-				goto bad_sgl;
-			goto done;
-		}
+	if (iod->sgl.type == NVME_SGL_FMT_LAST_SEG_DESC << 4) {
+		entries = iod->sgl.length / sizeof(*sg_list);
+		sg_list = iod->descriptors[0];
+	} else {
+		entries = 1;
+		sg_list = &iod->sgl;
+	}
+
+	dma_addr = le64_to_cpu(sg_list[i].addr);
+	dma_len = le32_to_cpu(sg_list[i].length);
+	prp1_dma = dma_addr;
+	prp_len = min(dma_len, NVME_CTRL_PAGE_SIZE -
+			(dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
+	dma_len -= prp_len;
+	if (!dma_len) {
+		if (++i == entries)
+			return BLK_STS_OK;
+		dma_addr = le64_to_cpu(sg_list[i].addr);
+		dma_len = le32_to_cpu(sg_list[i].length);
+	} else {
+		dma_addr += prp_len;
 	}
 
-	/*
-	 * PRP2 is usually a list, but can point to data if all data to be
-	 * transferred fits into PRP1 + PRP2:
-	 */
-	if (length <= NVME_CTRL_PAGE_SIZE) {
-		prp2_dma = iter->addr;
-		iod->total_len += length;
+	if (i + 1 == entries && dma_len <= NVME_CTRL_PAGE_SIZE) {
+		prp2_dma = dma_addr;
 		goto done;
 	}
 
-	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
+	if (DIV_ROUND_UP(iod->total_len - prp_len, NVME_CTRL_PAGE_SIZE) <=
 	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
 		iod->flags |= IOD_SMALL_DESCRIPTOR;
 
-	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
-			&prp2_dma);
-	if (!prp_list) {
-		iter->status = BLK_STS_RESOURCE;
-		goto done;
-	}
-	iod->descriptors[iod->nr_descriptors++] = prp_list;
+	pool = nvme_dma_pool(nvmeq, iod);
+	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp2_dma);
+	if (!prp_list)
+		return BLK_STS_RESOURCE;
 
-	i = 0;
+	j = 0;
 	for (;;) {
-		prp_list[i++] = cpu_to_le64(iter->addr);
-		prp_len = min(length, NVME_CTRL_PAGE_SIZE);
-		if (WARN_ON_ONCE(iter->len < prp_len))
-			goto bad_sgl;
-
-		iod->total_len += prp_len;
-		iter->addr += prp_len;
-		iter->len -= prp_len;
-		length -= prp_len;
-		if (!length)
-			break;
-
-		if (iter->len == 0) {
-			if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
-					&iod->dma_state, iter)) {
-				if (WARN_ON_ONCE(!iter->status))
-					goto bad_sgl;
-				goto done;
-			}
-		}
-
-		/*
-		 * If we've filled the entire descriptor, allocate a new that is
-		 * pointed to be the last entry in the previous PRP list.  To
-		 * accommodate for that move the last actual entry to the new
-		 * descriptor.
-		 */
-		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
-			__le64 *old_prp_list = prp_list;
-			dma_addr_t prp_list_dma;
-
-			prp_list = dma_pool_alloc(nvmeq->descriptor_pools.large,
-					GFP_ATOMIC, &prp_list_dma);
-			if (!prp_list) {
-				iter->status = BLK_STS_RESOURCE;
-				goto done;
-			}
-			iod->descriptors[iod->nr_descriptors++] = prp_list;
+		ret = nvme_pci_setup_prp_list(dma_addr, dma_len, &j, &prp_list,
+						iod, nvmeq);
+		if (ret)
+			return ret;
 
-			prp_list[0] = old_prp_list[i - 1];
-			old_prp_list[i - 1] = cpu_to_le64(prp_list_dma);
-			i = 1;
-		}
+		if (++i == entries)
+			break;
+		dma_addr = le64_to_cpu(sg_list[i].addr);
+		dma_len = le32_to_cpu(sg_list[i].length);
 	}
-
 done:
-	/*
-	 * nvme_unmap_data uses the DPT field in the SQE to tear down the
-	 * mapping, so initialize it even for failures.
-	 */
 	iod->cmd.common.dptr.prp1 = cpu_to_le64(prp1_dma);
 	iod->cmd.common.dptr.prp2 = cpu_to_le64(prp2_dma);
-	if (unlikely(iter->status))
-		nvme_unmap_data(req);
-	return iter->status;
-
-bad_sgl:
-	dev_err_once(nvmeq->dev->dev,
-		"Incorrectly formed request for payload:%d nents:%d\n",
-		blk_rq_payload_bytes(req), blk_rq_nr_phys_segments(req));
-	return BLK_STS_IOERR;
+	return ret;
 }
 
 static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
@@ -897,49 +839,50 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 }
 
 static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
-		struct blk_dma_iter *iter)
+		struct nvme_iod *iod, struct blk_dma_iter *iter)
+
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	unsigned int entries = blk_rq_nr_phys_segments(req), mapped = 0;
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	unsigned int entries = blk_rq_nr_phys_segments(req);
 	struct nvme_sgl_desc *sg_list;
+	struct dma_pool *pool;
 	dma_addr_t sgl_dma;
-	unsigned int mapped = 0;
-
-	/* set the transfer type as SGL */
-	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_sgl_set_data(&iod->sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
 
 	if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
-		iod->flags |= IOD_SMALL_DESCRIPTOR;
+		pool = nvmeq->descriptor_pools.small;
+	else
+		pool = nvmeq->descriptor_pools.large;
 
-	sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
-			&sgl_dma);
+	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
 	if (!sg_list)
 		return BLK_STS_RESOURCE;
-	iod->descriptors[iod->nr_descriptors++] = sg_list;
 
+	iod->descriptors[iod->nr_descriptors++] = sg_list;
 	do {
 		if (WARN_ON_ONCE(mapped == entries)) {
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
+
 		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, &iod->dma_state,
 				iter));
 
-	nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma, mapped);
 	if (unlikely(iter->status))
-		nvme_free_sgls(req);
+		nvme_free_sgls(req, iod);
+	else
+		nvme_pci_sgl_set_seg(&iod->sgl, sgl_dma, mapped);
 	return iter->status;
 }
 
+
 static blk_status_t nvme_pci_setup_data_simple(struct request *req,
 		enum nvme_use_sgl use_sgl)
 {
@@ -979,6 +922,13 @@ static blk_status_t nvme_pci_setup_data_simple(struct request *req,
 	return BLK_STS_OK;
 }
 
+static inline bool nvme_check_sgl_threshold(struct request *req,
+					enum nvme_use_sgl use_sgl)
+{
+	return use_sgl == SGL_SUPPORTED && sgl_threshold &&
+		nvme_pci_avg_seg_size(req) >= sgl_threshold;
+}
+
 static blk_status_t nvme_map_data(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1001,11 +951,18 @@ static blk_status_t nvme_map_data(struct request *req)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
 
-	if (use_sgl == SGL_FORCED ||
-	    (use_sgl == SGL_SUPPORTED &&
-	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
-		return nvme_pci_setup_data_sgl(req, &iter);
-	return nvme_pci_setup_data_prp(req, &iter);
+	ret = nvme_pci_setup_data_sgl(req, iod, &iter);
+	if (ret)
+		return ret;
+
+	if (use_sgl == SGL_FORCED || nvme_check_sgl_threshold(req, use_sgl)) {
+		iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+		iod->cmd.common.dptr.sgl = iod->sgl;
+	} else {
+		ret = nvme_pci_sgl_to_prp(req, iod);
+	}
+
+	return ret;
 }
 
 static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
@@ -1075,6 +1032,7 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->flags = 0;
 	iod->nr_descriptors = 0;
 	iod->total_len = 0;
+	iod->sgl.type = 0;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
--

