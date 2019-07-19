From: jsmart2021@gmail.com (James Smart)
Date: Fri, 19 Jul 2019 15:53:00 -0700
Subject: [PATCH v2 05/10] nvme-cli: extend ctrl_list_item for connect
 attributes
In-Reply-To: <20190719225305.11397-1-jsmart2021@gmail.com>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
Message-ID: <20190719225305.11397-6-jsmart2021@gmail.com>

In preparation for searching controllers to match with connect args:

Extend the ctrl_list_item with elements that can be compared against
connect arguments. Extend the get_nvme_ctrl_info() routine to set
the fields.

subsysnqn was added as the ctrl_list_item may now be used outside of
a subsystem listing.

traddr, trsvid, and host_traddr are added. Their values come from
the address attribute.  A new parsing routine was added that extracts
the values from the address string.

The new parsing routine and supporting field names strings are
declared as a global interface as a subsequent patch will call it
from the fabrics routines.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 nvme.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 nvme.h | 10 ++++++++++
 2 files changed, 82 insertions(+)

diff --git a/nvme.c b/nvme.c
index dabbbe0..66ba2fc 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1542,6 +1542,64 @@ static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 	free(ctrls->address);
 	free(ctrls->state);
 	free(ctrls->ana_state);
+	free(ctrls->subsysnqn);
+	free(ctrls->traddr);
+	free(ctrls->trsvcid);
+	free(ctrls->host_traddr);
+}
+
+static const char delim_space  = ' ';
+const char *conarg_traddr = "traddr";
+const char *conarg_trsvcid = "trsvcid";
+const char *conarg_host_traddr = "host_traddr";
+
+/*
+ * parse strings with connect arguments to find a particular field.
+ * If field found, return string containing field value. If field
+ * not found, return an empty string.
+ */
+char *__parse_connect_arg(char *conargs, const char delim, const char *fieldnm)
+{
+	char *s, *e;
+	size_t cnt;
+
+	/*
+	 * There are field name overlaps: traddr and host_traddr.
+	 * By chance, both connect arg strings are set up to
+	 * have traddr field followed by host_traddr field. Thus field
+	 * name matching doesn't overlap in the searches. Technically,
+	 * as is, the loop and delimiter checking isn't necessary.
+	 * However, better to be prepared.
+	 */
+	do {
+		s = strstr(conargs, fieldnm);
+		if (!s)
+			goto empty_field;
+		/* validate prior character is delimiter */
+		if (s == conargs || *(s - 1) == delim) {
+			/* match requires next character to be assignment */
+			s += strlen(fieldnm);
+			if (*s == '=')
+				/* match */
+				break;
+		}
+		/* field overlap: seek to delimiter and keep looking */
+		conargs = strchr(s, delim);
+		if (!conargs)
+			goto empty_field;
+		conargs++;	/* skip delimiter */
+	} while (1);
+	s++;		/* skip assignment character */
+	e = strchr(s, delim);
+	if (e)
+		cnt = e - s;
+	else
+		cnt = strlen(s);
+
+	return strndup(s, cnt);
+
+empty_field:
+	return strdup("\0");
 }
 
 static int get_nvme_ctrl_info(char *name, char *path,
@@ -1577,6 +1635,20 @@ static int get_nvme_ctrl_info(char *name, char *path,
 	if (nsid != NVME_NSID_ALL)
 		ctrl->ana_state = get_nvme_ctrl_path_ana_state(ctrl_path, nsid);
 
+	ctrl->subsysnqn = get_nvme_ctrl_attr(ctrl_path, "subsysnqn");
+	if (!ctrl->subsysnqn) {
+		fprintf(stderr, "%s: failed to get controller subsysnqn.\n",
+			ctrl->name);
+		goto free_ctrl_items;
+	}
+
+	ctrl->traddr = __parse_connect_arg(ctrl->address, delim_space,
+					conarg_traddr);
+	ctrl->trsvcid = __parse_connect_arg(ctrl->address, delim_space,
+					conarg_trsvcid);
+	ctrl->host_traddr = __parse_connect_arg(ctrl->address, delim_space,
+					conarg_host_traddr);
+
 	return 0;	/* success */
 
 free_ctrl_items:
diff --git a/nvme.h b/nvme.h
index 3409515..470f702 100644
--- a/nvme.h
+++ b/nvme.h
@@ -160,6 +160,10 @@ struct ctrl_list_item {
 	char *transport;
 	char *state;
 	char *ana_state;
+	char *subsysnqn;
+	char *traddr;
+	char *trsvcid;
+	char *host_traddr;
 };
 
 struct subsys_list_item {
@@ -175,6 +179,12 @@ enum {
 	BINARY,
 };
 
+char *__parse_connect_arg(char *conargs, const char delim, const char *fieldnm);
+
+extern const char *conarg_traddr;
+extern const char *conarg_trsvcid;
+extern const char *conarg_host_traddr;
+
 void register_extension(struct plugin *plugin);
 
 #include "argconfig.h"
-- 
2.13.7
