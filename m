From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 16 Jan 2018 13:06:32 +0800
Subject: [PATCH 2/3] nvme: free correct device name for nvme_init_ctrl
In-Reply-To: <1516079193-13772-1-git-send-email-guanjunxiong@huawei.com>
References: <1516079193-13772-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1516079193-13772-2-git-send-email-guanjunxiong@huawei.com>

We call dev_set_name for ctrl-device, so we need to free
this device name, rather than another device.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 839650e..5ada879 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3354,7 +3354,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_free_name:
-	kfree_const(dev->kobj.name);
+	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 out:
-- 
2.6.4.windows.1
