From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Thu, 22 Sep 2016 15:37:20 -0700
Subject: [PATCH RFC] nvme-cli: propose 'c' vs 'r' for connect flag
Message-ID: <1474583840-23739-1-git-send-email-james_p_freyensee@linux.intel.com>

I am not sure if it matters too much except in possibly
human usage understanding, but '-r' is used in the 'discover'
command for --raw.  Change the --reconnect-delay flag
single letter to something not being used in any fabrics
command.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index dff5d6a..5e892fb 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -759,7 +759,7 @@ int connect(const char *desc, int argc, char **argv)
 		 "number of io queues to use (default is core count)" },
 		{"keep-alive-tmo", 'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo, required_argument,
 			"keep alive timeout period in seconds" },
-		{"reconnect-delay", 'r', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument,
+		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument,
 			"reconnect timeout period in seconds" },
 		{0},
 	};
-- 
2.7.4
