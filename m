From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 10 Apr 2018 20:18:05 +0300
Subject: [PATCH v1 1/5] Revert "nvme: unexport nvme_start_keep_alive"
In-Reply-To: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
Message-ID: <1523380689-17151-2-git-send-email-maxg@mellanox.com>

This reverts commit c8799eee39e7523e5e0be10f8950b11cb66085bd.

nvme_start_keep_alive() will be used by the transport drivers
to fix keep-alive synchronization between NVMe-oF target/host.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 38b450e..6211066 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -826,7 +826,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	}
 }
 
-static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
+void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 {
 	if (unlikely(ctrl->kato == 0))
 		return;
@@ -836,6 +836,7 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
+EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ced5b3d..0ecd30a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -422,6 +422,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
+void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
-- 
1.8.3.1
