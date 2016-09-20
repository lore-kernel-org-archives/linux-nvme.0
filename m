From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 20 Sep 2016 08:02:12 -0700
Subject: [PATCH 2/2] nvme-cli/fabrics: Add reconnect-delay param to connect cmd
Message-ID: <20160920150439.D8168E0BC1@smtp.ogc.us>

Added 'reconnect-delay' to 'connect' command so users can specify the
delay time, in seconds, before reconnecting due to a keep alive timeout.

usage examples:

nvme connect --reconnect-delay=30 --transport=rdma --traddr=10.0.1.14 --nqn=test-nvme
nvme connect -r 30 -t rdma -a 10.0.1.14 -n test-nvme


Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 fabrics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index bb144bf..f80ae80 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -52,6 +52,7 @@ struct config {
 	char *hostnqn;
 	char *nr_io_queues;
 	char *keep_alive_tmo;
+	char *reconnect_delay;
 	char *raw;
 	char *device;
 } cfg = { 0 };
@@ -499,6 +500,14 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
+	if (cfg.reconnect_delay) {
+		len = snprintf(argstr, max_len, ",reconnect_delay=%s", cfg.reconnect_delay);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
 	return 0;
 }
 
@@ -735,6 +744,8 @@ int connect(const char *desc, int argc, char **argv)
 			"number of io queues to use (default is core count)" },
 		{"keep-alive-tmo", 'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo, required_argument,
 			"keep alive timeout period in seconds" },
+		{"reconnect-delay", 'r', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument,
+			"reconnect timeout period in seconds" },
 		{0},
 	};
 
-- 
2.7.0
