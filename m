From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Thu, 23 Aug 2018 19:33:12 +0000
Subject: [PATCH] nvme-cli: netapp plugin handle empty strings
Message-ID: <BL0PR06MB4564625CDE60945CFD8209A98C370@BL0PR06MB4564.namprd06.prod.outlook.com>

Handle controller fields with strings of length 0.

Signed-off-by: Steve Schremmer <steve.schremmer at netapp.com>
---
 netapp-nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/netapp-nvme.c b/netapp-nvme.c
index 1167db4..b369913 100644
--- a/netapp-nvme.c
+++ b/netapp-nvme.c
@@ -63,6 +63,9 @@ static void netapp_convert_string(char *dst, char *src, unsigned int count)
 	memset(dst, 0, count + 1);
 	for (i = 0; i < count; i++)
 		dst[i] = src[i * 2 + 1];
+	/* the json routines won't accept empty strings */
+	if (strlen(dst) == 0 && count)
+		dst[0] = ' ';
 }
 
 static void netapp_nguid_to_str(char *str, __u8 *nguid)
-- 
2.18.0
