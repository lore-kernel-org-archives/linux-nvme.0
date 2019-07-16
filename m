From: jsmart2021@gmail.com (James Smart)
Date: Tue, 16 Jul 2019 14:12:38 -0700
Subject: [PATCH 07/10] nvme-cli: Add routine to search for controller with
 specific attributes
In-Reply-To: <20190716211241.7650-1-jsmart2021@gmail.com>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
Message-ID: <20190716211241.7650-8-jsmart2021@gmail.com>

In preparation for searching controllers to match with connect args:

Create a new routine find_ctrl_with_connectargs() that will search the
controllers that exist in the system to find one that has attributes
that match the connect arguments specified.  If found, the routine
returns the controller name ("nvme?"). If not found, a NULL is returned.

Routine is defined as a global as a subsequent patch will use it
from the fabrics routines.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 nvme.c | 37 +++++++++++++++++++++++++++++++++++++
 nvme.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/nvme.c b/nvme.c
index 7f706c8..3fc2658 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2048,6 +2048,43 @@ cleanup_exit:
 	return found;
 }
 
+/*
+ * Look through the system to find an existing controller whose
+ * attributes match the connect arguments specified
+ * If found, a string containing the controller name (ex: "nvme?")
+ * is returned.
+ * If not found, a NULL is returned.
+ */
+char *find_ctrl_with_connectargs(struct connect_args *args)
+{
+	struct dirent **devices;
+	char *devname = NULL;
+	int i, n;
+
+	n = scandir(nvme_ctrl_dir, &devices, scan_ctrls_filter, alphasort);
+	if (n < 0) {
+		fprintf(stderr, "no NVMe controller(s) detected.\n");
+		return NULL;
+	}
+
+	for (i = 0; i < n; i++) {
+		if (ctrl_matches_connectargs(devices[i]->d_name, args)) {
+			devname = strdup(devices[i]->d_name);
+			if (devname == NULL)
+				fprintf(stderr, "no memory for ctlr name %s\n",
+						devices[i]->d_name);
+			goto cleanup_devices;
+		}
+	}
+
+cleanup_devices:
+	for (i = 0; i < n; i++)
+		free(devices[i]);
+	free(devices);
+
+	return devname;
+}
+
 int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin, void (*vs)(__u8 *vs, struct json_object *root))
 {
 	const char *desc = "Send an Identify Controller command to "\
diff --git a/nvme.h b/nvme.h
index 2fecb68..b91a22c 100644
--- a/nvme.h
+++ b/nvme.h
@@ -190,6 +190,7 @@ struct connect_args {
 #define SYS_NVME		"/sys/class/nvme"
 
 bool ctrl_matches_connectargs(char *name, struct connect_args *args);
+char *find_ctrl_with_connectargs(struct connect_args *args);
 char *__parse_connect_arg(char *conargs, const char delim, const char *fieldnm);
 
 extern const char *conarg_traddr;
-- 
2.13.7
