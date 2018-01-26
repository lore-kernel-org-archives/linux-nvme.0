From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 27 Jan 2018 00:35:44 +0900
Subject: [PATCH] nvme-cli: add print for command name to effects-log
Message-ID: <1516980944-12835-1-git-send-email-minwoo.im.dev@gmail.com>

Commands Supported and Effects log page describes commands supported and
effects of commands. It would be better if command names are printed out
with their opcodes.

So, Add the command names following NVMe 1.3a specification to
effects-log command to both normal mode and json mode.

Example of commands output
========
Admin Command Set
ACS0     [Delete I/O Submission Queue     ] 00000001
ACS1     [Create I/O Submission Queue     ] 00000001
ACS2     [Get Log Page                    ] 00000001
ACS4     [Delete I/O Completion Queue     ] 00000001
ACS5     [Create I/O Completion Queue     ] 00000001
ACS6     [Identify                        ] 00000001
ACS8     [Abort                           ] 00000001
ACS9     [Set Features                    ] 00000001
ACS10    [Get Features                    ] 00000001
ACS12    [Asynchronous Event Request      ] 00000001
ACS16    [Firmware Commit                 ] 00000001
ACS17    [Firmware Image Download         ] 00000001
ACS128   [Format NVM                      ] 00020003
ACS129   [Security Send                   ] 00020003
ACS130   [Security Receive                ] 00010001

NVM Command Set
IOCS0    [Flush                           ] 00010001
IOCS1    [Write                           ] 00000003
IOCS2    [Read                            ] 00000001
IOCS4    [Write Uncorrectable             ] 00000003
IOCS5    [Compare                         ] 00000001
IOCS8    [Write Zeroes                    ] 00000003
IOCS9    [Dataset Management              ] 00010003
=======

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 linux/nvme.h |  4 ++++
 nvme-print.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 9c152e4..8bacf3a 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -749,10 +749,14 @@ enum nvme_admin_opcode {
 	nvme_admin_ns_mgmt		= 0x0d,
 	nvme_admin_activate_fw		= 0x10,
 	nvme_admin_download_fw		= 0x11,
+	nvme_admin_dev_self_test	= 0x14,
 	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
 	nvme_admin_directive_send	= 0x19,
 	nvme_admin_directive_recv	= 0x1a,
+	nvme_admin_virtual_mgmt		= 0x1c,
+	nvme_admin_nvme_mi_send		= 0x1d,
+	nvme_admin_nvme_mi_recv		= 0x1e,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
diff --git a/nvme-print.c b/nvme-print.c
index 1ca4b71..af2bc15 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1047,26 +1047,80 @@ static void show_effects_log_human(__u32 effect)
 		printf("  Reserved CSE\n");
 }
 
