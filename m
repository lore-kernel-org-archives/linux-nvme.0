From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Apr 2016 08:34:51 -0400
Subject: [PATCH 3/5] nvme: tighten up state check for namespace scanning
In-Reply-To: <1460982893-11315-1-git-send-email-hch@lst.de>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
Message-ID: <1460982893-11315-4-git-send-email-hch@lst.de>

We only should be scanning namespaces if the controller is live.  Currently
we call the function just before setting it live, so fix the code up to
move the call to nvme_queue_scan to just below the state change.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b922608..f98d77f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -272,7 +272,7 @@ static void nvme_queue_scan(struct nvme_dev *dev)
 	 * Do not queue new scan work when a controller is reset during
 	 * removal.
 	 */
-	if (dev->ctrl.state != NVME_CTRL_DELETING)
+	if (dev->ctrl.state == NVME_CTRL_LIVE)
 		queue_work(nvme_workq, &dev->scan_work);
 }
 
@@ -1659,7 +1659,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		nvme_free_queues(dev, dev->online_queues);
 	}
 
-	nvme_queue_scan(dev);
 	return 0;
 }
 
@@ -1892,6 +1891,9 @@ static void nvme_reset_work(struct work_struct *work)
 		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
 		goto out;
 	}
+
+	if (dev->online_queues > 1)
+		nvme_queue_scan(dev);
 	return;
 
  out:
-- 
2.1.4
