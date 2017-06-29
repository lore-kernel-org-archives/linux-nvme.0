From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Wed, 28 Jun 2017 19:19:25 -0700
Subject: [PATCH 1/4] nvme-cli : add support for sanitize command.
In-Reply-To: <20170629021928.19389-1-chaitanya.kulkarni@hgst.com>
References: <20170629021928.19389-1-chaitanya.kulkarni@hgst.com>
Message-ID: <20170629021928.19389-2-chaitanya.kulkarni@hgst.com>

This adds support for NVMe sanitize command execution including
NVMe status codes, command opcode and help text.

For more details please refer to NVM Express 1.3 specification.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 linux/nvme.h   | 16 ++++++++++
 nvme-builtin.h |  1 +
 nvme-print.c   |  2 ++
 nvme.c         | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index c05d819..28ab9b8 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -660,6 +660,7 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+	nvme_admin_sanitize			= 0x84,
 };
 
 enum {
@@ -697,6 +698,18 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+/* Sanitize */
+enum {
+	NVME_SANITIZE_NO_DEALLOC		= 0x00000200,
+	NVME_SANITIZE_OIPBP				= 0x00000100,
+	NVME_SANITIZE_OWPASS_SHIFT		= 0x00000004,
+	NVME_SANITIZE_AUSE				= 0x00000008,
+	NVME_SANITIZE_ACT_CRYPTO_ERASE	= 0x00000004,
+	NVME_SANITIZE_ACT_OVERWRITE		= 0x00000003,
+	NVME_SANITIZE_ACT_BLOCK_ERASE	= 0x00000002,
+	NVME_SANITIZE_ACT_EXIT			= 0x00000001,
+};
+
 struct nvme_identify {
 	__u8			opcode;
 	__u8			flags;
@@ -1010,6 +1023,9 @@ enum {
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
+	NVME_SC_SANITIZE_FAILED			= 0x1C,
+	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
+
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 2bb01cb..b4cd3ba 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -42,6 +42,7 @@ COMMAND_LIST(
 	ENTRY("write", "Submit a write command, return results", write_cmd)
 	ENTRY("write-zeroes", "Submit a write zeroes command, return results", write_zeroes)
 	ENTRY("write-uncor", "Submit a write uncorrectable command, return results", write_uncor)
+	ENTRY("sanitize", "Submit a sanitize command", sanitize)
 	ENTRY("reset", "Resets the controller", reset)
 	ENTRY("subsystem-reset", "Resets the controller", subsystem_reset)
 	ENTRY("show-regs", "Shows the controller registers. Requires admin character device", show_registers)
diff --git a/nvme-print.c b/nvme-print.c
index bf78d4a..f03382f 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1102,6 +1102,8 @@ char *nvme_status_to_string(__u32 status)
 	case NVME_SC_FUSED_MISSING:		return "FUSED_MISSING";
 	case NVME_SC_INVALID_NS:		return "INVALID_NS";
 	case NVME_SC_CMD_SEQ_ERROR:		return "CMD_SEQ_ERROR";
+	case NVME_SC_SANITIZE_FAILED:		return "SANITIZE_FAILED";
+	case NVME_SC_SANITIZE_IN_PROGRESS:	return "SANITIZE_IN_PROGRESS";
 	case NVME_SC_LBA_RANGE:			return "LBA_RANGE";
 	case NVME_SC_CAP_EXCEEDED:		return "CAP_EXCEEDED";
 	case NVME_SC_NS_NOT_READY:		return "NS_NOT_READY";
diff --git a/nvme.c b/nvme.c
index 7e07ffd..8507cd3 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1428,6 +1428,98 @@ static int reset(int argc, char **argv, struct command *cmd, struct plugin *plug
 	return err;
 }
 
+static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	char *desc = "Send a sanitize command.";
+	char *no_dealloc_desc = "No deallocate after sanitize.";
+	char *oipbp_desc = "Overwrite invert pattern between passes.";
+	char *owpass_desc = "Overwrite pass count.";
+	char *ause_desc = "Allow unrestricted sanitize exit.";
+	char *sanact_desc = "Sanitize action.";
+	char *ovrpat_desc = "Overwrite pattern.";
+
+	int fd;
+	int ret;
+	__u32 sanitize_cdw10 = 0;
+	__u32 sanitize_cdw11 = 0;
+
+	struct nvme_passthru_cmd admin_cmd;
+
+	struct config {
+		uint8_t no_dealloc;
+		uint8_t oipbp;
+		uint8_t owpass;
+		uint8_t ause;
+		uint8_t sanact;
+		uint32_t ovrpat;
+	};
+
+	struct config cfg = {
+		.no_dealloc = 0,
+		.oipbp = 0,
+		.owpass = 0,
+		.ause = 0,
+		.sanact = 0,
+		.ovrpat = 0,
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"no_dealloc", 'd', "", CFG_NONE, &cfg.no_dealloc, no_argument, no_dealloc_desc},
+		{"oipbp", 'i', "", CFG_NONE, &cfg.oipbp, no_argument, oipbp_desc},
+		{"owpass", 'n', "NUM", CFG_POSITIVE, &cfg.owpass, required_argument, owpass_desc},
+		{"ause", 'u', "", CFG_NONE, &cfg.ause, no_argument, ause_desc},
+		{"sanact", 'a', "NUM", CFG_POSITIVE, &cfg.sanact, required_argument, sanact_desc},
+		{"ovrpat", 'p', "NUM", CFG_POSITIVE, &cfg.ovrpat, required_argument, ovrpat_desc},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	switch (cfg.sanact) {
+	case NVME_SANITIZE_ACT_CRYPTO_ERASE:
+	case NVME_SANITIZE_ACT_BLOCK_ERASE:
+	case NVME_SANITIZE_ACT_EXIT:
+		sanitize_cdw10 = cfg.sanact;
+		break;
+	case NVME_SANITIZE_ACT_OVERWRITE:
+		sanitize_cdw10 = cfg.sanact;
+		sanitize_cdw11 = cfg.ovrpat;
+		break;
+	default:
+		fprintf(stderr, "Invalid Sanitize Action\n");
+		return -1;
+	}
+
+	if (cfg.ause)
+		sanitize_cdw10 |= NVME_SANITIZE_AUSE;
+
+	if (cfg.sanact == NVME_SANITIZE_ACT_OVERWRITE) {
+		if (cfg.owpass >= 0 && cfg.owpass <= 16) {
+			sanitize_cdw10 |= (cfg.owpass << NVME_SANITIZE_OWPASS_SHIFT);
+		} else {
+			fprintf(stderr, "owpass out of range [0-16] or sanitize action is not set to overwrite\n");
+			return -1;
+		}
+		if (cfg.oipbp)
+			sanitize_cdw10 |= NVME_SANITIZE_OIPBP;
+	}
+
+	if (cfg.sanact != NVME_SANITIZE_ACT_EXIT && cfg.no_dealloc)
+		sanitize_cdw10 |= NVME_SANITIZE_NO_DEALLOC;
+
+	memset(&admin_cmd, 0, sizeof (admin_cmd));
+	admin_cmd.opcode = nvme_admin_sanitize;
+	admin_cmd.cdw10 = sanitize_cdw10;
+	admin_cmd.cdw11 = sanitize_cdw11;
+
+	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
+
+	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	return ret;
+}
+
 static int show_registers(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Reads and shows the defined NVMe controller registers "\
-- 
2.7.4
