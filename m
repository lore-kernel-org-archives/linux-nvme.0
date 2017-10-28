From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 29 Oct 2017 03:26:33 +0900
Subject: [PATCH] nvme-cli: make command description const
Message-ID: <1509215193-13119-1-git-send-email-minwoo.im.dev@gmail.com>

Make desc in sanitize_log() const.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index 9ac6a3c..ed1c61f 100644
--- a/nvme.c
+++ b/nvme.c
@@ -488,7 +488,7 @@ static const char * sanitize_mon_status_to_string(__u16 status)
 
 static int sanitize_log(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
-	char *desc = "Retrieve sanitize log and show it.";
+	const char *desc = "Retrieve sanitize log and show it.";
 	int fd;
 	int ret;
 	__u8 output[NVME_SANITIZE_LOG_DATA_LEN] = {0};
-- 
2.7.4
