From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 12:26:31 +0200
Subject: [PATCH 5/6] nvme-cli: Implement ana log page support
In-Reply-To: <20180727102632.32455-1-hare@suse.de>
References: <20180727102632.32455-1-hare@suse.de>
Message-ID: <20180727102632.32455-6-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 Documentation/nvme-ana-log.txt | 62 ++++++++++++++++++++++++++++++
 linux/nvme.h                   | 19 ++++++++++
 nvme-builtin.h                 |  1 +
 nvme-ioctl.c                   |  9 +++++
 nvme-ioctl.h                   |  2 +
 nvme-print.c                   | 86 ++++++++++++++++++++++++++++++++++++++++++
 nvme-print.h                   |  2 +
 nvme.c                         | 70 ++++++++++++++++++++++++++++++++++
 8 files changed, 251 insertions(+)
 create mode 100644 Documentation/nvme-ana-log.txt

diff --git a/Documentation/nvme-ana-log.txt b/Documentation/nvme-ana-log.txt
new file mode 100644
index 0000000..6ef33e7
--- /dev/null
+++ b/Documentation/nvme-ana-log.txt
@@ -0,0 +1,62 @@
+nvme-ana-log(1)
+===============
+
+NAME
+----
+nvme-ana-log - Send NVME ANA log page request, return result and log
+
+SYNOPSIS
+--------
+[verse]
+'nvme ana-log' <device> [--log-size=<size> | -l <size> ]
+			[--raw-binary | -b ]
+			[--output-format=<fmt> | -o <fmt> ]
+
+DESCRIPTION
+-----------
+Retrieves NVMe Asymmetric Namespace Access (ANA) log page from and
+NVMe device and prints the returned structure.
+
+The <device> parameter is mandatory and may be either the NVMe character
+device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
+
+On success, the returned ANA log struct may be returned in one of several
+ways depending on the option flags; the structure may be parsed by the
+program and printed in readable format or the raw buffer may be printed to
+stdout for another program to parse.
+
+OPTIONS
+-------
+-l <size>::
+--log-size=<size>::
+	Specify the size of the ANA log buffer.
+
+-b::
+--raw-binary::
+	Print the raw error log buffer to stdout.
+
+-o <format>::
+--output-format=<format>::
+	Set the reporting format to 'normal', 'json', or 'binary'.
+	Only one output formath can be used at a time.
+
+EXAMPLES
+--------
+* Get the ANA log and print it in a humen readable format:
+*
+------------
+# nvme ana-log /dev/nvme0
+------------
++
+
+* Print the raw output to a file:
++
+------------
+# nvme ana-log /dev/nvme0 --raw-binary > ana_log.raw
+------------
++
+It is probably a bad idea to not redirect stdout when using this mode.
+
+NVME
+----
+Part of the nvme-user suite
diff --git a/linux/nvme.h b/linux/nvme.h
index 55a197b..645e171 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -889,6 +889,7 @@ enum {
 	NVME_LOG_TELEMETRY_HOST = 0x07,
 	NVME_LOG_TELEMETRY_CTRL = 0x08,
 	NVME_LOG_ENDURANCE_GROUP = 0x09,
+	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_LOG_SANITIZE	= 0x81,
@@ -901,6 +902,7 @@ enum {
 	NVME_NO_LOG_LSP       = 0x0,
 	NVME_NO_LOG_LPO       = 0x0,
 	NVME_TELEM_LSP_CREATE = 0x1,
+	NVME_ANA_LSP_RGO      = 0x1,
 };
 
 /* Sanitize and Sanitize Monitor/Log */
@@ -1085,6 +1087,23 @@ struct nvme_sanitize_log_page {
 	__le32			est_crypto_erase_time;
 };
 
+/* Asymmetric Namespace Access Log Page */
+struct nvme_ana_group_descriptor {
+	__le32			groupid;
+	__le32			nsid_num;
+	__le64			change_count;
+	__u8			ana_state;
+	__u8			resv1[7];
+	__le32			nsid[0];
+};
+
+struct nvme_ana_log_page {
+	__le64			change_count;
+	__le16			grpid_num;
+	__le16			resv[3];
+	struct nvme_ana_group_descriptor desc[0];
+};
+
 /*
  * Fabrics subcommands.
  */
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 2c26d57..df3eb4f 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -28,6 +28,7 @@ COMMAND_LIST(
 	ENTRY("error-log", "Retrieve Error Log, show it", get_error_log)
 	ENTRY("effects-log", "Retrieve Command Effects Log, show it", get_effects_log)
 	ENTRY("endurance-log", "Retrieve Endurance Group Log, show it", get_endurance_log)
+	ENTRY("ana-log", "Retrieve ANA Log, show it", ana_log)
 	ENTRY("get-feature", "Get feature and show the resulting value", get_feature)
 	ENTRY("device-self-test", "Perform the necessary tests to observe the performance", device_self_test)
 	ENTRY("self-test-log", "Retrieve the SELF-TEST Log, show it", self_test_log)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 9cf2a33..f88909d 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -488,6 +488,15 @@ int nvme_sanitize_log(int fd, struct nvme_sanitize_log_page *sanitize_log)
 	return nvme_get_log(fd, 0, NVME_LOG_SANITIZE, sizeof(*sanitize_log), sanitize_log);
 }
 
+int nvme_ana_log(int fd, bool rgo, struct nvme_ana_log_page *ana_log,
+		 ssize_t ana_log_size)
+{
+	return nvme_get_log13(fd, 0, NVME_LOG_ANA,
+			      rgo ? NVME_ANA_LSP_RGO : NVME_NO_LOG_LSP,
+			      NVME_NO_LOG_LPO, 0, 1,
+			      ana_log_size, ana_log);
+}
+
 int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10, __u32 cdw11,
 		 __u32 cdw12, __u32 data_len, void *data, __u32 *result)
 {
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index b34f5de..9527cc3 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -97,6 +97,8 @@ int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size);
 int nvme_sanitize_log(int fd, struct nvme_sanitize_log_page *sanitize_log);
 int nvme_endurance_log(int fd, __u16 group_id,
 		       struct nvme_endurance_group_log *endurance_log);
