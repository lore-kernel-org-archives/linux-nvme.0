From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 15 May 2019 00:14:38 +0900
Subject: [PATCH] nvme-cli: align comments for struct telemetry_log_page_hdr
Message-ID: <1557846878-25595-1-git-send-email-akinobu.mita@gmail.com>

Align the field member comments for struct telemetry_log_page_hdr.
This also uses tabs instead of spaces to align field members.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 linux/nvme.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 2c840b9..118095a 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -427,17 +427,17 @@ struct nvme_id_nvmset {
 };
 
 struct nvme_telemetry_log_page_hdr {
-	__u8    lpi; /* Log page identifier */
-	__u8    rsvd[4];
-	__u8    iee_oui[3];
-	__le16  dalb1; /* Data area 1 last block */
-	__le16  dalb2; /* Data area 2 last block */
-	__le16  dalb3; /* Data area 3 last block */
-	__u8    rsvd1[368];
-	__u8    ctrlavail; /* Controller initiated data avail?*/
-	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
-	__u8    rsnident[128];
-	__u8    telemetry_dataarea[0];
+	__u8	lpi;		/* Log page identifier */
+	__u8	rsvd[4];
+	__u8	iee_oui[3];
+	__le16	dalb1;		/* Data area 1 last block */
+	__le16	dalb2;		/* Data area 2 last block */
+	__le16	dalb3;		/* Data area 3 last block */
+	__u8	rsvd1[368];
+	__u8	ctrlavail;	/* Controller initiated data avail? */
+	__u8	ctrldgn;	/* Controller initiated telemetry Data Gen # */
+	__u8	rsnident[128];
+	__u8	telemetry_dataarea[0];
 };
 
 struct nvme_endurance_group_log {
-- 
2.7.4
