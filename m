From: roland@kernel.org (Roland Dreier)
Date: Thu, 11 Jan 2018 13:38:15 -0800
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
Message-ID: <20180111213815.2107-1-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

In nvme_keep_alive() we pass a request with a pointer to an NVMe command on
the stack into blk_execute_rq_nowait().  However, the block layer doesn't
guarantee that the request is fully queued before blk_execute_rq_nowait()
returns.  If not, and the request is queued after nvme_keep_alive() returns,
then we'll end up using stack memory that might have been overwritten to
form the NVMe command we pass to hardware.

Fix this by keeping a special command struct in the nvme_ctrl struct right
next to the delayed work struct used for keep-alives.

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/core.c | 8 +++-----
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 839650e0926a..329f1dd5c421 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -748,13 +748,9 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 {
-	struct nvme_command c;
 	struct request *rq;
 
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = nvme_admin_keep_alive;
-
-	rq = nvme_alloc_request(ctrl->admin_q, &c, BLK_MQ_REQ_RESERVED,
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, BLK_MQ_REQ_RESERVED,
 			NVME_QID_ANY);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
@@ -786,6 +782,8 @@ void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 		return;
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
+	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
+	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a00eabd06427..f524c69339b5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -180,6 +180,7 @@ struct nvme_ctrl {
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
+	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
 
 	/* Power saving configuration */
-- 
2.14.1
