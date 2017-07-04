From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Tue,  4 Jul 2017 09:56:46 -0700
Subject: [PATCH] nvme-cli : wdc-plug-in : return on invalid input device.
Message-ID: <20170704165646.32576-1-chaitanya.kulkarni@hgst.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 wdc-nvme.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index b0cd771..03c86c9 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -400,6 +400,9 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
 	wdc_check_device(fd);
 	if (cfg.file != NULL) {
 		strncpy(f, cfg.file, PATH_MAX);
@@ -517,6 +520,9 @@ static int wdc_drive_log(int argc, char **argv, struct command *command,
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
 	wdc_check_device(fd);
 	if (cfg.file != NULL) {
 		strncpy(f, cfg.file, PATH_MAX);
@@ -550,6 +556,9 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
 	wdc_check_device(fd);
 	ret = wdc_crash_dump(fd, cfg.file);
 	if (ret != 0) {
@@ -624,6 +633,9 @@ static int wdc_purge(int argc, char **argv,
 	admin_cmd.opcode = WDC_NVME_PURGE_CMD_OPCODE;
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
 	wdc_check_device(fd);
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 	if (ret > 0) {
@@ -668,6 +680,9 @@ static int wdc_purge_monitor(int argc, char **argv,
 	admin_cmd.timeout_ms = WDC_NVME_PURGE_MONITOR_TIMEOUT;
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
 	wdc_check_device(fd);
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 	if (ret == 0) {
@@ -854,6 +869,9 @@ static int wdc_smart_log_add(int argc, char **argv, struct command *command,
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
 	wdc_check_device(fd);
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
-- 
2.13.0
