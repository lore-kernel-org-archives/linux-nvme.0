From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  1 Jul 2018 22:58:05 +0900
Subject: [PATCH] nvme-cli: print firmware activation notices support bit to
 id_ctrl
Message-ID: <1530453485-15698-1-git-send-email-minwoo.im.dev@gmail.com>

It's now currently printing the OAES(Optional Asynchronous Events Supported)
field in identify controller data structure without [9] firmware activation
notices field in case of human-readable format.
Print it out by updating the reserved bit field.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 20c2458..daf2929 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -94,12 +94,15 @@ static void show_nvme_id_ctrl_cmic(__u8 cmic)
 static void show_nvme_id_ctrl_oaes(__le32 ctrl_oaes)
 {
 	__u32 oaes = le32_to_cpu(ctrl_oaes);
-	__u32 rsvd0 = (oaes & 0xFFFFFE00) >> 9;
+	__u32 rsvd0 = (oaes & 0xFFFFFC00) >> 10;
 	__u32 nace = (oaes & 0x100) >> 8;
+	__u32 fan = (oaes & 0x200) >> 9;
 	__u32 rsvd1 = oaes & 0xFF;
 
 	if (rsvd0)
-		printf(" [31:9] : %#x\tReserved\n", rsvd0);
+		printf(" [31:10] : %#x\tReserved\n", rsvd0);
+	printf("  [9:9] : %#x\tFirmware Activation Notices %sSupported\n",
+		fan, fan ? "" : "Not ");
 	printf("  [8:8] : %#x\tNamespace Attribute Changed Event %sSupported\n",
 		nace, nace ? "" : "Not ");
 	if (rsvd1)
-- 
2.7.4
