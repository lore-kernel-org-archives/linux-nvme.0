From: kwan.huen@samsung.com (kwan.huen@samsung.com)
Date: Thu, 10 Aug 2017 19:54:10 -0700
Subject: [PATCH 1/2] nvme-cli: add nvme directive command support
In-Reply-To: <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>
References: <1502420051-12378-1-git-send-email-kwan.huen@samsung.com>
 <CGME20170811025054epcas1p48a24a0bd619e8bf754127422db8ebab9@epcas1p4.samsung.com>
Message-ID: <1502420051-12378-2-git-send-email-kwan.huen@samsung.com>

From: "Kwan (Hingkwan) Huen-SSI" <kwan.huen@samsung.com>

Signed-off-by: Kwan (Hingkwan) Huen-SSI <kwan.huen at samsung.com>
---
 linux/nvme.h   |  35 ++++++++
 nvme-builtin.h |   2 +
 nvme-ioctl.c   |  41 +++++++++
 nvme-ioctl.h   |   5 ++
 nvme-print.c   |  59 ++++++++++++-
 nvme-print.h   |   1 +
 nvme.c         | 260 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 402 insertions(+), 1 deletion(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 19354a5..44b8bd0 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -253,6 +253,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 7,
 };
 
@@ -304,6 +305,19 @@ enum {
 };
 
 enum {
+	NVME_DIR_IDENTIFY		= 0x00,
+	NVME_DIR_STREAMS		= 0x01,
+	NVME_DIR_SND_ID_OP_ENABLE	= 0x01,
+	NVME_DIR_SND_ST_OP_REL_ID	= 0x01,
+	NVME_DIR_SND_ST_OP_REL_RSC	= 0x02,
+	NVME_DIR_RCV_ID_OP_PARAM	= 0x01,
+	NVME_DIR_RCV_ST_OP_PARAM	= 0x01,
+	NVME_DIR_RCV_ST_OP_STATUS	= 0x02,
+	NVME_DIR_RCV_ST_OP_RESOURCE	= 0x03,
+	NVME_DIR_ENDIR			= 0x01,
+};
+
+enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
@@ -582,6 +596,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
+	NVME_RW_DTYPE_STREAMS		= 1 << 4,
 };
 
 struct nvme_dsm_cmd {
@@ -656,6 +671,8 @@ enum nvme_admin_opcode {
 	nvme_admin_download_fw		= 0x11,
 	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
+	nvme_admin_directive_send       = 0x19,
+	nvme_admin_directive_recv       = 0x1a,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -983,6 +1000,23 @@ struct nvme_dbbuf {
 	__u32			rsvd12[6];
 };
 
+struct nvme_directive_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le32			numd;
+	__u8			doper;
+	__u8			dtype;
+	__le16			dspec;
+	__u8			endir;
+	__u8			tdtype;
+	__u16			rsvd15;
+	__u32			rsvd16[3];
+};
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -1003,6 +1037,7 @@ struct nvme_command {
 		struct nvmf_property_set_command prop_set;
 		struct nvmf_property_get_command prop_get;
 		struct nvme_dbbuf dbbuf;
+		struct nvme_directive_cmd directive;
 	};
 };
 
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 2143ffd..b24c25b 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -52,6 +52,8 @@ COMMAND_LIST(
 	ENTRY("connect", "Connect to NVMeoF subsystem", connect_cmd)
 	ENTRY("disconnect", "Disconnect from NVMeoF subsystem", disconnect_cmd)
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
+	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
+	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
 );
 
 #endif
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index e0955b7..ca77c44 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -588,3 +588,44 @@ int nvme_sec_recv(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
 		*result = cmd.result;
 	return err;
 }
