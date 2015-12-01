From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:50 +0100
Subject: [PATCH 15/26] NVMe: Remove device management handles on remove
In-Reply-To: <1448995981-11982-1-git-send-email-hch@lst.de>
References: <1448995981-11982-1-git-send-email-hch@lst.de>
Message-ID: <1448995981-11982-16-git-send-email-hch@lst.de>

From: Keith Busch <keith.busch@intel.com>

We don't want to allow new references to open on a device that is
removed. This ties the lifetime of these handles to the physical device's
presence rather than to the open reference count.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 13 +++++++++----
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bd7de8f..d2ede9b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1200,17 +1200,22 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 	spin_unlock(&dev_list_lock);
 }
 
-static void nvme_free_ctrl(struct kref *kref)
-{
-	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
+void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
+ {
+	device_remove_file(ctrl->device, &dev_attr_reset_controller);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
 	spin_unlock(&dev_list_lock);
+}
+
+static void nvme_free_ctrl(struct kref *kref)
+{
+	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
 
 	put_device(ctrl->device);
 	nvme_release_instance(ctrl);
-	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	ctrl->ops->free_ctrl(ctrl);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2965c46..aa4b42e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -221,6 +221,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
+void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a909a8b..c83f0d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2373,6 +2373,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
+	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-- 
1.9.1
