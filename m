From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 11:36:51 -0700
Subject: [PATCH-4.5-v3 1/5] NVMe: Add controller removing state
In-Reply-To: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455734215-20396-2-git-send-email-keith.busch@intel.com>

The patch is preparing for reducing the scope of the namespace mutex. It
adds a removing state the namespace scan work uses to know if it is safe
to proceed. The scan work is flushed after setting the device state so
the removal path can safely walk the namespace list without locking it.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a128672..f0e97a3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -120,6 +120,7 @@ struct nvme_dev {
 	unsigned long flags;
 
 #define NVME_CTRL_RESETTING    0
+#define NVME_CTRL_REMOVING     1
 
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
@@ -1583,6 +1584,8 @@ static void nvme_dev_scan(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
 
+	if (test_bit(NVME_CTRL_REMOVING, &dev->flags))
+		return;
 	if (!dev->tagset.tags)
 		return;
 	nvme_scan_namespaces(&dev->ctrl);
@@ -2116,6 +2119,7 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	set_bit(NVME_CTRL_REMOVING, &dev->flags);
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
-- 
2.6.2.307.g37023ba