+
+int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
+                  __u32 data_len, __u32 dw12, void *data, __u32 *result)
+{
+        struct nvme_admin_cmd cmd = {
+                .opcode         = nvme_admin_directive_send,
+                .addr           = (__u64)(uintptr_t) data,
+                .data_len       = data_len,
+                .nsid           = nsid,
+                .cdw10          = data_len? (data_len >> 2) - 1 : 0,
+                .cdw11          = dspec << 16 | dtype << 8 | doper,
+                .cdw12          = dw12,
+        };
+        int err;
+
+        err = nvme_submit_admin_passthru(fd, &cmd);
+        if (!err && result)
+                *result = cmd.result;
+        return err;
+}
+
+int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
+                  __u32 data_len, __u32 dw12, void *data, __u32 *result)
+{
+        struct nvme_admin_cmd cmd = {
+                .opcode         = nvme_admin_directive_recv,
+                .addr           = (__u64)(uintptr_t) data,
+                .data_len       = data_len,
+                .nsid           = nsid,
+                .cdw10          = data_len? (data_len >> 2) - 1 : 0,
+                .cdw11          = dspec << 16 | dtype << 8 | doper,
+                .cdw12          = dw12,
+        };
+        int err;
+
+        err = nvme_submit_admin_passthru(fd, &cmd);
+        if (!err && result)
+                *result = cmd.result;
+        return err;
+}
+
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 7818721..4aee90a 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -116,4 +116,9 @@ int nvme_sec_recv(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
 int nvme_subsystem_reset(int fd);
 int nvme_reset_controller(int fd);
 
+int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
+		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
+int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
+		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
+
 #endif				/* _NVME_LIB_H */
diff --git a/nvme-print.c b/nvme-print.c
index f03382f..cec0bdb 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -122,7 +122,9 @@ static void show_nvme_id_ctrl_ctratt(__le32 ctrl_ctratt)
 static void show_nvme_id_ctrl_oacs(__le16 ctrl_oacs)
 {
 	__u16 oacs = le16_to_cpu(ctrl_oacs);
-	__u16 rsvd = (oacs & 0xFFF0) >> 4;
+	__u16 rsvd = (oacs & 0xFFF0) >> 6;
+	__u16 dir = (oacs & 0x20) >> 5;
+	__u16 sft = (oacs & 0x10) >> 4;
 	__u16 nsm = (oacs & 0x8) >> 3;
 	__u16 fwc = (oacs & 0x4) >> 2;
 	__u16 fmt = (oacs & 0x2) >> 1;
@@ -130,6 +132,10 @@ static void show_nvme_id_ctrl_oacs(__le16 ctrl_oacs)
 
 	if (rsvd)
 		printf(" [15:4] : %#x\tReserved\n", rsvd);
+	printf("  [5:5] : %#x\tDirectives %sSupported\n",
+		dir, dir ? "" : "Not ");
+	printf("  [4:4] : %#x\tDevice Self-test %sSupported\n",
+		sft, sft ? "" : "Not ");
 	printf("  [3:3] : %#x\tNS Management and Attachment %sSupported\n",
 		nsm, nsm ? "" : "Not ");
 	printf("  [2:2] : %#x\tFW Commit and Download %sSupported\n",
@@ -1242,6 +1248,57 @@ static void show_host_mem_buffer(struct nvme_host_mem_buffer *hmb)
 	printf("\tHost Memory Buffer Size                  (HSIZE): %u\n", hmb->hsize);
 }
 
+void nvme_directive_show_fields(__u8 dtype, __u8 doper, unsigned int result, unsigned char *buf)
+{
+        __u8 *field = buf;
+        int count, i;
+        switch (dtype) {
+        case NVME_DIR_IDENTIFY:
+                switch (doper) {
+                case NVME_DIR_RCV_ID_OP_PARAM:
+                        printf("\tDirective support \n");
+                        printf("\t\tIdentify Directive  : %s\n", (*field & 0x1) ? "supported":"not supported");
+                        printf("\t\tStream Directive    : %s\n", (*field & 0x2) ? "supported":"not supported");
+                        printf("\tDirective status \n");
+                        printf("\t\tIdentify Directive  : %s\n", (*(field + 32) & 0x1) ? "enabled" : "disabled");
+                        printf("\t\tStream Directive    : %s\n", (*(field + 32) & 0x2) ? "enabled" : "disabled");
+                        break;
+                default:
+                        fprintf(stderr, "invalid directive operations for Identify Directives\n");
+                }
+                break;
+        case NVME_DIR_STREAMS:
+                switch (doper) {
+                case NVME_DIR_RCV_ST_OP_PARAM:
+                        printf("\tMax Streams Limit                          (MSL): %u\n", *(__u16 *) field);
+                        printf("\tNVM Subsystem Streams Available           (NSSA): %u\n", *(__u16 *) (field + 2));
+                        printf("\tNVM Subsystem Streams Open                (NSSO): %u\n", *(__u16 *) (field + 4));
+                        printf("\tStream Write Size (in unit of LB size)     (SWS): %u\n", *(__u32 *) (field + 16));
+                        printf("\tStream Granularity Size (in unit of SWS)   (SGS): %u\n", *(__u16 *) (field + 20));
+                        printf("\tNamespece Streams Allocated                (NSA): %u\n", *(__u16 *) (field + 22));
+                        printf("\tNamespace Streams Open                     (NSO): %u\n", *(__u16 *) (field + 24));
+                        break;
+                case NVME_DIR_RCV_ST_OP_STATUS:
+                        count = *(__u16 *) field;
+                        printf("\tOpen Stream Count  : %u\n", *(__u16 *) field);
+                        for ( i = 0; i < count; i++ ) {
+                                printf("\tStream Identifier %.6u : %u\n", i + 1, *(__u16 *) (field + ((i + 1) * 2)));
+                        }
+                        break;
+                case NVME_DIR_RCV_ST_OP_RESOURCE:
+                        printf("\tNamespace Streams Allocated (NSA): %u\n", result & 0xffff);
+                        break;
+                default:
+                        fprintf(stderr, "invalid directive operations for Streams Directives\n");
+                }
+                break;
+        default:
+                fprintf(stderr, "invalid directive type\n");
+                break;
+        }
+        return;
+}
+
 void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf)
 {
 	__u8 field;
diff --git a/nvme-print.h b/nvme-print.h
index fd89c96..4cdcb95 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -29,6 +29,7 @@ void show_ctrl_registers(void *bar, unsigned int mode);
 void show_nvme_id_ns_descs(void *data);
 
 void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf);
+void nvme_directive_show_fields(__u8 dtype, __u8 doper, unsigned int result, unsigned char *buf);
 char *nvme_status_to_string(__u32 status);
 char *nvme_select_to_string(int sel);
 char *nvme_feature_to_string(int feature);
diff --git a/nvme.c b/nvme.c
index b4a039a..e78a379 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1925,6 +1925,142 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 	return err;
 }
 
