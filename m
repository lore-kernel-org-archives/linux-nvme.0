Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B1C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RMeBBtuZ6jN1c2xr45VBpasHrL1bqnzj0i7LLV0DoSY=; b=RyQL11cdqTIehzLhYHnCygEv1b
	C+hEpapXTMvWkMvbHwIauQkzmcTG7ZsZQ0It/UdsSa2KfqckNwNhKq4Kqx6mHK4gMa6VaWZoQW/j0
	k+AyEHt7F5DUanln8wyuxAslDXwXydDEoC1GcZVxpPWMMk7e9ZEYWIaMAPYqWG+IH+SYeOSm5iAKr
	+OSHwxbSDhy2BQPSy1X4JM0/2co1XjXBOgJoq5BQQS32y/kSVmxGyMJeuvAMWIuRx6QMSrLAyNpQm
	oeH82A6DBMJzN+CP8QYQNhW4F+c+EhtfKwIOk+MFrAgjQ9G9hWXgcoj5AJa/JjGxQfL2sHgcMQvgr
	Hsqj72sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opslM-005gke-8J; Tue, 01 Nov 2022 15:01:12 +0000
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opsl9-005ge8-7t; Tue, 01 Nov 2022 15:00:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 02/14] nvme-pci: refactor the tagset handling in nvme_reset_work
Date: Tue,  1 Nov 2022 16:00:38 +0100
Message-Id: <20221101150050.3510-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
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

The code to create, update or delete a tagset and namespaces in
nvme_reset_work is a bit convoluted.  Refactor it with a two high-level
conditionals for first probe vs reset and I/O queues vs no I/O queues
to make the code flow more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5f1d71ac00865..0e8410edb41bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2897,25 +2897,37 @@ static void nvme_reset_work(struct work_struct *work)
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
-
-	/*
-	 * Keep the controller around but remove all namespaces if we don't have
-	 * any working I/O queue.
-	 */
-	if (dev->online_queues < 2) {
-		dev_warn(dev->ctrl.device, "IO queues not created\n");
-		nvme_kill_queues(&dev->ctrl);
-		nvme_remove_namespaces(&dev->ctrl);
-		nvme_free_tagset(dev);
+		
+	if (dev->ctrl.tagset) {
+		/*
+		 * This is a controller reset and we already have a tagset.
+		 * Freeze and update the number of I/O queues as thos might have
+		 * changed.  If there are no I/O queues left after this reset,
+		 * keep the controller around but remove all namespaces.
+		 */
+		if (dev->online_queues > 1) {
+			nvme_start_queues(&dev->ctrl);
+			nvme_wait_freeze(&dev->ctrl);
+			nvme_pci_update_nr_queues(dev);
+			nvme_dbbuf_set(dev);
+			nvme_unfreeze(&dev->ctrl);
+		} else {
+			dev_warn(dev->ctrl.device, "IO queues lost\n");
+			nvme_kill_queues(&dev->ctrl);
+			nvme_remove_namespaces(&dev->ctrl);
+			nvme_free_tagset(dev);
+		}
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
-		if (!dev->ctrl.tagset)
+		/*
+		 * First probe.  Still allow the controller to show up even if
+		 * there are no namespaces.
+		 */
+		if (dev->online_queues > 1) {
 			nvme_pci_alloc_tag_set(dev);
-		else
-			nvme_pci_update_nr_queues(dev);
-		nvme_dbbuf_set(dev);
-		nvme_unfreeze(&dev->ctrl);
+			nvme_dbbuf_set(dev);
+		} else {
+			dev_warn(dev->ctrl.device, "IO queues not created\n");
+		}
 	}
 
 	/*
-- 
2.30.2


