From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 18 Jun 2019 22:12:16 +0900
Subject: [PATCH V7 7/7] fabrics: Return errno mapped for fabrics error status
In-Reply-To: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
References: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
Message-ID: <20190618131216.3661-8-minwoo.im.dev@gmail.com>

If discover has been failed due to a nvme status, it will be returned to
main() with mapped value for fabrics get log page command.

Now connect command related status cannot be added in this patch because
kernel is not currently returning the nvme status, it's instead
returning -EIO if fails.  errno for connect command can be added once
kernel is ready to return the proper value for nvme status.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Chaitanya Kulkarni <chaitanya.Kulkarni at wdc.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 fabrics.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 8470d97..c628152 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -35,6 +35,7 @@
 
 #include "parser.h"
 #include "nvme-ioctl.h"
+#include "nvme-status.h"
 #include "fabrics.h"
 
 #include "nvme.h"
@@ -296,7 +297,7 @@ enum {
 };
 
 static int nvmf_get_log_page_discovery(const char *dev_path,
-		struct nvmf_disc_rsp_page_hdr **logp, int *numrec)
+		struct nvmf_disc_rsp_page_hdr **logp, int *numrec, int *status)
 {
 	struct nvmf_disc_rsp_page_hdr *log;
 	unsigned int hdr_size;
@@ -411,6 +412,7 @@ out_free_log:
 out_close:
 	close(fd);
 out:
+	*status = nvme_status_to_errno(error, true);
 	return error;
 }
 
@@ -860,6 +862,7 @@ static int do_discover(char *argstr, bool connect)
 	struct nvmf_disc_rsp_page_hdr *log = NULL;
 	char *dev_name;
 	int instance, numrec = 0, ret, err;
+	int status = 0;
 
 	instance = add_ctrl(argstr);
 	if (instance < 0)
@@ -867,7 +870,7 @@ static int do_discover(char *argstr, bool connect)
 
 	if (asprintf(&dev_name, "/dev/nvme%d", instance) < 0)
 		return -errno;
-	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec);
+	ret = nvmf_get_log_page_discovery(dev_name, &log, &numrec, &status);
 	free(dev_name);
 	err = remove_ctrl(instance);
 	if (err)
@@ -885,9 +888,11 @@ static int do_discover(char *argstr, bool connect)
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
@@ -900,6 +905,7 @@ static int do_discover(char *argstr, bool connect)
 	case DISC_NOT_EQUAL:
 		fprintf(stderr,
 		"Numrec values of last two get discovery log page not equal\n");
+		ret = -EBADSLT;
 		break;
 	default:
 		fprintf(stderr, "Get discovery log page failed: %d\n", ret);
@@ -1015,7 +1021,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 	}
 
 out:
-	return ret;
+	return nvme_status_to_errno(ret, true);
 }
 
 int connect(const char *desc, int argc, char **argv)
@@ -1062,8 +1068,9 @@ int connect(const char *desc, int argc, char **argv)
 	instance = add_ctrl(argstr);
 	if (instance < 0)
 		ret = instance;
+
 out:
-	return ret;
+	return nvme_status_to_errno(ret, true);
 }
 
 static int scan_sys_nvme_filter(const struct dirent *d)
@@ -1196,7 +1203,7 @@ int disconnect(const char *desc, int argc, char **argv)
 	}
 
 out:
-	return ret;
+	return nvme_status_to_errno(ret, true);
 }
 
 int disconnect_all(const char *desc, int argc, char **argv)
@@ -1223,10 +1230,12 @@ int disconnect_all(const char *desc, int argc, char **argv)
 
 			ret = disconnect_by_device(ctrl->name);
 			if (ret)
-				goto out;
+				goto free;
 		}
 	}
-out:
+
+free:
 	free_subsys_list(slist, subcnt);
-	return ret;
+out:
+	return nvme_status_to_errno(ret, true);
 }
-- 
2.21.0
