From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Wed, 7 Jun 2017 21:24:26 +0000
Subject: [PATCH] nvme-cli: id-ctrl: display additional fields
Message-ID: <BN6PR06MB248106C59FDC918C6F32F16F8CC80@BN6PR06MB2481.namprd06.prod.outlook.com>


Additional fields displayed: ctratt, maxcmd, ioccsz, iorcsz, icdoff,
ctrattr, msdbd
Additional human-readable decode for lpa and sgls fields.
---
 nvme-print.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 184dd73..4234bdb 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -106,6 +106,19 @@ static void show_nvme_id_ctrl_oaes(__le32 ctrl_oaes)
 	printf("\n");
 }
 
+static void show_nvme_id_ctrl_ctratt(__le32 ctrl_ctratt)
+{
+	__u32 ctratt = le32_to_cpu(ctrl_ctratt);
+	__u32 rsvd0 = (ctratt & 0xFFFFFFFE) >> 1;
+	__u32 hostid128 = ctratt & 0x1;
+
+	if (rsvd0)
+		printf(" [31:1] : %#x\tReserved\n", rsvd0);
+	printf("  [0:0] : %#x\t128-bit Host Identifier %sSupported\n",
+		hostid128, hostid128 ? "" : "Not ");
+	printf("\n");
+}
+
 static void show_nvme_id_ctrl_oacs(__le16 ctrl_oacs)
 {
 	__u16 oacs = le16_to_cpu(ctrl_oacs);
@@ -146,11 +159,14 @@ static void show_nvme_id_ctrl_frmw(__u8 frmw)
 
 static void show_nvme_id_ctrl_lpa(__u8 lpa)
 {
-	__u8 rsvd = (lpa & 0xFC) >> 2;
+	__u8 rsvd = (lpa & 0xF8) >> 3;
+	__u8 ed = (lpa & 0x4) >> 2;
 	__u8 celp = (lpa & 0x2) >> 1;
 	__u8 smlp = lpa & 0x1;
 	if (rsvd)
-		printf("  [7:2] : %#x\tReserved\n", rsvd);
+		printf("  [7:3] : %#x\tReserved\n", rsvd);
+	printf("  [2:2] : %#x\tExtended data for Get Log Page %sSupported\n",
+		ed, ed ? "" : "Not ");
 	printf("  [1:1] : %#x\tCommand Effects Log Page %sSupported\n",
 		celp, celp ? "" : "Not ");
 	printf("  [0:0] : %#x\tSMART/Health Log Page per NS %sSupported\n",
@@ -303,7 +319,9 @@ static void show_nvme_id_ctrl_sgls(__le32 ctrl_sgls)
 	__u32 sglltb = (sgls & 0x40000) >> 18;
 	__u32 bacmdb = (sgls & 0x20000) >> 17;
 	__u32 bbs = (sgls & 0x10000) >> 16;
-	__u32 rsvd1 = (sgls & 0xFFFE) >> 1;
+	__u32 rsvd1 = (sgls & 0xFFF8) >> 3;
+	__u32 key = (sgls & 0x4) >> 2;
+	__u32 rsvd2 = (sgls & 0x2) >> 1;
 	__u32 sglsp = sgls & 0x1;
 
 	if (rsvd0)
@@ -318,12 +336,28 @@ static void show_nvme_id_ctrl_sgls(__le32 ctrl_sgls)
 		printf(" [16:16]: %#x\tSGL Bit-Bucket %sSupported\n",
 			bbs, bbs ? "" : "Not ");
 	if (rsvd1)
-		printf(" [15:1] : %#x\tReserved\n", rsvd1);
+		printf(" [15:3] : %#x\tReserved\n", rsvd1);
+	if (sglsp || (!sglsp && key))
+		printf(" [16:16]: %#x\tKeyed SGL Data Block descriptor %sSupported\n",
+			key, key ? "" : "Not ");
+	if (rsvd2)
+		printf(" [1:1] : %#x\tReserved\n", rsvd2);
 	printf("  [0:0] : %#x\tScatter-Gather Lists %sSupported\n",
 		sglsp, sglsp ? "" : "Not ");
 	printf("\n");
 }
 
+static void show_nvme_id_ctrl_ctrattr(__u8 ctrattr)
+{
+	__u8 rsvd = (ctrattr & 0xFE) >> 1;
+	__u8 scm = ctrattr & 0x1;
+	if (rsvd)
+		printf("  [7:1] : %#x\tReserved\n", rsvd);
+	printf("  [0:0] : %#x\t%s Controller Model\n",
+		scm, scm ? "Static" : "Dynamic");
+	printf("\n");
+}
+
 static void show_nvme_id_ns_nsfeat(__u8 nsfeat)
 {
 	__u8 rsvd = (nsfeat & 0xF8) >> 3;
@@ -614,6 +648,9 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("oaes    : %#x\n", le32_to_cpu(ctrl->oaes));
 	if (human)
 		show_nvme_id_ctrl_oaes(ctrl->oaes);
+	printf("ctratt  : %#x\n", le32_to_cpu(ctrl->ctratt));
+	if (human)
+		show_nvme_id_ctrl_ctratt(ctrl->ctratt);
 	printf("oacs    : %#x\n", le16_to_cpu(ctrl->oacs));
 	if (human)
 		show_nvme_id_ctrl_oacs(ctrl->oacs);
@@ -649,6 +686,7 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("cqes    : %#x\n", ctrl->cqes);
 	if (human)
 		show_nvme_id_ctrl_cqes(ctrl->cqes);
+	printf("maxcmd  : %d\n", le16_to_cpu(ctrl->maxcmd));
 	printf("nn      : %d\n", le32_to_cpu(ctrl->nn));
 	printf("oncs    : %#x\n", le16_to_cpu(ctrl->oncs));
 	if (human)
@@ -671,8 +709,14 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("sgls    : %x\n", le32_to_cpu(ctrl->sgls));
 	if (human)
 		show_nvme_id_ctrl_sgls(ctrl->sgls);
-
 	printf("subnqn  : %-.*s\n", (int)sizeof(ctrl->subnqn), ctrl->subnqn);
+	printf("ioccsz  : %d\n", le32_to_cpu(ctrl->ioccsz));
+	printf("iorcsz  : %d\n", le32_to_cpu(ctrl->iorcsz));
+	printf("icdoff  : %d\n", le16_to_cpu(ctrl->icdoff));
+	printf("ctrattr : %x\n", ctrl->ctrattr);
+	if (human)
+		show_nvme_id_ctrl_ctrattr(ctrl->ctrattr);
+	printf("msdbd   : %d\n", ctrl->msdbd);
 
 	show_nvme_id_ctrl_power(ctrl);
 	if (vendor_show)
@@ -1252,6 +1296,7 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_int(root, "rtd3r", le32_to_cpu(ctrl->rtd3r));
 	json_object_add_value_int(root, "rtd3e", le32_to_cpu(ctrl->rtd3e));
 	json_object_add_value_int(root, "oaes", le32_to_cpu(ctrl->oaes));
+	json_object_add_value_int(root, "ctratt", le32_to_cpu(ctrl->ctratt));
 	json_object_add_value_int(root, "oacs", le16_to_cpu(ctrl->oacs));
 	json_object_add_value_int(root, "acl", ctrl->acl);
 	json_object_add_value_int(root, "aerl", ctrl->aerl);
@@ -1271,6 +1316,7 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_int(root, "rpmbs", le32_to_cpu(ctrl->rpmbs));
 	json_object_add_value_int(root, "sqes", ctrl->sqes);
 	json_object_add_value_int(root, "cqes", ctrl->cqes);
+	json_object_add_value_int(root, "maxcmd", le16_to_cpu(ctrl->maxcmd));
 	json_object_add_value_int(root, "nn", le32_to_cpu(ctrl->nn));
 	json_object_add_value_int(root, "oncs", le16_to_cpu(ctrl->oncs));
 	json_object_add_value_int(root, "fuses", le16_to_cpu(ctrl->fuses));
@@ -1285,6 +1331,12 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	if (strlen(subnqn))
 		json_object_add_value_string(root, "subnqn", subnqn);
 
+	json_object_add_value_int(root, "ioccsz", le32_to_cpu(ctrl->ioccsz));
+	json_object_add_value_int(root, "iorcsz", le32_to_cpu(ctrl->iorcsz));
+	json_object_add_value_int(root, "icdoff", le16_to_cpu(ctrl->icdoff));
+	json_object_add_value_int(root, "ctrattr", ctrl->ctrattr);
+	json_object_add_value_int(root, "msdbd", ctrl->msdbd);
+
 	psds = json_create_array();
 	json_object_add_value_array(root, "psds", psds);
 
-- 
2.12.2
