From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Wed, 28 Jun 2017 19:40:02 +0000
Subject: [PATCH] nvme-cli: Extended Data Structure in resv-report
Message-ID: <MWHPR06MB2496402FDC8379115F3885B88CDD0@MWHPR06MB2496.namprd06.prod.outlook.com>

Allow user to specify cdw11 value to request Extended Data
Structure. Update resv_report show and json functions to decode
the returned data.

Signed-off-by: Steve Schremmer <steve.schremmer at netapp.com>
---
 Documentation/nvme-resv-report.txt |  5 ++
 linux/nvme.h                       | 20 +++++++-
 nvme-ioctl.c                       |  3 +-
 nvme-ioctl.h                       |  2 +-
 nvme-print.c                       | 96 +++++++++++++++++++++++++++++---------
 nvme-print.h                       |  4 +-
 nvme.c                             | 13 ++++--
 7 files changed, 114 insertions(+), 29 deletions(-)

diff --git a/Documentation/nvme-resv-report.txt b/Documentation/nvme-resv-report.txt
index a7def3a..e207102 100644
--- a/Documentation/nvme-resv-report.txt
+++ b/Documentation/nvme-resv-report.txt
@@ -37,6 +37,11 @@ OPTIONS
 	Specify the number of Dwords of the Reservation Status structure
 	to transfer. Defaults to 4k.
 
+-c <cdw11>::
+--cdw11=<cdw11>::
+	The value for command dword 11. Setting bit 0 specifies that the 
+	controller returns the Extended Data Structure.
+
 -b::
 --raw-binary::
 	Print the raw buffer to stdout. Structure is not parsed by
