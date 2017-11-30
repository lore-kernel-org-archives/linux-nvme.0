From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 30 Nov 2017 23:49:19 +0900
Subject: [PATCH] nvme-cli: replace values of all namespaces with NVME_NSID_ALL
Message-ID: <1512053359-15141-1-git-send-email-minwoo.im.dev@gmail.com>

Replace all magic numbers(0xffffffff) which means all namespaces
with NVME_NSID_ALL applied by a commit
c5a1120("nvme-cli: resync nvme.h with the kernel's").

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 intel-nvme.c    |  8 ++++----
 memblaze-nvme.c |  2 +-
 nvme-ioctl.c    |  2 +-
 nvme.c          | 14 +++++++-------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index 5b854c0..a2d12d9 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -241,7 +241,7 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	};
 
 	struct config cfg = {
-		.namespace_id = 0xffffffff,
+		.namespace_id = NVME_NSID_ALL,
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
@@ -290,7 +290,7 @@ static int get_market_log(int argc, char **argv, struct command *cmd, struct plu
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
 
-	err = nvme_get_log(fd, 0xffffffff, 0xdd, sizeof(log), log);
+	err = nvme_get_log(fd, NVME_NSID_ALL, 0xdd, sizeof(log), log);
 	if (!err) {
 		if (!cfg.raw_binary)
 			printf("Intel Marketing Name Log:\n%s\n", log);
@@ -350,7 +350,7 @@ static int get_temp_stats_log(int argc, char **argv, struct command *cmd, struct
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
 
-	err = nvme_get_log(fd, 0xffffffff, 0xc5, sizeof(stats), &stats);
+	err = nvme_get_log(fd, NVME_NSID_ALL, 0xc5, sizeof(stats), &stats);
 	if (!err) {
 		if (!cfg.raw_binary)
 			show_temp_stats(&stats);
@@ -416,7 +416,7 @@ static int get_lat_stats_log(int argc, char **argv, struct command *cmd, struct
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
 
-	err = nvme_get_log(fd, 0xffffffff, cfg.write ? 0xc2 : 0xc1, sizeof(stats), &stats);
+	err = nvme_get_log(fd, NVME_NSID_ALL, cfg.write ? 0xc2 : 0xc1, sizeof(stats), &stats);
 	if (!err) {
 		if (!cfg.raw_binary)
 			show_lat_stats(&stats, cfg.write);
diff --git a/memblaze-nvme.c b/memblaze-nvme.c
index b48a0e8..1e092db 100644
--- a/memblaze-nvme.c
+++ b/memblaze-nvme.c
@@ -212,7 +212,7 @@ static int get_additional_smart_log(int argc, char **argv, struct command *cmd,
 	};
 
 	struct config cfg = {
-		.namespace_id = 0xffffffff,
+		.namespace_id = NVME_NSID_ALL,
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 1843faf..4948c87 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -400,7 +400,7 @@ int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
 
 int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log)
 {
-	return nvme_get_log(fd, 0xffffffff, NVME_LOG_FW_SLOT, sizeof(*fw_log), fw_log);
+	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_FW_SLOT, sizeof(*fw_log), fw_log);
 }
 
 int nvme_error_log(int fd, __u32 nsid, int entries,
diff --git a/nvme.c b/nvme.c
index 35b10a7..9f0b8e2 100644
--- a/nvme.c
+++ b/nvme.c
@@ -185,7 +185,7 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 	};
 
 	struct config cfg = {
-		.namespace_id = 0xffffffff,
+		.namespace_id = NVME_NSID_ALL,
 		.output_format = "normal",
 	};
 
@@ -244,7 +244,7 @@ static int get_effects_log(int argc, char **argv, struct command *cmd, struct pl
 	if (fd < 0)
 		return fd;
 
-	err = nvme_get_log(fd, 0xffffffff, 5, 4096, &effects);
+	err = nvme_get_log(fd, NVME_NSID_ALL, 5, 4096, &effects);
 	if (!err)
 		show_effects_log(&effects);
 	else if (err > 0)
@@ -274,7 +274,7 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 	};
 
 	struct config cfg = {
-		.namespace_id = 0xffffffff,
+		.namespace_id = NVME_NSID_ALL,
 		.log_entries  = 64,
 		.output_format = "normal",
 	};
@@ -408,7 +408,7 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 	};
 
 	struct config cfg = {
-		.namespace_id = 0xffffffff,
+		.namespace_id = NVME_NSID_ALL,
 		.log_id       = 0,
 		.log_len      = 0,
 	};
@@ -1720,7 +1720,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	};
 
 	struct config cfg = {
-		.namespace_id = 0xffffffff,
+		.namespace_id = NVME_NSID_ALL,
 		.timeout      = 600000,
 		.lbaf         = 0xff,
 		.ses          = 0,
@@ -1746,7 +1746,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 
 	if (S_ISBLK(nvme_stat.st_mode))
 		cfg.namespace_id = get_nsid(fd);
-	if (cfg.namespace_id != 0xffffffff) {
+	if (cfg.namespace_id != NVME_NSID_ALL) {
 		err = nvme_identify_ns(fd, cfg.namespace_id, 0, &ns);
 		if (err) {
 			if (err < 0)
@@ -2360,7 +2360,7 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 	};
 
 	struct config cfg = {
-		.namespace_id = 0xffffffff,
+		.namespace_id = NVME_NSID_ALL,
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
-- 
2.7.4
