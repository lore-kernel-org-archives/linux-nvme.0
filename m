From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  8 Mar 2017 22:01:18 +0200
Subject: [PATCH] nvmet: confirm sq percpu has scheduled and switched to atomic
Message-ID: <1489003278-1998-1-git-send-email-sagi@grimberg.me>

percpu_ref_kill is not enough to prevent subsequent
percpu_ref_tryget_live from failing. Hence call
perfcpu_ref_kill_confirm to make it safe.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c  | 11 ++++++++++-
 drivers/nvme/target/nvmet.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 11b0a0a5f661..798653b329b2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -425,6 +425,13 @@ void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 	ctrl->sqs[qid] = sq;
 }
 
+static void nvmet_confirm_sq(struct percpu_ref *ref)
+{
+	struct nvmet_sq *sq = container_of(ref, struct nvmet_sq, ref);
+
+	complete(&sq->confirm_done);
+}
+
 void nvmet_sq_destroy(struct nvmet_sq *sq)
 {
 	/*
@@ -433,7 +440,8 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	 */
 	if (sq->ctrl && sq->ctrl->sqs && sq->ctrl->sqs[0] == sq)
 		nvmet_async_events_free(sq->ctrl);
-	percpu_ref_kill(&sq->ref);
+	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
+	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 
@@ -461,6 +469,7 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 		return ret;
 	}
 	init_completion(&sq->free_done);
+	init_completion(&sq->confirm_done);
 
 	return 0;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6ea32c49de58..1bbb67bf72d2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -73,6 +73,7 @@ struct nvmet_sq {
 	u16			qid;
 	u16			size;
 	struct completion	free_done;
+	struct completion	confirm_done;
 };
 
 /**
-- 
2.7.4
