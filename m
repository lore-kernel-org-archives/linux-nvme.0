From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu,  2 Aug 2018 19:43:43 -0700
Subject: [PATCH] nvme-cli add ns write protect support
Message-ID: <20180803024343.4088-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 linux/nvme.h | 16 ++++++++++++++--
 nvme-print.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index dc8ea89..b276798 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -253,7 +253,7 @@ struct nvme_id_ctrl {
 	__le16			awun;
 	__le16			awupf;
 	__u8			nvscc;
-	__u8			rsvd531;
+	__u8			nwpc;
 	__le16			acwu;
 	__u8			rsvd534[2];
 	__le32			sgls;
@@ -317,7 +317,8 @@ struct nvme_id_ns {
 	__le16			nabspf;
 	__le16			noiob;
 	__u8			nvmcap[16];
-	__u8			rsvd64[36];
+	__u8			rsvd64[35];
+	__u8			nsattr;
 	__le16			nvmsetid;
 	__le16			endgid;
 	__u8			nguid[16];
@@ -495,6 +496,14 @@ struct nvme_fw_slot_info_log {
 	__u8			rsvd64[448];
 };
 
+/* NVMe Namespace Write Protect State */
+enum {
+	NVME_NS_NO_WRITE_PROTECT = 0,
+	NVME_NS_WRITE_PROTECT,
+	NVME_NS_WRITE_PROTECT_POWER_CYCLE,
+	NVME_NS_WRITE_PROTECT_PERMANENT,
+};
+
 #define NVME_MAX_CHANGED_NAMESPACES     1024
 
 struct nvme_changed_ns_list_log {
@@ -872,6 +881,7 @@ enum {
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
 	NVME_FEAT_RESV_PERSIST	= 0x83,
+	NVME_FEAT_WRITE_PROTECT	= 0x84,
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
@@ -1284,6 +1294,8 @@ enum {
 	NVME_SC_SANITIZE_FAILED		= 0x1C,
 	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
 
+	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
+
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
diff --git a/nvme-print.c b/nvme-print.c
index daf2929..63f0d48 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -384,6 +384,25 @@ static void show_nvme_id_ctrl_nvscc(__u8 nvscc)
 	printf("\n");
 }
 
+static void show_nvme_id_ctrl_nwpc(__u8 nwpc)
+{
+	__u8 no_wp_wp = (nwpc & 0x01);
+	__u8 wp_power_cycle = (nwpc & 0x02) >> 1;
+	__u8 wp_permanent = (nwpc & 0x04) >> 2;
+	__u8 rsvd = (nwpc & 0xF8) >> 3;
+
+	if (rsvd)
+		printf("  [7:3] : %#x\tReserved\n", rsvd);
+
+	printf("  [2:2] : %#x\tPermanent Write Protect %sSupported\n",
+		wp_permanent, wp_permanent ? "" : "Not ");
+	printf("  [1:1] : %#x\tWrite Protect Until Power Supply %sSupported\n",
+		wp_power_cycle, wp_power_cycle ? "" : "Not ");
+	printf("  [0:0] : %#x\tNo Write Protect and Write Protect Namespace %sSupported\n",
+		no_wp_wp, no_wp_wp ? "" : "Not ");
+	printf("\n");
+}
+
 static void show_nvme_id_ctrl_sgls(__le32 ctrl_sgls)
 {
 	__u32 sgls = le32_to_cpu(ctrl_sgls);
@@ -644,6 +663,7 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	printf("nabspf  : %d\n", le16_to_cpu(ns->nabspf));
 	printf("noiob   : %d\n", le16_to_cpu(ns->noiob));
 	printf("nvmcap  : %.0Lf\n", int128_to_double(ns->nvmcap));
+	printf("nsattr	: %u\n", ns->nsattr);
 	printf("nvmsetid: %d\n", le16_to_cpu(ns->nvmsetid));
 	printf("endgid  : %d\n", le16_to_cpu(ns->endgid));
 
@@ -949,6 +969,9 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("nvscc     : %d\n", ctrl->nvscc);
 	if (human)
 		show_nvme_id_ctrl_nvscc(ctrl->nvscc);
+	printf("nwpc      : %d\n", ctrl->nwpc);
+	if (human)
+		show_nvme_id_ctrl_nwpc(ctrl->nwpc);
 	printf("acwu      : %d\n", le16_to_cpu(ctrl->acwu));
 	printf("sgls      : %x\n", le32_to_cpu(ctrl->sgls));
 	if (human)
@@ -1494,6 +1517,7 @@ char *nvme_feature_to_string(int feature)
 	case NVME_FEAT_RESV_MASK:	return "Reservation Notification Mask";
 	case NVME_FEAT_RESV_PERSIST:	return "Reservation Persistence";
 	case NVME_FEAT_TIMESTAMP:	return "Timestamp";
+	case NVME_FEAT_WRITE_PROTECT:	return "Namespce Write Protect";
 	case NVME_FEAT_HCTM:		return "Host Controlled Thermal Management";
 	default:			return "Unknown";
 	}
@@ -1549,6 +1573,7 @@ char *nvme_status_to_string(__u32 status)
 	case NVME_SC_SANITIZE_FAILED:		return "SANITIZE_FAILED: The most recent sanitize operation failed and no recovery actions has been successfully completed";
 	case NVME_SC_SANITIZE_IN_PROGRESS:	return "SANITIZE_IN_PROGRESS: The requested function is prohibited while a sanitize operation is in progress";
 	case NVME_SC_LBA_RANGE:			return "LBA_RANGE: The command references a LBA that exceeds the size of the namespace";
+	case NVME_SC_NS_WRITE_PROTECTED:	return "Namespace Write Protected";
 	case NVME_SC_CAP_EXCEEDED:		return "CAP_EXCEEDED: The execution of the command has caused the capacity of the namespace to be exceeded";
 	case NVME_SC_NS_NOT_READY:		return "NS_NOT_READY: The namespace is not ready to be accessed";
 	case NVME_SC_RESERVATION_CONFLICT:	return "RESERVATION_CONFLICT: The command was aborted due to a conflict with a reservation held on the accessed namespace";
@@ -1863,6 +1888,9 @@ void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf
 	case NVME_FEAT_RESV_PERSIST:
 		printf("\tPersist Through Power Loss (PTPL): %s\n", (result & 0x00000001) ? "True":"False");
 		break;
+	case NVME_FEAT_WRITE_PROTECT:
+		printf("\tNamespace Write Protect: %s\n", result != NVME_NS_NO_WRITE_PROTECT ? "True" :  "False");
+		break;
 	case NVME_FEAT_TIMESTAMP:
 		show_timestamp((struct nvme_timestamp *)buf);
 		break;
@@ -2029,6 +2057,7 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	json_object_add_value_int(root, "nabspf", le16_to_cpu(ns->nabspf));
 	json_object_add_value_int(root, "noiob", le16_to_cpu(ns->noiob));
 	json_object_add_value_float(root, "nvmcap", nvmcap);
+	json_object_add_value_int(root, "nsattr", ns->nsattr);
 	json_object_add_value_int(root, "nvmsetid", le16_to_cpu(ns->nvmsetid));
 	json_object_add_value_int(root, "endgid", le16_to_cpu(ns->endgid));
 
@@ -2137,6 +2166,7 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_int(root, "awun", le16_to_cpu(ctrl->awun));
 	json_object_add_value_int(root, "awupf", le16_to_cpu(ctrl->awupf));
 	json_object_add_value_int(root, "nvscc", ctrl->nvscc);
+	json_object_add_value_int(root, "nwpc", ctrl->nwpc);
 	json_object_add_value_int(root, "acwu", le16_to_cpu(ctrl->acwu));
 	json_object_add_value_int(root, "sgls", le32_to_cpu(ctrl->sgls));
 
-- 
2.17.0
