From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 23 Jun 2017 09:36:35 +0200
Subject: [PATCH nvme-cli v2] nvme-cli: add ns-descs subcommand
Message-ID: <20170623073635.3069-1-jthumshirn@suse.de>

NVMe 1.3 defines the "Namespace Identification Descriptor" command in
NVMe Identify NS. This command returns a list of so called Namespace
Identificastion Descriptors which currently can either be a EUI-64,
a NGUID or a UUID.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 linux/nvme.h   |  14 +++++++
 nvme-builtin.h |   1 +
 nvme-ioctl.c   |   6 +++
 nvme-ioctl.h   |   1 +
 nvme-print.c   | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 nvme-print.h   |   2 +
 nvme.c         |  63 +++++++++++++++++++++++++++++
 7 files changed, 209 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index b2c8dbb2244b..883b5eb8b710 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -862,6 +862,20 @@ struct nvme_command {
 	};
 };
 
+#define NVME_IDENTIFY_CMD_LEN 4096
+#define NVME_ID_CNS_NS_DESC_LIST 0x3
+enum {
+	NVME_NIDT_EUI64		= 0x1,
+	NVME_NIDT_NGUID		= 0x2,
+	NVME_NIDT_UUID		= 0x3,
+};
+
+struct nvme_ns_id_desc {
+	__u8 nidt;
+	__u8 nidl;
+	__u16 reserved;
+};
+
 static inline bool nvme_is_write(struct nvme_command *cmd)
 {
 	/*
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 087fc1986b2f..91f361df54a3 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -11,6 +11,7 @@ COMMAND_LIST(
 	ENTRY("id-ctrl", "Send NVMe Identify Controller", id_ctrl)
 	ENTRY("id-ns", "Send NVMe Identify Namespace, display structure", id_ns)
 	ENTRY("list-ns", "Send NVMe Identify List, display structure", list_ns)
+	ENTRY("ns-descs", "Send NVMe Namespace Descriptor List, display structure", ns_descs)
 	ENTRY("create-ns", "Creates a namespace with the provided parameters", create_ns)
 	ENTRY("delete-ns", "Deletes a namespace from the controller", delete_ns)
 	ENTRY("attach-ns", "Attaches a namespace to requested controller(s)", attach_ns)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index a22399ab6169..e3e9af412168 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -364,6 +364,12 @@ int nvme_identify_ctrl_list(int fd, __u32 nsid, __u16 cntid, void *data)
 	return nvme_identify(fd, nsid, (cntid << 16) | cns, data);
 }
 
+int nvme_identify_ns_descs(int fd, __u32 nsid, void *data)
+{
+
+	return nvme_identify(fd, nsid, NVME_ID_CNS_CTRL_LIST, data);
+}
+
 int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
 {
 	struct nvme_admin_cmd cmd = {
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 3beddf8e2db2..8faf345dcf37 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -77,6 +77,7 @@ int nvme_identify_ctrl(int fd, void *data);
 int nvme_identify_ns(int fd, __u32 nsid, bool present, void *data);
 int nvme_identify_ns_list(int fd, __u32 nsid, bool all, void *data);
 int nvme_identify_ctrl_list(int fd, __u32 nsid, __u16 cntid, void *data);
+int nvme_identify_ns_descs(int fd, __u32 nsid, void *data);
 
 int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data);
 int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log);
diff --git a/nvme-print.c b/nvme-print.c
index 2da5acd5c9b8..f0f7121cb070 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -3,6 +3,10 @@
 #include <string.h>
 #include <stdlib.h>
 
+#ifdef LIBUUID
+#include <uuid/uuid.h>
+#endif
+
 #include "nvme-print.h"
 #include "json.h"
 #include "nvme-models.h"
@@ -599,6 +603,124 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	}
 }
 
+void json_nvme_id_ns_descs(void *data)
+{
+#ifdef LIBUUID
+	uuid_t uuid;
+	char uuid_str[37];
+#endif
+	__u8 eui64_desc[8];
+	__u8 nguid_desc[16];
+	char nguid_str[2 * sizeof(nguid_desc) + 1];
+	char eui64_str[2 * sizeof(eui64_desc) + 1];
+	char *eui64 = eui64_str;
+	char *nguid = nguid_str;
+	struct json_object *root;
+	off_t off;
+	int pos, len = 0;
+	int i;
+
+	root = json_create_object();
+
+	for (pos = 0; pos < NVME_IDENTIFY_CMD_LEN; pos += len) {
+		struct nvme_ns_id_desc *cur = data + pos;
+
+		off = pos + sizeof(*cur);
+
+		if (cur->nidl == 0)
+			break;
+
+		switch (cur->nidt) {
+		case NVME_NIDT_EUI64:
+			memset(eui64, 0, sizeof(eui64_str));
+			memcpy(eui64_desc, data + off, sizeof(eui64_desc));
+			for (i = 0; i < sizeof(eui64); i++)
+				eui64 += sprintf(eui64, "%02x", eui64_desc[i]);
+			len += sizeof(eui64);
+			json_object_add_value_string(root, "eui64", eui64_str);
+			break;
+		case NVME_NIDT_NGUID:
+			memset(nguid, 0, sizeof(nguid_str));
+			memcpy(nguid_desc, data + off, sizeof(nguid_desc));
+			for (i = 0; i < sizeof(nguid); i++)
+				nguid += sprintf(nguid, "%02x", nguid_desc[i]);
+			len += sizeof(nguid);
+			json_object_add_value_string(root, "nguid", nguid_str);
+			break;
+#ifdef LIBUUID
+		case NVME_NIDT_UUID:
+			memcpy(uuid, data + off, 16);
+			uuid_unparse_lower(uuid, uuid_str);
+			len += sizeof(uuid);
+			json_object_add_value_string(root, "uuid", uuid_str);
+			break;
+#endif
+		default:
+			/* Skip unnkown types */
+			len = cur->nidl;
+			break;
+		}
+
+		len += sizeof(*cur);
+	}
+
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
+void show_nvme_id_ns_descs(void *data)
+{
+	int pos, len = 0;
+	int i;
+#ifdef LIBUUID
+	uuid_t uuid;
+	char uuid_str[37];
+#endif
+	__u8 eui64[8];
+	__u8 nguid[16];
+
+	for (pos = 0; pos < NVME_IDENTIFY_CMD_LEN; pos += len) {
+		struct nvme_ns_id_desc *cur = data + pos;
+
+		if (cur->nidl == 0)
+			break;
+
+		switch (cur->nidt) {
+		case NVME_NIDT_EUI64:
+			memcpy(eui64, data + pos + sizeof(*cur), sizeof(eui64));
+			printf("eui64   : ");
+			for (i = 0; i < 8; i++)
+				printf("%02x", eui64[i]);
+			printf("\n");
+			len += sizeof(eui64);
+			break;
+		case NVME_NIDT_NGUID:
+			memcpy(nguid, data + pos + sizeof(*cur), sizeof(nguid));
+			printf("nguid   : ");
+			for (i = 0; i < 16; i++)
+				printf("%02x", nguid[i]);
+			printf("\n");
+			len += sizeof(nguid);
+			break;
+#ifdef LIBUUID
+		case NVME_NIDT_UUID:
+			memcpy(uuid, data + pos + sizeof(*cur), 16);
+			uuid_unparse_lower(uuid, uuid_str);
+			printf("uuid    : %s\n", uuid_str);
+			len += sizeof(uuid);
+			break;
+#endif
+		default:
+			/* Skip unnkown types */
+			len = cur->nidl;
+			break;
+		}
+
+		len += sizeof(*cur);
+	}
+}
+
 static void print_ps_power_and_scale(__le16 ctr_power, __u8 scale)
 {
 	__u16 power = le16_to_cpu(ctr_power);
diff --git a/nvme-print.h b/nvme-print.h
index 0502d0d48ee4..d39bc63dc665 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -26,6 +26,7 @@ void show_error_log(struct nvme_error_log_page *err_log, int entries, const char
 void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
 void show_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void show_ctrl_registers(void *bar, unsigned int mode);
+void show_nvme_id_ns_descs(void *data);
 
 void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf);
 char *nvme_status_to_string(__u32 status);
@@ -39,6 +40,7 @@ void json_error_log(struct nvme_error_log_page *err_log, int entries, const char
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void json_print_list_items(struct list_item *items, unsigned amnt);
+void json_nvme_id_ns_descs(void *data);
 
 
 #endif
diff --git a/nvme.c b/nvme.c
index a4e1b719718d..a2d6e7d19551 100644
--- a/nvme.c
+++ b/nvme.c
@@ -952,6 +952,69 @@ static int id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *pl
 	return __id_ctrl(argc, argv, cmd, plugin, NULL);
 }
 
+static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "Send Namespace Identification Descriptoprs commadn to the "\
+			    "given device, returns the namespace identifcation descriptors "\
+			    "of the specific namespace in either human-readable or binary format.";
+	const char *raw_binary = "show infos in binary format";
+	const char *namespace_id = "identifier of desired namespace";
+	int err, fmt, fd;
+	char *nsdescs[0x1000] = { };
+	struct config {
+		__u32 namespace_id;
+		int raw_binary;
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.namespace_id = 0,
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"namespace-id",    'n', "NUM", CFG_POSITIVE, &cfg.namespace_id, required_argument, namespace_id},
+		{"raw-binary",      'b', "",    CFG_NONE,     &cfg.raw_binary,      no_argument,       raw_binary},
+		{"output-format",   'o', "FMT", CFG_STRING,   &cfg.output_format,   required_argument, output_format },
+		{NULL}
+	};
+
+	if (posix_memalign((void *)&nsdescs, getpagesize(), 0x1000)) {
+		fprintf(stderr, "can not allocate controller list payload\n");
+		return ENOMEM;
+	}
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (fd < 0)
+		return fd;
+
+	fmt = validate_output_format(cfg.output_format);
+	if (fmt < 0)
+		return fmt;
+	if (cfg.raw_binary)
+		fmt = BINARY;
+	if (!cfg.namespace_id)
+		cfg.namespace_id = get_nsid(fd);
+
+	err = nvme_identify_ns_descs(fd, cfg.namespace_id, &nsdescs);
+	if (!err) {
+		if (fmt == BINARY)
+			d_raw((unsigned char *)&nsdescs, 0x1000);
+		else if (fmt == JSON)
+			json_nvme_id_ns_descs(&nsdescs);
+		else {
+			printf("NVME Namespace Identification Descriptors NS %d:\n", cfg.namespace_id);
+			show_nvme_id_ns_descs(&nsdescs);
+		}
+	}
+	else if (err > 0)
+		fprintf(stderr, "NVMe Status:%s(%x) NSID:%d\n",
+			nvme_status_to_string(err), err, cfg.namespace_id);
+	else
+		perror("identify namespace");
+	return err;
+}
+
 static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Send an Identify Namespace command to the "\
-- 
2.12.3
