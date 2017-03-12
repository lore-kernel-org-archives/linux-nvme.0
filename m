From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Sun, 12 Mar 2017 16:13:24 -0700
Subject: [PATCH] nvme-cli: bug-fix: use right file name for perror.
In-Reply-To: <1489360404-16256-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1489360404-16256-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1489360404-16256-2-git-send-email-chaitanya.kulkarni@hgst.com>

Use right file descriptor while printing an error, when
--metadata option is used for read/write commands.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index 4971683..17318b4 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2282,7 +2282,7 @@ static int submit_io(int opcode, char *command, const char *desc,
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
