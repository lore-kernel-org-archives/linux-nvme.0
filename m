From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 May 2019 15:13:26 -0600
Subject: [PATCH] nvme: fix memory leak for power latency tolerance req
In-Reply-To: <20190516030521.40374-1-yuyufen@huawei.com>
References: <20190516030521.40374-1-yuyufen@huawei.com>
Message-ID: <20190516211326.GB23955@localhost.localdomain>

It's perfectly safe to call dev_pm_qos_hide_latency_tolerance even if we
never exposed it, so I think you're making this more complicated than
necessary. Would the following one-liner work for you instead?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f2411d50e764..0899dc5645a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3697,6 +3697,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
--
