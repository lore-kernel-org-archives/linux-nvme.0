From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 Aug 2018 22:59:19 -0700
Subject: [PATCH V4 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180813055920.22414-1-chaitanya.kulkarni@wdc.com>
References: <20180813055920.22414-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180813055920.22414-2-chaitanya.kulkarni@wdc.com>

This patch adds a new command to retrieve the ANA Log page.
We update identify ctrl/ns data structure to support this command.
We also add ana based error codes and different identifiers to the
linux/nvme.h header file in order to support this command.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 linux/nvme.h   |  52 +++++++++++++--
 nvme-builtin.h |   1 +
 nvme-ioctl.c   |   8 +++
 nvme-ioctl.h   |   1 +
 nvme-print.c   | 170 ++++++++++++++++++++++++++++++++++++++++++++++++-
 nvme-print.h   |   2 +
 nvme.c         |  72 +++++++++++++++++++++
 7 files changed, 299 insertions(+), 7 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index b276798..f585cd4 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -241,7 +241,12 @@ struct nvme_id_ctrl {
 	__le32			hmminds;
 	__le16			hmmaxd;
 	__le16			nsetidmax;
-	__u8			rsvd340[172];
+	__u8			rsvd340[2];
+	__u8			anatt;
+	__u8			anacap;
+	__le32			anagrpmax;
+	__le32			nanagrpid;
+	__u8			rsvd352[160];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -257,7 +262,8 @@ struct nvme_id_ctrl {
 	__le16			acwu;
 	__u8			rsvd534[2];
 	__le32			sgls;
-	__u8			rsvd540[228];
+	__le32			mnan;
+	__u8			rsvd544[224];
 	char			subnqn[256];
 	__u8			rsvd1024[768];
 	__le32			ioccsz;
@@ -317,7 +323,9 @@ struct nvme_id_ns {
 	__le16			nabspf;
 	__le16			noiob;
 	__u8			nvmcap[16];
-	__u8			rsvd64[35];
+	__u8			rsvd64[28];
+	__le32			anagrpid;
+	__u8			rsvd96[4];
 	__u8			nsattr;
 	__le16			nvmsetid;
 	__le16			endgid;
@@ -525,6 +533,32 @@ struct nvme_effects_log {
 	__u8   resv[2048];
 };
 
+enum nvme_ana_state {
+	NVME_ANA_OPTIMIZED		= 0x01,
+	NVME_ANA_NONOPTIMIZED		= 0x02,
+	NVME_ANA_INACCESSIBLE		= 0x03,
+	NVME_ANA_PERSISTENT_LOSS	= 0x04,
+	NVME_ANA_CHANGE			= 0x0f,
+};
+
+struct nvme_ana_group_desc {
+	__le32  grpid;
+	__le32  nnsids;
+	__le64  chgcnt;
+	__u8    state;
+	__u8    rsvd17[7];
+	__le32  nsids[];
+};
+
+/* flag for the log specific field of the ANA log */
+#define NVME_ANA_LOG_RGO   (1 << 0)
+
+struct nvme_ana_rsp_hdr {
+	__le64  chgcnt;
+	__le16  ngrps;
+	__le16  rsvd10[3];
+};
+
 enum {
 	NVME_SMART_CRIT_SPARE		= 1 << 0,
 	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
@@ -539,6 +573,7 @@ enum {
 	NVME_AER_CSS			= 6,
 	NVME_AER_VS			= 7,
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
+	NVME_AER_NOTICE_ANA		= 0x0003,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
 };
 
@@ -891,6 +926,7 @@ enum {
 	NVME_LOG_TELEMETRY_HOST = 0x07,
 	NVME_LOG_TELEMETRY_CTRL = 0x08,
 	NVME_LOG_ENDURANCE_GROUP = 0x09,
+	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_LOG_SANITIZE	= 0x81,
@@ -902,6 +938,7 @@ enum {
 enum {
 	NVME_NO_LOG_LSP       = 0x0,
 	NVME_NO_LOG_LPO       = 0x0,
+	NVME_LOG_ANA_LSP_RGO  = 0x1,
 	NVME_TELEM_LSP_CREATE = 0x1,
 };
 
@@ -1050,7 +1087,7 @@ struct nvme_get_log_page_command {
 	__u64			rsvd2[2];
 	union nvme_data_ptr	dptr;
 	__u8			lid;
-	__u8			rsvd10;
+	__u8			lsp;
 	__le16			numdl;
 	__le16			numdu;
 	__u16			rsvd11;
@@ -1366,6 +1403,13 @@ enum {
 	NVME_SC_ACCESS_DENIED		= 0x286,
 	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
 
+	/*
+	 * Path-related Errors:
+	 */
+	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
+	NVME_SC_ANA_INACCESSIBLE	= 0x302,
+	NVME_SC_ANA_TRANSITION		= 0x303,
+
 	NVME_SC_DNR			= 0x4000,
 };
 
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 2c26d57..f9e47b3 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -25,6 +25,7 @@ COMMAND_LIST(
 	ENTRY("fw-log", "Retrieve FW Log, show it", get_fw_log)
 	ENTRY("changed-ns-list-log", "Retrieve Changed Namespace List, show it", get_changed_ns_list_log)
 	ENTRY("smart-log", "Retrieve SMART Log, show it", get_smart_log)
+	ENTRY("ana-log", "Retrieve ANA Log, show it", get_ana_log)
 	ENTRY("error-log", "Retrieve Error Log, show it", get_error_log)
 	ENTRY("effects-log", "Retrieve Command Effects Log, show it", get_effects_log)
 	ENTRY("endurance-log", "Retrieve Endurance Group Log, show it", get_endurance_log)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 9cf2a33..d63c863 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -467,6 +467,14 @@ int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log)
 	return nvme_get_log(fd, nsid, NVME_LOG_SMART, sizeof(*smart_log), smart_log);
 }
 
+int nvme_ana_log(int fd, void *ana_log, size_t ana_log_len, int rgo)
+{
+	__u64 lpo = 0;
+
+	return nvme_get_log13(fd, NVME_NSID_ALL, NVME_LOG_ANA, rgo, lpo, 0,
+			true, ana_log_len, ana_log);
+}
+
 int nvme_self_test_log(int fd, struct nvme_self_test_log *self_test_log)
 {
 	return nvme_get_log(fd, NVME_NSID_ALL, NVME_LOG_DEVICE_SELF_TEST,
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index b34f5de..d3823a4 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -92,6 +92,7 @@ int nvme_changed_ns_list_log(int fd,
 		struct nvme_changed_ns_list_log *changed_ns_list_log);
 int nvme_error_log(int fd, int entries, struct nvme_error_log_page *err_log);
 int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log);
+int nvme_ana_log(int fd, void *ana_log, size_t ana_log_len, int rgo);
 int nvme_effects_log(int fd, struct nvme_effects_log_page *effects_log);
 int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size);
 int nvme_sanitize_log(int fd, struct nvme_sanitize_log_page *sanitize_log);
diff --git a/nvme-print.c b/nvme-print.c
index cb85066..6125662 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -8,6 +8,23 @@
 #include "nvme-models.h"
 #include "suffix.h"
 
+static const char *nvme_ana_state_to_string(enum nvme_ana_state state)
+{
+	switch (state) {
+	case NVME_ANA_OPTIMIZED:
+		return "optimized";
+	case NVME_ANA_NONOPTIMIZED:
+		return "non-optimized";
+	case NVME_ANA_INACCESSIBLE:
+		return "inaccessible";
+	case NVME_ANA_PERSISTENT_LOSS:
+		return "persistent-loss";
+	case NVME_ANA_CHANGE:
+		return "change";
+	}
+	return "invalid state";
+}
+
 static long double int128_to_double(__u8 *data)
 {
 	int i;
@@ -78,12 +95,14 @@ static void format(char *formatter, size_t fmt_sz, char *tofmt, size_t tofmtsz)
 
 static void show_nvme_id_ctrl_cmic(__u8 cmic)
 {
-	__u8 rsvd = (cmic & 0xF8) >> 3;
+	__u8 rsvd = (cmic & 0xF0) >> 4;
+	__u8 ana = (cmic & 0x8) >> 3;
 	__u8 sriov = (cmic & 0x4) >> 2;
 	__u8 mctl = (cmic & 0x2) >> 1;
 	__u8 mp = cmic & 0x1;
 	if (rsvd)
-		printf("  [7:3] : %#x\tReserved\n", rsvd);
+		printf("  [7:4] : %#x\tReserved\n", rsvd);
+	printf("  [3:3] : %#x\tANA %ssupported\n", ana, ana ? "" : "not ");
 	printf("  [2:2] : %#x\t%s\n", sriov, sriov ? "SR-IOV" : "PCI");
 	printf("  [1:1] : %#x\t%s Controller\n",
 		mctl, mctl ? "Multi" : "Single");
@@ -283,6 +302,36 @@ static void show_nvme_id_ctrl_sanicap(__le32 ctrl_sanicap)
 	printf("\n");
 }
 
+static void show_nvme_id_ctrl_anacap(__u8 anacap)
+{
+	__u8 nz = (anacap & 0x80) >> 7;
+	__u8 grpid_change = (anacap & 0x40) >> 6;
+	__u8 rsvd = (anacap & 0x20) >> 5;
+	__u8 ana_change = (anacap & 0x10) >> 4;
+	__u8 ana_persist_loss = (anacap & 0x08) >> 3;
+	__u8 ana_inaccessible = (anacap & 0x04) >> 2;
+	__u8 ana_nonopt = (anacap & 0x02) >> 1;
+	__u8 ana_opt = (anacap & 0x01);
+
+	printf("  [7:7] : %#x\tNon-zero group ID %sSupported\n",
+			nz, nz ? "" : "Not ");
+	printf("  [6:6] : %#x\tGroup ID does %schange\n",
+			grpid_change, grpid_change ? "" : "not ");
+	if (rsvd)
+		printf(" [5:5] : %#x\tReserved\n", rsvd);
+	printf("  [4:4] : %#x\tANA Change state %sSupported\n",
+			ana_change, ana_change ? "" : "Not ");
+	printf("  [3:3] : %#x\tANA Persistent Loss state %sSupported\n",
+			ana_persist_loss, ana_persist_loss ? "" : "Not ");
+	printf("  [2:2] : %#x\tANA Inaccessible state %sSupported\n",
+			ana_inaccessible, ana_inaccessible ? "" : "Not ");
+	printf("  [1:1] : %#x\tANA Non-optimized state %sSupported\n",
+			ana_nonopt, ana_nonopt ? "" : "Not ");
+	printf("  [0:0] : %#x\tANA Optimized state %sSupported\n",
+			ana_opt, ana_opt ? "" : "Not ");
+	printf("\n");
+}
+
 static void show_nvme_id_ctrl_sqes(__u8 sqes)
 {
 	__u8 msqes = (sqes & 0xF0) >> 4;
@@ -665,6 +714,7 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	printf("nvmcap  : %.0Lf\n", int128_to_double(ns->nvmcap));
 	printf("nsattr	: %u\n", ns->nsattr);
 	printf("nvmsetid: %d\n", le16_to_cpu(ns->nvmsetid));
+	printf("anagrpid: %d\n", le32_to_cpu(ns->anagrpid));
 	printf("endgid  : %d\n", le16_to_cpu(ns->endgid));
 
 	printf("nguid   : ");
@@ -972,6 +1022,12 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("hmminds   : %d\n", le32_to_cpu(ctrl->hmminds));
 	printf("hmmaxd    : %d\n", le16_to_cpu(ctrl->hmmaxd));
 	printf("nsetidmax : %d\n", le16_to_cpu(ctrl->nsetidmax));
+	printf("anatt     : %d\n", ctrl->anatt);
+	printf("anacap    : %d\n", ctrl->anacap);
+	if (human)
+		show_nvme_id_ctrl_anacap(ctrl->anacap);
+	printf("anagrpmax : %d\n", ctrl->anagrpmax);
+	printf("nanagrpid : %d\n", le32_to_cpu(ctrl->nanagrpid));
 	printf("sqes      : %#x\n", ctrl->sqes);
 	if (human)
 		show_nvme_id_ctrl_sqes(ctrl->sqes);
@@ -1004,6 +1060,7 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("sgls      : %x\n", le32_to_cpu(ctrl->sgls));
 	if (human)
 		show_nvme_id_ctrl_sgls(ctrl->sgls);
+	printf("mnan      : %d\n", le32_to_cpu(ctrl->mnan));
 	printf("subnqn    : %-.*s\n", (int)sizeof(ctrl->subnqn), ctrl->subnqn);
 	printf("ioccsz    : %d\n", le32_to_cpu(ctrl->ioccsz));
 	printf("iorcsz    : %d\n", le32_to_cpu(ctrl->iorcsz));
@@ -1376,6 +1433,44 @@ void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	printf("Thermal Management T2 Total Time    : %u\n", le32_to_cpu(smart->thm_temp2_total_time));
 }
 
+void show_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname)
+{
+	int offset = sizeof(struct nvme_ana_rsp_hdr);
+	struct nvme_ana_rsp_hdr *hdr = ana_log;
+	struct nvme_ana_group_desc *desc;
+	size_t nsid_buf_size;
+	void *base = ana_log;
+	__u32 nr_nsids;
+	int i;
+	int j;
+
+	printf("Asynchronous Namespace Access Log for NVMe device: %s\n",
+			devname);
+	printf("ANA LOG HEADER :-\n");
+	printf("chgcnt	:	%"PRIu64"\n",
+			(uint64_t)le64_to_cpu(hdr->chgcnt));
+	printf("ngrps	:	%u\n", le16_to_cpu(hdr->ngrps));
+	printf("ANA Log Desc :-\n");
+
+	for (i = 0; i < le16_to_cpu(ana_log->ngrps); i++) {
+		desc = base + offset;
+		nr_nsids = le32_to_cpu(desc->nnsids);
+		nsid_buf_size = nr_nsids * sizeof(__le32);
+
+		offset += sizeof(*desc);
+		printf("grpid	:	%u\n", le32_to_cpu(desc->grpid));
+		printf("nnsids	:	%u\n", le32_to_cpu(desc->nnsids));
+		printf("chgcnt	:	%llu\n", le64_to_cpu(desc->chgcnt));
+		printf("state	:	%s\n",
+				nvme_ana_state_to_string(desc->state));
+		for (j = 0; j < le32_to_cpu(desc->nnsids); j++)
+			printf("	nsid	:	%u\n",
+					le32_to_cpu(desc->nsids[j]));
+		printf("\n");
+		offset += nsid_buf_size;
+	}
+}
+
 void show_self_test_log(struct nvme_self_test_log *self_test, const char *devname)
 {
 	int i, temp;
@@ -1603,7 +1698,7 @@ char *nvme_status_to_string(__u32 status)
 	case NVME_SC_LBA_RANGE:			return "LBA_RANGE: The command references a LBA that exceeds the size of the namespace";
 	case NVME_SC_NS_WRITE_PROTECTED:	return "NS_WRITE_PROTECTED: The command is prohibited while the namespace is write protected by the host.";
 	case NVME_SC_CAP_EXCEEDED:		return "CAP_EXCEEDED: The execution of the command has caused the capacity of the namespace to be exceeded";
-	case NVME_SC_NS_NOT_READY:		return "NS_NOT_READY: The namespace is not ready to be accessed";
+	case NVME_SC_NS_NOT_READY:		return "NS_NOT_READY: The namespace is not ready to be accessed as a result of a condition other than a condition that is reported as an Asymmetric Namespace Access condition";
 	case NVME_SC_RESERVATION_CONFLICT:	return "RESERVATION_CONFLICT: The command was aborted due to a conflict with a reservation held on the accessed namespace";
 	case NVME_SC_CQ_INVALID:		return "CQ_INVALID: The Completion Queue identifier specified in the command does not exist";
 	case NVME_SC_QID_INVALID:		return "QID_INVALID: The creation of the I/O Completion Queue failed due to an invalid queue identifier specified as part of the command. An invalid queue identifier is one that is currently in use or one that is outside the range supported by the controller";
@@ -1643,6 +1738,9 @@ char *nvme_status_to_string(__u32 status)
 	case NVME_SC_COMPARE_FAILED:		return "COMPARE_FAILED: The command failed due to a miscompare during a Compare command";
 	case NVME_SC_ACCESS_DENIED:		return "ACCESS_DENIED: Access to the namespace and/or LBA range is denied due to lack of access rights";
 	case NVME_SC_UNWRITTEN_BLOCK:		return "UNWRITTEN_BLOCK: The command failed due to an attempt to read from an LBA range containing a deallocated or unwritten logical block";
+	case NVME_SC_ANA_PERSISTENT_LOSS:	return "ASYMMETRIC_NAMESPACE_ACCESS_PERSISTENT_LOSS: The requested function (e.g., command) is not able to be performed as a result of the relationship between the controller and the namespace being in the ANA Persistent Loss state";
+	case NVME_SC_ANA_INACCESSIBLE:		return "ASYMMETRIC_NAMESPACE_ACCESS_INACCESSIBLE: The requested function (e.g., command) is not able to be performed as a result of the relationship between the controller and the namespace being in the ANA Inaccessible state";
+	case NVME_SC_ANA_TRANSITION:		return "ASYMMETRIC_NAMESPACE_ACCESS_TRANSITION: The requested function (e.g., command) is not able to be performed as a result of the relationship between the controller and the namespace transitioning between Asymmetric Namespace Access states";
 	default:				return "Unknown";
 	}
 }
@@ -2087,6 +2185,8 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	json_object_add_value_float(root, "nvmcap", nvmcap);
 	json_object_add_value_int(root, "nsattr", ns->nsattr);
 	json_object_add_value_int(root, "nvmsetid", le16_to_cpu(ns->nvmsetid));
+
+	json_object_add_value_int(root, "anagrpid", le32_to_cpu(ns->anagrpid));
 	json_object_add_value_int(root, "endgid", le16_to_cpu(ns->endgid));
 
 	memset(eui64, 0, sizeof(eui64_buf));
@@ -2183,6 +2283,11 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_int(root, "hmminds", le32_to_cpu(ctrl->hmminds));
 	json_object_add_value_int(root, "hmmaxd", le16_to_cpu(ctrl->hmmaxd));
 	json_object_add_value_int(root, "nsetidmax", le16_to_cpu(ctrl->nsetidmax));
+
+	json_object_add_value_int(root, "anatt",ctrl->anatt);
+	json_object_add_value_int(root, "anacap", ctrl->anacap);
+	json_object_add_value_int(root, "anagrpmax", le32_to_cpu(ctrl->anagrpmax));
+	json_object_add_value_int(root, "nanagrpid", le32_to_cpu(ctrl->nanagrpid));
 	json_object_add_value_int(root, "sqes", ctrl->sqes);
 	json_object_add_value_int(root, "cqes", ctrl->cqes);
 	json_object_add_value_int(root, "maxcmd", le16_to_cpu(ctrl->maxcmd));
@@ -2490,6 +2595,65 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	json_free_object(root);
 }
 
+void json_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname)
+{
+	int offset = sizeof(struct nvme_ana_rsp_hdr);
+	struct nvme_ana_rsp_hdr *hdr = ana_log;
+	struct nvme_ana_group_desc *ana_desc;
+	struct json_array *desc_list;
+	struct json_array *ns_list;
+	struct json_object *desc;
+	struct json_object *nsid;
+	struct json_object *root;
+	size_t nsid_buf_size;
+	void *base = ana_log;
+	__u32 nr_nsids;
+	int i;
+	int j;
+
+	root = json_create_object();
+	json_object_add_value_string(root,
+			"Asynchronous Namespace Access Log for NVMe device:",
+			devname);
+	json_object_add_value_uint(root, "chgcnt",
+			(uint64_t)le64_to_cpu(hdr->chgcnt));
+	json_object_add_value_uint(root, "ngrps", le16_to_cpu(hdr->ngrps));
+
+	desc_list = json_create_array();
+	for (i = 0; i < le16_to_cpu(ana_log->ngrps); i++) {
+		desc = json_create_object();
+		ana_desc = base + offset;
+		nr_nsids = le32_to_cpu(ana_desc->nnsids);
+		nsid_buf_size = nr_nsids * sizeof(__le32);
+
+		offset += sizeof(*ana_desc);
+		json_object_add_value_uint(desc, "grpid",
+				le32_to_cpu(ana_desc->grpid));
+		json_object_add_value_uint(desc, "nnsids",
+				le32_to_cpu(ana_desc->nnsids));
+		json_object_add_value_uint(desc, "chgcnt",
+				le64_to_cpu(ana_desc->chgcnt));
+		json_object_add_value_string(desc, "state",
+				nvme_ana_state_to_string(ana_desc->state));
+
+		ns_list = json_create_array();
+		for (j = 0; j < le32_to_cpu(ana_desc->nnsids); j++) {
+			nsid = json_create_object();
+			json_object_add_value_uint(nsid, "nsid",
+					le32_to_cpu(ana_desc->nsids[j]));
+			json_array_add_value_object(ns_list, nsid);
+		}
+		json_object_add_value_array(desc, "NSIDS", ns_list);
+		offset += nsid_buf_size;
+		json_array_add_value_object(desc_list, desc);
+	}
+
+	json_object_add_value_array(root, "ANA DESC LIST ", desc_list);
+	json_print_object(root, NULL);
+	printf("\n");
+	json_free_object(root);
+}
+
 void json_self_test_log(struct nvme_self_test_log *self_test, const char *devname)
 {
 	struct json_object *root;
diff --git a/nvme-print.h b/nvme-print.h
index da287c2..367347c 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -24,6 +24,7 @@ void show_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __
 void show_lba_range(struct nvme_lba_range_type *lbrt, int nr_ranges);
 void show_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
 void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
+void show_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname);
 void show_self_test_log(struct nvme_self_test_log *self_test, const char *devname);
 void show_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void show_effects_log(struct nvme_effects_log_page *effects, unsigned int flags);
@@ -50,6 +51,7 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int flags);
 void json_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __u32 cdw11);
 void json_error_log(struct nvme_error_log_page *err_log, int entries, const char *devname);
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
+void json_ana_log(struct nvme_ana_rsp_hdr *ana_log, const char *devname);
 void json_effects_log(struct nvme_effects_log_page *effects_log, const char *devname);
 void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *devname);
 void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
diff --git a/nvme.c b/nvme.c
index 90aa2da..99640cb 100644
--- a/nvme.c
+++ b/nvme.c
@@ -228,6 +228,78 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 	return err;
 }
 
