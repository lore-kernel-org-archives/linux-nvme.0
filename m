From: jeff.lien@wdc.com (Jeff Lien)
Date: Fri, 24 Aug 2018 13:34:27 -0500
Subject: [PATCH] nvme-cli: Fix the displayed metadata length value on Big
 Endian systems.
Message-ID: <1535135667-32608-1-git-send-email-jeff.lien@wdc.com>

On BE systems, the metadata length value displayed as part of the
format in the nvme list command is byte swapped.  So a value of 0
appears just fine but a value of 8 bytes is displayed as 0x0800.
This patch fixes that is the value is correct for both LE and BE
systems.

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 4c2a73a..3589c19 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2050,7 +2050,7 @@ static void show_list_item(struct list_item list_item)
 	sprintf(usage,"%6.2f %2sB / %6.2f %2sB", nuse, u_suffix,
 		nsze, s_suffix);
 	sprintf(format,"%3.0f %2sB + %2d B", (double)lba, l_suffix,
-		list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ms);
+		le16_to_cpu(list_item.ns.lbaf[(list_item.ns.flbas & 0x0f)].ms));
 	printf("%-16s %-*.*s %-*.*s %-9d %-26s %-16s %-.*s\n", list_item.node,
             (int)sizeof(list_item.ctrl.sn), (int)sizeof(list_item.ctrl.sn), list_item.ctrl.sn,
             (int)sizeof(list_item.ctrl.mn), (int)sizeof(list_item.ctrl.mn), list_item.ctrl.mn,
-- 
1.8.3.1
