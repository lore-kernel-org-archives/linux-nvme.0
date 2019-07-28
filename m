From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 15:35:15 +0900
Subject: [PATCH V3 2/3] lnvm: introduce chunk-log command for chunk info
In-Reply-To: <20190728063516.17732-1-minwoo.im.dev@gmail.com>
References: <20190728063516.17732-1-minwoo.im.dev@gmail.com>
Message-ID: <20190728063516.17732-3-minwoo.im.dev@gmail.com>

To retrieve the chunk information from the nvme namespae for the given
OCSSD, we can just do like:
	nvme lnvm chunk-log /dev/nvme0n1 --output-format=normal

This will calculate the data length from the geometry data structure
which might be retrieved by a Geometry command(Identity for 1.2 spec.).
Then it will request get log page API for 1.3 NVMe spec to get the
entries which indicate chunk information.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Cc: Javier Gonz?lez <javier at javigon.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-lightnvm.c          | 79 ++++++++++++++++++++++++++++++++++++++-
 nvme-lightnvm.h          | 17 +++++++++
 plugins/lnvm/lnvm-nvme.c | 81 ++++++++++++++++++++++++++++++++++++++++
 plugins/lnvm/lnvm-nvme.h |  1 +
 4 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index e8cdccd..3ccc480 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -436,7 +436,7 @@ static void show_lnvm_id_ns(struct nvme_nvm_id *id, unsigned int flags)
 	}
 }
 
