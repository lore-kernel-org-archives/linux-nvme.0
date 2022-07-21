Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F165FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HDp9GhQcMsDaYpfwb9vWjW3qyKE8U5LwjaMt+zyD/pc=; b=GWUagdQ9bhf9nfKgeBjKkOJPlL
	zRSLHsSY0a1wRN5C/pQlLkkhYm46TwH4mgnZ2c6wBy29W6Q8PCrxyDB0cz93gnqoeNFiHHqbP5pU8
	G3oH+dAcedTB3so93Lq7CLOAqwI6cedON9IEXTLSVWWuliaRJVWfb9oKCoH5j6bOt5V2FqQ5f7AU0
	QbkEo6Awr24AuBmauomVbRW9mEn7s7aGY0gOPLgO61iFi9gGdi3lRTLbToOy0Wo0Xlbe7b0a6d0ME
	prot9oNZ6ap2QBybqZqQqDK2WCoFNq5CtEwXMf+4JelV6WmAxzPt9tLiDDCtuA/b3dWcPs+nVrZTm
	3Dc+czRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPcU-000yUI-6i; Thu, 21 Jul 2022 06:25:10 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPcS-000yRH-Cs; Thu, 21 Jul 2022 06:25:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvme-pci: split nvme_alloc_admin_tags
Date: Thu, 21 Jul 2022 08:25:03 +0200
Message-Id: <20220721062506.1712176-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

Split nvme_alloc_admin_tags into a helper to actually allocate the
tag set, and one that just restarts the admin queue.  Add a local
variable for the tag_set to clean up the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 60 +++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 375502de4c745..ceccd8331a76e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1766,37 +1766,35 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 	}
 }
 
-static int nvme_alloc_admin_tags(struct nvme_dev *dev)
+static int nvme_pci_alloc_admin_tag_set(struct nvme_dev *dev)
 {
-	if (!dev->ctrl.admin_q) {
-		dev->admin_tagset.ops = &nvme_mq_admin_ops;
-		dev->admin_tagset.nr_hw_queues = 1;
+	struct blk_mq_tag_set *set = &dev->admin_tagset;
 
-		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		dev->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
-		dev->admin_tagset.numa_node = dev->ctrl.numa_node;
-		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
-		dev->admin_tagset.driver_data = dev;
+	set->ops = &nvme_mq_admin_ops;
+	set->nr_hw_queues = 1;
 
-		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
-			return -ENOMEM;
-		dev->ctrl.admin_tagset = &dev->admin_tagset;
+	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+	set->timeout = NVME_ADMIN_TIMEOUT;
+	set->numa_node = dev->ctrl.numa_node;
+	set->cmd_size = sizeof(struct nvme_iod);
+	set->flags = BLK_MQ_F_NO_SCHED;
+	set->driver_data = dev;
 
-		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
-		if (IS_ERR(dev->ctrl.admin_q)) {
-			blk_mq_free_tag_set(&dev->admin_tagset);
-			dev->ctrl.admin_q = NULL;
-			return -ENOMEM;
-		}
-		if (!blk_get_queue(dev->ctrl.admin_q)) {
-			nvme_dev_remove_admin(dev);
-			dev->ctrl.admin_q = NULL;
-			return -ENODEV;
-		}
-	} else
-		nvme_start_admin_queue(&dev->ctrl);
+	if (blk_mq_alloc_tag_set(set))
+		return -ENOMEM;
+	dev->ctrl.admin_tagset = set;
 
+	dev->ctrl.admin_q = blk_mq_init_queue(set);
+	if (IS_ERR(dev->ctrl.admin_q)) {
+		blk_mq_free_tag_set(set);
+		dev->ctrl.admin_q = NULL;
+		return -ENOMEM;
+	}
+	if (!blk_get_queue(dev->ctrl.admin_q)) {
+		nvme_dev_remove_admin(dev);
+		dev->ctrl.admin_q = NULL;
+		return -ENODEV;
+	}
 	return 0;
 }
 
@@ -2836,9 +2834,13 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out_unlock;
 
-	result = nvme_alloc_admin_tags(dev);
-	if (result)
-		goto out_unlock;
+	if (!dev->ctrl.admin_q) {
+		result = nvme_pci_alloc_admin_tag_set(dev);
+		if (result)
+			goto out_unlock;
+	} else {
+		nvme_start_admin_queue(&dev->ctrl);
+	}
 
 	/*
 	 * Limit the max command size to prevent iod->sg allocations going
-- 
2.30.2


