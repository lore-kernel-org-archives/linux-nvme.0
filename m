From: roysh@mellanox.com (Roy Shterman)
Date: Fri, 29 Jul 2016 00:04:21 +0300
Subject: [PATCH] nvme-cli/fabrics: Adding hostnqn parameter to discover and
 connect
In-Reply-To: <1469739861-32703-1-git-send-email-roysh@mellanox.com>
References: <1469739861-32703-1-git-send-email-roysh@mellanox.com>
Message-ID: <1469739861-32703-2-git-send-email-roysh@mellanox.com>

Adding user-defined 'hostnqn' to 'discover' and 'connect' commands
so users could use the allowed_hosts attribute on the target and still
using nvme-cli tool.

usage examples:
	nvme discover -t <TRANSPORT> -a <ADDRESS> -s <SERVICE_ID> -q <USER-DEFINED_HOSTNQN>

Signed-off-by: Roy Shterman <roysh at mellanox.com>
---
 fabrics.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 3666a01..7ecdf90 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -49,6 +49,7 @@ struct config {
 	char *transport;
 	char *traddr;
 	char *trsvcid;
+	char *hostnqn;
 	char *raw;
 	char *device;
 } cfg = { 0 };
@@ -395,6 +396,14 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
+	if (cfg.hostnqn) {
+		len = snprintf(argstr, max_len, ",hostnqn=%s", cfg.hostnqn);
+		if (len < 0)
+			return -EINVAL;
+		argstr +=len;
+		max_len -= len;
+	}
+
 	return 0;
 }
 
@@ -527,6 +536,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 			"transport service id (e.g. IP port)" },
 		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
 			"raw output file" },
+		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn, required_argument,
+			"user-defined hostnqn" },
 		{0},
 	};
 
@@ -554,6 +565,8 @@ int connect(const char *desc, int argc, char **argv)
 			"transport address" },
 		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
 			"transport service id (e.g. IP port)" },
+		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn, required_argument,
+			"user-defined hostnqn" },
 		{0},
 	};
 
-- 
1.7.8.2
