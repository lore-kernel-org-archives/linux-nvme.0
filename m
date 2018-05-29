From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:26 +0200
Subject: [PATCH 05/10] nvme: retry nvme_get_log_ext() when processing ANA log
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-6-hare@suse.de>

When we can't fetch the ANA log page we should retry to ensure
that we really have nothing to read.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a520582811f8..73bd4ff6ab06 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -19,6 +19,10 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static u8 ana_log_retries = 5;
+module_param(ana_log_retries, byte, 0644);
+MODULE_PARM_DESC(ana_log_retries, "max number of retries retrieving ANA log");
+
 /*
  * If multipathing is enabled we need to always use the subsystem instance
  * number for numbering our devices to avoid conflicts between subsystems that
@@ -303,7 +307,7 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 {
 	void *base = ctrl->ana_log_buf;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
-	int error = 0, i;
+	int error = 0, i, retries = 0;
 
 	/*
 	 * If anagrpid never changes we don't need to process the namespace
@@ -312,10 +316,13 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 	if (ctrl->anacap & (1 << 6))
 		groups_only = true;
 
+resubmit:
 	error = nvme_get_log_ext(ctrl, NULL, NVME_LOG_ANA,
 			groups_only ? NVME_ANA_LOG_RGO : 0,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
 	if (error) {
+		if (++retries < ana_log_retries)
+			goto resubmit;
 		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
 		return -EIO;
 	}
-- 
2.12.3
