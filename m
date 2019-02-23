From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:31:16 -0800
Subject: [PATCH rfc nvme-cli 4/5] fabrics: support persistent connections to a
 discovery controller
In-Reply-To: <20190223023117.20517-1-sagi@grimberg.me>
References: <20190223023117.20517-1-sagi@grimberg.me>
Message-ID: <20190223023117.20517-5-sagi@grimberg.me>

Simply don't destroy the discovery controller after getting the
log pages. Note that persistent connection to a discovery subsystem
require to pass in a non-zero kato value, so if not provided we
simply use a default of 30 seconds kato.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 10 +++++++++-
 fabrics.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 029105b227ff..44aee67759c8 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -62,6 +62,7 @@ static struct config {
 	char *raw;
 	char *device;
 	int  duplicate_connect;
+	bool persistent;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -743,7 +744,8 @@ static int do_discover(char *argstr, bool connect)
 		return errno;
 	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
 	free(dev_name);
-	remove_ctrl(instance);
+	if (!cfg.persistent)
+		remove_ctrl(instance);
 
 	switch (ret) {
 	case DISC_OK:
@@ -819,6 +821,9 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (err)
 			continue;
 
+		if (cfg.persistent && !cfg.keep_alive_tmo)
+			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+
 		err = build_options(argstr, BUF_SIZE);
 		if (err) {
 			ret = err;
@@ -855,6 +860,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
+		{"persistent",  'p', "LIST", CFG_NONE, &cfg.persistent,  no_argument, "persistent discovery connection" },
 		{NULL},
 	};
 
@@ -869,6 +875,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		return discover_from_conf_file(desc, argstr,
 				command_line_options, connect);
 	} else {
+		if (cfg.persistent && !cfg.keep_alive_tmo)
+			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
 		ret = build_options(argstr, BUF_SIZE);
 		if (ret)
 			return ret;
diff --git a/fabrics.h b/fabrics.h
index 988f3ef2fbc4..7c1664b80d51 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -1,6 +1,8 @@
 #ifndef _DISCOVER_H
 #define _DISCOVER_H
 
+#define NVMF_DEF_DISC_TMO	30
+
 extern int discover(const char *desc, int argc, char **argv, bool connect);
 extern int connect(const char *desc, int argc, char **argv);
 extern int disconnect(const char *desc, int argc, char **argv);
-- 
2.17.1
