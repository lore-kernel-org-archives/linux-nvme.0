From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:40 +0100
Subject: [PATCH 06/13] lightnvm: remove unused attrs in nvm_id structs
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-7-git-send-email-m@bjorling.me>

The nvm_id, nvm_id_group and nvm_addr_format data structures contain
reserved attributes. They are unused by media managers and targets.
Remove them.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 include/linux/lightnvm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 2572856..e6ef8aa 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -58,7 +58,6 @@ enum {
 struct nvm_id_group {
 	u8	mtype;
 	u8	fmtype;
-	u16	res16;
 	u8	num_ch;
 	u8	num_lun;
 	u8	num_pln;
@@ -76,8 +75,7 @@ struct nvm_id_group {
 	u32	mpos;
 	u32	mccap;
 	u16	cpar;
-	u8	res[913];
-} __packed;
+};
 
 struct nvm_addr_format {
 	u8	ch_offset;
@@ -92,19 +90,16 @@ struct nvm_addr_format {
 	u8	pg_len;
 	u8	sect_offset;
 	u8	sect_len;
-	u8	res[4];
 };
 
 struct nvm_id {
 	u8	ver_id;
 	u8	vmnt;
 	u8	cgrps;
-	u8	res[5];
 	u32	cap;
 	u32	dom;
 	struct nvm_addr_format ppaf;
 	u8	ppat;
-	u8	resv[224];
 	struct nvm_id_group groups[4];
 } __packed;
 
-- 
2.1.4
