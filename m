From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 20:36:04 -0400
Subject: [PATCH 2/5] nvme-cli: remove always true condition for u8
In-Reply-To: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
References: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180820003607.21899-3-chaitanya.kulkarni@wdc.com>

Get rid of the always true condition of (cfg.owpass >= 0) since
cfg.owpass is defined as __u8.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index a893366..4233d9c 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2585,7 +2585,7 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 	}
 
 	if (cfg.sanact == NVME_SANITIZE_ACT_OVERWRITE) {
-		if (!(cfg.owpass >= 0 && cfg.owpass <= 16)) {
+		if (cfg.owpass > 16) {
 			fprintf(stderr, "OWPASS out of range [0-16]\n");
 			ret = EINVAL;
 			goto close_fd;
-- 
2.14.1
