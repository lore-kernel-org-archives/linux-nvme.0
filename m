From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Sep 2018 18:15:35 -0700
Subject: [PATCH 2/4] nvmet: support for traffic based keep-alive
In-Reply-To: <20180928011537.30069-1-sagi@grimberg.me>
References: <20180928011537.30069-1-sagi@grimberg.me>
Message-ID: <20180928011537.30069-3-sagi@grimberg.me>

A controller that supports traffic based keep-alive can restart
its keep alive timer even if keep-alive was not issued in the
kato period but other admin or io commands was. For each command
set ctrl->cmd_seen to true, and when keep-alive timer expires,
if any commands were seen, resched ka_work instead of escalating
to a fatal error.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c |  3 ++-
 drivers/nvme/target/core.c      | 12 ++++++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            |  1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 86be3d0ae847..5eb972a7c092 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -300,7 +300,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT);
+	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT |
+		NVME_CTRL_ATTR_TBKAS);
 
 	id->oacs = 0;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b5ec96abd048..7084704b468d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -298,6 +298,15 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 {
 	struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvmet_ctrl, ka_work);
+	bool cmd_seen = ctrl->cmd_seen;
+
+	ctrl->cmd_seen = false;
+	if (cmd_seen) {
+		pr_debug("ctrl %d traffic-based keep-alive timer expired, reschedule\n",
+			ctrl->cntlid);
+		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+		return;
+	}
 
 	pr_err("ctrl %d keep-alive timer (%d seconds) expired!\n",
 		ctrl->cntlid, ctrl->kato);
@@ -700,6 +709,9 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		goto fail;
 	}
 
+	if (sq->ctrl)
+		sq->ctrl->cmd_seen = true;
+
 	return true;
 
 fail:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ec9af4ee03b6..8f965e025e29 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -154,6 +154,8 @@ struct nvmet_ctrl {
 	struct nvmet_cq		**cqs;
 	struct nvmet_sq		**sqs;
 
+	bool			cmd_seen;
+
 	struct mutex		lock;
 	u64			cap;
 	u32			cc;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0692683c103a..6ea47158c41b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -200,6 +200,7 @@ enum {
 
 enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
+	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 };
 
 struct nvme_id_ctrl {
-- 
2.17.1
