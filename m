From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 16 Jan 2018 13:06:33 +0800
Subject: [PATCH 3/3] nvme: free subsystem device name when releasing subsystem
In-Reply-To: <1516079193-13772-1-git-send-email-guanjunxiong@huawei.com>
References: <1516079193-13772-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1516079193-13772-3-git-send-email-guanjunxiong@huawei.com>

We need to free the memory as the way we do in the nvme_init_ctrl
because the dev_set_name helper allocates memory for device name.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5ada879..70ee889 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1961,6 +1961,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 static void __nvme_release_subsystem(struct nvme_subsystem *subsys)
 {
 	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
+	kfree_const(subsys->dev.kobj.name);
 	kfree(subsys);
 }
 
-- 
2.6.4.windows.1
