From: Dong.Ho@wdc.com (Dong Ho)
Date: Mon, 4 Feb 2019 19:54:05 +0000
Subject: [PATCH 1/2] wdc: Update device capabilities for clear pcie corr
Message-ID: <1549310038-13075-1-git-send-email-dong.ho@wdc.com>

---
 plugins/wdc/wdc-nvme.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 3aeb28b..2f9a541 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -682,7 +682,7 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG | WDC_DRIVE_CAP_C1_LOG_PAGE);
 			break;
 		case WDC_NVME_SN200_DEV_ID:
-			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG);
+			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG | WDC_DRIVE_CAP_CLEAR_PCIE);
 
 			/* verify the 0xCA log page is supported */
 			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE) == true)
@@ -711,7 +711,7 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 		case WDC_NVME_SN840_DEV_ID:
 			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG |
 					WDC_DRIVE_CAP_DRIVE_STATUS | WDC_DRIVE_CAP_CLEAR_ASSERT |
-					WDC_DRIVE_CAP_RESIZE);
+					WDC_DRIVE_CAP_RESIZE | WDC_DRIVE_CAP_CLEAR_PCIE);
 
 			/* verify the 0xCA log page is supported */
 			if (wdc_nvme_check_supported_log_page(fd, WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE) == true)
@@ -2611,6 +2611,7 @@ static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct comma
 	char *desc = "Clear PCIE Correctable Errors.";
 	int fd;
 	int ret;
+	__u64 capabilities = 0;
 	struct nvme_passthru_cmd admin_cmd;
 	const struct argconfig_commandline_options command_line_options[] = {
 		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
@@ -2620,8 +2621,17 @@ static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct comma
 	if (fd < 0)
 		return fd;
 
-	if (!wdc_check_device(fd))
-		return -1;
+	if (!wdc_check_device(fd)) {
+		ret = -1;
+		goto out;
+	}
+
+	capabilities = wdc_get_drive_capabilities(fd);
+	if ((capabilities & WDC_DRIVE_CAP_CLEAR_PCIE) == 0) {
+		fprintf(stderr, "ERROR : WDC: unsupported device for this command\n");
+		ret = -1;
+		goto out;
+	}
 
 	memset(&admin_cmd, 0, sizeof (admin_cmd));
 	admin_cmd.opcode = WDC_NVME_CLEAR_PCIE_CORR_OPCODE;
@@ -2630,6 +2640,7 @@ static int wdc_clear_pcie_correctable_errors(int argc, char **argv, struct comma
 
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+out:
 	return ret;
 }
 static int wdc_drive_status(int argc, char **argv, struct command *command,
-- 
2.7.4
