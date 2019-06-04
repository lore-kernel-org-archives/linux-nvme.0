From: sashal@kernel.org (Sasha Levin)
Date: Tue,  4 Jun 2019 19:21:43 -0400
Subject: [PATCH AUTOSEL 5.1 33/60] nvme: fix memory leak for power latency
 tolerance
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
Message-ID: <20190604232212.6753-33-sashal@kernel.org>

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit 510a405d945bc985abc513fafe45890cac34fafa ]

Unconditionally hide device pm latency tolerance when uninitializing
the controller to ensure all qos resources are released so that we're
not leaking this memory. This is safe to call if none were allocated in
the first place, or were previously freed.

Fixes: c5552fde102fc("nvme: Enable autonomous power state transitions")
Suggested-by: Keith Busch <keith.busch at intel.com>
Tested-by: David Milburn <dmilburn at redhat.com>
Signed-off-by: Yufen Yu <yuyufen at huawei.com>
[changelog]
Signed-off-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 23c90382a515..35d2202ee2fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3699,6 +3699,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
-- 
2.20.1
