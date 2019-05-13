From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 14 May 2019 02:03:42 +0900
Subject: [PATCH V2 4/4] fabrics: Return errno mapped for fabrics error status
In-Reply-To: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
References: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
Message-ID: <20190513170342.9497-5-minwoo.im.dev@gmail.com>

If discover has been failed due to a nvme status, it will be returned to
main() with mapped value for fabrics get log page command.

Now connect command related status cannot be added in this patch because
kernel is not currently returning the nvme status, it's instead
returning -EIO if fails.  errno for connect command can be added once
kernel is ready to return the proper value for nvme status.

Cc: Keith Busch <keith.busch at intel.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 fabrics.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 511de06..ad61b07 100644
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
@@ -328,6 +329,7 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 
 	error = nvme_discovery_log(fd, log, hdr_size);
 	if (error) {
+		*status = (error > 0) ? nvme_status_to_errno(error, true) : error;
 		error = DISC_GET_NUMRECS;
 		goto out_free_log;
 	}
@@ -366,6 +368,8 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		 */
 		error = nvme_discovery_log(fd, log, log_size);
 		if (error) {
+			*status = (error > 0) ?
+				nvme_status_to_errno(error, true) : error;
 			error = DISC_GET_LOG;
 			goto out_free_log;
 		}
@@ -379,6 +383,8 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 		genctr = le64_to_cpu(log->genctr);
 		error = nvme_discovery_log(fd, log, hdr_size);
 		if (error) {
+			*status = (error > 0) ?
+				nvme_status_to_errno(error, true) : error;
 			error = DISC_GET_LOG;
 			goto out_free_log;
 		}
@@ -849,6 +855,7 @@ static int do_discover(char *argstr, bool connect)
 	struct nvmf_disc_rsp_page_hdr *log = NULL;
 	char *dev_name;
 	int instance, numrec = 0, ret, err;
+	int status = 0;
 
 	instance = add_ctrl(argstr);
 	if (instance < 0)
@@ -856,7 +863,7 @@ static int do_discover(char *argstr, bool connect)
 
 	if (asprintf(&dev_name, "/dev/nvme%d", instance) < 0)
 		return -errno;
-	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
+	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec, &status);
 	free(dev_name);
 	err = remove_ctrl(instance);
 	if (err)
@@ -874,9 +881,11 @@ static int do_discover(char *argstr, bool connect)
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
@@ -885,6 +894,7 @@ static int do_discover(char *argstr, bool connect)
 	case DISC_NOT_EQUAL:
 		fprintf(stderr,
 		"Numrec values of last two get discovery log page not equal\n");
+		ret = DISC_OK;
 		break;
 	default:
 		fprintf(stderr, "Get discovery log page failed: %d\n", ret);
@@ -989,15 +999,21 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 	cfg.nqn = NVME_DISC_SUBSYS_NAME;
 
 	if (!cfg.transport && !cfg.traddr) {
-		return discover_from_conf_file(desc, argstr,
+		ret = discover_from_conf_file(desc, argstr,
 				command_line_options, connect);
+		if (ret > 0)
+			ret = nvme_status_to_errno(ret, true);
 	} else {
 		ret = build_options(argstr, BUF_SIZE);
 		if (ret)
 			return ret;
 
-		return do_discover(argstr, connect);
+		ret = do_discover(argstr, connect);
+		if (ret > 0)
+			ret = nvme_status_to_errno(ret, true);
 	}
+
+	return ret;
 }
 
 int connect(const char *desc, int argc, char **argv)
-- 
2.21.0
