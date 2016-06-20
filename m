From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Jun 2016 11:44:51 -0600
Subject: [PATCH] nvme: Limit command retries
Message-ID: <1466444691-29448-1-git-send-email-keith.busch@intel.com>

Many controller implementations will return errors to commands that will
not succeed, but without the DNR bit set. The driver previously retried
these commands an unlimited number of times until the command timeout
has exceeded, which takes an unnecessarilly long period of time.

This patch limits the number of retries a command can have, defaulting
to 5, but is user tunable at load or runtime.

The struct request's 'retries' field is used to track the number of
retries attempted. This is in contrast with scsi's use of this field,
which indicates how many retries are allowed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 5 +++++
 drivers/nvme/host/nvme.h | 5 ++++-
 drivers/nvme/host/pci.c  | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d7cee4..2b2eca9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -47,6 +47,11 @@ unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
+unsigned int nvme_max_retries = 5;
+module_param_named(max_retries, nvme_max_retries, uint, 0644);
+MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
+EXPORT_SYMBOL_GPL(nvme_max_retries);
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 282421f..8ab141d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -38,6 +38,8 @@ extern unsigned char admin_timeout;
 extern unsigned char shutdown_timeout;
 #define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
 
+extern unsigned int nvme_max_retries;
+
 enum {
 	NVME_NS_LBA		= 0,
 	NVME_NS_LIGHTNVM	= 1,
@@ -204,7 +206,8 @@ static inline int nvme_error_status(u16 status)
 static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 {
 	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
-		(jiffies - req->start_time) < req->timeout;
+		(jiffies - req->start_time) < req->timeout &&
+		req->retries < nvme_max_retries;
 }
 
 void nvme_cancel_request(struct request *req, void *data, bool reserved);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6d33f77..a2b51ea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -310,6 +310,11 @@ static int nvme_init_iod(struct request *rq, unsigned size,
 	iod->npages = -1;
 	iod->nents = 0;
 	iod->length = size;
+
+	if (!(rq->cmd_flags & REQ_DONTPREP)) {
+		rq->retries = 0;
+		rq->cmd_flags |= REQ_DONTPREP;
+	}
 	return 0;
 }
 
@@ -623,6 +628,7 @@ static void nvme_complete_rq(struct request *req)
 
 	if (unlikely(req->errors)) {
 		if (nvme_req_needs_retry(req, req->errors)) {
+			req->retries++;
 			nvme_requeue_req(req);
 			return;
 		}
-- 
2.7.2
