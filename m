From: jeff.lien@wdc.com (Jeff Lien)
Date: Thu, 21 Jun 2018 13:58:17 -0500
Subject: [PATCH] NVMe-CLI Fix id-ns fpi field when Human Readable option
 selected.
Message-ID: <20180621185817.1297-1-jeff.lien@wdc.com>

Currently when fpi = 0, the Format Progress Indicator Remaining is
100% and should be 0%.  This patch fixes that condition.

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 4e7cb9f..25a4e03 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -573,7 +573,7 @@ static void show_nvme_id_ns_fpi(__u8 fpi)
 		fpis, fpis ? "" : "Not ");
 	if (fpis || (!fpis && fpii))
 	printf("  [6:0] : %#x\tFormat Progress Indicator (Remaining %d%%)\n",
-		fpii, 100 - fpii);
+		fpii, fpii);
 	printf("\n");
 }
 
-- 
2.14.2.746.g8fb8a94
