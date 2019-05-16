From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 17 May 2019 01:40:28 +0900
Subject: [PATCH] nvme-cli: add kernel-doc comment for struct
 telemetry_log_page_hdr
Message-ID: <1558024828-9356-1-git-send-email-akinobu.mita@gmail.com>

This adds the kernel-doc data structure comment for struct
telemetry_log_page_hdr.

This also replaces spaces with tabs to align the structure fields.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
Cc: Bart Van Assche <bvanassche at acm.org>
Suggested-by: Bart Van Assche <bvanassche at acm.org>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 linux/nvme.h | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 2c840b9..cac4d19 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -426,18 +426,33 @@ struct nvme_id_nvmset {
 	struct nvme_nvmset_attr_entry	ent[NVME_MAX_NVMSET];
 };
 
+/**
+ * struct nvme_telemetry_log_page_hdr - structure for telemetry log page
+ * @lpi: Log page identifier
+ * @iee_oui: IEEE OUI Identifier
+ * @dalb1: Data area 1 last block
+ * @dalb2: Data area 2 last block
+ * @dalb3: Data area 3 last block
+ * @ctrlavail: Controller initiated data available
+ * @ctrldgn: Controller initiated telemetry Data Generation Number
+ * @rsnident: Reason Identifier
+ * @telemetry_dataarea: Contains telemetry data block
+ *
+ * This structure can be used for both telemetry host-initiated log page
+ * and controller-initiated log page.
+ */
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
+	__u8	lpi;
+	__u8	rsvd[4];
+	__u8	iee_oui[3];
+	__le16	dalb1;
+	__le16	dalb2;
+	__le16	dalb3;
+	__u8	rsvd1[368];
+	__u8	ctrlavail;
+	__u8	ctrldgn;
+	__u8	rsnident[128];
+	__u8	telemetry_dataarea[0];
 };
 
 struct nvme_endurance_group_log {
-- 
2.7.4
