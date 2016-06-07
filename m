From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:27 +0200
Subject: [PATCH 11/11] implement the connect-all command
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-12-git-send-email-hch@lst.de>

Connects to all controllers pointed to by the discovery service.
Includes following referrals.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Ming Lin <ming.l at samsung.com>
Tested-by: Ming Lin <ming.l at samsung.com>
---
 fabrics.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 fabrics.h |   2 +-
 nvme.c    |   9 ++++-
 3 files changed, 113 insertions(+), 24 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 0a60258..c643598 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -64,6 +64,8 @@ static const match_table_t opt_tokens = {
 	{ OPT_ERR,		NULL		},
 };
 
+static int do_discover(char *argstr, bool connect);
+
 static int add_ctrl(const char *argstr)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -358,31 +360,82 @@ static int build_options(char *argstr, int max_len)
 	return 0;
 }
 
-int discover(const char *desc, int argc, char **argv)
+static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 {
-	char argstr[BUF_SIZE];
-	struct nvmf_disc_rsp_page_hdr *log = NULL;
-	char *dev_name;
-	int instance, numrec = 0, ret;
-	const struct argconfig_commandline_options command_line_options[] = {
-		{"transport", 't', "LIST", CFG_STRING, &cfg.transport, required_argument,
-			"transport type" },
-		{"traddr", 'a', "LIST", CFG_STRING, &cfg.traddr, required_argument,
-			"transport address" },
-		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
-			"transport service id (e.g. IP port)" },
-		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
-			"raw output file" },
-		{0},
-	};
+	char argstr[BUF_SIZE], *p = argstr;
+	bool discover = false;
+	int len;
 
-	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	switch (e->nqntype) {
+	case NVME_NQN_DISC:
+		discover = true;
+	case NVME_NQN_NVME:
+		break;
+	default:
+		fprintf(stderr, "skipping unsupported NQNtype %d\n",
+			 e->nqntype);
+		return -EINVAL;
+	}
 
-	cfg.nqn = NVME_DISC_SUBSYS_NAME;
+	len = sprintf(p, "nqn=%s", e->subnqn);
+	if (len < 0)
+		return -EINVAL;
+	p += len;
 
-	ret = build_options(argstr, BUF_SIZE);
-	if (ret)
-		return ret;
+	switch (e->trtype) {
+	case NVMF_TRTYPE_LOOP: /* loop */
+		len = sprintf(p, ",transport=loop");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+		/* we can safely ignore the rest of the entries */
+		break;
+	case NVMF_TRTYPE_RDMA:
+		if (e->adrfam != NVMF_ADDR_FAMILY_IP4) {
+			fprintf(stderr, "skipping unsupported adrfam\n");
+			return -EINVAL;
+		}
+
+		len = sprintf(p, ",transport=rdma");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+
+		len = sprintf(p, ",traddr=%s", e->traddr);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+
+		len = sprintf(p, ",trsvcid=%s", e->trsvcid);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+		break;
+	default:
+		fprintf(stderr, "skipping unsupported transport %d\n",
+				 e->trtype);
+		return -EINVAL;
+	}
+
+	if (discover)
+		return do_discover(argstr, true);
+	else
+		return add_ctrl(argstr);
+}
+
+static void connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
+{
+	int i;
+
+	for (i = 0; i < numrec; i++)
+		connect_ctrl(&log->entries[i]);
+}
+
+static int do_discover(char *argstr, bool connect)
+{
+	struct nvmf_disc_rsp_page_hdr *log = NULL;
+	char *dev_name;
+	int instance, numrec = 0, ret;
 
 	instance = add_ctrl(argstr);
 	if (instance < 0)
@@ -396,7 +449,9 @@ int discover(const char *desc, int argc, char **argv)
 
 	switch (ret) {
 	case DISC_OK:
-		if (cfg.raw)
+		if (connect)
+			connect_ctrls(log, numrec);
+		else if (cfg.raw)
 			save_discovery_log(log, numrec);
 		else
 			print_discovery_log(log, numrec);
@@ -421,6 +476,33 @@ int discover(const char *desc, int argc, char **argv)
 	return ret;
 }
 
+int discover(const char *desc, int argc, char **argv, bool connect)
+{
+	char argstr[BUF_SIZE];
+	int ret;
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"transport", 't', "LIST", CFG_STRING, &cfg.transport, required_argument,
+			"transport type" },
+		{"traddr", 'a', "LIST", CFG_STRING, &cfg.traddr, required_argument,
+			"transport address" },
+		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid, required_argument,
+			"transport service id (e.g. IP port)" },
+		{"raw", 'r', "LIST", CFG_STRING, &cfg.raw, required_argument,
+			"raw output file" },
+		{0},
+	};
+
+	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+
+	cfg.nqn = NVME_DISC_SUBSYS_NAME;
+
+	ret = build_options(argstr, BUF_SIZE);
+	if (ret)
+		return ret;
+
+	return do_discover(argstr, connect);
+}
+
 int connect(const char *desc, int argc, char **argv)
 {
 	char argstr[BUF_SIZE];
diff --git a/fabrics.h b/fabrics.h
index 7e3eb19..91aec90 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -1,7 +1,7 @@
 #ifndef _DISCOVER_H
 #define _DISCOVER_H
 
-extern int discover(const char *desc, int argc, char **argv);
+extern int discover(const char *desc, int argc, char **argv, bool connect);
 extern int connect(const char *desc, int argc, char **argv);
 extern int disconnect(const char *desc, int argc, char **argv);
 
diff --git a/nvme.c b/nvme.c
index e403022..06799a1 100644
--- a/nvme.c
+++ b/nvme.c
@@ -115,6 +115,7 @@ static const char nvme_version_string[] = NVME_VERSION;
 	ENTRY(LNVM_BBTBL_GET, "lnvm-diag-bbtbl", "Diagnose bad block table", lnvm_get_bbtbl) \
 	ENTRY(LNVM_BBTBL_SET, "lnvm-diag-set-bbtbl", "Update bad block table", lnvm_set_bbtbl) \
 	ENTRY(DISCOVER, "discover", "Discover NVMeoF subsystems", discover_cmd) \
+	ENTRY(CONNECT_ALL, "connect-all", "Discover and Connect to NVMeoF subsystems", connect_all_cmd) \
 	ENTRY(CONNECT, "connect", "Connect to NVMeoF subsystem", connect_cmd) \
 	ENTRY(DISCONNECT, "disconnect", "Disconnect from NVMeoF subsystem", disconnect_cmd) \
 	ENTRY(VERSION, "version", "Shows the program version", version) \
@@ -2845,7 +2846,13 @@ static int lnvm_set_bbtbl(int argc, char **argv)
 static int discover_cmd(int argc, char **argv)
 {
 	const char *desc = "Send command to discovery service.";
-	return discover(desc, argc, argv);
+	return discover(desc, argc, argv, false);
+}
+
+static int connect_all_cmd(int argc, char **argv)
+{
+	const char *desc = "Discover NVMeoF subsystems and connect to them";
+	return discover(desc, argc, argv, true);
 }
 
 static int connect_cmd(int argc, char **argv)
-- 
2.1.4
