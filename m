From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu,  2 May 2019 14:47:56 +0300
Subject: [PATCH v2 05/10] nvme/pci: use the NVME_CTRL_SUSPENDED state
In-Reply-To: <20190502114801.23116-1-mlevitsk@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
Message-ID: <20190502114801.23116-6-mlevitsk@redhat.com>

When enteriing low power state, the nvme
driver will now inform the core with the NVME_CTRL_SUSPENDED state
which will allow mdev driver to act on this information

Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 drivers/nvme/host/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1c844c66ecaa..282f28c851c1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2406,7 +2406,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
+		    dev->ctrl.state == NVME_CTRL_RESETTING ||
+		    dev->ctrl.state == NVME_CTRL_SUSPENDED)
 			nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
@@ -2852,6 +2853,9 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	if (!nvme_change_ctrl_state(&ndev->ctrl, NVME_CTRL_SUSPENDED))
+		WARN_ON(1);
+
 	nvme_dev_disable(ndev, true);
 	return 0;
 }
-- 
2.17.2
