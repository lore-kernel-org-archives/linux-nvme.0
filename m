From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Jan 2017 12:31:18 +0200
Subject: [PATCH 4/5] nvmet: cancel fatal error and flush async work before
 free controller
In-Reply-To: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
References: <1484217079-9259-1-git-send-email-sagi@grimberg.me>
Message-ID: <1484217079-9259-5-git-send-email-sagi@grimberg.me>

Make sure they are not running and we can free the controller
safely.

Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 16a1c5e85826..dcdc2f6146f1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -817,6 +817,9 @@ static void nvmet_ctrl_free(struct kref *ref)
 	list_del(&ctrl->subsys_entry);
 	mutex_unlock(&subsys->lock);
 
+	flush_work(&ctrl->async_event_work);
+	cancel_work_sync(&ctrl->fatal_err_work);
+
 	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 	nvmet_subsys_put(subsys);
 
-- 
2.7.4
