From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 20 May 2019 03:39:13 +0900
Subject: [PATCH V3 4/4] fabrics: Return errno mapped for fabrics error status
In-Reply-To: <20190519183913.3493-1-minwoo.im.dev@gmail.com>
References: <20190519183913.3493-1-minwoo.im.dev@gmail.com>
Message-ID: <20190519183913.3493-5-minwoo.im.dev@gmail.com>

If discover has been failed due to a nvme status, it will be returned to
main() with mapped value for fabrics get log page command.

Now connect command related status cannot be added in this patch because
kernel is not currently returning the nvme status, it's instead
returning -EIO if fails.  errno for connect command can be added once
kernel is ready to return the proper value for nvme status.

Cc: Keith Busch <keith.busch at intel.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 fabrics.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 511de06..5e16f09 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -35,6 +35,7 @@
 
 #include "parser.h"
 #include "nvme-ioctl.h"
+#include "nvme-status.h"
 #include "fabrics.h"
 
 #include "nvme.h"
@@ -295,7 +296,7 @@ enum {
 };
 
 static int nvmf_get_log_page_discovery(const char *dev_path,
-		struct nvmf_disc_rsp_page_hdr **logp, int *numrec)
+		struct nvmf_disc_rsp_page_hdr **logp, int *numrec, int *status)
 {
 	struct nvmf_disc_rsp_page_hdr *log;
 	unsigned int hdr_size;
@@ -400,6 +401,7 @@ out_free_log:
 out_close:
 	close(fd);
 out:
+	*status = nvme_status_to_errno(error, true);
 	return error;
 }
 
@@ -849,6 +851,7 @@ static int do_discover(char *argstr, bool connect)
 	struct nvmf_disc_rsp_page_hdr *log = NULL;
 	char *dev_name;
 	int instance, numrec = 0, ret, err;
+	int status = 0;
 
 	instance = add_ctrl(argstr);
 	if (instance < 0)
@@ -856,7 +859,7 @@ static int do_discover(char *argstr, bool connect)
 
 	if (asprintf(&dev_name, "/dev/nvme%d", instance) < 0)
 		return -errno;
-	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
+	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec, &status);
 	free(dev_name);
 	err = remove_ctrl(instance);
 	if (err)
@@ -874,9 +877,11 @@ static int do_discover(char *argstr, bool connect)
 	case DISC_GET_NUMRECS:
 		fprintf(stderr,
 			"Get number of discovery log entries failed.\n");
+		ret = status;
 		break;
 	case DISC_GET_LOG:
 		fprintf(stderr, "Get discovery log entries failed.\n");
+		ret = status;
 		break;
 	case DISC_NO_LOG:
 		fprintf(stdout, "No discovery log entries to fetch.\n");
@@ -885,6 +890,7 @@ static int do_discover(char *argstr, bool connect)
 	case DISC_NOT_EQUAL:
 		fprintf(stderr,
 		"Numrec values of last two get discovery log page not equal\n");
+		ret = DISC_OK;
 		break;
 	default:
 		fprintf(stderr, "Get discovery log page failed: %d\n", ret);
@@ -989,15 +995,17 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
 	if (!cfg.transport && !cfg.traddr) {
-		return discover_from_conf_file(desc, argstr,
+		ret = discover_from_conf_file(desc, argstr,
 				command_line_options, connect);
 	} else {
 		ret = build_options(argstr, BUF_SIZE);
 		if (ret)
-			return ret;
+			return nvme_status_to_errno(ret, true);
 
-		return do_discover(argstr, connect);
+		ret = do_discover(argstr, connect);
 	}
+
+	return nvme_status_to_errno(ret, true);
 }
 
 int connect(const char *desc, int argc, char **argv)
-- 
2.21.0
