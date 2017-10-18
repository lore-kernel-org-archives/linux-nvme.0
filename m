From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 14:07:44 +0300
Subject: [PATCH 5/5] nvme-loop: remove redundant check if the ctrl is in the
 ctrl when freeing it
In-Reply-To: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508324864-23087-6-git-send-email-sagi@grimberg.me>

From: Roy Shterman <roys@lightbitslabs.com>

Its no longer acceptable now that we do not invoke ->free_ctrl
from inside ->create_ctrl.

Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cea6bab1e70c..6f9748a0b7cd 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -284,9 +284,6 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
-
 	mutex_lock(&nvme_loop_ctrl_mutex);
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
@@ -297,7 +294,6 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 	}
 	kfree(ctrl->queues);
 	nvmf_free_options(nctrl->opts);
-free_ctrl:
 	kfree(ctrl);
 }
 
-- 
2.7.4
