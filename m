From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 Jul 2018 14:56:09 -0600
Subject: [PATCHv4 4/4] nvme-pci: Use controller start work to dispath IO
In-Reply-To: <20180713205609.19701-1-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
Message-ID: <20180713205609.19701-5-keith.busch@intel.com>

We don't want to wait for IO within the reset work because we need that
to context handle IO timeouts. This patch uses the new FROZEN state
to inform the controller start work to handle restarting IO queues and
waiting for their freeze to complete.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b9b83a7a5a52..2e12c8a746c7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2077,10 +2077,7 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 	}
 }
 
-/*
- * return error value only when tagset allocation failed
- */
-static int nvme_dev_add(struct nvme_dev *dev)
+static enum nvme_ctrl_state nvme_dev_add(struct nvme_dev *dev)
 {
 	int ret;
 
@@ -2103,19 +2100,18 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (ret) {
 			dev_warn(dev->ctrl.device,
 				"IO queues tagset allocation failed %d\n", ret);
-			return ret;
+			return NVME_CTRL_ADMIN_ONLY;
 		}
 		dev->ctrl.tagset = &dev->tagset;
 
 		nvme_dbbuf_set(dev);
 	} else {
-		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
-
 		/* Free previously allocated queues that are no longer usable */
 		nvme_free_queues(dev, dev->online_queues);
+		return NVME_CTRL_FROZEN;
 	}
 
-	return 0;
+	return NVME_CTRL_LIVE;
 }
 
 static int nvme_pci_enable(struct nvme_dev *dev)
@@ -2391,12 +2387,7 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
-		/* hit this only when allocate tagset fails */
-		if (nvme_dev_add(dev))
-			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+		new_state = nvme_dev_add(dev);
 	}
 
 	/*
-- 
2.14.3
