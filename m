From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 12:39:00 +0200
Subject: [PATCH resend 1/3] nvme-pci: serialize pci resets
In-Reply-To: <20180114103902.6413-1-sagi@grimberg.me>
References: <20180114103902.6413-1-sagi@grimberg.me>
Message-ID: <20180114103902.6413-2-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/pci.c  | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 921e0fe46775..d30f21aa0828 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -95,7 +95,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
 
-static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
+int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
@@ -104,6 +104,7 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 		flush_work(&ctrl->reset_work);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_reset_ctrl_sync);
 
 static void nvme_delete_ctrl_work(struct work_struct *work)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5aadfe504e5d..6097091bab42 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -394,6 +394,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
+int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 45f843d0cdf9..6ba59566d9fb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2535,7 +2535,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 static void nvme_reset_done(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_reset_ctrl(&dev->ctrl);
+	nvme_reset_ctrl_sync(&dev->ctrl);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
-- 
2.14.1