+static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+        const char *desc = "Set directive parameters of the "\
+                "specified directive type.";
+        const char *raw_binary = "show infos in binary format";
+        const char *namespace_id = "identifier of desired namespace";
+        const char *data_len = "buffer len (if) data is returned";
+        const char *dtype = "directive type";
+        const char *dspec = "directive specification associated with directive type";
+        const char *doper = "directive operation";
+        const char *endir = "directive enable";
+        const char *ttype = "target directive type to be enabled/disabled";
+        const char *human_readable = "show infos in readable format";
+        int err, fd;
+        __u32 result;
+        __u32 dw12 = 0;
+        void *buf = NULL;
+        int ffd = STDIN_FILENO;
+
+        struct config {
+                char *file;
+                __u32 namespace_id;
+                __u32 data_len;
+                __u16 dspec;
+                __u8  dtype;
+                __u8  doper;
+                __u16 endir;
+                __u8  ttype;
+                int  raw_binary;
+                int  human_readable;
+        };
+
+        struct config cfg = {
+                .file         = "",
+                .namespace_id = 1,
+                .data_len     = 0,
+                .dspec        = 0,
+                .dtype        = 0,
+                .ttype        = 0,
+                .doper        = 0,
+                .endir        = 1,
+        };
+
+        const struct argconfig_commandline_options command_line_options[] = {
+                {"namespace-id",   'n', "NUM", CFG_POSITIVE, &cfg.namespace_id,   required_argument, namespace_id},
+                {"data-len",       'l', "NUM", CFG_POSITIVE, &cfg.data_len,       required_argument, data_len},
+                {"raw-binary",     'b', "FLAG",CFG_NONE,     &cfg.raw_binary,     no_argument,       raw_binary},
+                {"dir-type",       'D', "NUM", CFG_BYTE,     &cfg.dtype,          required_argument, dtype},
+                {"target-dir",     'T', "NUM", CFG_BYTE,     &cfg.ttype,          required_argument, ttype},
+                {"dir-spec",       'S', "NUM", CFG_SHORT,    &cfg.dspec,          required_argument, dspec},
+                {"dir-oper",       'O', "NUM", CFG_BYTE,     &cfg.doper,          required_argument, doper},
+                {"endir",          'e', "NUM", CFG_SHORT,    &cfg.endir,          required_argument, endir},
+                {"human-readable", 'H', "FLAG",CFG_NONE,     &cfg.human_readable, no_argument,       human_readable},
+                {NULL}
+        };
+
+        fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (fd < 0)
+		return fd;
+
+        switch (cfg.dtype) {
+        case NVME_DIR_IDENTIFY:
+                switch (cfg.doper) {
+                case NVME_DIR_SND_ID_OP_ENABLE:
+                        if (!cfg.ttype) {
+                                fprintf(stderr, "target-dir required param\n");
+                                return EINVAL;
+                        }
+                        dw12 = cfg.ttype << 8 | cfg.endir;
+                        break;
+                default:
+                        fprintf(stderr, "invalid directive operations for Identify Directives\n");
+                        return EINVAL;
+                }
+                break;
+        case NVME_DIR_STREAMS:
+                switch (cfg.doper) {
+                case NVME_DIR_SND_ST_OP_REL_ID:
+                case NVME_DIR_SND_ST_OP_REL_RSC:
+                        break;
+                default:
+                        fprintf(stderr, "invalid directive operations for Streams Directives\n");
+                        return EINVAL;
+                }
+                break;
+        default:
+                fprintf(stderr, "invalid directive type\n");
+                return EINVAL;
+                break;
+        }
+
+
+        if (cfg.data_len) {
+                if (posix_memalign(&buf, getpagesize(), cfg.data_len))
+                        exit(ENOMEM);
+                memset(buf, 0, cfg.data_len);
+        }
+
+        if (buf) {
+                if (strlen(cfg.file)) {
+                        ffd = open(cfg.file, O_RDONLY);
+                        if (ffd <= 0) {
+                                fprintf(stderr, "no firmware file provided\n");
+                                return -EINVAL;
+                        }
+                }
+                if (read(ffd, (void *)buf, cfg.data_len) < 0) {
+                        fprintf(stderr, "failed to read data buffer from input file\n");
+                        return EINVAL;
+                }
+        }
+
+        err = nvme_dir_send(fd, cfg.namespace_id, cfg.dspec, cfg.dtype, cfg.doper,
+                                cfg.data_len, dw12, buf, &result);
+        if (err < 0) {
+                perror("dir-send");
+                return errno;
+        }
+        if (!err) {
+                printf("dir-send: type %#x, operation %#x, spec_val %#x, nsid %#x, result %#x \n",
+                                cfg.dtype, cfg.doper, cfg.dspec, cfg.namespace_id, result);
+                if (buf) {
+                        if (!cfg.raw_binary)
+                                d(buf, cfg.data_len, 16, 1);
+                        else
+                                d_raw(buf, cfg.data_len);
+                }
+        }
+        else if (err > 0)
+                fprintf(stderr, "NVMe Status:%s(%x)\n",
+                                nvme_status_to_string(err), err);
+        if (buf)
+                free(buf);
+        return err;
+}
+
 static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	int err, fd;
