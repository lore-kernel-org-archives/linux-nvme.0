From: jeff.lien@wdc.com (Jeff Lien)
Date: Tue, 15 May 2018 14:53:17 -0500
Subject: [PATCH] NVMe-CLI Fix id-ns fpi field when Human Readable option
 selected.
Message-ID: <20180515195317.23003-1-jeff.lien@wdc.com>

Currently when fpi = 0, the Format Progress Indicator Remaining is
100% and should be 0%.  This patch fixes that condition.

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 nvme-print.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index d63f58d..7b65a09 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -569,11 +569,17 @@ static void show_nvme_id_ns_fpi(__u8 fpi)
 {
 	__u8 fpis = (fpi & 0x80) >> 7;
 	__u8 fpii = fpi & 0x7F;
+	__u8 remaining;
 	printf("  [7:7] : %#x\tFormat Progress Indicator %sSupported\n",
 		fpis, fpis ? "" : "Not ");
-	if (fpis || (!fpis && fpii))
-	printf("  [6:0] : %#x\tFormat Progress Indicator (Remaining %d%%)\n",
-		fpii, 100 - fpii);
+	if (fpis || (!fpis && fpii)) {
+		if (fpii)
+			remaining = 100 - fpii;
+		else
+			remaining = 0;
+		printf("  [6:0] : %#x\tFormat Progress Indicator (Remaining %d%%)\n",
+				fpii, remaining);
+	}
 	printf("\n");
 }
 
-- 
2.14.2.746.g8fb8a94