+static int get_ana_log(int argc, char **argv, struct command *cmd,
+		struct plugin *plugin)
+{
+	const char *desc = "Retrieve ANA log for the given device" \
+			    "in either decoded format "\
+			    "(default) or binary.";
+	void *ana_log;
+	int err, fmt, fd;
+	int groups = 0; /* Right now get all the per ANA group NSIDS */
+	size_t ana_log_len;
+	struct nvme_id_ctrl ctrl;
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
+		{"output-format", 'o', "FMT", CFG_STRING,   &cfg.output_format, required_argument, output_format },
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	fmt = validate_output_format(cfg.output_format);
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
+
+	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
+	err = nvme_identify_ctrl(fd, &ctrl);
+	if (err) {
+		fprintf(stderr, "ERROR : nvme_identify_ctrl() failed 0x%x\n",
+				err);
+		goto close_fd;
+	}
+	ana_log_len = sizeof(struct nvme_ana_rsp_hdr) +
+		le32_to_cpu(ctrl.nanagrpid) * sizeof(struct nvme_ana_group_desc);
+	if (!(ctrl.anacap & (1 << 6)))
+		ana_log_len += ctrl.mnan * sizeof(__le32);
+
+	ana_log = malloc(ana_log_len);
+	if (!ana_log) {
+		perror("malloc : ");
+		err = -ENOMEM;
+		goto close_fd;
+	}
+
+	err = nvme_ana_log(fd, ana_log, ana_log_len, groups ? NVME_ANA_LOG_RGO : 0);
+	if (!err) {
+		if (fmt == BINARY)
+			d_raw((unsigned char *)ana_log, ana_log_len);
+		else if (fmt == JSON)
+			json_ana_log(ana_log, devicename);
+		else
+			show_ana_log(ana_log, devicename);
+	} else if (err > 0)
+		fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(err), err);
+	else
+		perror("ana-log");
+	free(ana_log);
+close_fd:
+	close(fd);
+	return err;
+}
+
 static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Retrieve telemetry log and write to binary file";
-- 
2.17.0
