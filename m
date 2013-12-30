From: santoshsy@gmail.com (Santosh Y)
Date: Mon, 30 Dec 2013 15:57:20 +0530
Subject: [PATCH RFC 5/5] NVMe: Hotplug support during hibernate/sleep states
In-Reply-To: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
Message-ID: <1388399240-13828-6-git-send-email-santoshsy@gmail.com>

This patch provides NVMe hotplug support during
hibernate/sleep states.

Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
Signed-off-by: Santosh Y <santoshsy at gmail.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 48698b7..9fbc063 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2863,6 +2863,30 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+	if (!ndev)
+		return -EINVAL;
+	
+	if (nvme_check_surprise_removal(ndev)) {
+		set_bit(NVME_HOT_REM, &ndev->hp_flag);
+		pci_dev_get(pdev);
+		pci_set_drvdata(pdev, NULL);
+		flush_work(&ndev->reset_work);
+		misc_deregister(&ndev->miscdev);
+		nvme_dev_remove(ndev);
+		nvme_dev_shutdown(ndev);
+		nvme_free_queues(ndev, 0);
+
+		if (!test_bit(NVME_STALE_NODE, &ndev->hp_flag))
+			nvme_release_instance(ndev);
+		nvme_release_prp_pools(ndev);
+		kref_put(&ndev->kref, nvme_free_dev);
+		pci_dev_put(pdev);
+		nvme_remove_stalen();
+		return -ENODEV;
+	}
+#endif
+
 	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
 		INIT_WORK(&ndev->reset_work, nvme_reset_failed_dev);
 		queue_work(nvme_workq, &ndev->reset_work);
-- 
1.8.3.2
