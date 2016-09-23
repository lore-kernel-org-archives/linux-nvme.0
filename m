From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri, 23 Sep 2016 09:57:51 -0700
Subject: [PATCH] nvme-cli: change 'r' to 'c' for connect flag
Message-ID: <1474649871-12495-1-git-send-email-james_p_freyensee@linux.intel.com>

To make things a tad easier for human usage understanding,
refine the single letter short option of 'r' to 'c' for the
'connect' command as 'r' is already used by 'discover'.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index b8068ba..0718446 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -759,7 +759,7 @@ int connect(const char *desc, int argc, char **argv)
 		 "number of io queues to use (default is core count)" },
 		{"keep-alive-tmo", 'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo, required_argument,
 			"keep alive timeout period in seconds" },
-		{"reconnect-delay", 'r', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument,
+		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument,
 			"reconnect timeout period in seconds" },
 		{NULL},
 	};
-- 
2.7.4