+int nvme_ana_log(int fd, bool rgo, struct nvme_ana_log_page *ana_log,
+		 ssize_t ana_log_size);
 
 int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10,
 		 __u32 cdw11, __u32 cdw12, __u32 data_len, void *data,
diff --git a/nvme-print.c b/nvme-print.c
index e4c90bf..487ea44 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1508,6 +1508,45 @@ void show_sanitize_log(struct nvme_sanitize_log_page *sanitize, unsigned int mod
 	printf("Estimated Time For Crypto Erase               :  %u\n", le32_to_cpu(sanitize->est_crypto_erase_time));
 }
 
+static char *nvme_ana_state_to_string(uint8_t ana_state)
+{
+	switch (ana_state & 0x0f) {
+	case 0x1: return "optimized";
+	case 0x2: return "non-optimized";
+	case 0x3: return "inaccessible";
+	case 0x4: return "persistent-loss";
+	case 0xf: return "change-state";
+	default: return "reserved";
+	}
+}
+
+void show_ana_log(struct nvme_ana_log_page *ana, const char *devname)
+{
+	int grpid_num = le16_to_cpu(ana->grpid_num), i, j;
+	unsigned char *p;
+
+	printf("ANA Log page for device:%s\n", devname);
+	printf("desc_num : %d\n", grpid_num);
+	printf("chgcnt   : %"PRIu64"\n",
+	       (uint64_t)le64_to_cpu(ana->change_count));
+	p = (unsigned char *)&ana->desc[0];
+	for (i = 0; i < grpid_num; i++) {
+		struct nvme_ana_group_descriptor *desc =
+			(struct nvme_ana_group_descriptor *)p;
+		int nsid_num = le32_to_cpu(desc->nsid_num);
+		printf(" desc[%d] :\n", i);
+		printf("  groupid  : %x\n", le32_to_cpu(desc->groupid));
+		printf("  nsid_num : %d\n", nsid_num);
+		printf("  chgcnt   : %"PRId64"\n",
+		       (uint64_t)le64_to_cpu(desc->change_count));
+		printf("  state    : %s\n",
+		       nvme_ana_state_to_string(desc->ana_state));
+		for (j = 0; j < nsid_num; j++)
+			printf("    nsid[%d] : %x\n", j, le32_to_cpu(desc->nsid[j]));
+		p += sizeof(*desc) + nsid_num * 4;
+	}
+}
+
 char *nvme_feature_to_string(int feature)
 {
 	switch (feature) {
@@ -2571,6 +2610,53 @@ void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *
 	json_free_object(root);
 }
 
+void json_ana_log(struct nvme_ana_log_page *ana_log)
+{
+	struct json_object *root;
+	struct json_array *ags;
+	unsigned char *p;
+	int grpid_num = le32_to_cpu(ana_log->grpid_num);
+	int i, j;
+
+	root = json_create_object();
+
+	json_object_add_value_int(root, "chgcnt", le64_to_cpu(ana_log->change_count));
+	json_object_add_value_int(root, "desc_num", grpid_num);
+	ags = json_create_array();
+	p = (unsigned char *)&ana_log->desc[0];
+	for (i = 0; i < grpid_num; i++) {
+		struct nvme_ana_group_descriptor *desc =
+			(struct nvme_ana_group_descriptor *)p;
+		struct json_object *ag = json_create_object();
+		struct json_array *nsids;
+		int nsid_num = le32_to_cpu(desc->nsid_num);
+
+		json_object_add_value_int(ag, "groupid", le32_to_cpu(desc->groupid));
+		json_object_add_value_int(ag, "nsid_num", nsid_num);
+		json_object_add_value_int(ag, "chgcnt", le64_to_cpu(desc->change_count));
+		json_object_add_value_string(ag, "state",
+			nvme_ana_state_to_string(desc->ana_state));
+
+		nsids = json_create_array();
+		for (j = 0; j < nsid_num; j++) {
+			struct json_object *nsid = json_create_object();
+
+			json_object_add_value_int(nsid, "nsid", desc->nsid[j]);
+			json_array_add_value_object(nsids, nsid);
+		}
+		if (j)
+			json_object_add_value_array(ag, "nsids", nsids);
+		json_array_add_value_object(ags, ag);
+
+		p += sizeof(*desc) + nsid_num * 4;
+	}
+	if (i)
+		json_object_add_value_array(root, "group_descriptors", ags);
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
 static void show_nvme_subsystem(struct subsys_list_item *item)
 {
 	int i;
diff --git a/nvme-print.h b/nvme-print.h
index da287c2..b3d16dc 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -31,6 +31,7 @@ void show_changed_ns_list_log(struct nvme_changed_ns_list_log *log, const char *
 void show_endurance_log(struct nvme_endurance_group_log *endurance_group,
 			__u16 group_id, const char *devname);
 void show_sanitize_log(struct nvme_sanitize_log_page *sanitize, unsigned int mode, const char *devname);
+void show_ana_log(struct nvme_ana_log_page *ana, const char *devname);
 void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics);
 void show_single_property(int offset, uint64_t prop, int human);
 void show_nvme_id_ns_descs(void *data);
@@ -56,6 +57,7 @@ void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void json_changed_ns_list_log(struct nvme_changed_ns_list_log *log, const char *devname);
 void json_endurance_log(struct nvme_endurance_group_log *endurance_group,
 			__u16 group_id, const char *devname);
+void json_ana_log(struct nvme_ana_log_page *ana_log);
 void json_print_list_items(struct list_item *items, unsigned amnt);
 void json_nvme_id_ns_descs(void *data);
 void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n);
diff --git a/nvme.c b/nvme.c
index 74dfb61..e463efc 100644
--- a/nvme.c
+++ b/nvme.c
@@ -824,6 +824,76 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
 	return ret;
 }
 
+static int ana_log(int argc, char **argv, struct command *command, struct plugin *plugin)
+{
+	const char *desc = "Retrieve ANA log and show it.";
+	const char *raw_binary = "show infos in binary format";
+	const char *log_size = "Size of the ANA log page";
+	const char *rgo = "Retrieve ANA Group Descriptors only";
+	int fd;
+	int ret;
+	int fmt;
+	struct nvme_ana_log_page *ana_log;
+
+	struct config {
+		int   raw_binary;
+		char *output_format;
+		size_t log_size;
+		int rgo;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+		.log_size = 4096,
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-format", 'o', "FMT", CFG_STRING,   &cfg.output_format, required_argument, output_format},
+		{"raw-binary",    'b', "",    CFG_NONE,     &cfg.raw_binary,    no_argument,       raw_binary},
+		{"log-size",      'l', "NUM", CFG_POSITIVE, &cfg.log_size,    required_argument,  log_size},
+		{"groups-only",   'r', "",    CFG_NONE,     &cfg.rgo,         no_argument,        rgo},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (fd < 0)
+		return fd;
+	ana_log = calloc(cfg.log_size, sizeof(char));
+	if (!ana_log) {
+		fprintf(stderr, "could not allocate buffer for ANA log\n");
+		ret = ENOMEM;
+		goto close_fd;
+	}
+	fmt = validate_output_format(cfg.output_format);
+	if (fmt < 0) {
+		ret = fmt;
+		goto close_fd_and_free;
+	}
+	if (cfg.raw_binary)
+		fmt = BINARY;
+
+	ret = nvme_ana_log(fd, cfg.rgo, ana_log, cfg.log_size);
+	if (!ret) {
+		if (fmt == BINARY)
+			d_raw((unsigned char *)ana_log, cfg.log_size);
+		else if (fmt == JSON)
+			json_ana_log(ana_log);
+		else
+			show_ana_log(ana_log, devicename);
+	}
+	else if (ret > 0)
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	else
+		perror("ana status log");
+
+close_fd_and_free:
+	free(ana_log);
+ close_fd:
+	close(fd);
+
+	return ret;
+}
+
 static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Show controller list information for the subsystem the "\
-- 
2.13.7
