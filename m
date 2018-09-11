From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 10 Sep 2018 17:41:26 -0700
Subject: [PATCH] nvme-cli: make default error log entries to 128
Message-ID: <20180911004126.32509-1-chaitanya.kulkarni@wdc.com>

NVMeOF target defines default error log entries to be 128, use the
same number as a default value in the nvme-cli when retrieving
error-log.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index 970fc0b..ad88aa6 100644
--- a/nvme.c
+++ b/nvme.c
@@ -557,7 +557,7 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 	};
 
 	struct config cfg = {
-		.log_entries  = 64,
+		.log_entries  = 128,
 		.output_format = "normal",
 	};
 
-- 
2.17.0
