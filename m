From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed,  3 Jan 2018 07:56:10 +0800
Subject: [PATCH 3/3] nvme-pci: add nvme_pci_post_init
In-Reply-To: <1514937370-4805-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1514937370-4805-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1514937370-4805-4-git-send-email-jianchao.w.wang@oracle.com>

No functional change. Add new interface nvme_pci_post_init to get
in the nvme sepcific initialization work after identify.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 58 +++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a63835..c390cf1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2295,11 +2295,41 @@ static int nvme_pci_pre_init(struct nvme_dev *dev)
 	return nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 }
 
+/* Include initialization work after identify
+ */
+static int nvme_pci_post_init(struct nvme_dev *dev)
+{
+	int ret;
+	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
+
+	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
+		if (!dev->ctrl.opal_dev)
+			dev->ctrl.opal_dev =
+				init_opal_dev(&dev->ctrl, &nvme_sec_submit);
+		else if (was_suspend)
+			opal_unlock_from_suspend(dev->ctrl.opal_dev);
+	} else {
+		free_opal_dev(dev->ctrl.opal_dev);
+		dev->ctrl.opal_dev = NULL;
+	}
+
+	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
+		if(nvme_dbbuf_dma_alloc(dev))
+			dev_warn(dev->dev,
+				 "unable to allocate dma for dbbuf\n");
+	}
+
+	if (dev->ctrl.hmpre) {
+		ret = nvme_setup_host_mem(dev);
+		return ret >= 0 ? 0 : ret;
+	}
+
+	return 0;
+}
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev =
 		container_of(work, struct nvme_dev, ctrl.reset_work);
-	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
@@ -2333,29 +2363,9 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
-		if (!dev->ctrl.opal_dev)
-			dev->ctrl.opal_dev =
-				init_opal_dev(&dev->ctrl, &nvme_sec_submit);
-		else if (was_suspend)
-			opal_unlock_from_suspend(dev->ctrl.opal_dev);
-	} else {
-		free_opal_dev(dev->ctrl.opal_dev);
-		dev->ctrl.opal_dev = NULL;
-	}
-
-	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
-		result = nvme_dbbuf_dma_alloc(dev);
-		if (result)
-			dev_warn(dev->dev,
-				 "unable to allocate dma for dbbuf\n");
-	}
-
-	if (dev->ctrl.hmpre) {
-		result = nvme_setup_host_mem(dev);
-		if (result < 0)
-			goto out;
-	}
+	result = nvme_pci_post_init(dev);
+	if (result)
+		goto out;
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-- 
2.7.4
