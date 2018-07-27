From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Jul 2018 12:26:29 +0200
Subject: [PATCH 3/6] nvme-cli: Add ANA support
In-Reply-To: <20180727102632.32455-1-hare@suse.de>
References: <20180727102632.32455-1-hare@suse.de>
Message-ID: <20180727102632.32455-4-hare@suse.de>

Decode additional fields specified in the ANA TP.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 linux/nvme.h | 14 +++++++++++---
 nvme-print.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index dc8ea89..55a197b 100644
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
-	__u8			rsvd64[36];
+	__u8			rsvd64[28];
+	__le32			anagrpid;
+	__u8			rsvd96[4];
 	__le16			nvmsetid;
 	__le16			endgid;
 	__u8			nguid[16];
diff --git a/nvme-print.c b/nvme-print.c
index daf2929..692c903 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -78,12 +78,14 @@ static void format(char *formatter, size_t fmt_sz, char *tofmt, size_t tofmtsz)
 
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
@@ -283,6 +285,36 @@ static void show_nvme_id_ctrl_sanicap(__le32 ctrl_sanicap)
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
+	       nz, nz ? "" : "Not ");
+	printf("  [6:6] : %#x\tGroup ID does %schange\n",
+	       grpid_change, grpid_change ? "" : "not ");
+	if (rsvd)
+		printf(" [5:5] : %#x\tReserved\n", rsvd);
+	printf("  [4:4] : %#x\tANA Change state %sSupported\n",
+		ana_change, ana_change ? "" : "Not ");
+	printf("  [3:3] : %#x\tANA Persistent Loss state %sSupported\n",
+		ana_persist_loss, ana_persist_loss ? "" : "Not ");
+	printf("  [2:2] : %#x\tANA Inaccessible state %sSupported\n",
+		ana_inaccessible, ana_inaccessible ? "" : "Not ");
+	printf("  [1:1] : %#x\tANA Non-optimized state %sSupported\n",
+		ana_nonopt, ana_nonopt ? "" : "Not ");
+	printf("  [0:0] : %#x\tANA Optimized state %sSupported\n",
+		ana_opt, ana_opt ? "" : "Not ");
+	printf("\n");
+}
+
 static void show_nvme_id_ctrl_sqes(__u8 sqes)
 {
 	__u8 msqes = (sqes & 0xF0) >> 4;
@@ -646,6 +678,7 @@ void show_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	printf("nvmcap  : %.0Lf\n", int128_to_double(ns->nvmcap));
 	printf("nvmsetid: %d\n", le16_to_cpu(ns->nvmsetid));
 	printf("endgid  : %d\n", le16_to_cpu(ns->endgid));
+	printf("anagrpid: %#x\n", le32_to_cpu(ns->anagrpid));
 
 	printf("nguid   : ");
 	for (i = 0; i < 16; i++)
@@ -924,6 +957,12 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("hmminds   : %d\n", le32_to_cpu(ctrl->hmminds));
 	printf("hmmaxd    : %d\n", le16_to_cpu(ctrl->hmmaxd));
 	printf("nsetidmax : %d\n", le16_to_cpu(ctrl->nsetidmax));
+	printf("anatt     : %d\n", ctrl->anatt);
+	printf("anacap    : %#x\n", ctrl->anacap);
+	if (human)
+		show_nvme_id_ctrl_anacap(ctrl->anacap);
+	printf("anagrpmax : %u\n", le32_to_cpu(ctrl->anagrpmax));
+	printf("nanagrpid : %u\n", le32_to_cpu(ctrl->nanagrpid));
 	printf("sqes      : %#x\n", ctrl->sqes);
 	if (human)
 		show_nvme_id_ctrl_sqes(ctrl->sqes);
@@ -953,6 +992,7 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("sgls      : %x\n", le32_to_cpu(ctrl->sgls));
 	if (human)
 		show_nvme_id_ctrl_sgls(ctrl->sgls);
+	printf("mnan:     : %d\n", le32_to_cpu(ctrl->mnan));
 	printf("subnqn    : %-.*s\n", (int)sizeof(ctrl->subnqn), ctrl->subnqn);
 	printf("ioccsz    : %d\n", le32_to_cpu(ctrl->ioccsz));
 	printf("iorcsz    : %d\n", le32_to_cpu(ctrl->iorcsz));
-- 
2.13.7
