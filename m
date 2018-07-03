From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue,  3 Jul 2018 22:18:59 +0900
Subject: [PATCH] nvme-cli: adjust memset size for data buffer in submit_io
Message-ID: <1530623939-12790-1-git-send-email-minwoo.im.dev@gmail.com>

Adjust size of memset() for the data buffer to its own size.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index e2f8752..039997a 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3942,7 +3942,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 		err = ENOMEM;
 		goto close_mfd;
 	}
-	memset(buffer, 0, cfg.data_size);
+	memset(buffer, 0, buffer_size);
 
 	if (cfg.metadata_size) {
 		mbuffer = malloc(cfg.metadata_size);
-- 
2.7.4
