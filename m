From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  2 Nov 2018 10:28:13 -0700
Subject: [PATCH v3 2/4] nvmet: support for traffic based keep-alive
In-Reply-To: <20181102172815.19777-1-sagi@grimberg.me>
References: <20181102172815.19777-1-sagi@grimberg.me>
Message-ID: <20181102172815.19777-3-sagi@grimberg.me>

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
index 30778ffc46f5..c9c6d25a3ec2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -304,7 +304,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
-	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT);
+	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT |
+		NVME_CTRL_ATTR_TBKAS);
 
 	id->oacs = 0;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0acdff9e6842..b9fbb60921a4 100644
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
+		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
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
index 08f7b57a1203..c5255e743f63 100644
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
index 753c83a5c01f..429c4cf90899 100644
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
