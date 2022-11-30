Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DB0C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TZUdeyEOfLfcufBOP6Ql77W42i4ktgWEl/8c6TROEuA=; b=vwK5490Nev+vaaXwbjQQhQNYAn
	4G0HAb3mJTPD+8an5WYnEOABEWxM5twKpj4xeMGqENy4l7V+rLxQ/eAgwkHAS2v8jix1oYcOVc+t+
	mMdCWh/1UFbB/yYg4y9s+sd4rnvcVQjkX7M7Mb/1pimZUnJnh93V9lUywQwB8rM7NEPEulg4JLwTp
	n9daReFFwcJz4T6ct0iDord3vodRCPQ6A30OTMm2xbEfA5YAoctaUjGyi6jQWrTTWDK8OTg6bKSrZ
	al+vEttd+bgSW4T6TVgdGjOZQSs14lyZlSsjtt6CDLT2+zVgG3vduwByiGhuf+FvERcoqZDDG5oVI
	6ZKv9gIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0RMe-001INc-9a; Wed, 30 Nov 2022 17:59:20 +0000
Received: from [2001:4bb8:192:26e7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0R6n-0017bG-9f; Wed, 30 Nov 2022 17:42:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/5] nvme-pci: use the tagset alloc/free helpers
Date: Wed, 30 Nov 2022 18:42:39 +0100
Message-Id: <20221130174240.227616-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130174240.227616-1-hch@lst.de>
References: <20221130174240.227616-1-hch@lst.de>
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

Use the common helpers to allocate and free the tagsets.  To make this
work the generic nvme_ctrl now needs to be stored in the hctx private
data instead of the nvme_dev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 89 +++++++++--------------------------------
 1 file changed, 18 insertions(+), 71 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d613b4292c0f95..f005e8569266cd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -398,7 +398,7 @@ static int nvme_pci_npages_sgl(void)
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
-	struct nvme_dev *dev = data;
+	struct nvme_dev *dev = to_nvme_dev(data);
 	struct nvme_queue *nvmeq = &dev->queues[0];
 
 	WARN_ON(hctx_idx != 0);
@@ -411,7 +411,7 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 			  unsigned int hctx_idx)
 {
-	struct nvme_dev *dev = data;
+	struct nvme_dev *dev = to_nvme_dev(data);
 	struct nvme_queue *nvmeq = &dev->queues[hctx_idx + 1];
 
 	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
@@ -423,7 +423,7 @@ static int nvme_pci_init_request(struct blk_mq_tag_set *set,
 		struct request *req, unsigned int hctx_idx,
 		unsigned int numa_node)
 {
-	struct nvme_dev *dev = set->driver_data;
+	struct nvme_dev *dev = to_nvme_dev(set->driver_data);
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	nvme_req(req)->ctrl = &dev->ctrl;
@@ -442,7 +442,7 @@ static int queue_irq_offset(struct nvme_dev *dev)
 
 static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
 {
-	struct nvme_dev *dev = set->driver_data;
+	struct nvme_dev *dev = to_nvme_dev(set->driver_data);
 	int i, qoff, offset;
 
 	offset = queue_irq_offset(dev);
@@ -1728,39 +1728,10 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 * queue to flush these to completion.
 		 */
 		nvme_unquiesce_admin_queue(&dev->ctrl);
-		blk_mq_destroy_queue(dev->ctrl.admin_q);
-		blk_put_queue(dev->ctrl.admin_q);
-		blk_mq_free_tag_set(&dev->admin_tagset);
+		nvme_remove_admin_tag_set(&dev->ctrl);
 	}
 }
 
-static int nvme_pci_alloc_admin_tag_set(struct nvme_dev *dev)
-{
-	struct blk_mq_tag_set *set = &dev->admin_tagset;
-
-	set->ops = &nvme_mq_admin_ops;
-	set->nr_hw_queues = 1;
-
-	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	set->timeout = NVME_ADMIN_TIMEOUT;
-	set->numa_node = dev->ctrl.numa_node;
-	set->cmd_size = sizeof(struct nvme_iod);
-	set->flags = BLK_MQ_F_NO_SCHED;
-	set->driver_data = dev;
-
-	if (blk_mq_alloc_tag_set(set))
-		return -ENOMEM;
-	dev->ctrl.admin_tagset = set;
-
-	dev->ctrl.admin_q = blk_mq_init_queue(set);
-	if (IS_ERR(dev->ctrl.admin_q)) {
-		blk_mq_free_tag_set(set);
-		dev->ctrl.admin_q = NULL;
-		return -ENOMEM;
-	}
-	return 0;
-}
-
 static unsigned long db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 {
 	return NVME_REG_DBS + ((nr_io_queues + 1) * 8 * dev->db_stride);
@@ -2515,40 +2486,13 @@ static void nvme_delete_io_queues(struct nvme_dev *dev)
 		__nvme_delete_io_queues(dev, nvme_admin_delete_cq);
 }
 
-static void nvme_pci_alloc_tag_set(struct nvme_dev *dev)
+static unsigned int nvme_pci_nr_maps(struct nvme_dev *dev)
 {
-	struct blk_mq_tag_set * set = &dev->tagset;
-	int ret;
-
-	set->ops = &nvme_mq_ops;
-	set->nr_hw_queues = dev->online_queues - 1;
-	set->nr_maps = 1;
-	if (dev->io_queues[HCTX_TYPE_READ])
-		set->nr_maps = 2;
 	if (dev->io_queues[HCTX_TYPE_POLL])
-		set->nr_maps = 3;
-	set->timeout = NVME_IO_TIMEOUT;
-	set->numa_node = dev->ctrl.numa_node;
-	set->queue_depth = min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-	set->cmd_size = sizeof(struct nvme_iod);
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	set->driver_data = dev;
-
-	/*
-	 * Some Apple controllers requires tags to be unique
-	 * across admin and IO queue, so reserve the first 32
-	 * tags of the IO queue.
-	 */
-	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
-		set->reserved_tags = NVME_AQ_DEPTH;
-
-	ret = blk_mq_alloc_tag_set(set);
-	if (ret) {
-		dev_warn(dev->ctrl.device,
-			"IO queues tagset allocation failed %d\n", ret);
-		return;
-	}
-	dev->ctrl.tagset = set;
+		return 3;
+	if (dev->io_queues[HCTX_TYPE_READ])
+		return 2;
+	return 1;
 }
 
 static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
@@ -2770,7 +2714,7 @@ static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 static void nvme_free_tagset(struct nvme_dev *dev)
 {
 	if (dev->tagset.tags)
-		blk_mq_free_tag_set(&dev->tagset);
+		nvme_remove_io_tag_set(&dev->ctrl);
 	dev->ctrl.tagset = NULL;
 }
 
@@ -3101,7 +3045,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto out_release_iod_mempool;
 
-	result = nvme_pci_alloc_admin_tag_set(dev);
+	result = nvme_alloc_admin_tag_set(&dev->ctrl, &dev->admin_tagset,
+				&nvme_mq_admin_ops, sizeof(struct nvme_iod));
 	if (result)
 		goto out_disable;
 
@@ -3131,12 +3076,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_disable;
 
 	if (dev->online_queues > 1) {
-		nvme_pci_alloc_tag_set(dev);
+		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
+				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
 		nvme_dbbuf_set(dev);
-	} else {
-		dev_warn(dev->ctrl.device, "IO queues not created\n");
 	}
 
+	if (!dev->ctrl.tagset)
+		dev_warn(dev->ctrl.device, "IO queues not created\n");
+
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller live state\n");
-- 
2.30.2


