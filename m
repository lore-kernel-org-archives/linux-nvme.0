From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:38 +0100
Subject: [PATCH 04/13] lightnvm: update alignments for identify command
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-5-git-send-email-m@bjorling.me>

A single 8 bit and 16 bit reserve field were inserted in the
specification to align fields appropriately. Reflect this in the
identify group structure.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 2c35465..60687ed 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -155,11 +155,13 @@ struct nvme_nvm_id_group {
 	__u8			num_ch;
 	__u8			num_lun;
 	__u8			num_pln;
+	__u8			rsvd1;
 	__le16			num_blk;
 	__le16			num_pg;
 	__le16			fpg_sz;
 	__le16			csecs;
 	__le16			sos;
+	__le16			rsvd2;
 	__le32			trdt;
 	__le32			trdm;
 	__le32			tprt;
@@ -168,7 +170,7 @@ struct nvme_nvm_id_group {
 	__le32			tbem;
 	__le32			mpos;
 	__le16			cpar;
-	__u8			reserved[913];
+	__u8			reserved[910];
 } __packed;
 
 struct nvme_nvm_addr_format {
-- 
2.1.4
