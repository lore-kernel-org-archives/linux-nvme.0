From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 27 Jan 2018 02:49:42 +0900
Subject: [PATCH] nvme-cli: convert iekey into a no_argument parameter
Message-ID: <1516988982-27969-1-git-send-email-minwoo.im.dev@gmail.com>

IEKEY(Ignore Existing Key) option is used widely in Reservation Acquire,
Reservation Register, and Reservation Release in a type of bool(1-bit).

Only resv_release() uses iekey field as a required_argument parameter.
It seems unnecessary because it will not be checked if this parameter
is given or not by a following condition because default value is 0.

        if (cfg.iekey > 1)

So remove unnecessary if-statement and convert this field to a
no_argument type option.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/nvme.c b/nvme.c
index aa2b8ec..f069622 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3118,7 +3118,7 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 		{"crkey",        'c', "NUM",  CFG_LONG_SUFFIX, &cfg.crkey,        required_argument, crkey},
 		{"rtype",        't', "NUM",  CFG_BYTE,        &cfg.rtype,        required_argument, rtype},
 		{"rrela",        'a', "NUM",  CFG_BYTE,        &cfg.rrela,        required_argument, rrela},
-		{"iekey",        'i', "NUM",  CFG_BYTE,        &cfg.iekey,        required_argument, iekey},
+		{"iekey",        'i', "",     CFG_NONE,        &cfg.iekey,        no_argument, iekey},
 		{NULL}
 	};
 
@@ -3128,10 +3128,6 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 
 	if (!cfg.namespace_id)
 		cfg.namespace_id = get_nsid(fd);
-	if (cfg.iekey > 1) {
-		fprintf(stderr, "invalid iekey:%d\n", cfg.iekey);
-		return EINVAL;
-	}
 	if (cfg.rrela > 7) {
 		fprintf(stderr, "invalid rrela:%d\n", cfg.rrela);
 		return EINVAL;
-- 
2.7.4
