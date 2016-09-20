From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 20 Sep 2016 08:01:54 -0700
Subject: [PATCH 1/2] nvme-cli/fabrics: Add keep-alive-tmo param to connect cmd
Message-ID: <20160920150437.CA26EE0BC1@smtp.ogc.us>

Added 'keep-alive-tmo' to 'connect' command so users can specify the
keep alive timeout period.

usage examples:

nvme connect --keep-alive-tmo=30 --transport=rdma --traddr=10.0.1.14 --nqn=test-nvme
nvme connect -k 30 -t rdma -a 10.0.1.14 -n test-nvme

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 fabrics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 18e961c..bb144bf 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -51,6 +51,7 @@ struct config {
 	char *trsvcid;
 	char *hostnqn;
 	char *nr_io_queues;
+	char *keep_alive_tmo;
 	char *raw;
 	char *device;
 } cfg = { 0 };
@@ -490,6 +491,14 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
+	if (cfg.keep_alive_tmo) {
+		len = snprintf(argstr, max_len, ",keep_alive_tmo=%s", cfg.keep_alive_tmo);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
 	return 0;
 }
 
@@ -724,6 +733,8 @@ int connect(const char *desc, int argc, char **argv)
 			"user-defined hostnqn" },
 		{"nr-io-queues", 'i', "LIST", CFG_STRING, &cfg.nr_io_queues, required_argument,
 			"number of io queues to use (default is core count)" },
+		{"keep-alive-tmo", 'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo, required_argument,
+			"keep alive timeout period in seconds" },
 		{0},
 	};
 
-- 
2.7.0
