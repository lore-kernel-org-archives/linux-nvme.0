Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB35C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qn+flxfGx6jn7uSJ/HmRl/Dxbu6gyoXo19fbbnqKF0g=; b=RBoebhEdNlug/k3WTVazkBisdp
	mhZlReaW1Og2jiUF2wWIlbsOF2j6LNsqq/cgFAXdcHqHMKxKMnDOTcDPJ51U9FF0TO7QjRhcgTUuJ
	ToMqMysPC1OAIKMOMQb3Cn0wQr/PeeR995GvfuXebvr9lZ9dnk/Zpa1Z9fGxQDEYyOKV2rqSTBxdG
	v8VH88aByq2E/I6IZRfyi0LkQRGzhd0Zcw5+juQyLzwzk3BprZ/56bprD5SQY6IVzKEWHECN6ei5p
	nmgzxlNVKqRdE7sPc73WANnxOKyCtfLA2l1C4g/M+25oyuuDgjj5+WdIfAMQZxJhXEa3uVUYEdT9t
	STplNFrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZN-008lj8-RI; Tue, 29 Nov 2022 13:22:41 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00ZD-008lcE-59; Tue, 29 Nov 2022 13:22:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6/9] nvme-pci: cleanup nvme_suspend_queue
Date: Tue, 29 Nov 2022 14:22:05 +0100
Message-Id: <20221129132208.4337-7-hch@lst.de>
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

Remove the unused returne value, pass a dev + qid instead of the queue
as that is better for the callers as well as the function itself, and
remove the entirely pointless kerneldoc comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c3d9b23699d3f3..2c8dd0f7ef463b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1468,14 +1468,12 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 	}
 }
 
-/**
- * nvme_suspend_queue - put queue into suspended state
- * @nvmeq: queue to suspend
- */
-static int nvme_suspend_queue(struct nvme_queue *nvmeq)
+static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
 {
+	struct nvme_queue *nvmeq = &dev->queues[qid];
+
 	if (!test_and_clear_bit(NVMEQ_ENABLED, &nvmeq->flags))
-		return 1;
+		return;
 
 	/* ensure that nvme_queue_rq() sees NVMEQ_ENABLED cleared */
 	mb();
@@ -1484,8 +1482,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		nvme_quiesce_admin_queue(&nvmeq->dev->ctrl);
 	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
-		pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
-	return 0;
+		pci_free_irq(to_pci_dev(dev->dev), nvmeq->cq_vector, nvmeq);
 }
 
 static void nvme_suspend_io_queues(struct nvme_dev *dev)
@@ -1493,7 +1490,7 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
 	int i;
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
-		nvme_suspend_queue(&dev->queues[i]);
+		nvme_suspend_queue(dev, i);
 }
 
 /*
@@ -2695,7 +2692,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_poll_irqdisable(&dev->queues[0]);
 	}
 	nvme_suspend_io_queues(dev);
-	nvme_suspend_queue(&dev->queues[0]);
+	nvme_suspend_queue(dev, 0);
 	pci_free_irq_vectors(pdev);
 	if (pci_is_enabled(pdev)) {
 		pci_disable_pcie_error_reporting(pdev);
-- 
2.30.2


