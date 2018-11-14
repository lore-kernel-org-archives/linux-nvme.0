From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Nov 2018 10:25:34 -0800
Subject: [PATCH v3 nvme-cli 5/4] fabrics: support fabrics sq flow control
 disable
In-Reply-To: <20181114182534.28807-1-sagi@grimberg.me>
References: <20181114182534.28807-1-sagi@grimberg.me>
Message-ID: <20181114182534.28807-6-sagi@grimberg.me>

If the discovery log entry indicates that the subsystem supports
disabling sq flow control, we ask the host to connect and disable
sq flow control (omit sq_head pointer updates). Also add an option
to explicitly ask for disable_sqflow.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c    | 15 ++++++++++++++-
 linux/nvme.h |  7 ++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 711a755a79e1..f6b060607b26 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -60,6 +60,7 @@ static struct config {
 	char *raw;
 	char *device;
 	int  duplicate_connect;
+	int  disable_sqflow;
 } cfg = { NULL };
 
 #define BUF_SIZE		4096
@@ -129,6 +130,8 @@ static const char * const treqs[] = {
 	[NVMF_TREQ_NOT_SPECIFIED]	= "not specified",
 	[NVMF_TREQ_REQUIRED]		= "required",
 	[NVMF_TREQ_NOT_REQUIRED]	= "not required",
+	[NVMF_TREQ_DISABLE_SQFLOW]	= "not specified, "
+					  "sq flow control disable supported",
 };
 
 static inline const char *treq_str(__u8 treq)
@@ -595,7 +598,9 @@ static int build_options(char *argstr, int max_len)
 	    add_int_argument(&argstr, &max_len, "ctrl_loss_tmo",
 				cfg.ctrl_loss_tmo) ||
 	    add_bool_argument(&argstr, &max_len, "duplicate_connect",
-				cfg.duplicate_connect))
+				cfg.duplicate_connect) ||
+	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
+				cfg.disable_sqflow))
 		return -EINVAL;
 
 	return 0;
@@ -732,6 +737,13 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		return -EINVAL;
 	}
 
+	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW) {
+		len = sprintf(p, ",disable_sqflow");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (discover)
 		return do_discover(argstr, true);
 	else
@@ -935,6 +947,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
 		{"ctrl-loss-tmo",   'l', "LIST", CFG_INT, &cfg.ctrl_loss_tmo,   required_argument, "controller loss timeout period in seconds" },
 		{"duplicate_connect", 'D', "", CFG_NONE, &cfg.duplicate_connect, no_argument, "allow duplicate connections between same transport host and subsystem port" },
+		{"disable_sqflow", 'd', "", CFG_NONE, &cfg.disable_sqflow, no_argument, "disable controller sq flow control (default false)" },
 		{NULL},
 	};
 
diff --git a/linux/nvme.h b/linux/nvme.h
index 1ad970a4c89a..a6a44b066267 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -58,9 +58,10 @@ enum {
 
 /* Transport Requirements codes for Discovery Log Page entry TREQ field */
 enum {
-	NVMF_TREQ_NOT_SPECIFIED	= 0,	/* Not specified */
-	NVMF_TREQ_REQUIRED	= 1,	/* Required */
-	NVMF_TREQ_NOT_REQUIRED	= 2,	/* Not Required */
+	NVMF_TREQ_NOT_SPECIFIED	= 0,		/* Not specified */
+	NVMF_TREQ_REQUIRED	= 1,		/* Required */
+	NVMF_TREQ_NOT_REQUIRED	= 2,		/* Not Required */
+	NVMF_TREQ_DISABLE_SQFLOW = (1 << 2),	/* SQ flow control disable supported */
 };
 
 /* RDMA QP Service Type codes for Discovery Log Page entry TSAS
-- 
2.17.1
