From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 19:00:19 -0800
Subject: [PATCH nvme-cli v2 17/14] fabrics: add transport header and data
 digest
In-Reply-To: <20181120030019.31738-1-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
Message-ID: <20181120030019.31738-19-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

This setting is enabling header and data digest over NVMe/TCP
controllers.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 fabrics.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 3df273894632..1995f15c5e7b 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -62,6 +62,8 @@ static struct config {
 	int  duplicate_connect;
 	int  disable_sqflow;
 	bool persistent;
+	int  hdr_digest;
+	int  data_digest;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -629,7 +631,9 @@ static int build_options(char *argstr, int max_len)
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
 				cfg.duplicate_connect) ||
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
-				cfg.disable_sqflow))
+				cfg.disable_sqflow) ||
+	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
+	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
 		return -EINVAL;
 
 	return 0;
@@ -710,6 +714,20 @@ retry:
 		p += len;
 	}
 
+	if (cfg.hdr_digest) {
+		len = sprintf(p, ",hdr_digest");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
+	if (cfg.data_digest) {
+		len = sprintf(p, ",data_digest");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_LOOP: /* loop */
 		len = sprintf(p, ",transport=loop");
@@ -957,6 +975,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"persistent",  'p', "LIST", CFG_NONE, &cfg.persistent,  no_argument, "persistent discovery connection" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
@@ -1000,6 +1020,8 @@ int connect(const char *desc, int argc, char **argv)
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
 		{"disable_sqflow", 'd', "", CFG_NONE, &cfg.disable_sqflow, no_argument, "disable controller sq flow control (default false)" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
-- 
2.17.1
