From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 10 Jun 2018 22:05:07 -0400
Subject: [PATCH 1/2] nvme-cli: add changed log ns support
Message-ID: <20180611020508.2845-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 linux/nvme.h   |  7 +++++++
 nvme-builtin.h |  1 +
 nvme-ioctl.c   |  6 ++++++
 nvme-ioctl.h   |  2 ++
 nvme-print.c   | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 nvme-print.h   |  2 ++
 nvme.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 126 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 982bd9e..3e87d17 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -473,6 +473,12 @@ struct nvme_fw_slot_info_log {
 	__u8			rsvd64[448];
 };
 
+#define NVME_MAX_CHANGED_NAMESPACES     1024
+
+struct nvme_changed_ns_list_log {
+	__le32			log[NVME_MAX_CHANGED_NAMESPACES];
+};
+
 enum {
 	NVME_CMD_EFFECTS_CSUPP		= 1 << 0,
 	NVME_CMD_EFFECTS_LBCC		= 1 << 1,
@@ -845,6 +851,7 @@ enum {
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
 	NVME_LOG_DEVICE_SELF_TEST = 0x06,
 	NVME_LOG_TELEMETRY_HOST = 0x07,
diff --git a/nvme-builtin.h b/nvme-builtin.h
index adfa520..d29e138 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -22,6 +22,7 @@ COMMAND_LIST(
 	ENTRY("get-log", "Generic NVMe get log, returns log in raw format", get_log)
 	ENTRY("telemetry-log", "Retrieve FW Telemetry log write to file", get_telemetry_log)
 	ENTRY("fw-log", "Retrieve FW Log, show it", get_fw_log)
+	ENTRY("changed-ns-list-log", "Retrieve Changed Namespace List, show it", get_changed_ns_list_log)
 	ENTRY("smart-log", "Retrieve SMART Log, show it", get_smart_log)
 	ENTRY("error-log", "Retrieve Error Log, show it", get_error_log)
 	ENTRY("effects-log", "Retrieve Command Effects Log, show it", get_effects_log)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 4cf815b..9af6960 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -458,6 +458,12 @@ int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log)
 	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_FW_SLOT, sizeof(*fw_log), fw_log);
 }
 
+int nvme_changed_ns_list_log(int fd, struct nvme_changed_ns_list_log *changed_ns_list_log)
+{
+	return nvme_get_log(fd, 0, NVME_LOG_CHANGED_NS, sizeof(changed_ns_list_log->log),
+			changed_ns_list_log->log);
+}
+
 int nvme_error_log(int fd, int entries, struct nvme_error_log_page *err_log)
 {
 	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_ERROR, entries * sizeof(*err_log), err_log);
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 75f8104..d5e7921 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -94,6 +94,8 @@ int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data);
 int nvme_get_telemetry_log(int fd, void *lp, int generate_report,
 			   int ctrl_gen, size_t log_page_size, __u64 offset);
 int nvme_fw_log(int fd, struct nvme_firmware_log_page *fw_log);
+int nvme_changed_ns_list_log(int fd,
+		struct nvme_changed_ns_list_log *changed_ns_list_log);
 int nvme_error_log(int fd, int entries, struct nvme_error_log_page *err_log);
 int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log);
 int nvme_effects_log(int fd, struct nvme_effects_log_page *effects_log);
diff --git a/nvme-print.c b/nvme-print.c
index 0d91a82..403df01 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1044,6 +1044,23 @@ void show_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
 						fw_to_string(fw_log->frs[i]));
 }
 
+void show_changed_ns_list_log(struct nvme_changed_ns_list_log *log, const char *devname)
+{
+	int i;
+	__u32 nsid;
+
+	if (log->log[0] != cpu_to_le32(0XFFFFFFFF)) {
+		for (i = 0; i < NVME_MAX_CHANGED_NAMESPACES; i++) {
+			nsid = le32_to_cpu(log->log[i]);
+			if (nsid == 0)
+				break;
+
+			printf("[%4u]:%#x\n", i, nsid);
+		}
+	} else
+		printf("more than %d ns changed\n", NVME_MAX_CHANGED_NAMESPACES);
+}
+
 static void show_effects_log_human(__u32 effect)
 {
 	const char *set = "+";
@@ -2178,6 +2195,41 @@ void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
 	json_free_object(root);
 }
 
