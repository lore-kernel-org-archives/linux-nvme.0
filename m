From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Jun 2014 16:03:21 -0600
Subject: [PATCH] NVMe: Whitespace fixes
Message-ID: <1403561001-19964-1-git-send-email-keith.busch@intel.com>

Fixing tabs inadvertently converted to spaces.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 69bad18..7433da4 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2825,12 +2825,12 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 {
-       struct nvme_dev *dev = pci_get_drvdata(pdev);
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-       if (prepare)
-               nvme_dev_shutdown(dev);
-       else
-               nvme_dev_resume(dev);
+	if (prepare)
+		nvme_dev_shutdown(dev);
+	else
+		nvme_dev_resume(dev);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
-- 
1.7.10.4
