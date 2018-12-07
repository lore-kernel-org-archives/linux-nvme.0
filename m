From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  7 Dec 2018 14:05:30 -0800
Subject: [PATCH] nvme-ioctl: clear rae for discovery log pages
Message-ID: <20181207220530.30310-1-sagi@grimberg.me>

The discovery controller should now be able to send
us discovery log change events so we need to clear the
rae bit for that.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 nvme-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index be0823dfbcc2..70a16ced925a 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -504,7 +504,7 @@ int nvme_effects_log(int fd, struct nvme_effects_log_page *effects_log)
 
 int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size)
 {
-	return nvme_get_log(fd, 0, NVME_LOG_DISC, true, size, log);
+	return nvme_get_log(fd, 0, NVME_LOG_DISC, false, size, log);
 }
 
 int nvme_sanitize_log(int fd, struct nvme_sanitize_log_page *sanitize_log)
-- 
2.17.1
