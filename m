From: jsmart2021@gmail.com (James Smart)
Date: Thu,  1 Aug 2019 16:13:44 -0700
Subject: [PATCH v3 06/10] nvme-cli: Add routine to compare ctrl_list_item to
 connect args
In-Reply-To: <20190801231348.21397-1-jsmart2021@gmail.com>
References: <20190801231348.21397-1-jsmart2021@gmail.com>
Message-ID: <20190801231348.21397-7-jsmart2021@gmail.com>

In preparation for searching controllers to match with connect args:

Create a new routine that receives a structure containing connect
arguments and a device name. The routine will build and fill in a
ctrl_list_item for the device and compare its attributes with the
connect arguments. The routine returns true/false on whether they
match.

Routine is defined as a global as a subsequent patch will use it
from the fabrics routines.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c |  1 -
 nvme.c    | 38 ++++++++++++++++++++++++++++++++++++++
 nvme.h    | 11 +++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index d92c2ff..f3afa0b 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -74,7 +74,6 @@ static struct config {
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
 #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
 #define PATH_NVMF_HOSTID	"/etc/nvme/hostid"
-#define SYS_NVME		"/sys/class/nvme"
 #define MAX_DISC_ARGS		10
 #define MAX_DISC_RETRIES	10
 
diff --git a/nvme.c b/nvme.c
index b93d9da..875b2c8 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2010,6 +2010,44 @@ ret:
 	return nvme_status_to_errno(ret, false);
 }
 
+/*
+ * Given a controller name, create a ctrl_list_item with its
+ * attributes and compare the attributes against the connect args
+ * given.
+ * Return true/false based on whether it matches
+ */
+bool ctrl_matches_connectargs(char *name, struct connect_args *args)
+{
+	struct ctrl_list_item *ctrl;
+	bool found = false;
+
+	ctrl = malloc(sizeof(*ctrl));
+	if (!ctrl) {
+		fprintf(stderr, "Failed to allocate controller list element\n");
+		return false;
+	}
+	memset(ctrl, 0, sizeof(*ctrl));
+
+	if (get_nvme_ctrl_info(name, SYS_NVME, ctrl, NVME_NSID_ALL))
+		goto cleanup_exit;
+
+	if (!strcmp(ctrl->subsysnqn, args->subsysnqn) &&
+	    !strcmp(ctrl->transport, args->transport) &&
+	    (!strcmp(ctrl->traddr, args->traddr) ||
+	     !strcmp(args->traddr, "none")) &&
+	    (!strcmp(ctrl->trsvcid, args->trsvcid) ||
+	     !strcmp(args->trsvcid, "none")) &&
+	    (!strcmp(ctrl->host_traddr, args->host_traddr) ||
+	     !strcmp(args->host_traddr, "none")))
+		found = true;
+
+cleanup_exit:
+	free_ctrl_list_item(ctrl);
+	free(ctrl);
+
+	return found;
+}
+
 int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root))
 {
 	const char *desc = "Send an Identify Controller command to "\
diff --git a/nvme.h b/nvme.h
index 470f702..2fecb68 100644
--- a/nvme.h
+++ b/nvme.h
@@ -179,6 +179,17 @@ enum {
 	BINARY,
 };
 
+struct connect_args {
+	char *subsysnqn;
+	char *transport;
+	char *traddr;
+	char *trsvcid;
+	char *host_traddr;
+};
+
+#define SYS_NVME		"/sys/class/nvme"
+
+bool ctrl_matches_connectargs(char *name, struct connect_args *args);
 char *__parse_connect_arg(char *conargs, const char delim, const char *fieldnm);
 
 extern const char *conarg_traddr;
-- 
2.13.7
