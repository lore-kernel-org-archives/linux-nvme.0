From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Fri, 16 Aug 2019 13:15:49 +0100
Subject: [PATCH] Revert "nvme-pci: use host managed power state for suspend"
Message-ID: <20190816121549.8754-1-chris@chris-wilson.co.uk>

commit d916b1be94b6dc8d293abed2451f3062f6af7551
Author: Keith Busch <keith.busch at intel.com>
Date:   Thu May 23 09:27:35 2019 -0600

    nvme-pci: use host managed power state for suspend

Bisected as cause of suspend failure for gem_eio/suspend on multiple kbl
hosts.

Cc: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: linux-nvme at lists.infradead.org
---
 drivers/nvme/host/pci.c | 95 ++---------------------------------------
 1 file changed, 3 insertions(+), 92 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db160cee42ad..bdc9e0625bb7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -18,7 +18,6 @@
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
-#include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -111,7 +110,6 @@ struct nvme_dev {
 	u32 cmbsz;
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
-	u32 last_ps;
 
 	mempool_t *iod_mempool;
 
@@ -2831,94 +2829,16 @@ static void nvme_remove(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int nvme_get_power_state(struct nvme_ctrl *ctrl, u32 *ps)
-{
-	return nvme_get_features(ctrl, NVME_FEAT_POWER_MGMT, 0, NULL, 0, ps);
-}
-
-static int nvme_set_power_state(struct nvme_ctrl *ctrl, u32 ps)
-{
-	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
-}
-
-static int nvme_resume(struct device *dev)
-{
-	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
-	struct nvme_ctrl *ctrl = &ndev->ctrl;
-
-	if (pm_resume_via_firmware() || !ctrl->npss ||
-	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
-		nvme_reset_ctrl(ctrl);
-	return 0;
-}
-
 static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
-	struct nvme_ctrl *ctrl = &ndev->ctrl;
-	int ret = -EBUSY;
-
-	/*
-	 * The platform does not remove power for a kernel managed suspend so
-	 * use host managed nvme power settings for lowest idle power if
-	 * possible. This should have quicker resume latency than a full device
-	 * shutdown.  But if the firmware is involved after the suspend or the
-	 * device does not support any non-default power states, shut down the
-	 * device fully.
-	 */
-	if (pm_suspend_via_firmware() || !ctrl->npss) {
-		nvme_dev_disable(ndev, true);
-		return 0;
-	}
-
-	nvme_start_freeze(ctrl);
-	nvme_wait_freeze(ctrl);
-	nvme_sync_queues(ctrl);
-
-	if (ctrl->state != NVME_CTRL_LIVE &&
-	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
-		goto unfreeze;
-
-	ndev->last_ps = 0;
-	ret = nvme_get_power_state(ctrl, &ndev->last_ps);
-	if (ret < 0)
-		goto unfreeze;
-
-	ret = nvme_set_power_state(ctrl, ctrl->npss);
-	if (ret < 0)
-		goto unfreeze;
-
-	if (ret) {
-		/*
-		 * Clearing npss forces a controller reset on resume. The
-		 * correct value will be resdicovered then.
-		 */
-		nvme_dev_disable(ndev, true);
-		ctrl->npss = 0;
-		ret = 0;
-		goto unfreeze;
-	}
-	/*
-	 * A saved state prevents pci pm from generically controlling the
-	 * device's power. If we're using protocol specific settings, we don't
-	 * want pci interfering.
-	 */
-	pci_save_state(pdev);
-unfreeze:
-	nvme_unfreeze(ctrl);
-	return ret;
-}
-
-static int nvme_simple_suspend(struct device *dev)
-{
-	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
 	nvme_dev_disable(ndev, true);
 	return 0;
 }
 
-static int nvme_simple_resume(struct device *dev)
+static int nvme_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
@@ -2926,16 +2846,9 @@ static int nvme_simple_resume(struct device *dev)
 	nvme_reset_ctrl(&ndev->ctrl);
 	return 0;
 }
+#endif
 
-static const struct dev_pm_ops nvme_dev_pm_ops = {
-	.suspend	= nvme_suspend,
-	.resume		= nvme_resume,
-	.freeze		= nvme_simple_suspend,
-	.thaw		= nvme_simple_resume,
-	.poweroff	= nvme_simple_suspend,
-	.restore	= nvme_simple_resume,
-};
-#endif /* CONFIG_PM_SLEEP */
+static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
@@ -3042,11 +2955,9 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
-#ifdef CONFIG_PM_SLEEP
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-#endif
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
 };
-- 
2.23.0.rc1
