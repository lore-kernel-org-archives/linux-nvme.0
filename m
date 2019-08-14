From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 14 Aug 2019 13:19:36 +0300
Subject: [PATCH] nvme-cli/fabrics: Add tos param to connect cmd
In-Reply-To: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
References: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
Message-ID: <1565777981-18755-2-git-send-email-israelr@mellanox.com>

Added 'tos' to 'connect' command so users can specify the type of service.

usage examples:
nvme connect --tos=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
nvme connect -T 0 -t rdma -a 10.0.1.1 -n test_nvme

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 fabrics.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 333669f..f952722 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -60,6 +60,7 @@ static struct config {
 	int  keep_alive_tmo;
 	int  reconnect_delay;
 	int  ctrl_loss_tmo;
+	int  tos;
 	char *raw;
 	char *device;
 	int  duplicate_connect;
@@ -576,11 +577,12 @@ add_bool_argument(char **argstr, int *max_len, char *arg_str, bool arg)
 }
 
 static int
-add_int_argument(char **argstr, int *max_len, char *arg_str, int arg)
+add_int_argument(char **argstr, int *max_len, char *arg_str, int arg,
+		 bool allow_zero)
 {
 	int len;
 
-	if (arg) {
+	if ((arg && !allow_zero) || (arg != -1 && allow_zero)) {
 		len = snprintf(*argstr, *max_len, ",%s=%d", arg_str, arg);
 		if (len < 0)
 			return -EINVAL;
@@ -640,21 +642,23 @@ static int build_options(char *argstr, int max_len, bool discover)
 		    add_argument(&argstr, &max_len, "hostid", cfg.hostid)) ||
 	    (!discover &&
 	      add_int_argument(&argstr, &max_len, "nr_io_queues",
-				cfg.nr_io_queues)) ||
+				cfg.nr_io_queues, false)) ||
 	    add_int_argument(&argstr, &max_len, "nr_write_queues",
-				cfg.nr_write_queues) ||
+				cfg.nr_write_queues, false) ||
 	    add_int_argument(&argstr, &max_len, "nr_poll_queues",
-				cfg.nr_poll_queues) ||
+				cfg.nr_poll_queues, false) ||
 	    (!discover &&
 	      add_int_argument(&argstr, &max_len, "queue_size",
-				cfg.queue_size)) ||
+				cfg.queue_size, false)) ||
 	    (!discover &&
 	      add_int_argument(&argstr, &max_len, "keep_alive_tmo",
-				cfg.keep_alive_tmo)) ||
+				cfg.keep_alive_tmo, false)) ||
 	    add_int_argument(&argstr, &max_len, "reconnect_delay",
-				cfg.reconnect_delay) ||
+				cfg.reconnect_delay, false) ||
 	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
-				cfg.ctrl_loss_tmo) ||
+				cfg.ctrl_loss_tmo, false) ||
+	    add_int_argument(&argstr, &max_len, "tos",
+				cfg.tos, true) ||
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
 				cfg.duplicate_connect) ||
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
@@ -749,6 +753,13 @@ retry:
 		p += len;
 	}
 
+	if (cfg.tos != -1) {
+		len = sprintf(p, ",tos=%d", cfg.tos);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (cfg.keep_alive_tmo && !discover) {
 		len = sprintf(p, ",keep_alive_tmo=%d", cfg.keep_alive_tmo);
 		if (len < 0)
@@ -1065,6 +1076,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
+		{"tos",             'T', "LIST", CFG_INT, &cfg.tos,             required_argument, "type of service" },
 		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
 		{"data_digest", 'G', "", CFG_NONE, &cfg.data_digest, no_argument, "enable transport protocol data digest (TCP transport)" },
 		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
@@ -1076,6 +1088,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{NULL},
 	};
 
+	cfg.tos = -1;
 	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
 			sizeof(cfg));
 	if (ret)
@@ -1122,6 +1135,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
+		{"tos",             'T', "LIST", CFG_INT, &cfg.tos,             required_argument, "type of service" },
 		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
 		{"disable_sqflow", 'd', "", CFG_NONE, &cfg.disable_sqflow, no_argument, "disable controller sq flow control (default false)" },
 		{"hdr_digest", 'g', "", CFG_NONE, &cfg.hdr_digest, no_argument, "enable transport protocol header digest (TCP transport)" },
@@ -1129,6 +1143,7 @@ int connect(const char *desc, int argc, char **argv)
 		{NULL},
 	};
 
+	cfg.tos = -1;
 	ret = argconfig_parse(argc, argv, desc, command_line_options, &cfg,
 			sizeof(cfg));
 	if (ret)
-- 
1.8.3.1
