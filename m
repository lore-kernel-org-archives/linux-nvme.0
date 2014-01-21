From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 21 Jan 2014 15:37:20 +0900
Subject: [PATCH] NVMe: Add CONFIG_PM_SLEEP to suspend/resume functions
Message-ID: <000301cf1673$3c2e9690$b48bc3b0$%han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/block/nvme-core.c:2149:12: warning: 'nvme_suspend' defined but not used [-Wunused-function]
drivers/block/nvme-core.c:2158:12: warning: 'nvme_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han at samsung.com>
---
 drivers/block/nvme-core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 1f14ac4..7971796 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2146,6 +2146,7 @@ static void nvme_remove(struct pci_dev *pdev)
 #define nvme_slot_reset NULL
 #define nvme_error_resume NULL
 
+#ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -2167,6 +2168,7 @@ static int nvme_resume(struct device *dev)
 		nvme_free_queues(ndev);
 	return ret;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
-- 
1.7.10.4