@@ -2753,6 +2889,130 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
 	return err;
 }
 
+static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+        const char *desc = "Read directive parameters of the "\
+                "specified directive type.";
+        const char *raw_binary = "show infos in binary format";
+        const char *namespace_id = "identifier of desired namespace";
+        const char *data_len = "buffer len (if) data is returned";
+        const char *dtype = "directive type";
+        const char *dspec = "directive specification associated with directive type";
+        const char *doper = "directive operation";
+        const char *nsr = "namespace stream requested";
+        const char *human_readable = "show infos in readable format";
+        int err, fd;
+        __u32 result;
+        __u32 dw12 = 0;
+        void *buf = NULL;
+
+        struct config {
+                __u32 namespace_id;
+                __u32 data_len;
+                __u16 dspec;
+                __u8  dtype;
+                __u8  doper;
+                __u16 nsr; /* dw12 for NVME_DIR_ST_RCVOP_STATUS */
+                int  raw_binary;
+                int  human_readable;
+        };
+
+        struct config cfg = {
+                .namespace_id = 1,
+                .data_len     = 0,
+                .dspec        = 0,
+                .dtype        = 0,
+                .doper        = 0,
+                .nsr          = 0,
+        };
+
+        const struct argconfig_commandline_options command_line_options[] = {
+                {"namespace-id",   'n', "NUM", CFG_POSITIVE, &cfg.namespace_id,   required_argument, namespace_id},
+                {"data-len",       'l', "NUM", CFG_POSITIVE, &cfg.data_len,       required_argument, data_len},
+                {"raw-binary",     'b', "FLAG",CFG_NONE,     &cfg.raw_binary,     no_argument,       raw_binary},
+                {"dir-type",       'D', "NUM", CFG_BYTE,     &cfg.dtype,          required_argument, dtype},
+                {"dir-spec",       'S', "NUM", CFG_SHORT,    &cfg.dspec,          required_argument, dspec},
+                {"dir-oper",       'O', "NUM", CFG_BYTE,     &cfg.doper,          required_argument, doper},
+                {"req-resource",   'r', "NUM", CFG_SHORT,    &cfg.nsr,            required_argument, nsr},
+                {"human-readable", 'H', "FLAG",CFG_NONE,     &cfg.human_readable, no_argument,       human_readable},
+                {NULL}
+        };
+
+        fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (fd < 0)
+		return fd;
+
+        switch (cfg.dtype) {
+        case NVME_DIR_IDENTIFY:
+                switch (cfg.doper) {
+                case NVME_DIR_RCV_ID_OP_PARAM:
+                        if (!cfg.data_len)
+                                cfg.data_len = 4096;
+                        break;
+                default:
+                        fprintf(stderr, "invalid directive operations for Identify Directives\n");
+                        return EINVAL;
+                }
+                break;
+        case NVME_DIR_STREAMS:
+                switch (cfg.doper) {
+                case NVME_DIR_RCV_ST_OP_PARAM:
+                        if (!cfg.data_len)
+                                cfg.data_len = 32;
+                        break;
+                case NVME_DIR_RCV_ST_OP_STATUS:
+                        if (!cfg.data_len)
+                                cfg.data_len = 128 * 1024;
+                        break;
+                case NVME_DIR_RCV_ST_OP_RESOURCE:
+                        dw12 = cfg.nsr;
+                        break;
+                default:
+                        fprintf(stderr, "invalid directive operations for Streams Directives\n");
+                        return EINVAL;
+                }
+                break;
+        default:
+                fprintf(stderr, "invalid directive type\n");
+                return EINVAL;
+                break;
+        }
+
+        if (cfg.data_len) {
+                if (posix_memalign(&buf, getpagesize(), cfg.data_len))
+                        exit(ENOMEM);
+                memset(buf, 0, cfg.data_len);
+        }
+
+        err = nvme_dir_recv(fd, cfg.namespace_id, cfg.dspec, cfg.dtype, cfg.doper,
+                        cfg.data_len, dw12, buf, &result);
+        if (err < 0) {
+                perror("dir-receive");
+                return errno;
+        }
+
+        if (!err) {
+                printf("dir-receive: type %#x, operation %#x, spec %#x, nsid %#x, result %#x \n",
+                                cfg.dtype, cfg.doper, cfg.dspec, cfg.namespace_id, result);
+                if (cfg.human_readable)
+                        nvme_directive_show_fields(cfg.dtype, cfg.doper, result, buf);
+                else {
+                        if (buf) {
+                                if (!cfg.raw_binary)
+                                        d(buf, cfg.data_len, 16, 1);
+                                else
+                                        d_raw(buf, cfg.data_len);
+                        }
+                }
+        }
+        else if (err > 0)
+                fprintf(stderr, "NVMe Status:%s(%x)\n",
+                                nvme_status_to_string(err), err);
+        if (buf)
+                free(buf);
+        return err;
+}
+
 static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, struct command *cmd)
 {
 	void *data = NULL, *metadata = NULL;
-- 
2.7.4
