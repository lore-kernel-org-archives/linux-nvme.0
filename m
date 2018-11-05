From: ming.lei@redhat.com (Ming Lei)
Date: Mon,  5 Nov 2018 19:57:34 +0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
Message-ID: <20181105115734.15515-1-ming.lei@redhat.com>

When scan work is in-progress, any controller error may trigger
reset, now fc, rdma and loop host tries to flush scan work
inside reset context.

This way can cause deadlock easily because any IO during controler
recovery(reset) can't be completed until the recovery is done.

This patch tries to address the deadlock issue by not flushing
scan work inside reset context. Actually not see obvious reason
to do that:

- once reset is done, a new scan will be scheduled.
- PCI NVMe doesn't do that way

Cc: James Smart <james.smart at broadcom.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c   | 4 ++--
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/pci.c    | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2e65be8b1387..fbbb6bd8fbc5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -161,7 +161,7 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
 		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);
 
 	flush_work(&ctrl->reset_work);
-	nvme_stop_ctrl(ctrl);
+	nvme_stop_ctrl(ctrl, true);
 	nvme_remove_namespaces(ctrl);
 	ctrl->ops->delete_ctrl(ctrl);
 	nvme_uninit_ctrl(ctrl);
@@ -3469,7 +3469,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
-void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
+void nvme_stop_ctrl(struct nvme_ctrl *ctrl, bool flush_scan)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e52b9d3c0bd6..358249f83bc7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2872,7 +2872,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 	int ret;
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl, false);
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cee79cb388af..02cdbfb66bca 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -418,7 +418,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
-void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
+void nvme_stop_ctrl(struct nvme_ctrl *ctrl, bool flush_scan);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f31e14b35421..9373f1bf8469 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2828,7 +2828,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-	nvme_stop_ctrl(&dev->ctrl);
+	nvme_stop_ctrl(&dev->ctrl, true);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_free_host_mem(dev);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181cafedc58..26afcc97a445 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1823,7 +1823,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl =
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl, false);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9908082b32c4..cf2169cb890c 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -468,7 +468,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	bool changed;
 	int ret;
 
-	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl, false);
 	nvme_loop_shutdown_ctrl(ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-- 
2.9.5
