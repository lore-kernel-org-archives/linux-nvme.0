From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 13 Aug 2017 18:45:04 +0300
Subject: [PATCH] nvme-cli/fabrics: Add ctrl-loss-tmo param to connect cmd
Message-ID: <1502639104-27315-1-git-send-email-maxg@mellanox.com>

From: Nitzan Carmi <nitzanc@mellanox.com>

Added 'ctrl-loss-tmo' to 'connect' command so users can specify the
controller lost timeout period.

usage examples:
nvme connect --ctrl-loss-tmo=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
nvme connect -l 0 -t rdma -a 10.0.1.1 -n test_nvme

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 fabrics.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 9ed1127..4871e17 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -58,6 +58,7 @@ static struct config {
 	char *queue_size;
 	char *keep_alive_tmo;
 	char *reconnect_delay;
+	char *ctrl_loss_tmo;
 	char *raw;
 	char *device;
 } cfg = { NULL };
@@ -585,6 +586,14 @@ static int build_options(char *argstr, int max_len)
 		max_len -= len;
 	}
 
+	if (cfg.ctrl_loss_tmo) {
+		len = snprintf(argstr, max_len, ",ctrl_loss_tmo=%s", cfg.ctrl_loss_tmo);
+		if (len < 0)
+			return -EINVAL;
+		argstr += len;
+		max_len -= len;
+	}
+
 	return 0;
 }
 
@@ -863,6 +872,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"queue-size",      'Q', "LIST", CFG_STRING, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
+		{"ctrl-loss-tmo",   'l', "LIST", CFG_STRING, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{NULL},
 	};
 
-- 
2.9.4
