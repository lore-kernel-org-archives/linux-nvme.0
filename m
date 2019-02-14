From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 14 Feb 2019 23:05:23 +0000
Subject: [PATCH 4/6] nvme: Unexport nvme_delete_ctrl_sync()
In-Reply-To: <20190214225057.195397-5-bvanassche@acm.org>
References: <20190214225057.195397-1-bvanassche@acm.org>,
 <20190214225057.195397-5-bvanassche@acm.org>
Message-ID: <BYAPR04MB4502B9139AE38BA3ED458ACB86670@BYAPR04MB4502.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Bart Van Assche <bvanassche@acm.org>
Sent: Thursday, February 14, 2019 2:50 PM
To: Christoph Hellwig
Cc: Keith Busch; Sagi Grimberg; linux-nvme at lists.infradead.org; Bart Van Assche
Subject: [PATCH 4/6] nvme: Unexport nvme_delete_ctrl_sync()
?
Since nvme_delete_ctrl_sync() is not called from any other kernel module,
unexport it.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
?drivers/nvme/host/core.c | 3 +--
?drivers/nvme/host/nvme.h | 1 -
?2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c365f0aa9433..17356c51901e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -177,7 +177,7 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
?}
?EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
?
-int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
+static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
?{
???????? int ret = 0;
?
@@ -192,7 +192,6 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
???????? nvme_put_ctrl(ctrl);
???????? return ret;
?}
-EXPORT_SYMBOL_GPL(nvme_delete_ctrl_sync);
?
?static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
?{
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a0cc733c753e..d0c113a1388b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -457,7 +457,6 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
?int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
?int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
?int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
-int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
?
?int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
???????????????? void *log, size_t size, u64 offset);
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
