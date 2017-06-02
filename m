From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Fri, 2 Jun 2017 15:18:19 +0800
Subject: [PATCH 2/2] nvme-cli: show more fields for id-ctrl
In-Reply-To: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
References: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1496387899-26012-3-git-send-email-guanjunxiong@huawei.com>

NVMe 1.3 inctrodues new fields such as EDSTT, DSTO, FWUG, HCTMA, MNTMT,
MXTMT, SANICAP into the idenfity controller data structure. The id-ctrl
command should print them or write them into json format. Note that
although KAS field is included in the previous NVMe 1.2.1 spec, this
patch also supports this field.
---
 nvme-print.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 60fe119..ffa63ad 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -198,6 +198,38 @@ static void show_nvme_id_ctrl_rpmbs(__le32 ctrl_rpmbs)
 	printf("\n");
 }
 
+static void show_nvme_id_ctrl_hctma(__le16 ctrl_hctma)
+{
+	__u16 hctma = le16_to_cpu(ctrl_hctma);
+	__u16 rsvd = (hctma & 0xFFFE) >> 1;
+	__u16 hctm = hctma & 0x1;
+
+	if (rsvd)
+		printf(" [15:1] : %#x\tReserved\n", rsvd);
+	printf("  [0:0] : %#x\tHost Controlled Thermal Management %sSupported\n",
+		hctm, hctm ? "" : "Not ");
+	printf("\n");
+}
+
+static void show_nvme_id_ctrl_sanicap(__le32 ctrl_sanicap)
+{
+	__u32 sanicap = le32_to_cpu(ctrl_sanicap);
+	__u32 rsvd = (sanicap & 0xFFFFFFF8) >> 3;
+	__u32 owr = (sanicap & 0x4) >> 2;
+	__u32 ber = (sanicap & 0x2) >> 1;
+	__u32 cer = sanicap & 0x1;
+
+	if (rsvd)
+		printf(" [31:3] : %#x\tReserved\n", rsvd);
+	printf("  [2:2] : %#x\tOverwrite Sanitize Operation %sSupported\n",
+		owr, owr ? "" : "Not ");
+	printf("  [1:1] : %#x\tBlock Erase Sanitize Operation %sSupported\n",
+		ber, ber ? "" : "Not ");
+	printf("  [0:0] : %#x\tCrypto Erase Sanitize Operation %sSupported\n",
+		cer, cer ? "" : "Not ");
+	printf("\n");
+}
+
 static void show_nvme_id_ctrl_sqes(__u8 sqes)
 {
 	__u8 msqes = (sqes & 0xF0) >> 4;
@@ -643,6 +675,18 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("rpmbs   : %#x\n", le32_to_cpu(ctrl->rpmbs));
 	if (human)
 		show_nvme_id_ctrl_rpmbs(ctrl->rpmbs);
+	printf("edstt   : %d\n", le16_to_cpu(ctrl->edstt));
+	printf("dsto    : %d\n", ctrl->dsto);
+	printf("fwug    : %d\n", ctrl->fwug);
+	printf("kas     : %d\n", le16_to_cpu(ctrl->kas));
+	printf("hctma   : %#x\n", le16_to_cpu(ctrl->hctma));
+	if (human)
+		show_nvme_id_ctrl_hctma(ctrl->hctma);
+	printf("mntmt   : %d\n", le16_to_cpu(ctrl->mntmt));
+	printf("mxtmt   : %d\n", le16_to_cpu(ctrl->mxtmt));
+	printf("sanicap : %#x\n", le32_to_cpu(ctrl->sanicap));
+	if (human)
+		show_nvme_id_ctrl_sanicap(ctrl->sanicap);
 	printf("sqes    : %#x\n", ctrl->sqes);
 	if (human)
 		show_nvme_id_ctrl_sqes(ctrl->sqes);
@@ -1269,6 +1313,14 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_float(root, "tnvmcap", tnvmcap);
 	json_object_add_value_float(root, "unvmcap", unvmcap);
 	json_object_add_value_int(root, "rpmbs", le32_to_cpu(ctrl->rpmbs));
+	json_object_add_value_int(root, "edstt", le16_to_cpu(ctrl->edstt));
+	json_object_add_value_int(root, "dsto", ctrl->dsto);
+	json_object_add_value_int(root, "fwug", ctrl->fwug);
+	json_object_add_value_int(root, "kas", le16_to_cpu(ctrl->kas));
+	json_object_add_value_int(root, "hctma", le16_to_cpu(ctrl->hctma));
+	json_object_add_value_int(root, "mntmt", le16_to_cpu(ctrl->mntmt));
+	json_object_add_value_int(root, "mxtmt", le16_to_cpu(ctrl->mxtmt));
+	json_object_add_value_int(root, "sanicap", le32_to_cpu(ctrl->sanicap));
 	json_object_add_value_int(root, "sqes", ctrl->sqes);
 	json_object_add_value_int(root, "cqes", ctrl->cqes);
 	json_object_add_value_int(root, "nn", le32_to_cpu(ctrl->nn));
-- 
2.11.1
