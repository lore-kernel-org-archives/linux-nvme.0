From: jsmart2021@gmail.com (James Smart)
Date: Mon, 30 Apr 2018 15:46:58 -0700
Subject: [PATCH v2] nvme-cli: Add ioctl retry support for "connect-all"
Message-ID: <20180430224658.6537-1-jsmart2021@gmail.com>

Currently, if an ioctl command to a controller fails, the routines
within nvme-cli don't do retries and just fail.  In the case of
operations such as "connect-all" which depend on the ioctl to read
the discovery log to give it the list of controller to then "connect"
to, this failure can be catastrophic as there's no guarantee that the
event/admin action that performed the connect-all will be re-triggered,
resulting in a loss of connectivity to storage subsystems.

As to why the ioctl may have failed in the first place: if the
controller is in the middle of a reset or reconnect due to
an error or temporary loss of connectivity (which can happen even
on a discovery controller), ioctl commands will fail rather than
suspend for the full duration of the controller state change
(say to live or delete), which could be a minute or more.

This patch makes the following changes:
- Implement an ioctl wrapper that does retries. The ioctl will only
  retry if the failure status was EAGAIN.
- Create an admin passthru wrapper that uses the ioctl wrapper with
  retry
= Modify the ioctl that reads the discovery log to use the new
  admin passthru wrapper that performs retries when reading the
  discovery log, and uses the normal admin passthru (no retries)
  for all other log types.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2: rather than all ioctls having a retry counter, reduce to simply
  the code flow for connect-all
---
 nvme-ioctl.c | 26 +++++++++++++++++++++++++-
 nvme-ioctl.h |  8 ++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index e8ba935..37d1bce 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -21,6 +21,20 @@
 
 #include "nvme-ioctl.h"
 
+static int nvme_do_ioctl(int fd, int rqst, void *cmd, int maxretry)
+{
+	int ret = 0, retry;
+
+	for (retry = 0 ; retry <= maxretry; retry++) {
+		ret = ioctl(fd, rqst, cmd);
+		if (ret != -1 || errno != EAGAIN)
+			break;
+
+		usleep(IOCTL_DELAY);
+	}
+	return ret;
+}
+
 static int nvme_verify_chr(int fd)
 {
 	static struct stat nvme_stat;
@@ -94,6 +108,12 @@ static int nvme_submit_admin_passthru(int fd, struct nvme_passthru_cmd *cmd)
 	return ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd);
 }
 
+static int nvme_submit_admin_passthru_retry(int fd,
+			struct nvme_passthru_cmd *cmd, int maxretry)
+{
+	return nvme_do_ioctl(fd, NVME_IOCTL_ADMIN_CMD, cmd, maxretry);
+}
+
 static int nvme_submit_io_passthru(int fd, struct nvme_passthru_cmd *cmd)
 {
 	return ioctl(fd, NVME_IOCTL_IO_CMD, cmd);
@@ -401,7 +421,11 @@ int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
 	cmd.cdw12 = lpo;
 	cmd.cdw13 = (lpo >> 32);
 
-	return nvme_submit_admin_passthru(fd, &cmd);
+	if (log_id == NVME_LOG_DISC)
+		return nvme_submit_admin_passthru_retry(fd, &cmd,
+				DISCOVERY_RETRIES);
+	else
+		return nvme_submit_admin_passthru(fd, &cmd);
 
 }
 
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 9bf5459..36f1661 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -6,6 +6,14 @@
 #include "linux/nvme_ioctl.h"
 #include "nvme.h"
 
+/* rate of ioctl retries */
+#define IOCTL_TIMESPERSEC	4
+/* delay between retries. Units in us */
+#define IOCTL_DELAY		(1000000 / IOCTL_TIMESPERSEC)	/* 250ms */
+
+#define NO_RETRIES		0
+#define DISCOVERY_RETRIES	(IOCTL_TIMESPERSEC * 60)	/* 60s */
+
 int nvme_get_nsid(int fd);
 
 /* Generic passthrough */
-- 
2.13.1
