From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Wed, 28 Jun 2017 19:19:27 -0700
Subject: [PATCH 3/4] nvme-cli : add support for retrieving sanitize log.
In-Reply-To: <20170629021928.19389-1-chaitanya.kulkarni@hgst.com>
References: <20170629021928.19389-1-chaitanya.kulkarni@hgst.com>
Message-ID: <20170629021928.19389-4-chaitanya.kulkarni@hgst.com>

This adds support for retrieving and printing NVMe sanitize log
page. For more details please look into NVM Express 1.3
specification.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 linux/nvme.h   | 23 +++++++++++++++++++++-
 nvme-builtin.h |  1 +
 nvme.c         | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 28ab9b8..19354a5 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -693,13 +693,15 @@ enum {
 	NVME_LOG_FW_SLOT	= 0x03,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
+	NVME_LOG_SANITIZE	= 0x81,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
-/* Sanitize */
+/* Sanitize and Sanitize Monitor/Log */
 enum {
+	/* Sanitize */
 	NVME_SANITIZE_NO_DEALLOC		= 0x00000200,
 	NVME_SANITIZE_OIPBP				= 0x00000100,
 	NVME_SANITIZE_OWPASS_SHIFT		= 0x00000004,
@@ -708,6 +710,15 @@ enum {
 	NVME_SANITIZE_ACT_OVERWRITE		= 0x00000003,
 	NVME_SANITIZE_ACT_BLOCK_ERASE	= 0x00000002,
 	NVME_SANITIZE_ACT_EXIT			= 0x00000001,
+
+	/* Sanitize Monitor/Log */
+	NVME_SANITIZE_LOG_DATA_LEN				= 0x0014,
+	NVME_SANITIZE_LOG_GLOBAL_DATA_ERASED	= 0x0100,
+	NVME_SANITIZE_LOG_STATUS_MASK			= 0x0007,
+	NVME_SANITIZE_LOG_NEVER_SANITIZED		= 0x0000,
+	NVME_SANITIZE_LOG_COMPLETED_SUCCESS		= 0x0001,
+	NVME_SANITIZE_LOG_IN_PROGESS			= 0x0002,
+	NVME_SANITIZE_LOG_COMPLETED_FAILED		= 0x0003,
 };
 
 struct nvme_identify {
@@ -832,6 +843,16 @@ struct nvme_get_log_page_command {
 	__u32			rsvd14[2];
 };
 
+/* Sanitize Log Page */
+struct nvme_sanitize_log_page {
+	__le16			progress;
+	__le16			status;
+	__le32			cdw10_info;
+	__le32			est_ovrwrt_time;
+	__le32			est_blk_erase_time;
+	__le32			est_crypto_erase_time;
+};
+
 /*
  * Fabrics subcommands.
  */
diff --git a/nvme-builtin.h b/nvme-builtin.h
index b4cd3ba..2143ffd 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -43,6 +43,7 @@ COMMAND_LIST(
 	ENTRY("write-zeroes", "Submit a write zeroes command, return results", write_zeroes)
 	ENTRY("write-uncor", "Submit a write uncorrectable command, return results", write_uncor)
 	ENTRY("sanitize", "Submit a sanitize command", sanitize)
+	ENTRY("sanitize-log", "Retrive sanitize log, show it", sanitize_log)
 	ENTRY("reset", "Resets the controller", reset)
 	ENTRY("subsystem-reset", "Resets the controller", subsystem_reset)
 	ENTRY("show-regs", "Shows the controller registers. Requires admin character device", show_registers)
diff --git a/nvme.c b/nvme.c
index 8507cd3..40fb3df 100644
--- a/nvme.c
+++ b/nvme.c
@@ -422,6 +422,68 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 	}
 }
 
+static const char * sanitize_mon_status_to_string(__u16 status)
+{
+	const char * str;
+
+	switch (status & NVME_SANITIZE_LOG_STATUS_MASK) {
+	case NVME_SANITIZE_LOG_NEVER_SANITIZED:
+		str = "NVM Subsystem has never been sanitized.";
+		break;
+	case NVME_SANITIZE_LOG_COMPLETED_SUCCESS:
+		str = "Most Recent Sanitize Command Completed Successfully.";
+		break;
+	case NVME_SANITIZE_LOG_IN_PROGESS:
+		str = "Sanitize in Progress.";
+		break;
+	case NVME_SANITIZE_LOG_COMPLETED_FAILED:
+		str = "Most Recent Sanitize Command Failed.";
+		break;
+	default:
+		str = "Unknown.";
+	}
+
+	return str;
+}
+
+static int sanitize_log(int argc, char **argv, struct command *command, struct plugin *plugin)
+{
+	char *desc = "Retrieve sanitize log and show it.";
+	int fd;
+	int ret;
+	__u8 output[NVME_SANITIZE_LOG_DATA_LEN] = {0};
+	struct nvme_sanitize_log_page *slp;
+	double progress_percent;
+	const struct argconfig_commandline_options command_line_options[] = {
+		{ NULL, '\0', NULL, CFG_NONE, NULL, no_argument, desc},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	ret = nvme_get_log(fd, 0x01, NVME_LOG_SANITIZE, NVME_SANITIZE_LOG_DATA_LEN, output);
+	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	if (ret != 0)
+		return ret;
+
+	slp = (struct nvme_sanitize_log_page *) output;
+	printf("Sanitize status                     = 0x%0x\n", slp->status);
+	printf("%s\n", sanitize_mon_status_to_string(slp->status));
+
+	if ((slp->status & NVME_SANITIZE_LOG_STATUS_MASK) == NVME_SANITIZE_LOG_IN_PROGESS) {
+		progress_percent = (((double)le32_to_cpu(slp->progress) * 100) / 0x10000);
+		printf("Sanitize Progress (percentage)      = %f%%\n", progress_percent);
+	} else {
+		if (slp->status & NVME_SANITIZE_LOG_GLOBAL_DATA_ERASED)
+			printf("Global Data Erased Set\n");
+		else
+			printf("Global Data Erased Cleared\n");
+	}
+	return ret;
+}
+
 static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Show controller list information for the subsystem the "\
-- 
2.7.4
