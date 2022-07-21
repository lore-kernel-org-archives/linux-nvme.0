Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000C5CCA488
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hzFyeSYoCResq3W+Jbg6TPKLiz9Mm4+1sckLQ1ZIa+Y=; b=jnqaX1SLdJ6xGgPUj96XDCWMHB
	gKAhBg+fdywcXrqihEaEOOTO931nYHFa57uhXwvBgfiD1tK6WomIAswme5lkn1kV98lyISo0aKl2A
	9n7pWi2HS8PFIN6KGIMO5rOGNh6J3G08bmJFQm8cWioe4PEe9pkvFcI6Bz8dqd2Fecloey1mVkCNx
	z7+48LjNvCwnnGKwBWZaPd0zwMvk2nxVfKIedEkUpKV0ZZTRGoqsQVzZT2OP4SGI0mI8ZgNPsY3ot
	Zb6umoFyyiIqU+wopV6oooETB11u77DE9yZKvo0YfpXrBFExD/WEYSB+9pCJ3GtoNbhCXbUmePOxW
	p3xA7zag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPcZ-000yYZ-8d; Thu, 21 Jul 2022 06:25:15 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPcV-000ySU-4t; Thu, 21 Jul 2022 06:25:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme-pci: split nvme_dev_add
Date: Thu, 21 Jul 2022 08:25:04 +0200
Message-Id: <20220721062506.1712176-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721062506.1712176-1-hch@lst.de>
References: <20220721062506.1712176-1-hch@lst.de>
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

Split nvme_dev_add into a helper to actually allocate the tag set, and
one that just update the number of queues.  Add a local variable for
the tag_set to clean up the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 72 +++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ceccd8331a76e..61866951dcce5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2533,47 +2533,45 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	return true;
 }
 
-static void nvme_dev_add(struct nvme_dev *dev)
+static void nvme_pci_alloc_tag_set(struct nvme_dev *dev)
 {
+	struct blk_mq_tag_set * set = &dev->tagset;
 	int ret;
 
-	if (!dev->ctrl.tagset) {
-		dev->tagset.ops = &nvme_mq_ops;
-		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.nr_maps = 2; /* default + read */
-		if (dev->io_queues[HCTX_TYPE_POLL])
-			dev->tagset.nr_maps++;
-		dev->tagset.timeout = NVME_IO_TIMEOUT;
-		dev->tagset.numa_node = dev->ctrl.numa_node;
-		dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth,
-						BLK_MQ_MAX_DEPTH) - 1;
-		dev->tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
-		dev->tagset.driver_data = dev;
-
-		/*
-		 * Some Apple controllers requires tags to be unique
-		 * across admin and IO queue, so reserve the first 32
-		 * tags of the IO queue.
-		 */
-		if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
-			dev->tagset.reserved_tags = NVME_AQ_DEPTH;
+	set->ops = &nvme_mq_ops;
+	set->nr_hw_queues = dev->online_queues - 1;
+	set->nr_maps = 2; /* default + read */
+	if (dev->io_queues[HCTX_TYPE_POLL])
+		set->nr_maps++;
+	set->timeout = NVME_IO_TIMEOUT;
+	set->numa_node = dev->ctrl.numa_node;
+	set->queue_depth = min_t(unsigned, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
+	set->cmd_size = sizeof(struct nvme_iod);
+	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	set->driver_data = dev;
 
-		ret = blk_mq_alloc_tag_set(&dev->tagset);
-		if (ret) {
-			dev_warn(dev->ctrl.device,
-				"IO queues tagset allocation failed %d\n", ret);
-			return;
-		}
-		dev->ctrl.tagset = &dev->tagset;
-	} else {
-		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
+	/*
+	 * Some Apple controllers requires tags to be unique
+	 * across admin and IO queue, so reserve the first 32
+	 * tags of the IO queue.
+	 */
+	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
+		set->reserved_tags = NVME_AQ_DEPTH;
 
-		/* Free previously allocated queues that are no longer usable */
-		nvme_free_queues(dev, dev->online_queues);
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret) {
+		dev_warn(dev->ctrl.device,
+			"IO queues tagset allocation failed %d\n", ret);
+		return;
 	}
+	dev->ctrl.tagset = set;
+}
 
-	nvme_dbbuf_set(dev);
+static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
+{
+	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
+	/* free previously allocated queues that are no longer usable */
+	nvme_free_queues(dev, dev->online_queues);
 }
 
 static int nvme_pci_enable(struct nvme_dev *dev)
@@ -2919,7 +2917,11 @@ static void nvme_reset_work(struct work_struct *work)
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-		nvme_dev_add(dev);
+		if (!dev->ctrl.tagset)
+			nvme_pci_alloc_tag_set(dev);
+		else
+			nvme_pci_update_nr_queues(dev);
+		nvme_dbbuf_set(dev);
 		nvme_unfreeze(&dev->ctrl);
 	}
 
-- 
2.30.2


