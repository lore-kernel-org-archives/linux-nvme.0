From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:56:15 -0800
Subject: [PATCH nvme-cli v3 17/13] fabrics: add transport header and data
 digest
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Message-ID: <20181122015615.15763-18-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

This setting is enabling header and data digest over NVMe/TCP
controllers.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 fabrics.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index f8e03de46632..394cba406a88 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -61,6 +61,8 @@ static struct config {
 	char *device;
 	int  duplicate_connect;
 	int  disable_sqflow;
+	int  hdr_digest;
+	int  data_digest;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -615,7 +617,9 @@ static int build_options(char *argstr, int max_len)
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
 				cfg.duplicate_connect) ||
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
-				cfg.disable_sqflow))
+				cfg.disable_sqflow) ||
+	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
+	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
 		return -EINVAL;
 
 	return 0;
@@ -709,6 +713,20 @@ retry:
 		return -EINVAL;
 	p += len;
 
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
 	case NVMF_TRTYPE_RDMA:
 	case NVMF_TRTYPE_TCP:
@@ -929,6 +947,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
@@ -970,6 +990,8 @@ int connect(const char *desc, int argc, char **argv)
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
 		{"disable_sqflow", 'd', "", CFG_NONE, &cfg.disable_sqflow, no_argument, "disable controller sq flow control (default false)" },
+		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
+		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{NULL},
 	};
 
-- 
2.17.1
