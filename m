From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 23 Jul 2019 23:42:34 +0900
Subject: [PATCH 2/3] lnvm: do not print 0 when the arg is not given
In-Reply-To: <20190723144235.12207-1-minwoo.im.dev@gmail.com>
References: <20190723144235.12207-1-minwoo.im.dev@gmail.com>
Message-ID: <20190723144235.12207-3-minwoo.im.dev@gmail.com>

If an argument is not given by the user, it just needs to show the
situation, not a prominent 0 which indicates the size of the argument
variable.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Javier Gonz?lez <javier at javigon.com>
---
 plugins/lnvm/lnvm-nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/lnvm/lnvm-nvme.c b/plugins/lnvm/lnvm-nvme.c
index 37b6733..aacd469 100644
--- a/plugins/lnvm/lnvm-nvme.c
+++ b/plugins/lnvm/lnvm-nvme.c
@@ -48,7 +48,7 @@ static int lnvm_init(int argc, char **argv, struct command *cmd, struct plugin *
 		return ret;
 
 	if (!strlen(cfg.devname)) {
-		fprintf(stderr, "device name missing %d\n", (int)strlen(cfg.devname));
+		fprintf(stderr, "device name missing\n");
 		return -EINVAL;
 	}
 
@@ -179,7 +179,7 @@ static int lnvm_create_tgt(int argc, char **argv, struct command *cmd, struct pl
 		return ret;
 
 	if (!strlen(cfg.devname)) {
-		fprintf(stderr, "device name missing %d\n", (int)strlen(cfg.devname));
+		fprintf(stderr, "device name missing\n");
 		return -EINVAL;
 	}
 	if (!strlen(cfg.tgtname)) {
@@ -265,7 +265,7 @@ static int lnvm_factory_init(int argc, char **argv, struct command *cmd, struct
 		return ret;
 
 	if (!strlen(cfg.devname)) {
-		fprintf(stderr, "device name missing %d\n", (int)strlen(cfg.devname));
+		fprintf(stderr, "device name missing\n");
 		return -EINVAL;
 	}
 
-- 
2.17.1
