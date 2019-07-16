From: jsmart2021@gmail.com (James Smart)
Date: Tue, 16 Jul 2019 14:12:39 -0700
Subject: [PATCH 08/10] nvme-cli: Expand --device argument processing
In-Reply-To: <20190716211241.7650-1-jsmart2021@gmail.com>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
Message-ID: <20190716211241.7650-9-jsmart2021@gmail.com>

The connect-all --device argument was used to specify a specific device
to be used as the discovery controller. The device is typically a
long-lived discovery controller that posted a discovery event.
No attempt was made to ensure the device is who it is supposed to be
before using it.

Revised the code to use the other arguments in the connect-all request
to validate that the device is the entity that was expected. If the
device doesn't match, the cli will look for an existing matching device
in the system (should be a discovery controller due to nqn) with the
same connect parameters and use it.  If one is not found on the system,
a new discovery controller will be created for the connect-all request.

The revision uses new routines to parse the connect arguments given
in the argstr parameter. As a couple of new fieldnames are needed, the
parse routine constants were expanded for them.

The revision uses the new routines to match the specified device vs
it's attributes as well as the search routine that looks for a device
with the connect arguments.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 fabrics.c | 38 ++++++++++++++++++++++++++++++++++++++
 nvme.c    |  2 ++
 nvme.h    |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index f3afa0b..9a7f832 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -872,6 +872,8 @@ static int connect_ctrls(struct nvmf_disc_rsp_page_hdr *log, int numrec)
 	return ret;
 }
 
+static const char delim_comma  = ',';
+
 static int do_discover(char *argstr, bool connect)
 {
 	struct nvmf_disc_rsp_page_hdr *log = NULL;
@@ -879,6 +881,42 @@ static int do_discover(char *argstr, bool connect)
 	int instance, numrec = 0, ret, err;
 	int status = 0;
 
+	if (cfg.device) {
+		struct connect_args cargs;
+
+		memset(&cargs, 0, sizeof(cargs));
+		cargs.subsysnqn = __parse_connect_arg(argstr, delim_comma,
+						conarg_nqn);
+		cargs.transport = __parse_connect_arg(argstr, delim_comma,
+						conarg_transport);
+		cargs.traddr = __parse_connect_arg(argstr, delim_comma,
+						conarg_traddr);
+		cargs.trsvcid = __parse_connect_arg(argstr, delim_comma,
+						conarg_trsvcid);
+		cargs.host_traddr = __parse_connect_arg(argstr, delim_comma,
+						conarg_host_traddr);
+
+		/*
+		 * if the cfg.device passed in matches the connect args
+		 *    cfg.device is left as-is
+		 * else if there exists a controller that matches the
+		 *         connect args
+		 *    cfg.device is the matching ctrl name
+		 * else if no ctrl matches the connect args
+		 *    cfg.device is set to null. This will attempt to
+		 *    create a new ctrl.
+		 * endif
+		 */
+		if (!ctrl_matches_connectargs(cfg.device, &cargs))
+			cfg.device = find_ctrl_with_connectargs(&cargs);
+
+		free(cargs.subsysnqn);
+		free(cargs.transport);
+		free(cargs.traddr);
+		free(cargs.trsvcid);
+		free(cargs.host_traddr);
+	}
+
 	if (!cfg.device)
 		instance = add_ctrl(argstr);
 	else
diff --git a/nvme.c b/nvme.c
index 3fc2658..2f4bc76 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1549,6 +1549,8 @@ static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 }
 
 static const char delim_space  = ' ';
+const char *conarg_nqn = "nqn";
+const char *conarg_transport = "transport";
 const char *conarg_traddr = "traddr";
 const char *conarg_trsvcid = "trsvcid";
 const char *conarg_host_traddr = "host_traddr";
diff --git a/nvme.h b/nvme.h
index b91a22c..e630b10 100644
--- a/nvme.h
+++ b/nvme.h
@@ -193,6 +193,8 @@ bool ctrl_matches_connectargs(char *name, struct connect_args *args);
 char *find_ctrl_with_connectargs(struct connect_args *args);
 char *__parse_connect_arg(char *conargs, const char delim, const char *fieldnm);
 
+extern const char *conarg_nqn;
+extern const char *conarg_transport;
 extern const char *conarg_traddr;
 extern const char *conarg_trsvcid;
 extern const char *conarg_host_traddr;
-- 
2.13.7
