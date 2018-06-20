From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed, 20 Jun 2018 13:42:22 +0800
Subject: [PATCH V2] nvme-pci: move nvme_kill_queues to nvme_remove_dead_ctrl
Message-ID: <1529473342-1886-1-git-send-email-jianchao.w.wang@oracle.com>

There is race between nvme_remove and nvme_reset_work that can
lead to io hang.

nvme_remove                    nvme_reset_work
                               -> nvme_remove_dead_ctrl
                                 -> nvme_dev_disable
                                   -> quiesce request_queue
                                 -> queue remove_work
-> cancel_work_sync reset_work
-> nvme_remove_namespaces
  -> splice ctrl->namespaces
                               nvme_remove_dead_ctrl_work
                               -> nvme_kill_queues
  -> nvme_ns_remove               do nothing
    -> blk_cleanup_queue
      -> blk_freeze_queue

Finally, the request_queue is quiesced state when wait freeze,
we will get io hang here. To fix it, move the nvme_kill_queues
from nvme_remove_dead_ctrl_work to nvme_remove_dead_ctrl.

Suggested-by: Keith Busch <keith.busch at linux.intel.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---

V2:
 - Just not invoke nvme_remove_dead_ctrl cannot fix the hole completely.
   Move the nvme_kill_queues to nvme_remove_dead_ctrl based on Keith's
   suggestion
 - Patch comment changes

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804..73a97fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2289,6 +2289,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
+	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -2405,7 +2406,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		device_release_driver(&pdev->dev);
 	nvme_put_ctrl(&dev->ctrl);
-- 
2.7.4