+void json_changed_ns_list_log(struct nvme_changed_ns_list_log *log, const char *devname)
+{
+	struct json_object *root;
+	struct json_object *nsi;
+	char fmt[32];
+	char str[32];
+	__u32 nsid;
+	int i;
+
+	if (log->log[0] == cpu_to_le32(0XFFFFFFFF))
+		return;
+
+	root = json_create_object();
+	nsi = json_create_object();
+
+	json_object_add_value_string(root, "Changed Namespace List Log", devname);
+
+	for (i = 0; i < NVME_MAX_CHANGED_NAMESPACES; i++) {
+		nsid = le32_to_cpu(log->log[i]);
+
+		if (nsid == 0)
+			break;
+
+		snprintf(fmt, sizeof(fmt), "[%4u]", i + 1);
+		snprintf(str, sizeof(str), "%#x", nsid);
+		json_object_add_value_string(nsi, fmt, str);
+	}
+
+	json_object_add_value_object(root, devname, nsi);
+	json_print_object(root, NULL);
+	printf("\n");
+
+	json_free_object(root);
+}
+
 void json_endurance_log(struct nvme_endurance_group_log *endurance_group,
 			__u16 group_id, const char *devname)
 {
diff --git a/nvme-print.h b/nvme-print.h
index 98e1502..18ec59e 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -27,6 +27,7 @@ void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 void show_self_test_log(struct nvme_self_test_log *self_test, const char *devname);
 void show_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void show_effects_log(struct nvme_effects_log_page *effects, unsigned int flags);
+void show_changed_ns_list_log(struct nvme_changed_ns_list_log *log, const char *devname);
 void show_endurance_log(struct nvme_endurance_group_log *endurance_group,
 			__u16 group_id, const char *devname);
 void show_sanitize_log(struct nvme_sanitize_log_page *sanitize, unsigned int mode, const char *devname);
@@ -50,6 +51,7 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 void json_effects_log(struct nvme_effects_log_page *effects_log, const char *devname);
 void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *devname);
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
+void json_changed_ns_list_log(struct nvme_changed_ns_list_log *log, const char *devname);
 void json_endurance_log(struct nvme_endurance_group_log *endurance_group,
 			__u16 group_id, const char *devname);
 void json_print_list_items(struct list_item *items, unsigned amnt);
diff --git a/nvme.c b/nvme.c
index 440cb24..4c83163 100644
--- a/nvme.c
+++ b/nvme.c
@@ -606,6 +606,62 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
 	return err;
 }
 
+static int get_changed_ns_list_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	struct nvme_changed_ns_list_log changed_ns_list_log;
+	const char *desc = "Retrieve Changed Namespaces log for the given device "\
+			"in either decoded format "\
+			"(default) or binary.";
+	const char *raw = "output in binary format";
+	int err, fmt, fd;
+
+	struct config {
+		int   raw_binary;
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-format", 'o', "FMT", CFG_STRING,   &cfg.output_format, required_argument, output_format },
+		{"raw-binary",    'b', "",    CFG_NONE,     &cfg.raw_binary,    no_argument,       raw},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (fd < 0)
+		return fd;
+
+	fmt = validate_output_format(cfg.output_format);
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
+
+	if (cfg.raw_binary)
+		fmt = BINARY;
+
+	err = nvme_changed_ns_list_log(fd, &changed_ns_list_log);
+	if (!err) {
+		if (fmt == BINARY)
+			d_raw((unsigned char *)changed_ns_list_log.log, sizeof(changed_ns_list_log.log));
+		else if (fmt == JSON)
+			json_changed_ns_list_log(&changed_ns_list_log, devicename);
+		else
+			show_changed_ns_list_log(&changed_ns_list_log, devicename);
+	} else if (err > 0)
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(err), err);
+	else
+		perror("changed ns list log");
+
+ close_fd:
+	close(fd);
+
+	return err;
+}
+
 static int get_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Retrieve desired number of bytes "\
-- 
2.17.0
