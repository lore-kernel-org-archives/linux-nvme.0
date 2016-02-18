From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Feb 2016 16:21:15 -0700
Subject: [PATCH-4.6 1/3] NVMe: Use simple ida interface
Message-ID: <1455837677-23248-1-git-send-email-keith.busch@intel.com>

This is an easier interface to use and removes one of the overloaded
dev_list_lock uses.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Feature was originally posted by Lee Duncan last October, but this missed
being applied.

 drivers/nvme/host/core.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b1253f..04443b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1334,29 +1334,17 @@ static DEFINE_IDA(nvme_instance_ida);
 
 static int nvme_set_instance(struct nvme_ctrl *ctrl)
 {
-	int instance, error;
-
-	do {
-		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
-			return -ENODEV;
-
-		spin_lock(&dev_list_lock);
-		error = ida_get_new(&nvme_instance_ida, &instance);
-		spin_unlock(&dev_list_lock);
-	} while (error == -EAGAIN);
-
-	if (error)
-		return -ENODEV;
+	int instance = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
 
+	if (instance < 0)
+		return instance;
 	ctrl->instance = instance;
 	return 0;
 }
 
 static void nvme_release_instance(struct nvme_ctrl *ctrl)
 {
-	spin_lock(&dev_list_lock);
-	ida_remove(&nvme_instance_ida, ctrl->instance);
-	spin_unlock(&dev_list_lock);
+	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 }
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
-- 
2.6.2.307.g37023ba
