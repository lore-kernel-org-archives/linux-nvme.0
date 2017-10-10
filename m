From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 10 Oct 2017 14:40:31 +0300
Subject: [PATCH 2/4] nvmet: Fix error flow in nvmet_alloc_ctrl()
In-Reply-To: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
Message-ID: <1507635633-16665-3-git-send-email-israelr@mellanox.com>

Also rearrange nvmet_ctrl_free().

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 08270c1..711df73 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -798,7 +798,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		/* Don't accept keep-alive timeout for discovery controllers */
 		if (kato) {
 			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-			goto out_free_sqs;
+			goto out_remove_ida;
 		}
 
 		/*
@@ -829,6 +829,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	*ctrlp = ctrl;
 	return 0;
 
+out_remove_ida:
+	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_cqs:
@@ -846,21 +848,22 @@ static void nvmet_ctrl_free(struct kref *ref)
 	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
 	struct nvmet_subsys *subsys = ctrl->subsys;
 
-	nvmet_stop_keep_alive_timer(ctrl);
-
 	mutex_lock(&subsys->lock);
 	list_del(&ctrl->subsys_entry);
 	mutex_unlock(&subsys->lock);
 
+	nvmet_stop_keep_alive_timer(ctrl);
+
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
 	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
-	nvmet_subsys_put(subsys);
 
 	kfree(ctrl->sqs);
 	kfree(ctrl->cqs);
 	kfree(ctrl);
+
+	nvmet_subsys_put(subsys);
 }
 
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
-- 
1.8.4.3
