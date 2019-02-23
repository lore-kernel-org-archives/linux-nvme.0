From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:31:17 -0800
Subject: [PATCH rfc nvme-cli 5/5] fabrics: allow user to retrieve discovery
 log from existing discovery controller
In-Reply-To: <20190223023117.20517-1-sagi@grimberg.me>
References: <20190223023117.20517-1-sagi@grimberg.me>
Message-ID: <20190223023117.20517-6-sagi@grimberg.me>

Simply allow discover to receive the discovery device node name.
Also centralize extraction of controller instance from the controller
name to a common helper.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 44aee67759c8..703020fa5b17 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -172,6 +172,19 @@ static const char *cms_str(__u8 cm)
 
 static int do_discover(char *argstr, bool connect);
 
+static int ctrl_instance(char *device)
+{
+	int ret, instance;
+
+	device = basename(device);
+	ret = sscanf(device, "nvme%d", &instance);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -1;
+	return instance;
+}
+
 static int add_ctrl(const char *argstr)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -736,7 +749,10 @@ static int do_discover(char *argstr, bool connect)
 	char *dev_name;
 	int instance, numrec = 0, ret;
 
-	instance = add_ctrl(argstr);
+	if (!cfg.device)
+		instance = add_ctrl(argstr);
+	else
+		instance = ctrl_instance(cfg.device);
 	if (instance < 0)
 		return instance;
 
@@ -744,7 +760,7 @@ static int do_discover(char *argstr, bool connect)
 		return errno;
 	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
 	free(dev_name);
-	if (!cfg.persistent)
+	if (!cfg.device && !cfg.persistent)
 		remove_ctrl(instance);
 
 	switch (ret) {
@@ -857,6 +873,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"hostnqn",     'q', "LIST", CFG_STRING, &cfg.hostnqn,     required_argument, "user-defined hostnqn (if default not used)" },
 		{"hostid",      'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
+		{"device",      'd', "LIST", CFG_STRING, &cfg.device, required_argument, "use existing discovery contoller device" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
@@ -1001,15 +1018,10 @@ static int disconnect_by_nqn(char *nqn)
 static int disconnect_by_device(char *device)
 {
 	int instance;
-	int ret;
-
-	device = basename(device);
-	ret = sscanf(device, "nvme%d", &instance);
-	if (ret < 0)
-		return ret;
-	if (!ret)
-		return -1;
 
+	instance = ctrl_instance(device);
+	if (instance < 0)
+		return instance;
 	return remove_ctrl(instance);
 }
 
-- 
2.17.1
