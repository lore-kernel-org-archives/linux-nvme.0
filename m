From: roysh@mellanox.com (Roy Shterman)
Date: Wed, 24 Aug 2016 09:53:06 +0300
Subject: [PATCH] nvme-cli/fabrics: Added hostnqn parameter to connect command
Message-ID: <1472021586-15203-1-git-send-email-roysh@mellanox.com>

Added user-defined 'hostnqn' to 'connect' command
so users could use the allowed_hosts attribute on the target and still
connect to target with nvme-cli tool.

usage examples:
	nvme connect -t <TRANSPORT> -a <ADDRESS> -s <SERVICE_ID> -n <NQN> -q <USER-DEFINED_HOSTNQN>

Signed-off-by: Roy Shterman <roysh at mellanox.com>
---
 fabrics.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 26c4e22..942e987 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -711,6 +711,8 @@ int connect(const char *desc, int argc, char **argv)
 			"transport address" },
 		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
 			"transport service id (e.g. IP port)" },
+		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn, required_argument,
+			"user-defined hostnqn" },
 		{0},
 	};
 
-- 
1.7.8.2
