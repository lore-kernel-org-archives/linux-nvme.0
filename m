From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 May 2016 07:58:26 -0600
Subject: [PATCHv2] NVMe: Short-cut removal on surprise hot-unplug
Message-ID: <1463061506-8780-1-git-send-email-keith.busch@intel.com>

This patch adds a new state that when set has the core automatically
kill request queues prior to removing namespaces.

If PCI device is not present at the time the nvme driver's remove is
called, we can kill all IO queues immediately instead of waiting for
the watchdog thread to do that at its polling interval. This improves
scenarios where multiple hot plug events occur at the same time since
it doesn't block the pci enumeration for as long.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

  Added comment explaining the use of the dead controller state and how
  it helps with namespace removal.

 drivers/nvme/host/core.c | 18 ++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6a89da..2dfe6af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -95,6 +95,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_DEAD:
+		switch (old_state) {
+		case NVME_CTRL_DELETING:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -1599,6 +1608,15 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 
+	/*
+	 * The dead states indicates the controller was not gracefully
+	 * disconnected. In that case, we won't be able to flush any data while
+	 * removing the namespaces' disks; fail all the queues now to avoid
+	 * potentially having to clean up the failed sync later.
+	 */
+	if (ctrl->state == NVME_CTRL_DEAD)
+		nvme_kill_queues(ctrl);
+
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 114b928..1daa048 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -72,6 +72,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_LIVE,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_DELETING,
+	NVME_CTRL_DEAD,
 };
 
 struct nvme_ctrl {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d260a54..9c57a10 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2017,6 +2017,10 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
 	pci_set_drvdata(pdev, NULL);
+
+	if (!pci_device_is_present(pdev))
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
+
 	flush_work(&dev->reset_work);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-- 
2.7.2
