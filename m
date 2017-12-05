From: thomas.tai@oracle.com (Thomas Tai)
Date: Tue,  5 Dec 2017 12:01:35 -0700
Subject: [PATCH] nvme: nvme_remove should cancel the reset_work before setting
 the ctrl state
Message-ID: <1512500495-16147-1-git-send-email-thomas.tai@oracle.com>

During nvme_probe, a reset_work task is queued up
for execution. When removing the nvme during unbinding,
the remove function set the ctrl state to NVME_CTRL_DELETING
and then cancel the reset_work. The correct sequence should
have been cancel the reset_work first then change the state.

Otherwise, if the reset_work happens to schedule to work,
the NVME_CTRL_DELETING causes the reset_work function to
fail with "failed to make controller live".

Steps to reproduce the problem:

drive="0000:14:00.0"
for i in {1..20};
do
   echo iteration $i
   driverctl set-override $drive nvme
done

Signed-off-by: Thomas Tai <thomas.tai at oracle.com>
Reviewed-by: Kyle Fortin <kyle.fortin at oracle.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a11cfd4..e2d10f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2534,9 +2534,9 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
 	cancel_work_sync(&dev->ctrl.reset_work);
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	pci_set_drvdata(pdev, NULL);
 
 	if (!pci_device_is_present(pdev)) {
-- 
1.8.3.1
