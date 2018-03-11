From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 11 Mar 2018 17:46:06 +0200
Subject: [PATCH 1/1] nvme: centralize ctrl removal prints
Message-ID: <1520783166-13428-1-git-send-email-maxg@mellanox.com>

nvme_delete_ctrl can be called from various contexts in parallel,
and cause duplicated information prints, even though the specific
context doesn't perform the actual removal. Instead, print the
information when the actual removal occurs.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c |  3 +++
 drivers/nvme/host/fc.c   | 13 +++++--------
 drivers/nvme/host/rdma.c |  4 ----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7aeca5d..331e613 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -135,6 +135,9 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, delete_work);
 
+	dev_info(ctrl->device,
+		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);
+
 	flush_work(&ctrl->reset_work);
 	nvme_stop_ctrl(ctrl);
 	nvme_remove_namespaces(ctrl);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1dc1387..86f6b2e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -768,8 +768,7 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 		 */
 		if (nvme_reset_ctrl(&ctrl->ctrl)) {
 			dev_warn(ctrl->ctrl.device,
-				"NVME-FC{%d}: Couldn't schedule reset. "
-				"Deleting controller.\n",
+				"NVME-FC{%d}: Couldn't schedule reset.\n",
 				ctrl->cnum);
 			nvme_delete_ctrl(&ctrl->ctrl);
 		}
@@ -836,8 +835,7 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 		/* if dev_loss_tmo==0, dev loss is immediate */
 		if (!portptr->dev_loss_tmo) {
 			dev_warn(ctrl->ctrl.device,
-				"NVME-FC{%d}: controller connectivity lost. "
-				"Deleting controller.\n",
+				"NVME-FC{%d}: controller connectivity lost.\n",
 				ctrl->cnum);
 			nvme_delete_ctrl(&ctrl->ctrl);
 		} else
@@ -2889,14 +2887,13 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 		if (portptr->port_state == FC_OBJSTATE_ONLINE)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: Max reconnect attempts (%d) "
-				"reached. Removing controller\n",
+				"reached.\n",
 				ctrl->cnum, ctrl->ctrl.nr_reconnects);
 		else
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: dev_loss_tmo (%d) expired "
-				"while waiting for remoteport connectivity. "
-				"Removing controller\n", ctrl->cnum,
-				portptr->dev_loss_tmo);
+				"while waiting for remoteport connectivity.\n",
+				ctrl->cnum, portptr->dev_loss_tmo);
 		WARN_ON(nvme_delete_ctrl(&ctrl->ctrl));
 	}
 }
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4d84a73..f5f460b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -899,7 +899,6 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->ctrl.device, "Removing controller...\n");
 		nvme_delete_ctrl(&ctrl->ctrl);
 	}
 }
@@ -2031,9 +2030,6 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
 		if (ctrl->device->dev != ib_device)
 			continue;
-		dev_info(ctrl->ctrl.device,
-			"Removing ctrl: NQN \"%s\", addr %pISp\n",
-			ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
 		nvme_delete_ctrl(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
-- 
1.8.3.1
