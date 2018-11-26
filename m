From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Nov 2018 16:39:47 -0700
Subject: [PATCH] nvme: Free ctrl device name on init failure
Message-ID: <20181126233947.5256-1-keith.busch@intel.com>

Free the kobject name that was allocated for the controller device on
failure rather than its parent.

Fixes: d22524a4782a9 ("nvme: switch controller refcounting to use struct device")
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 559d567693b8..5afda6fe5ae9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3585,7 +3585,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_free_name:
-	kfree_const(dev->kobj.name);
+	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 out:
-- 
2.14.4
