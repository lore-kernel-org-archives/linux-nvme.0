From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Wed, 12 Apr 2017 15:15:18 -0700
Subject: [PATCH] nvmet_fc: Change traddr field separator to a colon
Message-ID: <20170412221518.23473-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

The FC-NVME spec revised syntax to avoid comma separators.
Sync with the change in the parser for traddr on port attachments.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 9a8b846..e6243bb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2326,7 +2326,7 @@ nvmet_fc_parse_traddr(struct nvmet_fc_traddr *traddr, char *buf)
 	if (!options)
 		return -ENOMEM;
 
-	while ((p = strsep(&o, ",\n")) != NULL) {
+	while ((p = strsep(&o, ":\n")) != NULL) {
 		if (!*p)
 			continue;
 
-- 
2.9.3
