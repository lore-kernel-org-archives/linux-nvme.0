From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:32:53 -0800
Subject: [PATCH nvme-cli rfc 2/6] fabrics: support persistent connections to a
 discovery controller
In-Reply-To: <20190223023257.21227-1-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
Message-ID: <20190223023257.21227-3-sagi@grimberg.me>

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
index ad9a15e72070..b9c5378b8034 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -65,6 +65,7 @@ static struct config {
 	int  disable_sqflow;
 	int  hdr_digest;
 	int  data_digest;
+	bool persistent;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -855,7 +856,8 @@ static int do_discover(char *argstr, bool connect)
 		return errno;
 	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
 	free(dev_name);
-	remove_ctrl(instance);
+	if (!cfg.persistent)
+		remove_ctrl(instance);
 
 	switch (ret) {
 	case DISC_OK:
@@ -931,6 +933,9 @@ static int discover_from_conf_file(const char *desc, char *argstr,
 		if (err)
 			continue;
 
+		if (cfg.persistent && !cfg.keep_alive_tmo)
+			cfg.keep_alive_tmo = NVMF_DEF_DISC_TMO;
+
 		err = build_options(argstr, BUF_SIZE);
 		if (err) {
 			ret = err;
@@ -973,6 +978,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		{"nr-write-queues", 'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
 		{"nr-poll-queues",  'P', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },
 		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
+		{"persistent",  'p', "LIST", CFG_NONE, &cfg.persistent,  no_argument, "persistent discovery connection" },
 		{NULL},
 	};
 
@@ -987,6 +993,8 @@ int discover(const char *desc, int argc, char **argv, bool connect)
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
