From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 14 Feb 2019 14:50:56 -0800
Subject: [PATCH 5/6] nvme: Introduce a helper function for controller deletion
In-Reply-To: <20190214225057.195397-1-bvanassche@acm.org>
References: <20190214225057.195397-1-bvanassche@acm.org>
Message-ID: <20190214225057.195397-6-bvanassche@acm.org>

This patch does not change any functionality but makes the next patch
in this series easier to read.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 17356c51901e..c99905bcf1e2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -151,11 +151,8 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_reset_ctrl_sync);
 
-static void nvme_delete_ctrl_work(struct work_struct *work)
+static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *ctrl =
-		container_of(work, struct nvme_ctrl, delete_work);
-
 	dev_info(ctrl->device,
 		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);
 
@@ -167,6 +164,14 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(ctrl);
 }
 
+static void nvme_delete_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, delete_work);
+
+	nvme_do_delete_ctrl(ctrl);
+}
+
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
-- 
2.21.0.rc0.258.g878e2cd30e-goog
