Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC026C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NZBb3+rrPBiSndsrNQl389jDCiyxUTQ5bcI8WyA2tw4=; b=K3v/UYxj6Y6H5iy8NFaChdEwSs
	jC4WHxS+x/iKUBswn6H65Xkr5+5ivnd+rhyvO6TiOv63+AVrdiwowzCMJsHXxlT2wfHoKPg9tYfCL
	VwAFgDzZ2qWpdcwgl28htfjmn/wxukBSMFpmKk2GOeZA+qgIyk7BradGW+ECqJ5GVWDC4bw40WaPY
	K/tpNLgTSBFHzHb3T+dWJ8Bfw22ptM4vPiNhLs1MINBww5nyFFlpZkALA8KKrJn4KOXDo8RqIASwI
	UM58zc+3bIyuoSzytxcDMiHeh68V3+orFm0L+z96aPbZT5tePbaU51b14ev0MACWBWwXQ/Lji6tuG
	hVytc84w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OxV-00AN0z-1A; Sun, 25 Dec 2022 11:14:25 +0000
Received: from [88.128.92.76] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OJH-00A2fP-Af; Sun, 25 Dec 2022 10:32:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hugh Dickins <hughd@google.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme-pci: remove the dev->q_depth field
Date: Sun, 25 Dec 2022 11:32:34 +0100
Message-Id: <20221225103234.226794-5-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221225103234.226794-1-hch@lst.de>
References: <20221225103234.226794-1-hch@lst.de>
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

This field duplicates the sqsize field in the common nvme_ctrl structure,
so remove it and use the common field instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a621dd7a0a8efa..59ef702f910efa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -126,7 +126,6 @@ struct nvme_dev {
 	unsigned max_qid;
 	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
-	u32 q_depth;
 	int io_sqes;
 	u32 db_stride;
 	void __iomem *bar;
@@ -1515,7 +1514,7 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 				int entry_size)
 {
-	int q_depth = dev->q_depth;
+	u16 q_depth = dev->ctrl.sqsize;
 	unsigned q_size_aligned = roundup(q_depth * entry_size,
 					  NVME_CTRL_PAGE_SIZE);
 
@@ -1824,7 +1823,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	int ret = 0;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
-		if (nvme_alloc_queue(dev, i, dev->q_depth)) {
+		if (nvme_alloc_queue(dev, i, dev->ctrl.sqsize)) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -2333,12 +2332,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
 				sizeof(struct nvme_command));
-		if (result > 0) {
-			dev->q_depth = result;
+		if (result > 0)
 			dev->ctrl.sqsize = result;
-		} else {
+		else
 			dev->cmb_use_sqes = false;
-		}
 	}
 
 	do {
@@ -2537,8 +2534,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
-				io_queue_depth);
+	dev->ctrl.sqsize = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
+				 io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
@@ -2557,16 +2554,16 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 * some MacBook7,1 to avoid controller resets and data loss.
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
-		dev->q_depth = 2;
+		dev->ctrl.sqsize = 2;
 		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
 			"set queue depth=%u to work around controller resets\n",
-			dev->q_depth);
+			dev->ctrl.sqsize);
 	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
 		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
 		   NVME_CAP_MQES(dev->ctrl.cap) == 0) {
-		dev->q_depth = 64;
+		dev->ctrl.sqsize = 64;
 		dev_err(dev->ctrl.device, "detected PM1725 NVMe controller, "
-                        "set queue depth=%u\n", dev->q_depth);
+                        "set queue depth=%u\n", dev->ctrl.sqsize);
 	}
 
 	/*
@@ -2574,12 +2571,11 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 * big enough so that we get 32 tags for the admin queue
 	 */
 	if ((dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) &&
-	    (dev->q_depth < (NVME_AQ_DEPTH + 2))) {
-		dev->q_depth = NVME_AQ_DEPTH + 2;
+	    (dev->ctrl.sqsize < NVME_AQ_DEPTH + 2)) {
+		dev->ctrl.sqsize = NVME_AQ_DEPTH + 2;
 		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
-			 dev->q_depth);
+			 dev->ctrl.sqsize);
 	}
-	dev->ctrl.sqsize = dev->q_depth;
 
 	nvme_map_cmb(dev);
 
-- 
2.35.1


