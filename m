From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Tue, 19 Jun 2018 16:30:50 +0800
Subject: [PATCH] nvme-pci: not invoke nvme_remove_dead_ctrl when change state
 fails
Message-ID: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>

There is race between nvme_remove and nvme_reset_work that can
lead to io hang.

nvme_remove                    nvme_reset_work
-> change state to DELETING
                               -> fail to change state to LIVE
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
we will get io hang here.

In fact, when fails to change state in nvme_reset_work, the only
reason is someone has changed state to DELETING. So it is not
necessary to invoke nvme_remove_dead_ctrl in that case.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804..fc56e63 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2318,7 +2318,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller CONNECTING\n");
-		goto out;
+		goto fail_state;
 	}
 
 	result = nvme_pci_enable(dev);
@@ -2390,13 +2390,22 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller state %d\n", new_state);
-		goto out;
+		goto fail_state;
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
- out:
+fail_state:
+	/*
+	 * The only possible state here is DELETING, there must be someone
+	 * removing the ctrl right now, so needn't invoke nvme_remove_dead_ctrl.
+	 * The queues may have been quiesced, start them to avoid io hang.
+	 */
+	WARN_ON(dev->ctrl.state != NVME_CTRL_DELETING);
+	nvme_start_queues(&dev->ctrl);
+	return;
+out:
 	nvme_remove_dead_ctrl(dev, result);
 }
 
-- 
2.7.4
