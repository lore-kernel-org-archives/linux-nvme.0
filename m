From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 25 Jul 2018 20:11:45 -0700
Subject: [PATCH] nvme-cli: use RAE bit for changed-ns-list-log
Message-ID: <20180726031145.2848-1-chaitanya.kulkarni@wdc.com>

This patch uses Retain Asynchronous Event bit when reading the
NVMe Changed Namespace List log page. This allows nvme-cli to
not clear any pending AEN(s) which are expected to be cleaned
by the driver.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Hi,

As per yesterday's discussion, I've posted the RAE patch for the 
NVMeOF target :-
"nvmet: use Retain Async Event bit to clear AEN"
http://lists.infradead.org/pipermail/linux-nvme/2018-July/019469.html.

This is an extension of the RAE implementation where we set the RAE 
to true for nvme-cli when executing nvme-changed-ns-list-log.
A similar pattern can be repeated for the ANA target and nvme-cli command.

Regards,
Chaitanya
---
 nvme-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 9cf2a33..32c299e 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -447,8 +447,8 @@ int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log)
 
 int nvme_changed_ns_list_log(int fd, struct nvme_changed_ns_list_log *changed_ns_list_log)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_CHANGED_NS, sizeof(changed_ns_list_log->log),
-			changed_ns_list_log->log);
+	return nvme_get_log13(fd, 0, NVME_LOG_CHANGED_NS, NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
+			0, true, sizeof(changed_ns_list_log->log), changed_ns_list_log->log);
 }
 
 int nvme_error_log(int fd, int entries, struct nvme_error_log_page *err_log)
-- 
2.17.0
