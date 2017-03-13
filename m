From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Mar 2017 17:10:53 -0600
Subject: [PATCH 3/4] remove nvme_intel_smart_log
In-Reply-To: <20170313231054.30400-1-hch@lst.de>
References: <20170313231054.30400-1-hch@lst.de>
Message-ID: <20170313231054.30400-4-hch@lst.de>

and just inline it into the only caller.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 intel-nvme.c | 3 ++-
 nvme-ioctl.c | 7 -------
 nvme-ioctl.h | 2 --
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index dc13475..3446115 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -123,7 +123,8 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
 
-	err = nvme_intel_smart_log(fd, cfg.namespace_id, &smart_log);
+	err = nvme_get_log(fd, cfg.namespace_id, 0xca, sizeof(smart_log),
+			&smart_log);
 	if (!err) {
 		if (!cfg.raw_binary)
 			show_intel_smart_log(&smart_log, cfg.namespace_id, devicename);
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index b74cdc8..a22399a 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -397,13 +397,6 @@ int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log)
 	return nvme_get_log(fd, nsid, NVME_LOG_SMART, sizeof(*smart_log), smart_log);
 }
 
-int nvme_intel_smart_log(int fd, __u32 nsid,
-			 struct nvme_additional_smart_log *intel_smart_log)
-{
-	return nvme_get_log(fd, nsid, 0xca, sizeof(*intel_smart_log),
-			intel_smart_log);
-}
-
 int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size)
 {
 	return nvme_get_log(fd, 0, NVME_LOG_DISC, size, log);
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 434b29e..3beddf8 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -83,8 +83,6 @@ int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log);
 int nvme_error_log(int fd, __u32 nsid, int entries,
 		   struct nvme_error_log_page *err_log);
 int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log);
-int nvme_intel_smart_log(int fd, __u32 nsid,
-			 struct nvme_additional_smart_log *intel_smart_log);
 int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size);
 
 int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10,
-- 
2.11.0
