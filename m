From: jsmart2021@gmail.com (James Smart)
Date: Thu, 28 Sep 2017 08:35:52 -0700
Subject: [PATCH 1/2] nvmet: fix ctlr ref counting
In-Reply-To: <20170928153553.13993-1-jsmart2021@gmail.com>
References: <20170928153553.13993-1-jsmart2021@gmail.com>
Message-ID: <20170928153553.13993-2-jsmart2021@gmail.com>

Current code:
initializes the reference at allocation
increments reference when ctlr finds are done
has decrements to back out of ctlr finds
decrements in admin queue connect cmd failures to
  cause ctlr free
in nvmet_sq_destroy() decrements to cause ctlr free

Issue is: nvmet_sq_destroy is called for every queue (admin and
io), thus the controller is freed upon the first queue termination.
It's an early "free". There could be other ctlr struct changes made
while subsequent queues are being torn down.

An illustration of use-after-free was seen where the mutex for the
ctrl was corrupted resulting in a mutex_lock hang.

Fix by:
- make a formal control ref get routine.
- have each sq binding to the ctlr do a ctlr get. This will
  now pair with the put on each sq destroy.
- in sq_destroy, if destroying the admin queue, do an
  additional put so that ctlr will be torn down on last
  queue sq_destroy

Signed-off-by: James Smart <james.smart at broadcom.com>
Reported-by: Zhang Yi <yizhan at redhat.com>
---
 drivers/nvme/target/core.c        | 16 ++++++++++++++--
 drivers/nvme/target/fabrics-cmd.c |  1 +
 drivers/nvme/target/nvmet.h       |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1b208beeef50..035a3919d095 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -440,8 +440,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	 * If this is the admin queue, complete all AERs so that our
 	 * queue doesn't have outstanding requests on it.
 	 */
-	if (sq->ctrl && sq->ctrl->sqs && sq->ctrl->sqs[0] == sq)
+	if (sq->ctrl && sq->ctrl->sqs && sq->ctrl->sqs[0] == sq) {
 		nvmet_async_events_free(sq->ctrl);
+		/*
+		 * if freeing admin queue, do another controller
+		 * put so that the controller will be released on
+		 * on the last queue reference being released.
+		 */
+		nvmet_ctrl_put(sq->ctrl);
+	}
 	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
@@ -650,7 +657,7 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 				pr_warn("hostnqn mismatch.\n");
 				continue;
 			}
-			if (!kref_get_unless_zero(&ctrl->ref))
+			if (!nvmet_ctrl_get(ctrl))
 				continue;
 
 			*ret = ctrl;
@@ -867,6 +874,11 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
 	kref_put(&ctrl->ref, nvmet_ctrl_free);
 }
 
+int nvmet_ctrl_get(struct nvmet_ctrl *ctrl)
+{
+	return kref_get_unless_zero(&ctrl->ref);
+}
+
 static void nvmet_fatal_error_handler(struct work_struct *work)
 {
 	struct nvmet_ctrl *ctrl =
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index db3bf6b8bf9e..ceb007e460fd 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -113,6 +113,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		pr_warn("queue size zero!\n");
 		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	}
+	nvmet_ctrl_get(ctrl);
 
 	/* note: convert queue size from 0's-based value to 1's-based value */
 	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7b8e20adf760..6c3a5a5fc71e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -283,6 +283,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 		struct nvmet_req *req, struct nvmet_ctrl **ret);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
+int nvmet_ctrl_get(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
-- 
2.13.1
