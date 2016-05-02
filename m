From: keith.busch@intel.com (Keith Busch)
Date: Mon,  2 May 2016 11:12:07 -0600
Subject: [PATCH-4.7 2/3] NVMe: Short-cut removal on surprise hot-unplug
In-Reply-To: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
Message-ID: <1462209128-12376-3-git-send-email-keith.busch@intel.com>

This patch adds a new state that when set has the core automatically
kill request queues prior to removing namespaces. If PCI device is not
present at the time the nvme driver's remove is called, we can kill all
IO queues immediately instead of waiting for the watchdog thread to do
that at its polling interval. This improves scenarios where multiple hot
plug events occur at the same time since it doesn't block pci enumeration.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e7fbe1f..9f1f318 100644
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
@@ -1584,6 +1593,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 
+	if (ctrl->state == NVME_CTRL_DEAD)
+		nvme_kill_queues(ctrl);
+
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 48c7f3c..78135cd 100644
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
index f99833b..0881b54 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2019,6 +2019,10 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
 	pci_set_drvdata(pdev, NULL);
+
+	if (!pci_device_is_present(pdev))
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
+
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	flush_work(&dev->reset_work);
-- 
2.7.2
