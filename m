From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 16:18:15 -0700
Subject: [PATCH v2] nvme-cli: add duplicate_connect parameter support
Message-ID: <20171020231815.3288-1-jsmart2021@gmail.com>

Add support for the duplicate_connect parameter for the fabrics
device.

Rather than add yet another 6-line code block, created a small helper
routine invoked for each argument option.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2:
  converted to a boolean arg (true if present).
  helper expanded for different arg types
---
 fabrics.c | 140 ++++++++++++++++++++++++--------------------------------------
 1 file changed, 54 insertions(+), 86 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 5dec9f4..4bdaaf2 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -61,6 +61,7 @@ static struct config {
 	char *ctrl_loss_tmo;
 	char *raw;
 	char *device;
+	int  duplicate_connect;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -484,6 +485,38 @@ out:
 	return ret;
 }
 
+static int
+add_bool_argument(char **argstr, int *max_len, char *arg_str, bool arg)
+{
+	int len;
+
+	if (arg) {
+		len = snprintf(*argstr, *max_len, ",%s", arg_str);
+		if (len < 0)
+			return -EINVAL;
+		*argstr += len;
+		*max_len -= len;
+	}
+
+	return 0;
+}
+
+static int
+add_argument(char **argstr, int *max_len, char *arg_str, char *arg)
+{
+	int len;
+
+	if (arg) {
+		len = snprintf(*argstr, *max_len, ",%s=%s", arg_str, arg);
+		if (len < 0)
+			return -EINVAL;
+		*argstr += len;
+		*max_len -= len;
+	}
+
+	return 0;
+}
+
 static int build_options(char *argstr, int max_len)
 {
 	int len;
@@ -500,99 +533,33 @@ static int build_options(char *argstr, int max_len)
 		}
 	}
 
+	/* always specify nqn as first arg - this will init the string */
 	len = snprintf(argstr, max_len, "nqn=%s", cfg.nqn);
 	if (len < 0)
 		return -EINVAL;
 	argstr += len;
 	max_len -= len;
 
-	len = snprintf(argstr, max_len, ",transport=%s", cfg.transport);
-	if (len < 0)
+	if (add_argument(&argstr, &max_len, "transport", cfg.transport) ||
+	    add_argument(&argstr, &max_len, "traddr", cfg.traddr) ||
+	    add_argument(&argstr, &max_len, "host_traddr", cfg.host_traddr) ||
+	    add_argument(&argstr, &max_len, "trsvcid", cfg.trsvcid) ||
+	    ((cfg.hostnqn || nvmf_hostnqn_file()) &&
+		    add_argument(&argstr, &max_len, "hostnqn", cfg.hostnqn)) ||
+	    ((cfg.hostid || nvmf_hostid_file()) &&
+		    add_argument(&argstr, &max_len, "hostid", cfg.hostid)) ||
+	    add_argument(&argstr, &max_len, "nr_io_queues",
+				cfg.nr_io_queues) ||
+	    add_argument(&argstr, &max_len, "queue_size", cfg.queue_size) ||
+	    add_argument(&argstr, &max_len, "keep_alive_tmo",
+				cfg.keep_alive_tmo) ||
+	    add_argument(&argstr, &max_len, "reconnect_delay",
+				cfg.reconnect_delay) ||
+	    add_argument(&argstr, &max_len, "ctrl_loss_tmo",
+				cfg.ctrl_loss_tmo) ||
+	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
+				cfg.duplicate_connect))
 		return -EINVAL;
-	argstr += len;
-	max_len -= len;
-
-	if (cfg.traddr) {
-		len = snprintf(argstr, max_len, ",traddr=%s", cfg.traddr);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.host_traddr) {
-		len = snprintf(argstr, max_len, ",host_traddr=%s", cfg.host_traddr);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.trsvcid) {
-		len = snprintf(argstr, max_len, ",trsvcid=%s", cfg.trsvcid);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.hostnqn || nvmf_hostnqn_file()) {
-		len = snprintf(argstr, max_len, ",hostnqn=%s", cfg.hostnqn);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.hostid || nvmf_hostid_file()) {
-		len = snprintf(argstr, max_len, ",hostid=%s", cfg.hostid);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.nr_io_queues) {
-		len = snprintf(argstr, max_len, ",nr_io_queues=%s",
-				cfg.nr_io_queues);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.queue_size) {
-		len = snprintf(argstr, max_len, ",queue_size=%s",
-				cfg.queue_size);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.keep_alive_tmo) {
-		len = snprintf(argstr, max_len, ",keep_alive_tmo=%s", cfg.keep_alive_tmo);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.reconnect_delay) {
-		len = snprintf(argstr, max_len, ",reconnect_delay=%s", cfg.reconnect_delay);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
-
-	if (cfg.ctrl_loss_tmo) {
-		len = snprintf(argstr, max_len, ",ctrl_loss_tmo=%s", cfg.ctrl_loss_tmo);
-		if (len < 0)
-			return -EINVAL;
-		argstr += len;
-		max_len -= len;
-	}
 
 	return 0;
 }
@@ -888,6 +855,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"keep-alive-tmo",  'k', "LIST", CFG_STRING, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_STRING, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_STRING, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
+		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
 		{NULL},
 	};
 
-- 
2.13.1
