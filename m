From: ming.lei@redhat.com (Ming Lei)
Date: Thu,  2 Nov 2017 17:36:24 +0800
Subject: [PATCH] nvme-pci: avoid dereference of symbol from unloaded module
Message-ID: <20171102093624.20333-1-ming.lei@redhat.com>

The 'remove_work' may be scheduled to run after nvme_remove()
returns since we can't simply cancel it in nvme_remove() for
avoiding deadlock. Once nvme_remove() returns, this module(nvme)
can be unloaded.

On the other hand, nvme_put_ctrl() calls ctr->ops->free_ctrl
which may point to nvme_pci_free_ctrl() in unloaded module.

This patch avoids this issue by holding the module refcount before
scheduling 'remove_work'.

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f5a04c586ce..3ed8fd7218d4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2134,8 +2134,12 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 
 	kref_get(&dev->ctrl.kref);
 	nvme_dev_disable(dev, false);
-	if (!schedule_work(&dev->remove_work))
+
+	__module_get(THIS_MODULE);
+	if (!schedule_work(&dev->remove_work)) {
 		nvme_put_ctrl(&dev->ctrl);
+		module_put(THIS_MODULE);
+	}
 }
 
 static void nvme_reset_work(struct work_struct *work)
@@ -2231,10 +2235,20 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	/*
+	 * Inside nvme_remove(), we can't simply cancel this 'remove_work'
+	 * for avoiding deadlock, so this work function may be run after
+	 * nvme_remove() returns, and this module may have been removed
+	 * at that time. We have to get the module refcount before scheduling
+	 * 'remove_work', otherwise nvme_put_ctrl() may deference symbols
+	 * of the unloaded module via ctrl->ops.
+	 */
+
 	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		device_release_driver(&pdev->dev);
 	nvme_put_ctrl(&dev->ctrl);
+	module_put(THIS_MODULE);
 }
 
 static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
-- 
2.9.5
