From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Sat, 25 Feb 2017 23:07:03 -0800
Subject: [PATCH] nvme-cli: bug-fix: use right file name for perror.
Message-ID: <1488092823-21513-1-git-send-email-chaitanya.kulkarni@hgst.com>

Use right file descriptor while printing an error, when
--metadata option is used for read/write commands.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index e693914..1d74b50 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2283,7 +2283,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 	if (strlen(cfg.metadata)){
 		mfd = open(cfg.metadata, flags, mode);
 		if (mfd < 0) {
-			perror(cfg.data);
+			perror(cfg.metadata);
 			return EINVAL;
 		}
 	}
-- 
1.9.1
