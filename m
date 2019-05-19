From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 May 2019 10:56:42 -0700
Subject: [PATCH] nvme-cli: close fd before return
Message-ID: <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>

Instead of returning on the erro use existing close_fd label before
we return in create_ns() and format().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/nvme.c b/nvme.c
index e0f7552..d6e5b21 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1216,7 +1216,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 				fprintf(stderr, "identify failed\n");
 				show_nvme_status(err);
 			}
-			return err;
+			goto close_fd;
 		}
 		for (i = 0; i < 16; ++i) {
 			if ((1 << ns.lbaf[i].ds) == cfg.bs && ns.lbaf[i].ms == 0) {
@@ -1245,6 +1245,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	else
 		perror("create namespace");
 
+ close_fd:
 	close(fd);
 
 	return err;
@@ -3198,7 +3199,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 				fprintf(stderr, "identify failed\n");
 				show_nvme_status(err);
 			}
-			return err;
+			goto close_fd;
 		}
 		prev_lbaf = ns.flbas & 0xf;
 
-- 
2.17.0
