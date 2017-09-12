From: jeff.lien@wdc.com (jeffreyalien)
Date: Tue, 12 Sep 2017 12:37:05 -0500
Subject: [PATCH] NVMe-CLI Fixed Status Code check for reset type on
 fw-activate.
Message-ID: <1505237825-21002-1-git-send-email-jeff.lien@wdc.com>

From: Jeff Lien <Jeff.Lien@hgst.com>

If a device returns a fw-activate status with the More or DNR bit
set, the CLI code will return a message indicating an Admin command
error instead of succesful status.  With this patch, the More and
DNR bits will be masked off and not affect the returned message.
---
 nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme.c b/nvme.c
index f1d6d65..d495cbb 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1389,7 +1389,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 
 static char *nvme_fw_status_reset_type(__u32 status)
 {
-	switch (status) {
+	switch (status & 0x3ff) {
 	case NVME_SC_FW_NEEDS_CONV_RESET:	return "conventional";
 	case NVME_SC_FW_NEEDS_SUBSYS_RESET:	return "subsystem";
 	case NVME_SC_FW_NEEDS_RESET:		return "any controller";
@@ -1441,7 +1441,7 @@ static int fw_activate(int argc, char **argv, struct command *cmd, struct plugin
 	if (err < 0)
 		perror("fw-activate");
 	else if (err != 0)
-		switch (err) {
+		switch (err & 0x3ff) {
 		case NVME_SC_FW_NEEDS_CONV_RESET:
 		case NVME_SC_FW_NEEDS_SUBSYS_RESET:
 		case NVME_SC_FW_NEEDS_RESET:
-- 
1.8.3.1
