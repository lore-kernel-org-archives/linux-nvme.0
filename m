From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 22 Jul 2019 00:32:16 +0900
Subject: [PATCH 1/4] lnvm: remove redundant whitespace in lnvm_init()
In-Reply-To: <20190721153219.5730-1-minwoo.im.dev@gmail.com>
References: <20190721153219.5730-1-minwoo.im.dev@gmail.com>
Message-ID: <20190721153219.5730-2-minwoo.im.dev@gmail.com>

The description for lnvm-init subcommand has a redundant whitespace.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 plugins/lnvm/lnvm-nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/lnvm/lnvm-nvme.c b/plugins/lnvm/lnvm-nvme.c
index 754931a..37b6733 100644
--- a/plugins/lnvm/lnvm-nvme.c
+++ b/plugins/lnvm/lnvm-nvme.c
@@ -17,7 +17,7 @@
 static int lnvm_init(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc = "Initialize LightNVM device. A LightNVM/Open-Channel SSD"\
-			   " must have a media manager associated before it can "\
+			   " must have a media manager associated before it can"\
 			   " be exposed to the user. The default is to initialize"
 			   " the general media manager on top of the device.\n\n"
 			   "Example:"
-- 
2.17.1