-static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
+int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
 {
 	struct nvme_admin_cmd cmd = {
 		.opcode		= nvme_nvm_admin_identity,
@@ -465,6 +465,83 @@ int lnvm_do_id_ns(int fd, int nsid, unsigned int flags)
 	return err;
 }
 
+static inline const char *print_chunk_state(__u8 cs)
+{
+	switch (cs) {
+	case 1 << 0:	return "FREE";
+	case 1 << 1:	return "CLOSED";
+	case 1 << 2:	return "OPEN";
+	case 1 << 3:	return "OFFLINE";
+	default:	return "UNKNOWN";
+	}
+}
+
+static inline const char *print_chunk_type(__u8 ct)
+{
+	switch (ct & 0xF) {
+	case 1 << 0:	return "SEQWRITE_REQ";
+	case 1 << 1:	return "RANDWRITE_ALLOWED";
+	default:	return "UNKNOWN";
+	}
+}
+
+static inline const char *print_chunk_attr(__u8 ct)
+{
+	switch (ct & 0xF0) {
+	case 1 << 4:	return "DEVIATED";
+	default:	return "NONE";
+	}
+}
+
+static void show_lnvm_chunk_log(struct nvme_nvm_chunk_desc *chunk_log,
+				__u32 data_len)
+{
+	int nr_entry = data_len / sizeof(struct nvme_nvm_chunk_desc);
+	int idx;
+
+	printf("Total chunks in namespace: %d\n", nr_entry);
+	for (idx = 0; idx < nr_entry; idx++) {
+		struct nvme_nvm_chunk_desc *desc = &chunk_log[idx];
+
+		printf(" [%5d] { ", idx);
+		printf("SLBA: 0x%016"PRIx64, le64_to_cpu(desc->slba));
+		printf(", WP: 0x%016"PRIx64, le64_to_cpu(desc->wp));
+		printf(", CNLB: 0x%016"PRIx64, le64_to_cpu(desc->cnlb));
+		printf(", State: %-8s", print_chunk_state(desc->cs));
+		printf(", Type: %-20s", print_chunk_type(desc->ct));
+		printf(", Attr: %-8s", print_chunk_attr(desc->ct));
+		printf(", WLI: %4d }\n", desc->wli);
+	}
+}
+
+int lnvm_do_chunk_log(int fd, __u32 nsid, __u32 data_len, void *data,
+			unsigned int flags)
+{
+	int err;
+
+	err = nvme_get_log13(fd, nsid, NVM_LID_CHUNK_INFO, 0, 0, 0,
+			false, data_len, data);
+	if (err > 0) {
+		fprintf(stderr, "NVMe Status:%s(%x) NSID:%d\n",
+			nvme_status_to_string(err), err, nsid);
+
+		goto out;
+	} else if (err < 0) {
+		err = -errno;
+		perror("nvme_get_log13");
+
+		goto out;
+	}
+
+	if (flags & RAW)
+		d_raw(data, data_len);
+	else
+		show_lnvm_chunk_log(data, data_len);
+
+out:
+	return err;
+}
+
 static void show_lnvm_bbtbl(struct nvme_nvm_bb_tbl *tbl)
 {
 	printf("verid    : %#x\n", (uint16_t)le16_to_cpu(tbl->verid));
diff --git a/nvme-lightnvm.h b/nvme-lightnvm.h
index 9dea912..19660b7 100644
--- a/nvme-lightnvm.h
+++ b/nvme-lightnvm.h
@@ -246,6 +246,20 @@ struct nvme_nvm_id {
 	__u8			resv[4095];
 } __attribute__((packed));
 
+enum {
+	NVM_LID_CHUNK_INFO = 0xCA,
+};
+
+struct nvme_nvm_chunk_desc {
+	__u8	cs;
+	__u8	ct;
+	__u8	wli;
+	__u8	rsvd_7_3[5];
+	__u64	slba;
+	__u64	cnlb;
+	__u64	wp;
+};
+
 struct nvme_nvm_bb_tbl {
 	__u8	tblid[4];
 	__le16	verid;
@@ -299,6 +313,8 @@ static inline struct ppa_addr generic_to_dev_addr(
 	return l;
 }
 
+int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id);
+
 int lnvm_do_init(char *, char *);
 int lnvm_do_list_devices(void);
 int lnvm_do_info(void);
@@ -306,6 +322,7 @@ int lnvm_do_create_tgt(char *, char *, char *, int, int, int, int);
 int lnvm_do_remove_tgt(char *);
 int lnvm_do_factory_init(char *, int, int, int);
 int lnvm_do_id_ns(int, int, unsigned int);
+int lnvm_do_chunk_log(int, __u32, __u32, void *, unsigned int);
 int lnvm_do_get_bbtbl(int, int, int, int, unsigned int);
 int lnvm_do_set_bbtbl(int, int, int, int, int, int, __u8);
 
diff --git a/plugins/lnvm/lnvm-nvme.c b/plugins/lnvm/lnvm-nvme.c
index 754931a..90e5d57 100644
--- a/plugins/lnvm/lnvm-nvme.c
+++ b/plugins/lnvm/lnvm-nvme.c
@@ -1,5 +1,7 @@
 #include <stdio.h>
 #include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
 
 #include "nvme.h"
 #include "nvme-print.h"
@@ -127,6 +129,85 @@ static int lnvm_id_ns(int argc, char **argv, struct command *cmd, struct plugin
 	return lnvm_do_id_ns(fd, cfg.namespace_id, flags);
 }
 
+static int lnvm_chunk_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "Retrieve the chunk information log for the "\
+		"specified given LightNVM device, returns in either "\
+		"human-readable or binary format.\n"\
+		"This will request Geometry first to get the "\
+		"num_grp,num_pu,num_chk first to figure out the total size "\
+		"of the log pages."\
+		;
+	const char *output_format = "Output format: normal|binary";
+	const char *human_readable = "Print normal in readable format";
+	int err, fmt, fd;
+	struct nvme_nvm_id20 geo;
+	struct nvme_nvm_chunk_desc *chunk_log;
+	__u32 nsid;
+	__u32 data_len;
+	unsigned int flags = 0;
+
+	struct config {
+		char *output_format;
+		int human_readable;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format},
+		{"human-readable",'H', "",    CFG_NONE,   &cfg.human_readable,no_argument,       human_readable},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg,
+				sizeof(cfg));
+	if (fd < 0)
+		return fd;
+
+	fmt = validate_output_format(cfg.output_format);
+	if (fmt < 0) {
+		err = fmt;
+		goto close;
+	}
+
+	if (fmt == BINARY)
+		flags |= RAW;
+	else if (cfg.human_readable)
+		flags |= HUMAN;
+
+	nsid = nvme_get_nsid(fd);
+
+	/*
+	 * It needs to figure out how many bytes will be requested by this
+	 * subcommand by the (num_grp * num_pu * num_chk) from the Geometry.
+	 */
+	err = lnvm_get_identity(fd, nsid, (struct nvme_nvm_id *) &geo);
+	if (err)
+		goto close;
+
+	data_len = (geo.num_grp * geo.num_pu * geo.num_chk) *
+			sizeof(struct nvme_nvm_chunk_desc);
+	chunk_log = malloc(data_len);
+	if (!chunk_log) {
+		fprintf(stderr, "cound not alloc for chunk log %dbytes\n",
+				data_len);
+		err = -ENOMEM;
+		goto close;
+	}
+
+	err = lnvm_do_chunk_log(fd, nsid, data_len, chunk_log, flags);
+	if (err)
+		fprintf(stderr, "get log page for chunk information failed\n");
+
+	free(chunk_log);
+close:
+	close(fd);
+	return err;
+}
+
 static int lnvm_create_tgt(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Instantiate a target on top of a LightNVM enabled device.";
diff --git a/plugins/lnvm/lnvm-nvme.h b/plugins/lnvm/lnvm-nvme.h
index 3d5cbc5..e25f756 100644
--- a/plugins/lnvm/lnvm-nvme.h
+++ b/plugins/lnvm/lnvm-nvme.h
@@ -12,6 +12,7 @@ PLUGIN(NAME("lnvm", "LightNVM specific extensions"),
 		ENTRY("list", "List available LightNVM devices", lnvm_list)
 		ENTRY("info", "List general information and available target engines", lnvm_info)
 		ENTRY("id-ns", "List geometry for LightNVM device", lnvm_id_ns)
+		ENTRY("chunk-log", "Chunk Information Log Page", lnvm_chunk_log)
 		ENTRY("init", "Initialize media manager on LightNVM device", lnvm_init)
 		ENTRY("create", "Create target on top of a LightNVM device", lnvm_create_tgt)
 		ENTRY("remove", "Remove target from device", lnvm_remove_tgt)
-- 
2.17.1