diff --git a/linux/nvme.h b/linux/nvme.h
index fd58a36..c5a6ca6 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -373,7 +373,7 @@ struct nvme_reservation_status {
 	__u8	regctl[2];
 	__u8	resv5[2];
 	__u8	ptpls;
-	__u8	resv10[13];
+	__u8	resv10[14];
 	struct {
 		__le16	cntlid;
 		__u8	rcsts;
@@ -383,6 +383,24 @@ struct nvme_reservation_status {
 	} regctl_ds[];
 };
 
+struct nvme_reservation_status_ext {
+	__le32	gen;
+	__u8	rtype;
+	__u8	regctl[2];
+	__u8	resv5[2];
+	__u8	ptpls;
+	__u8	resv10[14];
+	__u8	resv24[40];
+	struct {
+		__le16	cntlid;
+		__u8	rcsts;
+		__u8	resv3[5];
+		__le64	rkey;
+		__u8	hostid[16];
+		__u8	resv32[32];
+	} regctl_eds[];
+};
+
 enum nvme_async_event_type {
 	NVME_AER_TYPE_ERROR	= 0,
 	NVME_AER_TYPE_SMART	= 1,
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index e3e9af4..f5cbc28 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -300,12 +300,13 @@ int nvme_resv_release(int fd, __u32 nsid, __u8 rtype, __u8 rrela,
 	return nvme_submit_io_passthru(fd, &cmd);
 }
 
-int nvme_resv_report(int fd, __u32 nsid, __u32 numd, void *data)
+int nvme_resv_report(int fd, __u32 nsid, __u32 numd, __u32 cdw11, void *data)
 {
 	struct nvme_passthru_cmd cmd = {
 		.opcode		= nvme_cmd_resv_report,
 		.nsid		= nsid,
 		.cdw10		= numd,
+		.cdw11		= cdw11,
 		.addr		= (__u64)(uintptr_t) data,
 		.data_len	= numd << 2,
 	};
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 8faf345..7818721 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -62,7 +62,7 @@ int nvme_resv_register(int fd, __u32 nsid, __u8 rrega, __u8 cptpl,
 		       bool iekey, __u64 crkey, __u64 nrkey);
 int nvme_resv_release(int fd, __u32 nsid, __u8 rtype, __u8 rrela,
 		      bool iekey, __u64 crkey);
-int nvme_resv_report(int fd, __u32 nsid, __u32 numd, void *data);
+int nvme_resv_report(int fd, __u32 nsid, __u32 numd, __u32 cdw11, void *data);
 
 /* NVME_ADMIN_CMD */
 int nvme_passthru_admin(int fd, __u8 opcode, __u8 flags, __u16 rsvd,
diff --git a/nvme-print.c b/nvme-print.c
index f2050a6..f92c6fc 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -921,29 +921,53 @@ void show_error_log(struct nvme_error_log_page *err_log, int entries, const char
 	}
 }
 
-void show_nvme_resv_report(struct nvme_reservation_status *status)
+void show_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __u32 cdw11)
 {
-	int i, regctl;
+	int i, j, regctl, entries;
 
 	regctl = status->regctl[0] | (status->regctl[1] << 8);
 
 	printf("\nNVME Reservation status:\n\n");
 	printf("gen       : %d\n", le32_to_cpu(status->gen));
-	printf("regctl    : %d\n", regctl);
 	printf("rtype     : %d\n", status->rtype);
+	printf("regctl    : %d\n", regctl);
 	printf("ptpls     : %d\n", status->ptpls);
 
-	for (i = 0; i < regctl; i++) {
-		printf("regctl[%d] :\n", i);
-		printf("  cntlid  : %x\n", le16_to_cpu(status->regctl_ds[i].cntlid));
-		printf("  rcsts   : %x\n", status->regctl_ds[i].rcsts);
-		printf("  hostid  : %"PRIx64"\n", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
-		printf("  rkey    : %"PRIx64"\n", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
+	/* check Extended Data Structure bit */
+	if ((cdw11 & 0x1) == 0) {
+		/* if status buffer was too small, don't loop past the end of the buffer */
+		entries = (bytes - 24) / 24;
+		if (entries < regctl)
+			regctl = entries;
+
+		for (i = 0; i < regctl; i++) {
+			printf("regctl[%d] :\n", i);
+			printf("  cntlid  : %x\n", le16_to_cpu(status->regctl_ds[i].cntlid));
+			printf("  rcsts   : %x\n", status->regctl_ds[i].rcsts);
+			printf("  hostid  : %"PRIx64"\n", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
+			printf("  rkey    : %"PRIx64"\n", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
+		}
+	} else {
+		struct nvme_reservation_status_ext *ext_status = (struct nvme_reservation_status_ext *)status;
+		/* if status buffer was too small, don't loop past the end of the buffer */
+		entries = (bytes - 64) / 64;
+		if (entries < regctl)
+			regctl = entries;
+
+		for (i = 0; i < regctl; i++) {
+			printf("regctlext[%d] :\n", i);
+			printf("  cntlid     : %x\n", le16_to_cpu(ext_status->regctl_eds[i].cntlid));
+			printf("  rcsts      : %x\n", ext_status->regctl_eds[i].rcsts);
+			printf("  rkey       : %"PRIx64"\n", (uint64_t)le64_to_cpu(ext_status->regctl_eds[i].rkey));
+			printf("  hostid     : ");
+			for (j = 0; j < 16; j++)
+				printf("%x", ext_status->regctl_eds[i].hostid[j]);
+			printf("\n");
+		}
 	}
 	printf("\n");
 }
 
-
 static char *fw_to_string(__u64 fw)
 {
 	static char ret[9];
@@ -1582,33 +1606,63 @@ void json_error_log(struct nvme_error_log_page *err_log, int entries, const char
 	json_free_object(root);
 }
 
-void json_nvme_resv_report(struct nvme_reservation_status *status)
+void json_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __u32 cdw11)
 {
 	struct json_object *root;
 	struct json_array *rcs;
-	int i, regctl;
+	int i, j, regctl, entries;
 
 	regctl = status->regctl[0] | (status->regctl[1] << 8);
 
 	root = json_create_object();
 
 	json_object_add_value_int(root, "gen", le32_to_cpu(status->gen));
-	json_object_add_value_int(root, "regctl", regctl);
 	json_object_add_value_int(root, "rtype", status->rtype);
+	json_object_add_value_int(root, "regctl", regctl);
 	json_object_add_value_int(root, "ptpls", status->ptpls);
 
 	rcs = json_create_array();
-	json_object_add_value_array(root, "regctls", rcs);
+        /* check Extended Data Structure bit */
+        if ((cdw11 & 0x1) == 0) {
+                /* if status buffer was too small, don't loop past the end of the buffer */
+                entries = (bytes - 24) / 24;
+                if (entries < regctl)
+                        regctl = entries;
+
+		json_object_add_value_array(root, "regctls", rcs);
+		for (i = 0; i < regctl; i++) {
+			struct json_object *rc = json_create_object();
+
+			json_object_add_value_int(rc, "cntlid", le16_to_cpu(status->regctl_ds[i].cntlid));
+			json_object_add_value_int(rc, "rcsts", status->regctl_ds[i].rcsts);
+			json_object_add_value_int(rc, "hostid", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
+			json_object_add_value_int(rc, "rkey", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
+
+			json_array_add_value_object(rcs, rc);
+		}
+	} else {
+		struct nvme_reservation_status_ext *ext_status = (struct nvme_reservation_status_ext *)status;
+		char	hostid[33];
 
-	for (i = 0; i < regctl; i++) {
-		struct json_object *rc = json_create_object();
+                /* if status buffer was too small, don't loop past the end of the buffer */
+                entries = (bytes - 64) / 64;
+                if (entries < regctl)
+                        regctl = entries;
 
-		json_object_add_value_int(rc, "cntlid", le16_to_cpu(status->regctl_ds[i].cntlid));
-		json_object_add_value_int(rc, "rcsts", status->regctl_ds[i].rcsts);
-		json_object_add_value_int(rc, "hostid", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
-		json_object_add_value_int(rc, "rkey", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
+		json_object_add_value_array(root, "regctlext", rcs);
+		for (i = 0; i < regctl; i++) {
+			struct json_object *rc = json_create_object();
 
-		json_array_add_value_object(rcs, rc);
+			json_object_add_value_int(rc, "cntlid", le16_to_cpu(ext_status->regctl_eds[i].cntlid));
+			json_object_add_value_int(rc, "rcsts", ext_status->regctl_eds[i].rcsts);
+			json_object_add_value_int(rc, "rkey", (uint64_t)le64_to_cpu(ext_status->regctl_eds[i].rkey));
+			for (j = 0; j < 16; j++)
+				sprintf(hostid + j * 2, "%02x", ext_status->regctl_eds[i].hostid[j]);
+
+			json_object_add_value_string(rc, "hostid", hostid);
+
+			json_array_add_value_object(rcs, rc);
+		}
 	}
 
 	json_print_object(root, NULL);
diff --git a/nvme-print.h b/nvme-print.h
index d39bc63..fd89c96 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -20,7 +20,7 @@ uint64_t int48_to_long(__u8 *data);
 void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vendor_show)(__u8 *vs, struct json_object *root));
 void show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode);
 void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
-void show_nvme_resv_report(struct nvme_reservation_status *status);
+void show_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __u32 cdw11);
 void show_lba_range(struct nvme_lba_range_type *lbrt, int nr_ranges);
 void show_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
 void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
@@ -35,7 +35,7 @@ char *nvme_feature_to_string(int feature);
 
 void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vendor_show)(__u8 *vs, struct json_object *root));
 void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
-void json_nvme_resv_report(struct nvme_reservation_status *status);
+void json_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __u32 cdw11);
 void json_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
diff --git a/nvme.c b/nvme.c
index 62ddd17..b31483f 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2214,6 +2214,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 		"namespace.";
 	const char *namespace_id = "identifier of desired namespace";
 	const char *numd = "number of dwords to transfer";
+	const char *cdw11 = "command dword 11 value";
 	const char *raw_binary = "dump output in binary format";
 
 	int err, fmt, fd;
@@ -2222,6 +2223,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 	struct config {
 		__u32 namespace_id;
 		__u32 numd;
+		__u32 cdw11;
 		int   raw_binary;
 		char *output_format;
 	};
@@ -2229,12 +2231,14 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 	struct config cfg = {
 		.namespace_id = 0,
 		.numd         = 0,
+		.cdw11	      = 0,
 		.output_format = "normal",
 	};
 
 	const struct argconfig_commandline_options command_line_options[] = {
 		{"namespace-id",  'n', "NUM", CFG_POSITIVE, &cfg.namespace_id,  required_argument, namespace_id},
 		{"numd",          'd', "NUM", CFG_POSITIVE, &cfg.numd,          required_argument, numd},
+		{"cdw11",         'c', "NUM", CFG_POSITIVE, &cfg.cdw11,         required_argument, cdw11},
 		{"raw-binary",    'b', "",    CFG_NONE,     &cfg.raw_binary,    no_argument,       raw_binary},
 		{"output-format", 'o', "FMT", CFG_STRING,   &cfg.output_format, required_argument, output_format },
 		{NULL}
@@ -2254,13 +2258,16 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 		cfg.namespace_id = get_nsid(fd);
 	if (!cfg.numd || cfg.numd > (0x1000 >> 2))
 		cfg.numd = 0x1000 >> 2;
+	if (cfg.numd < 3)
+		cfg.numd = 3; /* get the header fields at least */
 
 	if (posix_memalign((void **)&status, getpagesize(), cfg.numd << 2)) {
 		fprintf(stderr, "No memory for resv report:%d\n", cfg.numd << 2);
 		return ENOMEM;
 	}
+	memset(status, 0, cfg.numd << 2);
 
-	err = nvme_resv_report(fd, cfg.namespace_id, cfg.numd, status);
+	err = nvme_resv_report(fd, cfg.namespace_id, cfg.numd, cfg.cdw11, status);
 	if (err < 0)
 		perror("reservation report");
 	else if (err != 0)
@@ -2269,10 +2276,10 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 		if (fmt == BINARY)
 			d_raw((unsigned char *)status, cfg.numd << 2);
 		else if (fmt == JSON)
-			json_nvme_resv_report(status);
+			json_nvme_resv_report(status, cfg.numd << 2, cfg.cdw11);
 		else {
 			printf("NVME Reservation Report success\n");
-			show_nvme_resv_report(status);
+			show_nvme_resv_report(status, cfg.numd << 2, cfg.cdw11);
 		}
 	}
 	free(status);
-- 
2.12.2
