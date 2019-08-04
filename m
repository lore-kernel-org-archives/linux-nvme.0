From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:10:26 +0900
Subject: [PATCH 3/3] get-lba-status: add Get LBA Status command
In-Reply-To: <20190804071026.16149-1-minwoo.im.dev@gmail.com>
References: <20190804071026.16149-1-minwoo.im.dev@gmail.com>
Message-ID: <20190804071026.16149-4-minwoo.im.dev@gmail.com>

This command has been added in NVMe 1.4 spec.  This command can retrieve
some information about the unrecoverable LBAs from the device.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 linux/nvme.h   | 16 ++++++++++
 nvme-builtin.h |  1 +
 nvme-ioctl.c   | 15 +++++++++
 nvme-ioctl.h   |  2 ++
 nvme-print.c   | 28 +++++++++++++++++
 nvme-print.h   |  1 +
 nvme.c         | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 145 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 40bc8d7a76b6..e6945bd0e42a 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -526,6 +526,21 @@ struct nvme_fw_slot_info_log {
 	__u8			rsvd64[448];
 };
 
+struct nvme_lba_status_desc {
+	__u64 dslba;
+	__u32 nlb;
+	__u8 rsvd_12;
+	__u8 status;
+	__u8 rsvd_15_14[2];
+};
+
+struct nvme_lba_status {
+	__u32 nlsd;
+	__u8 cmpc;
+	__u8 rsvd_7_5[3];
+	struct nvme_lba_status_desc descs[0];
+};
+
 /* NVMe Namespace Write Protect State */
 enum {
 	NVME_NS_NO_WRITE_PROTECT = 0,
@@ -904,6 +919,7 @@ enum nvme_admin_opcode {
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
 	nvme_admin_sanitize_nvm		= 0x84,
+	nvme_admin_get_lba_status	= 0x86,
 };
 
 enum {
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 1eb8b9291c3f..e70b74ddaa0b 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -43,6 +43,7 @@ COMMAND_LIST(
 	ENTRY("io-passthru", "Submit an arbitrary IO command, return results", io_passthru)
 	ENTRY("security-send", "Submit a Security Send command, return results", sec_send)
 	ENTRY("security-recv", "Submit a Security Receive command, return results", sec_recv)
+	ENTRY("get-lba-status", "Submit a Get LBA Status command, return results", get_lba_status)
 	ENTRY("resv-acquire", "Submit a Reservation Acquire, return results", resv_acquire)
 	ENTRY("resv-register", "Submit a Reservation Register, return results", resv_register)
 	ENTRY("resv-release", "Submit a Reservation Release, return results", resv_release)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 0fbb91314d1f..e8a50cbcf5ba 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -820,6 +820,21 @@ int nvme_sec_recv(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
 	return err;
 }
 
+int nvme_get_lba_status(int fd, __u64 slba, __u32 mndw, __u8 atype, __u16 rl,
+		void *data)
+{
+	struct nvme_admin_cmd cmd = {
+		.opcode =  nvme_admin_get_lba_status,
+		.addr = (__u64)(uintptr_t) data,
+		.cdw10 = slba & 0xffffffff,
+		.cdw11 = slba >> 32,
+		.cdw12 = mndw,
+		.cdw13 = (atype << 24) | rl,
+	};
+
+	return nvme_submit_admin_passthru(fd, &cmd);
+}
+
 int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
                   __u32 data_len, __u32 dw12, void *data, __u32 *result)
 {
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index a0173c41833d..27325488d086 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -131,6 +131,8 @@ int nvme_subsystem_reset(int fd);
 int nvme_reset_controller(int fd);
 int nvme_ns_rescan(int fd);
 
+int nvme_get_lba_status(int fd, __u64 slba, __u32 mndw, __u8 atype, __u16 rl,
+		void *data);
 int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
 int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
diff --git a/nvme-print.c b/nvme-print.c
index 91eb326157f2..d80f81ede90c 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2169,6 +2169,34 @@ void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf
 	}
 }
 
+void show_lba_status(struct nvme_lba_status *list)
+{
+	int idx;
+
+	printf("Number of LBA Status Descriptors(NLSD): %lu\n",
+			le64_to_cpu(list->nlsd));
+	printf("Completion Condition(CMPC): %u\n", list->cmpc);
+	switch (list->cmpc) {
+	case 1:
+		printf("\tCompleted due to transferring the amount of data"\
+			" specified in the MNDW field\n");
+		break;
+	case 2:
+		printf("\tCompleted due to having performed the action\n"\
+			"\tspecified in the Action Type field over the\n"\
+			"\tnumber of logical blocks specified in the\n"\
+			"\tRange Length field\n");
+		break;
+	}
+
+	for (idx = 0; idx < list->nlsd; idx++) {
+		struct nvme_lba_status_desc *e = &list->descs[idx];
+		printf("{ DSLBA: 0x%016"PRIu64", NLB: 0x%08x, Status: 0x%02x }\n",
+				le64_to_cpu(e->dslba), le32_to_cpu(e->nlb),
+				e->status);
+	}
+}
+
 static void show_list_item(struct list_item list_item)
 {
 	long long int lba = 1 << list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ds;
diff --git a/nvme-print.h b/nvme-print.h
index bfdb00779526..0faa226c53be 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -36,6 +36,7 @@ void show_sanitize_log(struct nvme_sanitize_log_page *sanitize, unsigned int mod
 void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics);
 void show_single_property(int offset, uint64_t prop, int human);
 void show_nvme_id_ns_descs(void *data);
+void show_lba_status(struct nvme_lba_status *list);
 void show_list_items(struct list_item *list_items, unsigned len);
 void show_nvme_subsystem_list(struct subsys_list_item *slist, int n);
 void show_nvme_id_nvmset(struct nvme_id_nvmset *nvmset);
diff --git a/nvme.c b/nvme.c
index 19385a088c04..56f52f40eb0c 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4852,6 +4852,88 @@ ret:
 	return nvme_status_to_errno(err, false);
 }
 
+static int get_lba_status(int argc, char **argv, struct command *cmd,
+		struct plugin *plugin)
+{
+	const char *desc = "Information about potentially unrecoverable LBAs.";
+	const char *slba = "Starting LBA(SLBA) in 64-bit address of the first"\
+			    " logical block addressed by this command";
+	const char *mndw = "Maximum Number of Dwords(MNDW) specifies maximum"\
+			    " number of dwords to return";
+	const char *atype = "Action Type(ATYPE) specifies the mechanism the"\
+			     " the controller uses in determining the LBA"\
+			     " Status Descriptors to return.";
+	const char *rl = "Range Length(RL) specifies the length of the range"\
+			  " of contiguous LBAs beginning at SLBA";
+	int err, fd, fmt;
+	void *buf;
+	unsigned long buf_len;
+
+	struct config {
+		__u64 slba;
+		__u32 mndw;
+		__u8 atype;
+		__u16 rl;
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.slba = 0,
+		.mndw = 0,
+		.atype = 0,
+		.rl = 0,
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"start-lba", 's', "NUM", CFG_LONG_SUFFIX, &cfg.slba, required_argument, slba},
+		{"max-dw", 'm', "NUM", CFG_POSITIVE, &cfg.mndw, required_argument, mndw},
+		{"action", 'a', "NUM", CFG_BYTE, &cfg.atype, required_argument, atype},
+		{"range-len", 'l', "NUM", CFG_SHORT, &cfg.rl, required_argument, rl},
+		{"output-format", 'o', "FMT", CFG_STRING, &cfg.output_format, required_argument, output_format},
+		{NULL}
+	};
+
+	err = fd = parse_and_open(argc, argv, desc, command_line_options, &cfg,
+			sizeof(cfg));
+	if (fd < 0)
+		goto ret;
+
+	err = fmt = validate_output_format(cfg.output_format);
+	if (fmt < 0)
+		goto close_fd;
+
+	if (!cfg.atype) {
+		fprintf(stderr, "action type (--action) has to be given\n");
+		err = -EINVAL;
+		goto close_fd;
+	}
+
+	buf_len = (cfg.mndw + 1) * 4;
+	buf = calloc(1, buf_len);
+	if (!buf) {
+		err = -ENOMEM;
+		goto close_fd;
+	}
+
+	err = nvme_get_lba_status(fd, cfg.slba, cfg.mndw, cfg.atype, cfg.rl,
+			buf);
+	if (err)
+		goto free;
+
+	if (fmt == BINARY)
+		d_raw((unsigned char *)buf, buf_len);
+	else
+		show_lba_status(buf);
+
+free:
+	free(buf);
+close_fd:
+	close(fd);
+ret:
+	return nvme_status_to_errno(err, false);
+}
+
 static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Read directive parameters of the "\
-- 
2.17.1
