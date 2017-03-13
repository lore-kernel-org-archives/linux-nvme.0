From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 16:02:20 +0200
Subject: [PATCH 3/3] nvme-loop: remove some code duplication
In-Reply-To: <1489413740-29085-1-git-send-email-sagi@grimberg.me>
References: <1489413740-29085-1-git-send-email-sagi@grimberg.me>
Message-ID: <1489413740-29085-3-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 22f7bc6bac7f..87da4bcceaa4 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -349,6 +349,19 @@ static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
 	return ret;
 }
 
+static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
+{
+	int i, ret;
+
+	for (i = 1; i < ctrl->queue_count; i++) {
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
 	int error;
@@ -490,7 +503,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	struct nvme_loop_ctrl *ctrl = container_of(work,
 					struct nvme_loop_ctrl, reset_work);
 	bool changed;
-	int i, ret;
+	int ret;
 
 	nvme_loop_shutdown_ctrl(ctrl);
 
@@ -502,11 +515,9 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto out_destroy_admin;
 
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
-		if (ret)
-			goto out_destroy_io;
-	}
+	ret = nvme_loop_connect_io_queues(ctrl);
+	if (ret)
+		goto out_destroy_io;
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
@@ -559,7 +570,7 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 
 static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 {
-	int ret, i;
+	int ret;
 
 	ret = nvme_loop_init_io_queues(ctrl);
 	if (ret)
@@ -588,11 +599,9 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 		goto out_free_tagset;
 	}
 
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
-		if (ret)
-			goto out_cleanup_connect_q;
-	}
+	ret = nvme_loop_connect_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
 
 	return 0;
 
-- 
2.7.4
