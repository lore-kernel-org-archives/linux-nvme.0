From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 28 Sep 2016 16:49:42 -0700
Subject: [PATCH 2/4] nvme-cli: Tweak discover summary to match docs
In-Reply-To: <1475106584-14961-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1475106584-14961-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1475106584-14961-3-git-send-email-james_p_freyensee@linux.intel.com>

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme.c b/nvme.c
index ab782d0..9c331ae 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2668,7 +2668,7 @@ static int admin_passthru(int argc, char **argv, struct command *cmd, struct plu
 
 static int discover_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
-	const char *desc = "Send command to discovery service.";
+	const char *desc = "Send Get Log Page request to Discovery Controller.";
 	return discover(desc, argc, argv, false);
 }
 
-- 
2.7.4
