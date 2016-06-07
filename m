From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:25 +0200
Subject: [PATCH 09/11] Implement connect command
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-10-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

Example usage:

root at host: nvme connect -t rdma -a 192.168.2.2 -p 1023 -n nqn.testiqn

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
Tested-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
---
 fabrics.c | 35 ++++++++++++++++++++++++++++++++++-
 fabrics.h |  1 +
 nvme.c    |  7 +++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 50dfcd8..84dde2b 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -371,7 +371,7 @@ int discover(const char *desc, int argc, char **argv)
 		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
 			"transport service id (e.g. IP port)" },
 		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
-			"raw" },
+			"raw output file" },
 		{0},
 	};
 
@@ -419,3 +419,36 @@ int discover(const char *desc, int argc, char **argv)
 
 	return ret;
 }
+
+int connect(const char *desc, int argc, char **argv)
+{
+	char argstr[BUF_SIZE];
+	int instance, ret;
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"transport", 't', "LIST", CFG_STRING, &cfg.transport, required_argument,
+			"transport type" },
+		{"nqn", 'n', "LIST", CFG_STRING, &cfg.nqn, required_argument,
+			"nqn name" },
+		{"traddr", 'a', "LIST", CFG_STRING, &cfg.traddr, required_argument,
+			"transport address" },
+		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
+			"transport service id (e.g. IP port)" },
+		{0},
+	};
+
+	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+
+	ret = build_options(argstr, BUF_SIZE);
+	if (ret)
+		return ret;
+
+	if (!cfg.nqn) {
+		fprintf(stderr, "need a -n argument\n");
+		return -EINVAL;
+	}
+
+	instance = add_ctrl(argstr);
+	if (instance < 0)
+		return instance;
+	return 0;
+}
diff --git a/fabrics.h b/fabrics.h
index c80b016..43072a1 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -2,5 +2,6 @@
 #define _DISCOVER_H
 
 extern int discover(const char *desc, int argc, char **argv);
+extern int connect(const char *desc, int argc, char **argv);
 
 #endif
diff --git a/nvme.c b/nvme.c
index 2dd2f3a..902d84b 100644
--- a/nvme.c
+++ b/nvme.c
@@ -115,6 +115,7 @@ static const char nvme_version_string[] = NVME_VERSION;
 	ENTRY(LNVM_BBTBL_GET, "lnvm-diag-bbtbl", "Diagnose bad block table", lnvm_get_bbtbl) \
 	ENTRY(LNVM_BBTBL_SET, "lnvm-diag-set-bbtbl", "Update bad block table", lnvm_set_bbtbl) \
 	ENTRY(DISCOVER, "discover", "Discover NVMeoF subsystems", discover_cmd) \
+	ENTRY(CONNECT, "connect", "Connect to NVMeoF subsystem", connect_cmd) \
 	ENTRY(VERSION, "version", "Shows the program version", version) \
 	ENTRY(HELP, "help", "Display this help", help)
 
@@ -2846,6 +2847,12 @@ static int discover_cmd(int argc, char **argv)
 	return discover(desc, argc, argv);
 }
 
+static int connect_cmd(int argc, char **argv)
+{
+	const char *desc = "Connect to NVMeoF subsystem";
+	return connect(desc, argc, argv);
+}
+
 static void usage()
 {
 	printf("usage: nvme <command> [<device>] [<args>]\n");
-- 
2.1.4
