From: jeff.lien@wdc.com (Jeff Lien)
Date: Thu, 18 Jan 2018 15:01:00 -0600
Subject: [PATCH 1/2] NVMe-CLI WDC-Plugin Add clear-pcie-corr command
Message-ID: <20180118210100.1650-1-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 wdc-nvme.c | 35 +++++++++++++++++++++++++++++++++++
 wdc-nvme.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 9affaf0..188b6de 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -121,6 +121,11 @@
 #define WDC_NVME_GET_DEVICE_INFO_LOG_OPCODE			0xCA
 #define WDC_CA_LOG_BUF_LEN							0x80
 
+/* Clear PCIe Correctable Errors */
+#define WDC_NVME_CLEAR_PCIE_CORR_OPCODE  	WDC_NVME_CAP_DIAG_CMD_OPCODE
+#define WDC_NVME_CLEAR_PCIE_CORR_CMD		0x22
+#define WDC_NVME_CLEAR_PCIE_CORR_SUBCMD		0x04
+
 /* Drive Essentials */
 #define WDC_DE_DEFAULT_NUMBER_OF_ERROR_ENTRIES		64
 #define WDC_DE_GENERIC_BUFFER_SIZE					80
@@ -294,6 +299,8 @@ static int wdc_purge(int argc, char **argv,
 static int wdc_purge_monitor(int argc, char **argv,
 		struct command *command, struct plugin *plugin);
 static int wdc_nvme_check_supported_log_page(int fd, __u8 log_id);
+static int wdc_clear_pcie_corr(int argc, char **argv, struct command *command,
+		struct plugin *plugin);
 static int wdc_do_drive_essentials(int fd, char *dir, char *key);
 static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 		struct plugin *plugin);
@@ -1462,6 +1469,34 @@ static int wdc_smart_add_log(int argc, char **argv, struct command *command,
 	return 0;
 }
 
+static int wdc_clear_pcie_corr(int argc, char **argv, struct command *command,
+		struct plugin *plugin)
+{
+	char *desc = "Clear PCIE Correctable Errors.";
+	int fd;
+	int ret;
+	struct nvme_passthru_cmd admin_cmd;
+	const struct argconfig_commandline_options command_line_options[] = {
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc },
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	wdc_check_device(fd);
+
+	memset(&admin_cmd, 0, sizeof (admin_cmd));
+	admin_cmd.opcode = WDC_NVME_CLEAR_PCIE_CORR_OPCODE;
+	admin_cmd.cdw12 = ((WDC_NVME_CLEAR_PCIE_CORR_SUBCMD << WDC_NVME_SUBCMD_SHIFT) |
+			WDC_NVME_CLEAR_PCIE_CORR_CMD);
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	return ret;
+}
+
 static int wdc_get_serial_and_fw_rev(int fd, char *sn, char *fw_rev)
 {
 	int i;
diff --git a/wdc-nvme.h b/wdc-nvme.h
index 2e28ee9..415bbc0 100644
--- a/wdc-nvme.h
+++ b/wdc-nvme.h
@@ -15,6 +15,7 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 		ENTRY("purge", "WDC Purge", wdc_purge)
 		ENTRY("purge-monitor", "WDC Purge Monitor", wdc_purge_monitor)
 		ENTRY("smart-add-log", "WDC Additional Smart Log", wdc_smart_add_log)
+		ENTRY("clear-pcie-corr", "WDC Clear PCIe Correctable Error Count", wdc_clear_pcie_corr)
 		ENTRY("drive-essentials", "WDC Drive Essentials", wdc_drive_essentials)
 	)
 );
-- 
2.14.2.746.g8fb8a94
