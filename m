From: Dong.Ho@wdc.com (Dong Ho)
Date: Mon, 11 Mar 2019 20:34:11 +0000
Subject: [PATCH] wdc: Additional device capabilities check
Message-ID: <1552336444-8586-1-git-send-email-dong.ho@wdc.com>

---
 plugins/wdc/wdc-nvme.c | 62 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index f78325a..5da8587 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -84,6 +84,9 @@
 #define WDC_DRIVE_CAP_CLEAR_PCIE			0x0000000000000080
 #define WDC_DRIVE_CAP_RESIZE				0x0000000000000100
 #define WDC_DRIVE_CAP_NAND_STATS			0x0000000000000200
+#define WDC_DRIVE_CAP_DRIVE_LOG				0x0000000000000400
+#define WDC_DRIVE_CAP_CRASH_DUMP			0x0000000000000800
+#define WDC_DRIVE_CAP_PFAIL_DUMP			0x0000000000001000
 
 #define WDC_DRIVE_CAP_DRIVE_ESSENTIALS			0x0000000100000000
 #define WDC_DRIVE_CAP_DUI_DATA				0x0000000200000000
@@ -718,10 +721,12 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 	case WDC_NVME_VID:
 		switch (read_device_id) {
 		case WDC_NVME_SN100_DEV_ID:
-			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG | WDC_DRIVE_CAP_C1_LOG_PAGE);
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG | WDC_DRIVE_CAP_C1_LOG_PAGE |
+					WDC_DRIVE_CAP_DRIVE_LOG | WDC_DRIVE_CAP_CRASH_DUMP | WDC_DRIVE_CAP_PFAIL_DUMP);
 			break;
 		case WDC_NVME_SN200_DEV_ID:
-			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG | WDC_DRIVE_CAP_CLEAR_PCIE);
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG | WDC_DRIVE_CAP_CLEAR_PCIE |
+					WDC_DRIVE_CAP_DRIVE_LOG | WDC_DRIVE_CAP_CRASH_DUMP | WDC_DRIVE_CAP_PFAIL_DUMP);
 
 			/* verify the 0xCA log page is supported */
 			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE) == true)
@@ -1849,6 +1854,8 @@ static int wdc_drive_log(int argc, char **argv, struct command *command,
 	const char *file = "Output file pathname.";
 	char f[PATH_MAX] = {0};
 	int fd;
+	int ret;
+	__u64 capabilities = 0;
 	struct config {
 		char *file;
 	};
@@ -1868,14 +1875,22 @@ static int wdc_drive_log(int argc, char **argv, struct command *command,
 
 	if (!wdc_check_device(fd))
 		return -1;
-	if (cfg.file != NULL) {
-		strncpy(f, cfg.file, PATH_MAX - 1);
-	}
-	if (wdc_get_serial_name(fd, f, PATH_MAX, "drive_log") == -1) {
-		fprintf(stderr, "ERROR : WDC : failed to generate file name\n");
-		return -1;
+	capabilities = wdc_get_drive_capabilities(fd);
+
+	if ((capabilities & WDC_DRIVE_CAP_DRIVE_LOG) == 0) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+	} else {
+		if (cfg.file != NULL) {
+			strncpy(f, cfg.file, PATH_MAX - 1);
+		}
+		if (wdc_get_serial_name(fd, f, PATH_MAX, "drive_log") == -1) {
+			fprintf(stderr, "ERROR : WDC : failed to generate file name\n");
+			return -1;
+		}
+		ret = wdc_do_drive_log(fd, f);
 	}
-	return wdc_do_drive_log(fd, f);
+	return ret;
 }
 
 static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
@@ -1885,6 +1900,7 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 	const char *file = "Output file pathname.";
 	int fd;
 	int ret;
+	__u64 capabilities = 0;
 	struct config {
 		char *file;
 	};
@@ -1904,9 +1920,17 @@ static int wdc_get_crash_dump(int argc, char **argv, struct command *command,
 
 	if (!wdc_check_device(fd))
 		return -1;
-	ret = wdc_crash_dump(fd, cfg.file, WDC_NVME_CRASH_DUMP_TYPE);
-	if (ret != 0) {
-		fprintf(stderr, "ERROR : WDC : failed to read crash dump\n");
+
+	capabilities = wdc_get_drive_capabilities(fd);
+
+	if ((capabilities & WDC_DRIVE_CAP_CRASH_DUMP) == 0) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+	} else {
+		ret = wdc_crash_dump(fd, cfg.file, WDC_NVME_CRASH_DUMP_TYPE);
+		if (ret != 0) {
+			fprintf(stderr, "ERROR : WDC : failed to read crash dump\n");
+		}
 	}
 	return ret;
 }
@@ -1918,6 +1942,7 @@ static int wdc_get_pfail_dump(int argc, char **argv, struct command *command,
 	char *file = "Output file pathname.";
 	int fd;
 	int ret;
+	__u64 capabilities = 0;
 	struct config {
 		char *file;
 	};
@@ -1937,9 +1962,16 @@ static int wdc_get_pfail_dump(int argc, char **argv, struct command *command,
 
 	if (!wdc_check_device(fd))
 		return -1;
-	ret = wdc_crash_dump(fd, cfg.file, WDC_NVME_PFAIL_DUMP_TYPE);
-	if (ret != 0) {
-		fprintf(stderr, "ERROR : WDC : failed to read pfail crash dump\n");
+	capabilities = wdc_get_drive_capabilities(fd);
+
+	if ((capabilities & WDC_DRIVE_CAP_PFAIL_DUMP) == 0) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+	} else {
+		ret = wdc_crash_dump(fd, cfg.file, WDC_NVME_PFAIL_DUMP_TYPE);
+		if (ret != 0) {
+			fprintf(stderr, "ERROR : WDC : failed to read pfail crash dump\n");
+		}
 	}
 	return ret;
 }
-- 
2.7.4
