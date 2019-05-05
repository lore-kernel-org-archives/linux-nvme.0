From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Mon,  6 May 2019 02:55:27 +0900
Subject: [PATCH] nvme-cli: add missing endianness conversions for telemetry
 log page
Message-ID: <1557078927-4101-1-git-send-email-akinobu.mita@gmail.com>

Add missing endianness conversions for data area last block fields of
telemetry log page.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 linux/nvme.h | 6 +++---
 nvme.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index a1422a7..f6d7341 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -433,9 +433,9 @@ struct nvme_telemetry_log_page_hdr {
 	__u8    lpi; /* Log page identifier */
 	__u8    rsvd[4];
 	__u8    iee_oui[3];
-	__u16   dalb1; /* Data area 1 last block */
-	__u16   dalb2; /* Data area 2 last block */
-	__u16   dalb3; /* Data area 3 last block */
+	__le16  dalb1; /* Data area 1 last block */
+	__le16  dalb2; /* Data area 2 last block */
+	__le16  dalb3; /* Data area 3 last block */
 	__u8    rsvd1[368]; /* TODO verify */
 	__u8    ctrlavail; /* Controller initiated data avail?*/
 	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
diff --git a/nvme.c b/nvme.c
index f4c027b..220fb18 100644
--- a/nvme.c
+++ b/nvme.c
@@ -376,13 +376,13 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 
 	switch (cfg.data_area) {
 	case 1:
-		full_size = (hdr->dalb1 * bs) + offset;
+		full_size = (le16_to_cpu(hdr->dalb1) * bs) + offset;
 		break;
 	case 2:
-		full_size = (hdr->dalb2 * bs) + offset;
+		full_size = (le16_to_cpu(hdr->dalb2) * bs) + offset;
 		break;
 	case 3:
-		full_size = (hdr->dalb3 * bs) + offset;
+		full_size = (le16_to_cpu(hdr->dalb3) * bs) + offset;
 		break;
 	default:
 		fprintf(stderr, "Invalid data area requested");
-- 
2.7.4
