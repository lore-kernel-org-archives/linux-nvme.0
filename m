From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:22:59 -0700
Subject: [PATCH 08/18] add missing endianess annoations for lightnvm data
 structures
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-9-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-lightnvm.h | 136 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/nvme-lightnvm.h b/nvme-lightnvm.h
index 78b9f8a..19a2202 100644
--- a/nvme-lightnvm.h
+++ b/nvme-lightnvm.h
@@ -32,55 +32,55 @@ enum nvme_nvm_admin_opcode {
 struct nvme_nvm_identity {
 	__u8	opcode;
 	__u8	flags;
-	__u16	command_id;
-	__u32	nsid;
-	__u64	rsvd[2];
-	__u64	prp1;
-	__u64	prp2;
-	__u32	chnl_off;
-	__u32	rsvd11[5];
+	__le16	command_id;
+	__le32	nsid;
+	__le64	rsvd[2];
+	__le64	prp1;
+	__le64	prp2;
+	__le32	chnl_off;
+	__le32	rsvd11[5];
 };
 
 struct nvme_nvm_setbbtbl {
 	__u8	opcode;
 	__u8	flags;
-	__u16	rsvd1;
-	__u32	nsid;
-	__u32	cdw2;
-	__u32	cdw3;
-	__u64	metadata;
+	__le16	rsvd1;
+	__le32	nsid;
+	__le32	cdw2;
+	__le32	cdw3;
+	__le64	metadata;
 	__u64	addr;
-	__u32	metadata_len;
-	__u32	data_len;
-	__u64	ppa;
-	__u16	nlb;
+	__le32	metadata_len;
+	__le32	data_len;
+	__le64	ppa;
+	__le16	nlb;
 	__u8	value;
 	__u8	rsvd2;
-	__u32	cdw14;
-	__u32	cdw15;
-	__u32	timeout_ms;
-	__u32	result;
+	__le32	cdw14;
+	__le32	cdw15;
+	__le32	timeout_ms;
+	__le32	result;
 };
 
 struct nvme_nvm_getbbtbl {
 	__u8	opcode;
 	__u8	flags;
-	__u16	rsvd1;
-	__u32	nsid;
-	__u32	cdw2;
-	__u32	cdw3;
-	__u64	metadata;
+	__le16	rsvd1;
+	__le32	nsid;
+	__le32	cdw2;
+	__le32	cdw3;
+	__le64	metadata;
 	__u64	addr;
-	__u32	metadata_len;
-	__u32	data_len;
-	__u64	ppa;
-	__u32	cdw11;
-	__u32	cdw12;
-	__u32	cdw13;
-	__u32	cdw14;
-	__u32	cdw15;
-	__u32	timeout_ms;
-	__u32	result;
+	__le32	metadata_len;
+	__le32	data_len;
+	__le64	ppa;
+	__le32	cdw11;
+	__le32	cdw12;
+	__le32	cdw13;
+	__le32	cdw14;
+	__le32	cdw15;
+	__le32	timeout_ms;
+	__le32	result;
 };
 
 struct nvme_nvm_command {
@@ -91,16 +91,16 @@ struct nvme_nvm_command {
 };
 
 struct nvme_nvm_completion {
-	__u64	result;		/* Used by LightNVM to return ppa completions */
-	__u16	sq_head;	/* how much of this queue may be reclaimed */
-	__u16	sq_id;		/* submission queue that generated this entry */
-	__u16	command_id;	/* of the command which completed */
-	__u16	status;		/* did the command fail, and if so, why? */
+	__le64	result;		/* Used by LightNVM to return ppa completions */
+	__le16	sq_head;	/* how much of this queue may be reclaimed */
+	__le16	sq_id;		/* submission queue that generated this entry */
+	__le16	command_id;	/* of the command which completed */
+	__le16	status;		/* did the command fail, and if so, why? */
 };
 
 #define NVME_NVM_LP_MLC_PAIRS 886
 struct nvme_nvm_lp_mlc {
-	__u16			num_pairs;
+	__le16			num_pairs;
 	__u8			pairs[NVME_NVM_LP_MLC_PAIRS];
 };
 
@@ -112,26 +112,26 @@ struct nvme_nvm_lp_tbl {
 struct nvme_nvm_id_group {
 	__u8			mtype;
 	__u8			fmtype;
-	__u16			res16;
+	__le16			res16;
 	__u8			num_ch;
 	__u8			num_lun;
 	__u8			num_pln;
 	__u8			rsvd1;
-	__u16			num_blk;
-	__u16			num_pg;
-	__u16			fpg_sz;
-	__u16			csecs;
-	__u16			sos;
-	__u16			rsvd2;
-	__u32			trdt;
-	__u32			trdm;
-	__u32			tprt;
-	__u32			tprm;
-	__u32			tbet;
-	__u32			tbem;
-	__u32			mpos;
-	__u32			mccap;
-	__u16			cpar;
+	__le16			num_blk;
+	__le16			num_pg;
+	__le16			fpg_sz;
+	__le16			csecs;
+	__le16			sos;
+	__le16			rsvd2;
+	__le32			trdt;
+	__le32			trdm;
+	__le32			tprt;
+	__le32			tprm;
+	__le32			tbet;
+	__le32			tbem;
+	__le32			mpos;
+	__le32			mccap;
+	__le16			cpar;
 	__u8			reserved[10];
 	struct nvme_nvm_lp_tbl lptbl;
 } __attribute__((packed));
@@ -157,8 +157,8 @@ struct nvme_nvm_id {
 	__u8			vmnt;
 	__u8			cgrps;
 	__u8			res;
-	__u32			cap;
-	__u32			dom;
+	__le32			cap;
+	__le32			dom;
 	struct nvme_nvm_addr_format ppaf;
 	__u8			resv[228];
 	struct nvme_nvm_id_group groups[4];
@@ -166,15 +166,15 @@ struct nvme_nvm_id {
 
 struct nvme_nvm_bb_tbl {
 	__u8	tblid[4];
-	__u16	verid;
-	__u16	revid;
-	__u32	rvsd1;
-	__u32	tblks;
-	__u32	tfact;
-	__u32	tgrown;
-	__u32	tdresv;
-	__u32	thresv;
-	__u32	rsvd2[8];
+	__le16	verid;
+	__le16	revid;
+	__le32	rvsd1;
+	__le32	tblks;
+	__le32	tfact;
+	__le32	tgrown;
+	__le32	tdresv;
+	__le32	thresv;
+	__le32	rsvd2[8];
 	__u8	blk[0];
 };
 
-- 
2.1.4
