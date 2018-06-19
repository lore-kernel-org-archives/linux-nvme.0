From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Tue, 19 Jun 2018 09:28:59 -0600
Subject: [PATCH] nvme-cli: Implemented primary and secondary controller
Message-ID: <20180619152859.3686-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 linux/nvme.h   |  43 ++++++++++++++++++
 nvme-builtin.h |   2 +
 nvme-ioctl.c   |  22 +++++++++
 nvme-ioctl.h   |   3 ++
 nvme-print.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
 nvme-print.h   |   7 +++
 nvme.c         | 109 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 306 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 8df7255..d6f99d9 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -34,6 +34,8 @@
 
 #define NVME_NSID_ALL		0xffffffff
 
+#define NVME_SECONDARY_CONTROLLER_MAX	127
+
 enum nvme_subsys_type {
 	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
@@ -270,6 +272,44 @@ struct nvme_id_ctrl {
 	__u8			vs[1024];
 };
 
+struct nvme_id_primary_ctrl {
+	__le16	cntlid;
+	__le16	portid;
+	__u8	crt;
+	__u8	rsvd5[27];
+	__le32	vqfrt;
+	__le32	vqrfa;
+	__le16	vqrfap;
+	__le16 	vqprt;
+	__le16	vqfrsm;
+	__le16 	vqgran;
+	__u8	rsvd48[16];
+	__le32	vifrt;
+	__le32	virfa;
+	__le16 	virfap;
+	__le16	viprt;
+	__le16	vifrsm;
+	__le16	vigran;
+	__u8	rsvd80[4016];
+};
+
+struct nvme_secondary_ctrl_entry {
+	__le16	scid;
+	__le16 	pcid;
+	__u8 	scs;
+	__u8 	rsvd5[3];
+	__le16 	vfn;
+	__le16 	nvq;
+	__le16 	nvi;
+	__u8 	rsvd14[18];
+};
+
+struct nvme_id_secondary_ctrl_list {
+	__u8 	num_of_identifiers;
+	__u8	rsvd1[31];
+	struct  nvme_secondary_ctrl_entry sc[NVME_SECONDARY_CONTROLLER_MAX];
+};
+
 enum {
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
@@ -337,6 +377,8 @@ enum {
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
 	NVME_ID_CNS_CTRL_LIST		= 0x13,
+	NVME_ID_CNS_PIMARY_CTRL_CAP 		= 0x14,
+	NVME_ID_CNS_SECONDARY_CTRL_LIST 	= 0x15,
 };
 
 enum {
@@ -934,6 +976,7 @@ struct nvme_identify {
 };
 
 #define NVME_IDENTIFY_DATA_SIZE 4096
+#define NVME_VIRTUAL_CTRL_DATA_SIZE 4096
 
 struct nvme_features {
 	__u8			opcode;
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 86b0fff..0b81193 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -63,6 +63,8 @@ COMMAND_LIST(
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
+	ENTRY("id-primary-ctrl", "Obtain the primary controller capabilities structure", id_primary_ctrl)
+	ENTRY("id-secondary-ctrl", "Obtain a Secondary Controller list associated with the primary controller", id_secondary_ctrl)
 );
 
 #endif
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 63ff8fb..493f643 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -393,6 +393,28 @@ int nvme_identify_nvmset(int fd, __u16 nvmset_id, void *data)
 	return nvme_identify13(fd, 0, NVME_ID_CNS_NVMSET_LIST, nvmset_id, data);
 }
 
+int nvme_ctrl(int fd, __u32 cdw10, void *data)
+{
+	struct nvme_admin_cmd cmd = {
+		.opcode 	= nvme_admin_virtual_mgmt,
+		.addr 		= (__u64)(uintptr_t) data,
+		.data_len	= NVME_VIRTUAL_CTRL_DATA_SIZE,
+		.cdw10 		= cdw10,
+	};
+
+	return nvme_submit_admin_passthru(fd, &cmd);
+}
+
+int nvme_id_primary_ctrl(int fd, void *data)
+{
+	return nvme_ctrl(fd, NVME_ID_CNS_PIMARY_CTRL_CAP, data);
+}
+
+int nvme_id_secondary_ctrl(int fd, void *data)
+{
+	return nvme_ctrl(fd, NVME_ID_CNS_SECONDARY_CTRL_LIST, data);
+}
+
 int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
                  __u16 lsi, __u32 data_len, void *data)
 {
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 6d4ac95..4919020 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -138,4 +138,7 @@ int nvme_sanitize(int fd, __u8 sanact, __u8 ause, __u8 owpass, __u8 oipbp,
 		  __u8 no_dealloc, __u32 ovrpat);
 int nvme_self_test_start(int fd, __u32 nsid, __u32 cdw10);
 int nvme_self_test_log(int fd, struct nvme_self_test_log *self_test_log);
+int nvme_ctrl(int fd, __u32 cdw10, void *data);
+int nvme_id_primary_ctrl(int fd, void *data);
+int nvme_id_secondary_ctrl(int fd, void *data);
 #endif				/* _NVME_LIB_H */
diff --git a/nvme-print.c b/nvme-print.c
index 8699d6c..509125f 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -951,6 +951,74 @@ void show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
 	__show_nvme_id_ctrl(ctrl, mode, NULL);
 }
 
+void show_nvme_id_primary_ctrl_crt(__u8 crt)
+{
+	__u8 rsvd = (crt & 0xFC) >> 2;
+	__u8 vir  = (crt & 0x2) >> 1;
+	__u8 vqr  = crt & 0x1;
+	if (rsvd)
+		printf("  [7:2] : %#x\tReserved\n", rsvd);
+	printf("  [1:1] : %#x\t VI Resources are %s\n",
+		vir, vir ? "Supported" : "NOT Supported");
+	printf("  [0:0] : %#x\t VQ Resources are %s\n", vqr,
+		vqr ? "Supported" : "NOT Supported");
+	printf("\n");
+}
+
+void show_nvme_id_primary_ctrl(struct nvme_id_primary_ctrl *ctrl)
+{
+	printf("cntlid     : %#x\n", le16_to_cpu(ctrl->cntlid));
+	printf("portid     : %#x\n", le16_to_cpu(ctrl->portid));
+	printf("crt        : %#x\n", ctrl->crt);
+	show_nvme_id_primary_ctrl_crt(ctrl->crt);
+	printf("vqfrt      : %u\n", le32_to_cpu(ctrl->vqfrt));
+	printf("vqrfa      : %u\n", le32_to_cpu(ctrl->vqrfa));
+	printf("vqrfap     : %d\n", le16_to_cpu(ctrl->vqrfap));
+	printf("vqprt      : %d\n", le16_to_cpu(ctrl->vqprt));
+	printf("vqfrsm     : %d\n", le16_to_cpu(ctrl->vqfrsm));
+	printf("vqgran     : %d\n", le16_to_cpu(ctrl->vqgran));
+	printf("vifrt      : %u\n", le32_to_cpu(ctrl->vifrt));
+	printf("virfa      : %u\n", le32_to_cpu(ctrl->virfa));
+	printf("virfap     : %d\n", le16_to_cpu(ctrl->virfap));
+	printf("viprt      : %d\n", le16_to_cpu(ctrl->viprt));
+	printf("vifrsm     : %d\n", le16_to_cpu(ctrl->vifrsm));
+	printf("vigran     : %d\n", le16_to_cpu(ctrl->vigran));
+}
+
+void show_nvme_id_secondary_ctrl_entry_scs(__u8 scs)
+{
+	__u8 rsvd = (scs & 0xFE) >> 1;
+	__u8 os  = scs & 0x1;
+
+	if (rsvd)
+		printf("  [7:1] : %#x\tReserved\n", rsvd);
+	printf("  [0:0] : %#x\t Controller is in %s state\n", os,
+		os ? "Online" : "Offline");
+
+}
+
+void show_nvme_id_secondary_ctrl_entry(struct nvme_secondary_ctrl_entry *ctrl)
+{
+	printf("scid     : %#x\n", le16_to_cpu(ctrl->scid));
+	printf("pcid     : %#x\n", le16_to_cpu(ctrl->pcid));
+	printf("scs 	 : %#x\n",ctrl->scs);
+	show_nvme_id_secondary_ctrl_entry_scs(ctrl->scs);
+	printf("vfn	     : %d\n", le16_to_cpu(ctrl->vfn));
+	printf("nvq	     : %d\n", le16_to_cpu(ctrl->nvq));
+	printf("nvi	     : %d\n", le16_to_cpu(ctrl->nvi));
+}
+
+void show_nvme_id_secondary_ctrl_list(struct nvme_id_secondary_ctrl_list *ctrl)
+{
+	int i;
+
+	printf("num_of_identifiers  : %d\n", ctrl->num_of_identifiers);
+	for(i = 0; i < ctrl->num_of_identifiers; i++) {
+		printf("\n Secondary Controller - %d  : \n", i+1);
+		show_nvme_id_secondary_ctrl_entry(&ctrl->sc[i]);
+	}
+}
+
 void show_nvme_id_nvmset(struct nvme_id_nvmset *nvmset)
 {
 	int i;
@@ -2141,6 +2209,58 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_free_object(root);
 }
 
+void json_nvme_id_primary_ctrl(struct nvme_id_primary_ctrl *ctrl)
+{
+	struct json_object *root;
+	root = json_create_object();
+
+	json_object_add_value_int(root, "cntlid", le16_to_cpu(ctrl->cntlid));
+	json_object_add_value_int(root, "portid", le16_to_cpu(ctrl->portid));
+	json_object_add_value_int(root, "crt", ctrl->crt);
+	json_object_add_value_int(root, "vqfrt", le32_to_cpu(ctrl->vqfrt));
+	json_object_add_value_int(root, "vqrfa", le32_to_cpu(ctrl->vqrfa));
+	json_object_add_value_int(root, "vqrfap", le16_to_cpu(ctrl->vqrfap));
+	json_object_add_value_int(root, "vqprt", le16_to_cpu(ctrl->vqprt));
+	json_object_add_value_int(root, "vqfrsm", le16_to_cpu(ctrl->vqfrsm));
+	json_object_add_value_int(root, "vqgran", le16_to_cpu(ctrl->vqgran));
+	json_object_add_value_uint(root, "vifrt", le32_to_cpu(ctrl->vifrt));
+	json_object_add_value_uint(root, "virfa", le32_to_cpu(ctrl->virfa));
+	json_object_add_value_int(root, "virfap", le16_to_cpu(ctrl->virfap));
+	json_object_add_value_int(root, "viprt", le16_to_cpu(ctrl->viprt));
+	json_object_add_value_int(root, "vifrsm", le16_to_cpu(ctrl->vifrsm));
+	json_object_add_value_int(root, "vigran", le16_to_cpu(ctrl->vigran));
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
+void json_nvme_id_secondary_ctrl(struct nvme_id_secondary_ctrl_list *ctrl)
+{
+	struct json_object *root;
+	struct json_array *valid;
+	struct json_object *valid_attrs;
+	int i;
+
+	root = json_create_object();
+	json_object_add_value_int(root, "num_of_identifiers", ctrl->num_of_identifiers);
+	valid = json_create_array();
+
+	for (i=0; i < ctrl->num_of_identifiers; i++) {
+		valid_attrs = json_create_object();
+		json_object_add_value_int(valid_attrs, "scid", le16_to_cpu(ctrl->sc[i].scid));
+		json_object_add_value_int(valid_attrs, "pcid", le16_to_cpu(ctrl->sc[i].pcid));
+		json_object_add_value_int(valid_attrs, "scs", ctrl->sc[i].scs );
+		json_object_add_value_int(valid_attrs, "vfn", le16_to_cpu(ctrl->sc[i].vfn));
+		json_object_add_value_int(valid_attrs, "nvq", le16_to_cpu(ctrl->sc[i].nvq));
+		json_object_add_value_int(valid_attrs, "nvi", le16_to_cpu(ctrl->sc[i].nvi));
+		json_array_add_value_object(valid, valid_attrs);
+	}
+	json_object_add_value_array(root, "Secondary Controller Entries", valid);
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
 void json_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname)
 {
 	struct json_object *root;
diff --git a/nvme-print.h b/nvme-print.h
index 7dd5f34..2d5ab8c 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -58,6 +58,13 @@ void json_nvme_id_ns_descs(void *data);
 void json_print_nvme_subsystem_list(struct subsys_list_item *slist, int n);
 void json_self_test_log(struct nvme_self_test_log *self_test, const char *devname);
 void json_nvme_id_nvmset(struct nvme_id_nvmset *nvmset, const char *devname);
+void show_nvme_id_primary_ctrl_crt(__u8 crt);
+void show_nvme_id_primary_ctrl(struct nvme_id_primary_ctrl *ctrl);
+void show_nvme_id_secondary_ctrl_entry_scs(__u8 scs);
+void show_nvme_id_secondary_ctrl_entry(struct nvme_secondary_ctrl_entry *ctrl);
+void show_nvme_id_secondary_ctrl_list(struct nvme_id_secondary_ctrl_list *ctrl);
+void json_nvme_id_primary_ctrl(struct nvme_id_primary_ctrl *ctrl);
+void json_nvme_id_secondary_ctrl(struct nvme_id_secondary_ctrl_list *ctrl);
 
 
 #endif
diff --git a/nvme.c b/nvme.c
index 2dd74d2..798cfcd 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1633,6 +1633,115 @@ static int id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *pl
 	return __id_ctrl(argc, argv, cmd, plugin, NULL);
 }
 
+int id_primary_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "Send an Primary Controller command to "\
+		"the given device and report information about the specified "\
+		"primary controller in human-readable or binary format.";
+	int err, fmt, fd;
+	struct nvme_id_primary_ctrl ctrl;
+
+	struct config {
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-format",   'o', "FMT", CFG_STRING, &cfg.output_format,   required_argument, output_format },
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
+	err = nvme_id_primary_ctrl(fd, &ctrl);
+	if (!err) {
+		if (fmt == BINARY)
+			d_raw((unsigned char *)&ctrl, sizeof(ctrl));
+		else if (fmt == JSON)
+			json_nvme_id_primary_ctrl(&ctrl);
+		else {
+			printf("NVME Primary Controller:\n");
+			show_nvme_id_primary_ctrl(&ctrl);
+		}
+	}
+	else if (err > 0)
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(err), err);
+	else
+		perror("Primary controller");
+
+ close_fd:
+	close(fd);
+
+	return err;
+}
+
+int id_secondary_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "Send an Secondary Controller command to "\
+		"the given device and report information about the "\
+		"secondary controllers associated with the primary controller in "\
+		"human-readable or binary format.";
+	int err, fmt, fd;
+	struct nvme_id_secondary_ctrl_list ctrl;
+
+	struct config {
+		char *output_format;
+	};
+
+	struct config cfg = {
+		.output_format = "normal",
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"output-format",   'o', "FMT", CFG_STRING, &cfg.output_format,   required_argument, output_format },
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
+	err = nvme_id_secondary_ctrl(fd, &ctrl);
+	if (!err) {
+		if (fmt == BINARY)
+			d_raw((unsigned char *)&ctrl, sizeof(ctrl));
+		else if (fmt == JSON)
+			json_nvme_id_secondary_ctrl(&ctrl);
+		else {
+			printf("NVME Secondary Controller:\n");
+			show_nvme_id_secondary_ctrl_list(&ctrl);
+		}
+	}
+	else if (err > 0)
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(err), err);
+	else
+		perror("Secondary controller");
+
+ close_fd:
+	close(fd);
+
+	return err;
+}
+
 static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Send Namespace Identification Descriptors command to the "\
-- 
2.17.1
