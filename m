Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E62C5B543
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 05:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8gv5fiBdOK+eRadfER0ToDeAvRYKAMPwXDHxAOIVdw0=; b=n8B/rxLZTtQcVduVI0qt+1wZ9h
	Y334KDDX5M2OZ8OnSSJRF/5F653lSXeXYGkasKXIzFo8lG28+pAyHKvle6vubBJfP4x9nXL5qhQZR
	7mYOJiibaAJOx0of/P18lKJRM8zzM9ybAPlZfL5yVipVdtc6VmM6JKCKouEpI5jgCuAs8z7VsZ+va
	UCoiK/QlQH6SDw4nY37TpsxoEvvI67E8nnUcu3Tguvlezqn1OeagDLXDIapjNTit1E5cV7Jw7va5x
	7VQwKZIg+d+9B0dhTeDsnpaLgvgg2E5kZvFCSV4rp5qKsoVTmlwg2vPTA5fThVfY3nhsKSdoYridg
	V+itjiTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCv-00000005nmf-4AMH;
	Tue, 10 Jun 2025 05:07:34 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCt-00000005niO-2trv;
	Tue, 10 Jun 2025 05:07:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into a common helper
Date: Tue, 10 Jun 2025 07:06:43 +0200
Message-ID: <20250610050713.2046316-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610050713.2046316-1-hch@lst.de>
References: <20250610050713.2046316-1-hch@lst.de>
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

nvme_setup_prp_simple and nvme_setup_sgl_simple share a lot of logic.
Merge them into a single helper that makes use of the previously added
use_sgl tristate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 77 +++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0b85c11d3c96..50bb1ebe6810 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -814,42 +814,41 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 	return BLK_STS_OK;
 }
 
-static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
+static blk_status_t nvme_pci_setup_data_simple(struct request *req,
+		enum nvme_use_sgl use_sgl)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
-	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
-
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->first_dma))
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	struct bio_vec bv = req_bvec(req);
+	unsigned int prp1_offset = bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
+	bool prp_possible = prp1_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2;
+	dma_addr_t dma_addr;
+
+	if (!use_sgl && !prp_possible)
+		return BLK_STS_AGAIN;
+	if (is_pci_p2pdma_page(bv.bv_page))
+		return BLK_STS_AGAIN;
+
+	dma_addr = dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0);
+	if (dma_mapping_error(nvmeq->dev->dev, dma_addr))
 		return BLK_STS_RESOURCE;
-	iod->dma_len = bv->bv_len;
-
-	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
-	if (bv->bv_len > first_prp_len)
-		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
-	else
-		cmnd->dptr.prp2 = 0;
-	return BLK_STS_OK;
-}
+	iod->dma_len = bv.bv_len;
 
-static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	if (use_sgl == SGL_FORCED || !prp_possible) {
+		iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+		iod->cmd.common.dptr.sgl.addr = cpu_to_le64(dma_addr);
+		iod->cmd.common.dptr.sgl.length = cpu_to_le32(bv.bv_len);
+		iod->cmd.common.dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
+	} else {
+		unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - prp1_offset;
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->first_dma))
-		return BLK_STS_RESOURCE;
-	iod->dma_len = bv->bv_len;
+		iod->cmd.common.dptr.prp1 = cpu_to_le64(dma_addr);
+		iod->cmd.common.dptr.prp2 = 0;
+		if (bv.bv_len > first_prp_len)
+			iod->cmd.common.dptr.prp2 =
+				cpu_to_le64(dma_addr + first_prp_len);
+	}
 
-	cmnd->flags = NVME_CMD_SGL_METABUF;
-	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
-	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
-	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
 	return BLK_STS_OK;
 }
 
@@ -863,21 +862,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	int rc;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
-		struct bio_vec bv = req_bvec(req);
-
-		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if ((!nvme_ctrl_meta_sgl_supported(&dev->ctrl) ||
-			     !nvme_pci_metadata_use_sgls(req)) &&
-			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
-			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
-				return nvme_setup_prp_simple(dev, req,
-							     &cmnd->rw, &bv);
-
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
-				return nvme_setup_sgl_simple(dev, req,
-							     &cmnd->rw, &bv);
-		}
+		ret = nvme_pci_setup_data_simple(req, use_sgl);
+		if (ret != BLK_STS_AGAIN)
+			return ret;
 	}
 
 	iod->dma_len = 0;
-- 
2.47.2


