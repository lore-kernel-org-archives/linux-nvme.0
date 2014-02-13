From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 13 Feb 2014 11:19:14 +0900
Subject: [PATCH V2] NVMe: Add CONFIG_PM_SLEEP to suspend/resume functions
Message-ID: <003601cf2861$fd8033d0$f8809b70$%han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/block/nvme-core.c:2541:12: warning: 'nvme_suspend' defined but not used [-Wunused-function]
drivers/block/nvme-core.c:2550:12: warning: 'nvme_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han at samsung.com>
---
Changes since V1:
- Re-based on the latest kernel v3.14-rc2

 drivers/block/nvme-core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 51824d1..87dd4c7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2538,6 +2538,7 @@ static void nvme_remove(struct pci_dev *pdev)
 #define nvme_slot_reset NULL
 #define nvme_error_resume NULL
 
+#ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2558,6 +2559,7 @@ static int nvme_resume(struct device *dev)
 	}
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
-- 
1.7.10.4
