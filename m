Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99969C5B543
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 05:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCo2ImpgmdhL2lI9YPHJoAms+C0Dytco15Yvs7ulJkE=; b=K318OYfFQbrldy5tR8ObDlr5qe
	1oQ5n5Ithxqv8W5FAAIoQTTsi6r4S2e97W6oaw1GM8KXzKZm9cU9tw/LzLZ7vGm+LzO62OKHzun/H
	Wk3CLIQ3T7zy2EGzZhrZ06ISYWivrpwkzOMoaGwfJFCPdpbajmzxKU5XdQ4cRiuj1NaxfqirRxnDz
	6WOl47vv4xY6Hv6Y0jc2fHj/A1m0mh7ZJlaW76JJ33Np73+/yUF6ZQ77gROocZDzcxO4TbvC8ESoU
	MUCqRTzPbpaDYC68SA2GYnKyck791OqJ//NB+XmeBgBTDRdb6j3VrNTJao8gnAcC/slKNT5u+WY3V
	vz+KNWjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCp-00000005ngz-0MAo;
	Tue, 10 Jun 2025 05:07:27 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCm-00000005nep-3VZM;
	Tue, 10 Jun 2025 05:07:25 +0000
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
Subject: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Date: Tue, 10 Jun 2025 07:06:41 +0200
Message-ID: <20250610050713.2046316-4-hch@lst.de>
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

Move the nvme_ctrl_meta_sgl_supported into the callers.  2 out of
three already have it, and the third will be simplified in follow on
patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..449a9950b46c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -578,11 +578,8 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	spin_unlock(&nvmeq->sq_lock);
 }
 
-static inline bool nvme_pci_metadata_use_sgls(struct nvme_dev *dev,
-					      struct request *req)
+static inline bool nvme_pci_metadata_use_sgls(struct request *req)
 {
-	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
-		return false;
 	return req->nr_integrity_segments > 1 ||
 		nvme_req(req)->flags & NVME_REQ_USERCMD;
 }
@@ -599,7 +596,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 		return false;
 	if (!nvmeq->qid)
 		return false;
-	if (nvme_pci_metadata_use_sgls(dev, req))
+	if (nvme_pci_metadata_use_sgls(req))
 		return true;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return nvme_req(req)->flags & NVME_REQ_USERCMD;
@@ -858,7 +855,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (!nvme_pci_metadata_use_sgls(dev, req) &&
+			if ((!nvme_ctrl_meta_sgl_supported(&dev->ctrl) ||
+			     !nvme_pci_metadata_use_sgls(req)) &&
 			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
 			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
@@ -981,7 +979,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
-	    nvme_pci_metadata_use_sgls(dev, req))
+	    nvme_pci_metadata_use_sgls(req))
 		return nvme_pci_setup_meta_sgls(dev, req);
 	return nvme_pci_setup_meta_mptr(dev, req);
 }
-- 
2.47.2