+static char *nvme_cmd_to_string(int admin, __u8 opcode)
+{
+	if (admin) {
+		switch (opcode) {
+		case nvme_admin_delete_sq:	return "Delete I/O Submission Queue";
+		case nvme_admin_create_sq:	return "Create I/O Submission Queue";
+		case nvme_admin_get_log_page:	return "Get Log Page";
+		case nvme_admin_delete_cq:	return "Delete I/O Completion Queue";
+		case nvme_admin_create_cq:	return "Create I/O Completion Queue";
+		case nvme_admin_identify:	return "Identify";
+		case nvme_admin_abort_cmd:	return "Abort";
+		case nvme_admin_set_features:	return "Set Features";
+		case nvme_admin_get_features:	return "Get Features";
+		case nvme_admin_async_event:	return "Asynchronous Event Request";
+		case nvme_admin_ns_mgmt:	return "Namespace Management";
+		case nvme_admin_activate_fw:	return "Firmware Commit";
+		case nvme_admin_download_fw:	return "Firmware Image Download";
+		case nvme_admin_dev_self_test:	return "Device Self-test";
+		case nvme_admin_ns_attach:	return "Namespace Attachment";
+		case nvme_admin_keep_alive:	return "Keep Alive";
+		case nvme_admin_directive_send:	return "Directive Send";
+		case nvme_admin_directive_recv:	return "Directive Receive";
+		case nvme_admin_virtual_mgmt:	return "Virtualization Management";
+		case nvme_admin_nvme_mi_send:	return "NVMEe-MI Send";
+		case nvme_admin_nvme_mi_recv:	return "NVMEe-MI Receive";
+		case nvme_admin_dbbuf:		return "Doorbell Buffer Config";
+		case nvme_admin_format_nvm:	return "Format NVM";
+		case nvme_admin_security_send:	return "Security Send";
+		case nvme_admin_security_recv:	return "Security Receive";
+		case nvme_admin_sanitize_nvm:	return "Sanitize";
+		}
+	} else {
+		switch (opcode) {
+		case nvme_cmd_flush:		return "Flush";
+		case nvme_cmd_write:		return "Write";
+		case nvme_cmd_read:		return "Read";
+		case nvme_cmd_write_uncor:	return "Write Uncorrectable";
+		case nvme_cmd_compare:		return "Compare";
+		case nvme_cmd_write_zeroes:	return "Write Zeroes";
+		case nvme_cmd_dsm:		return "Dataset Management";
+		case nvme_cmd_resv_register:	return "Reservation Register";
+		case nvme_cmd_resv_report:	return "Reservation Report";
+		case nvme_cmd_resv_acquire:	return "Reservation Acquire";
+		case nvme_cmd_resv_release:	return "Reservation Release";
+		}
+	}
+
+	return "Unknown";
+}
+
 void show_effects_log(struct nvme_effects_log_page *effects, unsigned int flags)
 {
 	int i;
 	int human = flags & HUMAN;
 	__u32 effect;
 
+	printf("Admin Command Set\n");
 	for (i = 0; i < 256; i++) {
 		effect = le32_to_cpu(effects->acs[i]);
 		if (effect & NVME_CMD_EFFECTS_CSUPP) {
-			printf("ACS%-4d: %08x", i, effect);
+			printf("ACS%-6d[%-32s] %08x", i,
+					nvme_cmd_to_string(1, i), effect);
 			if (human)
 				show_effects_log_human(effect);
 			else
 				printf("\n");
 		}
 	}
+	printf("\nNVM Command Set\n");
 	for (i = 0; i < 256; i++) {
 		effect = le32_to_cpu(effects->iocs[i]);
 		if (effect & NVME_CMD_EFFECTS_CSUPP) {
-			printf("IOCS%-3d: %08x", i, effect);
+			printf("IOCS%-5d[%-32s] %08x", i,
+					nvme_cmd_to_string(0, i), effect);
 			if (human)
 				show_effects_log_human(effect);
 			else
@@ -2009,19 +2063,19 @@ void json_effects_log(struct nvme_effects_log_page *effects_log, const char *dev
 {
 	struct json_object *root;
 	unsigned int opcode;
-	char key[16];
+	char key[128];
 	__u32 effect;
 
 	root = json_create_object();
 
 	for (opcode = 0; opcode < 256; opcode++) {
-		sprintf(key, "ACS%-4d", opcode);
+		sprintf(key, "ACS%d (%s)", opcode, nvme_cmd_to_string(1, opcode));
 		effect = le32_to_cpu(effects_log->acs[opcode]);
 		json_object_add_value_int(root, key, effect);
 	}
 
 	for (opcode = 0; opcode < 256; opcode++) {
-		sprintf(key, "IOCS%-3d", opcode);
+		sprintf(key, "IOCS%d (%s)", opcode, nvme_cmd_to_string(0, opcode));
 		effect = le32_to_cpu(effects_log->iocs[opcode]);
 		json_object_add_value_int(root, key, effect);
 	}
-- 
2.7.4
