Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EAFC4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KKBmeYqsbzZo6HcXsM4V/24vGrVwbM7W2COZA8MhMTU=; b=ODi6QdPll/lqRVjrYPLdPOJoN2
	feDGffnHhiuzQgBZxDtFtuLyOYw+2n7okcIaN7ed6/n0oEblkFxp11s+WXClAmpOc0fZbedIEDPT8
	tSJXsI104xyCbiFnQs+RnYA+VPz0q3nvdj1c98zEsU2QJfJ+Axwa6septmjWqvo2jbM6AbpAyvtk1
	u2FW4/to9OMqvADgBiJOrfbgwYPhCT3Zv1z//tsS42BiqxkDWg0kmfnJjILHYV3edxZHczVqLT/f1
	EQ5RMlY/Q6sKdn9LbVrGVvIK9k6IT85PyN23o6a3ynFHjlB4y/g2frsTlP7Q8tpg4DBFpQPYfIRj6
	7gmA+umg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZS-008lmT-8w; Tue, 29 Nov 2022 13:22:46 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZG-008ldO-1s; Tue, 29 Nov 2022 13:22:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 7/9] nvme-pci: rename nvme_disable_io_queues
Date: Tue, 29 Nov 2022 14:22:06 +0100
Message-Id: <20221129132208.4337-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129132208.4337-1-hch@lst.de>
References: <20221129132208.4337-1-hch@lst.de>
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

This function really deletes the I/O queues, so rename it to match
the functionality.  Also move the main wrapper right next to the
actual underlying implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2c8dd0f7ef463b..1b527377e35197 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -109,7 +109,7 @@ struct nvme_dev;
 struct nvme_queue;
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
-static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
+static void nvme_delete_io_queues(struct nvme_dev *dev);
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -2310,12 +2310,6 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
 
-static void nvme_disable_io_queues(struct nvme_dev *dev)
-{
-	if (__nvme_disable_io_queues(dev, nvme_admin_delete_sq))
-		__nvme_disable_io_queues(dev, nvme_admin_delete_cq);
-}
-
 static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 {
 	/*
@@ -2423,7 +2417,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	if (dev->online_queues - 1 < dev->max_qid) {
 		nr_io_queues = dev->online_queues - 1;
-		nvme_disable_io_queues(dev);
+		nvme_delete_io_queues(dev);
 		result = nvme_setup_io_queues_trylock(dev);
 		if (result)
 			return result;
@@ -2487,7 +2481,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	return 0;
 }
 
-static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
+static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
 {
 	int nr_queues = dev->online_queues - 1, sent = 0;
 	unsigned long timeout;
@@ -2515,6 +2509,12 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	return true;
 }
 
+static void nvme_delete_io_queues(struct nvme_dev *dev)
+{
+	if (__nvme_delete_io_queues(dev, nvme_admin_delete_sq))
+		__nvme_delete_io_queues(dev, nvme_admin_delete_cq);
+}
+
 static void nvme_pci_alloc_tag_set(struct nvme_dev *dev)
 {
 	struct blk_mq_tag_set * set = &dev->tagset;
@@ -2687,7 +2687,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_quiesce_io_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		nvme_disable_io_queues(dev);
+		nvme_delete_io_queues(dev);
 		nvme_disable_ctrl(&dev->ctrl, shutdown);
 		nvme_poll_irqdisable(&dev->queues[0]);
 	}
-- 
2.30.2


