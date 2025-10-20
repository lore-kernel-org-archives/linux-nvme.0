Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830A6CCD19F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xogrN/i6h0bInyaAW3BaERbcdzCCZapIWgTtes0uSZg=; b=HquDt14bmA+SajgF4U/S8prs+F
	bGrer45vx0Uovc+1kERERkNTDbUOl01QlekmcRTVM+MUmgsUl8Gvbg15fuubsV3k6a3zIACIarQWx
	RInXv6kzzmZriEY+1lZkHUt8P8HquexKfIX/RvncVY7uUc1MCPdYHb31dy50MJSa4VLbyn7myu0Xk
	K2fEYyvuewXumQ8NtlWoriFyYlcGVpAVmAmGpWKivMpBECnu3QWzTVImtDLWlWIBCdvUtn2iU1fIj
	BVtStIRECphAUmKtwn90L+NnumriIV9Xb3r2gRlC/7LXKb0BbMldUOWfb5rofVMMePqOEWa3L7iU4
	DcogvpPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtFK-0000000EOjL-1I9f;
	Mon, 20 Oct 2025 17:00:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtFJ-0000000EOjC-15ka
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 17:00:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ADFC1602B8;
	Mon, 20 Oct 2025 17:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF041C4CEFE;
	Mon, 20 Oct 2025 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979632;
	bh=GSMtbQxIziDBartMOI3UoueF4pGkRJRkbLHLAUdPIT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDJTxk26YjTNViQxMXa/zV1CGWeeSQVTEbQDTM8NOcw8eI1xLFsYDQ1iier8bEdRW
	 8yHyDhepMuRyhFhOkNNsmU1QFQrmu+6zUZmqeYMc/uf1IHSTEK5vzah4cjh42iHj3T
	 oBUaMNpnoC4Oc3MmgDpDpxogrfayvYH9ER89u85/o4NFHNvkFYkoUttJz9dx9Bqo10
	 BsimoVjtuyOxSm1YLY79ef1hcCtfthQ55hYcbRykZ+m0O6j6PbgZ80LouxUJDEKiIg
	 IEbSwIDT5HeUQqnvxFBppayK7PO81sa2UxqqrD+FZnW3o7qtrBCiljXRModdkg9xLA
	 vP9QJFp5Aq7Aw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of map_page
Date: Mon, 20 Oct 2025 20:00:20 +0300
Message-ID: <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
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

From: Leon Romanovsky <leonro@nvidia.com>

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c         |  4 ++--
 drivers/nvme/host/pci.c    | 27 +++++++++++++++------------
 include/linux/blk-mq-dma.h |  1 +
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 449950029872..4ba7b0323da4 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -93,8 +93,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
-	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
-			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
+			rq_dma_dir(req), 0);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f0..91a8965754f0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -685,20 +685,20 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
-static void nvme_free_prps(struct request *req)
+static void nvme_free_prps(struct request *req, unsigned int attrs)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	unsigned int i;
 
 	for (i = 0; i < iod->nr_dma_vecs; i++)
-		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
-				iod->dma_vecs[i].len, rq_dma_dir(req));
+		dma_unmap_phys(nvmeq->dev->dev, iod->dma_vecs[i].addr,
+			       iod->dma_vecs[i].len, rq_dma_dir(req), attrs);
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
 
 static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
-		struct nvme_sgl_desc *sg_list)
+		struct nvme_sgl_desc *sg_list, unsigned int attrs)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	enum dma_data_direction dir = rq_dma_dir(req);
@@ -707,13 +707,14 @@ static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
 	unsigned int i;
 
 	if (sge->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
-		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sge->addr), len, dir,
+			       attrs);
 		return;
 	}
 
 	for (i = 0; i < len / sizeof(*sg_list); i++)
-		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-			le32_to_cpu(sg_list[i].length), dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir, attrs);
 }
 
 static void nvme_unmap_metadata(struct request *req)
@@ -723,6 +724,7 @@ static void nvme_unmap_metadata(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct device *dma_dev = nvmeq->dev->dev;
 	struct nvme_sgl_desc *sge = iod->meta_descriptor;
+	unsigned int attrs = 0;
 
 	if (iod->flags & IOD_SINGLE_META_SEGMENT) {
 		dma_unmap_page(dma_dev, iod->meta_dma,
@@ -734,10 +736,10 @@ static void nvme_unmap_metadata(struct request *req)
 	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
 					iod->meta_total_len)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
-			nvme_free_sgls(req, sge, &sge[1]);
+			nvme_free_sgls(req, sge, &sge[1], attrs);
 		else
-			dma_unmap_page(dma_dev, iod->meta_dma,
-				       iod->meta_total_len, dir);
+			dma_unmap_phys(dma_dev, iod->meta_dma,
+				       iod->meta_total_len, dir, attrs);
 	}
 
 	if (iod->meta_descriptor)
@@ -750,6 +752,7 @@ static void nvme_unmap_data(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct device *dma_dev = nvmeq->dev->dev;
+	unsigned int attrs = 0;
 
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
@@ -762,9 +765,9 @@ static void nvme_unmap_data(struct request *req)
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, iod->descriptors[0],
-				       &iod->cmd.common.dptr.sgl);
+				       &iod->cmd.common.dptr.sgl, attrs);
 		else
-			nvme_free_prps(req);
+			nvme_free_prps(req, attrs);
 	}
 
 	if (iod->nr_descriptors)
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 51829958d872..faf4dd574c62 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -16,6 +16,7 @@ struct blk_dma_iter {
 	/* Output address range for this iteration */
 	dma_addr_t			addr;
 	u32				len;
+	unsigned int			attrs;
 
 	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
 	blk_status_t			status;

-- 
2.51.0


