From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 13 Nov 2017 12:29:41 +0000
Subject: [PATCH 2/4] nvmet: Rearrange nvmet_ctrl_free()
In-Reply-To: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
Message-ID: <1510576183-17215-3-git-send-email-israelr@mellanox.com>

Make it symmetric to nvmet_alloc_ctrl().

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5699c9a..995976e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -870,21 +870,22 @@ static void nvmet_ctrl_free(struct kref *ref)
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
1.8.3.1
