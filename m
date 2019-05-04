From: jsmart2021@gmail.com (James Smart)
Date: Fri,  3 May 2019 17:04:54 -0700
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address discovery
 controller by persistent name
In-Reply-To: <20190504000456.3888-1-jsmart2021@gmail.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
Message-ID: <20190504000456.3888-4-jsmart2021@gmail.com>

To support discovery (connect/connect-all) to operate against a
persistent discovery controller, let the discovery controller to
be specified by its device node name rather than new connection
attributes.

Also centralize extraction of controller instance from the controller
name to a common helper.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
Patch originated from Sagi in an RFC
fix merge issue
fix contoller->controller
add cfg.device check for "none"
---
 fabrics.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 6fe1343..a80c11c 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -189,6 +189,19 @@ static const char *cms_str(__u8 cm)
 
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
@@ -851,7 +864,10 @@ static int do_discover(char *argstr, bool connect)
 	char *dev_name;
 	int instance, numrec = 0, ret, err;
 
-	instance = add_ctrl(argstr);
+	if (!cfg.device)
+		instance = add_ctrl(argstr);
+	else
+		instance = ctrl_instance(cfg.device);
 	if (instance < 0)
 		return instance;
 
@@ -859,7 +875,7 @@ static int do_discover(char *argstr, bool connect)
 		return -errno;
 	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
 	free(dev_name);
-	if (!cfg.persistent) {
+	if (!cfg.device && !cfg.persistent) {
 		err = remove_ctrl(instance);
 		if (err)
 			return err;
@@ -975,6 +991,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"hostnqn",     'q', "LIST", CFG_STRING, &cfg.hostnqn,     required_argument, "user-defined hostnqn (if default not used)" },
 		{"hostid",      'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"raw",         'r', "LIST", CFG_STRING, &cfg.raw,         required_argument, "raw output file" },
+		{"device",      'd', "LIST", CFG_STRING, &cfg.device, required_argument, "use existing discovery controller device" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
@@ -993,6 +1010,9 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 	if (ret)
 		return ret;
 
+	if (cfg.device && !strcmp(cfg.device, "none"))
+		cfg.device = NULL;
+
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
 	if (!cfg.transport && !cfg.traddr) {
@@ -1130,15 +1150,10 @@ static int disconnect_by_nqn(char *nqn)
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
2.13.7
