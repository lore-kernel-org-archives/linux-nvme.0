Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72B9C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X/BxEqUc1iS7BvAVLdGTwk5vk8u4nacAGXFHXJGtWyY=; b=K6Wk4PmuDpetzu80N5++jRSOfI
	xKgFcsOaXMNMCLufCYrUe5lYW5+8bZIusW9byenNeM7Ymr7VY6cshbaZZnPMOqmbYnQHU4Xe/f9nj
	CP6bWnPf2xylFPnM0C5P/pi2gCvNDDWLXGEPVSewrAnr4rXImthz0sajU2JSTzg7eCLfNTQdvZb0u
	hYCrhriC2wJbTkyr/7ZDK6iqRtGeIsMq7/QBca+9DjFjMGkZC+uOe8Ehl5GlEHVxQ+Hr9XLhcz8f7
	9cxC0KPzE48O8VzFVJjPmPuOyZfYoH0IoiZUZCg4wBlwB9bYSPBgn9Wu2kDBs/Aki6ZBHgtDP0vpu
	CuC9hMJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFbW-00CCcb-2M; Sun, 13 Nov 2022 16:13:06 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFav-00CCB5-PJ; Sun, 13 Nov 2022 16:12:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 12/13] nvme-pci: split the initial probe from the rest path
Date: Sun, 13 Nov 2022 17:11:37 +0100
Message-Id: <20221113161138.883195-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
References: <20221113161138.883195-1-hch@lst.de>
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

nvme_reset_work is a little fragile as it needs to handle both resetting
a live controller and initializing one during probe.  Split out the initial
probe and open code it in nvme_probe and leave nvme_reset_work to just do
the live controller reset.

This fixes a recently introduced bug where nvme_dev_disable causes a NULL
pointer dereferences in blk_mq_quiesce_tagset because the tagset pointer
is not set when the reset state is entered directly from the new state.
The separate probe code can skip the reset state and probe directly and
fixes this.

To make sure the system isn't single threaded on enabling nvme
controllers, set the PROBE_PREFER_ASYNCHRONOUS flag in the device_driver
structure so that the driver core probes in parallel.

Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
---
 drivers/nvme/host/pci.c | 133 ++++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 53 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 54e16cf1590c3..6a5b661084509 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2837,15 +2837,7 @@ static void nvme_reset_work(struct work_struct *work)
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out_unlock;
-
-	if (!dev->ctrl.admin_q) {
-		result = nvme_pci_alloc_admin_tag_set(dev);
-		if (result)
-			goto out_unlock;
-	} else {
-		nvme_start_admin_queue(&dev->ctrl);
-	}
-
+	nvme_start_admin_queue(&dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 
 	/*
@@ -2873,37 +2865,23 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if (dev->ctrl.tagset) {
-		/*
-		 * This is a controller reset and we already have a tagset.
-		 * Freeze and update the number of I/O queues as thos might have
-		 * changed.  If there are no I/O queues left after this reset,
-		 * keep the controller around but remove all namespaces.
-		 */
-		if (dev->online_queues > 1) {
-			nvme_start_queues(&dev->ctrl);
-			nvme_wait_freeze(&dev->ctrl);
-			nvme_pci_update_nr_queues(dev);
-			nvme_dbbuf_set(dev);
-			nvme_unfreeze(&dev->ctrl);
-		} else {
-			dev_warn(dev->ctrl.device, "IO queues lost\n");
-			nvme_mark_namespaces_dead(&dev->ctrl);
-			nvme_start_queues(&dev->ctrl);
-			nvme_remove_namespaces(&dev->ctrl);
-			nvme_free_tagset(dev);
-		}
+	/*
+	 * Freeze and update the number of I/O queues as thos might have
+	 * changed.  If there are no I/O queues left after this reset, keep the
+	 * controller around but remove all namespaces.
+	 */
+	if (dev->online_queues > 1) {
+		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
+		nvme_pci_update_nr_queues(dev);
+		nvme_dbbuf_set(dev);
+		nvme_unfreeze(&dev->ctrl);
 	} else {
-		/*
-		 * First probe.  Still allow the controller to show up even if
-		 * there are no namespaces.
-		 */
-		if (dev->online_queues > 1) {
-			nvme_pci_alloc_tag_set(dev);
-			nvme_dbbuf_set(dev);
-		} else {
-			dev_warn(dev->ctrl.device, "IO queues not created\n");
-		}
+		dev_warn(dev->ctrl.device, "IO queues lost\n");
+		nvme_mark_namespaces_dead(&dev->ctrl);
+		nvme_start_queues(&dev->ctrl);
+		nvme_remove_namespaces(&dev->ctrl);
+		nvme_free_tagset(dev);
 	}
 
 	/*
@@ -3059,15 +3037,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
-static void nvme_async_probe(void *data, async_cookie_t cookie)
-{
-	struct nvme_dev *dev = data;
-
-	flush_work(&dev->ctrl.reset_work);
-	flush_work(&dev->ctrl.scan_work);
-	nvme_put_ctrl(&dev->ctrl);
-}
-
 static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
@@ -3159,12 +3128,69 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_release_prp_pools;
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
+
+	result = nvme_pci_enable(dev);
+	if (result)
+		goto out_release_iod_mempool;
+
+	result = nvme_pci_alloc_admin_tag_set(dev);
+	if (result)
+		goto out_disable;
+
+	/*
+	 * Mark the controller as connecting before sending admin commands to
+	 * allow the timeout handler to do the right thing.
+	 */
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
+		dev_warn(dev->ctrl.device,
+			"failed to mark controller CONNECTING\n");
+		result = -EBUSY;
+		goto out_disable;
+	}
+
+	result = nvme_init_ctrl_finish(&dev->ctrl, false);
+	if (result)
+		goto out_disable;
+
+	nvme_dbbuf_dma_alloc(dev);
+
+	result = nvme_setup_host_mem(dev);
+	if (result < 0)
+		goto out_disable;
+
+	result = nvme_setup_io_queues(dev);
+	if (result)
+		goto out_disable;
+
+	if (dev->online_queues > 1) {
+		nvme_pci_alloc_tag_set(dev);
+		nvme_dbbuf_set(dev);
+	} else {
+		dev_warn(dev->ctrl.device, "IO queues not created\n");
+	}
+
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
+		dev_warn(dev->ctrl.device,
+			"failed to mark controller live state\n");
+		result = -ENODEV;
+		goto out_disable;
+	}
+
 	pci_set_drvdata(pdev, dev);
 
-	nvme_reset_ctrl(&dev->ctrl);
-	async_schedule(nvme_async_probe, dev);
+	nvme_start_ctrl(&dev->ctrl);
+	nvme_put_ctrl(&dev->ctrl);
 	return 0;
 
+out_disable:
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+	nvme_dev_disable(dev, true);
+	nvme_free_host_mem(dev);
+	nvme_dev_remove_admin(dev);
+	nvme_dbbuf_dma_free(dev);
+	nvme_free_queues(dev, 0);
+out_release_iod_mempool:
+	mempool_destroy(dev->iod_mempool);
 out_release_prp_pools:
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
@@ -3560,11 +3586,12 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
-#ifdef CONFIG_PM_SLEEP
 	.driver		= {
-		.pm	= &nvme_dev_pm_ops,
-	},
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+#ifdef CONFIG_PM_SLEEP
+		.pm		= &nvme_dev_pm_ops,
 #endif
+	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
 };
-- 
2.30.2


