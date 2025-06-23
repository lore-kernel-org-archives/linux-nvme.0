Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E7AC7EE2A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4dvZH8x/z+zoatdMqg/HCCwdY+57eWLFYcfLppgAEgw=; b=0z2GkXEyAtC+KMLLb6Crb0o8Jk
	giX8wS/CQ1JcOUKTJi3/U+ahcvip4gJ98qfWrUoSCSNfM4DuVAF8VlXG9TcmjKy087isnc3C2lKYw
	JqkmYzKtdZqRzjw4T4IMjvHL4vpgtrIllXvte8a4AN8MVIRN92HyGDdqiYzDyKb9msNYaOcDRWzno
	PUH94bf4pjkWna1BPvlVrl60F7MqZgFLNMJGr+w6+x3PNCK3SB+/jh9DWgIYp6soaHxxTQvZlb9Gw
	7r1GgCIDD68UYnY+hexAqA6Iue3P8PrEntF+xoZKM3c3e00zw+Jg6kiWIhM0aeyZp/c6Gr8Jq6F/1
	0UZ8Bdew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTkt9-00000003XlE-0ZjK;
	Mon, 23 Jun 2025 17:23:23 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThv5-00000002zpO-2C92;
	Mon, 23 Jun 2025 14:13:12 +0000
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
Subject: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Date: Mon, 23 Jun 2025 16:12:25 +0200
Message-ID: <20250623141259.76767-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623141259.76767-1-hch@lst.de>
References: <20250623141259.76767-1-hch@lst.de>
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

Move the average segment size into a separate helper, and return a
tristate to distinguish the case where can use SGL vs where we have to
use SGLs.  This will allow the simplify the code and make more efficient
decisions in follow on changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..bc84438f0523 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -578,6 +578,12 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
+enum nvme_use_sgl {
+	SGL_UNSUPPORTED,
+	SGL_SUPPORTED,
+	SGL_FORCED,
+};
+
 static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
 					      struct request *req)
 {
@@ -587,23 +593,27 @@ static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
 		nvme_req(req)->flags & NVME_REQ_USERCMD;
 }
 
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
-				     int nseg)
+static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
+		struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	unsigned int avg_seg_size;
 
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
+	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
+		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
+			return SGL_FORCED;
+		if (req->nr_integrity_segments > 1)
+			return SGL_FORCED;
+		return SGL_SUPPORTED;
+	}
 
-	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
-		return false;
-	if (!nvmeq->qid)
-		return false;
-	if (nvme_pci_metadata_use_sgls(dev, req))
-		return true;
-	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return nvme_req(req)->flags & NVME_REQ_USERCMD;
-	return true;
+	return SGL_UNSUPPORTED;
+}
+
+static unsigned int nvme_pci_avg_seg_size(struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	return DIV_ROUND_UP(blk_rq_payload_bytes(req), iod->sgt.nents);
 }
 
 static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
@@ -851,6 +861,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	enum nvme_use_sgl use_sgl = nvme_pci_use_sgls(dev, req);
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int rc;
 
@@ -888,7 +899,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_free_sg;
 	}
 
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
+	if (use_sgl == SGL_FORCED ||
+	    (use_sgl == SGL_SUPPORTED &&
+	     (!sgl_threshold || nvme_pci_avg_seg_size(req) >= sgl_threshold)))
 		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);
-- 
2.47.2


