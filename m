From: jsmart2021@gmail.com (James Smart)
Date: Thu, 11 Jul 2019 17:31:36 -0700
Subject: [PATCH rfc v2 06/10] nvme-cli: Add routine to compare ctrl_list_item
 to connect args
In-Reply-To: <20190712003140.16221-1-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
Message-ID: <20190712003140.16221-7-jsmart2021@gmail.com>

In preparation for searching controllers to match with connect args:

Create a new routine that receives a structure containing connect
arguments and a device name. The routine will build and fill in a
ctrl_list_item for the device and compare its attributes with the
connect arguments. The routine returns true/false on whether they
match.

Routine is defined as a global as a subsequent patch will use it
from the fabrics routines.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
CC: Sagi Grimberg <sagi at grimberg.me>
CC: Hannes Reinecke <hare at suse.com>
---
 nvme.c | 40 ++++++++++++++++++++++++++++++++++++++++
 nvme.h |  9 +++++++++
 2 files changed, 49 insertions(+)

diff --git a/nvme.c b/nvme.c
index 66ba2fc..ef3c61c 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2010,6 +2010,46 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	return nvme_status_to_errno(ret, false);
 }
 
+static char *nvme_ctrl_dir = "/sys/class/nvme/";
+
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
+	if (get_nvme_ctrl_info(name, nvme_ctrl_dir, ctrl, NVME_NSID_ALL))
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
index 470f702..537b8dd 100644
--- a/nvme.h
+++ b/nvme.h
@@ -179,6 +179,15 @@ enum {
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
+bool ctrl_matches_connectargs(char *name, struct connect_args *args);
 char *__parse_connect_arg(char *conargs, const char delim, const char *fieldnm);
 
 extern const char *conarg_traddr;
-- 
2.13.7
