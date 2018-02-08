From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  8 Feb 2018 20:44:41 +0900
Subject: [PATCH] nvme-cli: add helper for sanitize command
Message-ID: <1518090281-5969-1-git-send-email-minwoo.im.dev@gmail.com>

Add helper function for sanitize command just like other commands with few
error returning from wrong options.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-ioctl.c | 13 +++++++++++++
 nvme-ioctl.h |  2 ++
 nvme.c       | 53 +++++++++++++++++++++++------------------------------
 3 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 6dd7192..d2a37a7 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -773,3 +773,16 @@ int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
         return err;
 }
 
+int nvme_sanitize(int fd, __u8 sanact, __u8 ause, __u8 owpass, __u8 oipbp,
+		  __u8 no_dealloc, __u32 ovrpat)
+{
+	struct nvme_admin_cmd cmd = {
+		.opcode		= nvme_admin_sanitize_nvm,
+		.cdw10		= no_dealloc << 9 | oipbp << 8 |
+				  owpass << NVME_SANITIZE_OWPASS_SHIFT |
+				  ause << 3 | sanact,
+		.cdw11		= ovrpat,
+	};
+
+	return nvme_submit_admin_passthru(fd, &cmd);
+}
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 6569665..e3a5968 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -129,5 +129,7 @@ int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
 int nvme_get_properties(int fd, void **pbar);
 int nvme_set_property(int fd, int offset, int value);
+int nvme_sanitize(int fd, __u8 sanact, __u8 ause, __u8 owpass, __u8 oipbp,
+		  __u8 no_dealloc, __u32 ovrpat);
 
 #endif				/* _NVME_LIB_H */
diff --git a/nvme.c b/nvme.c
index 499beef..f750426 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2129,10 +2129,6 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 
 	int fd;
 	int ret;
-	__u32 sanitize_cdw10 = 0;
-	__u32 sanitize_cdw11 = 0;
-
-	struct nvme_passthru_cmd admin_cmd;
 
 	struct config {
 		int    no_dealloc;
@@ -2146,7 +2142,7 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 	struct config cfg = {
 		.no_dealloc = 0,
 		.oipbp = 0,
-		.owpass = 1,
+		.owpass = 0,
 		.ause = 0,
 		.sanact = 0,
 		.ovrpat = 0,
@@ -2170,44 +2166,41 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 	case NVME_SANITIZE_ACT_CRYPTO_ERASE:
 	case NVME_SANITIZE_ACT_BLOCK_ERASE:
 	case NVME_SANITIZE_ACT_EXIT:
-		sanitize_cdw10 = cfg.sanact;
-		break;
 	case NVME_SANITIZE_ACT_OVERWRITE:
-		sanitize_cdw10 = cfg.sanact;
-		sanitize_cdw11 = cfg.ovrpat;
 		break;
 	default:
 		fprintf(stderr, "Invalid Sanitize Action\n");
-		ret = -1;
+		ret = EINVAL;
 		goto close_fd;
 	}
 
-	if (cfg.sanact != NVME_SANITIZE_ACT_EXIT && cfg.ause)
-		sanitize_cdw10 |= NVME_SANITIZE_AUSE;
+	if (cfg.sanact == NVME_SANITIZE_ACT_EXIT) {
+	       if (cfg.ause || cfg.no_dealloc) {
+			fprintf(stderr, "SANACT is Exit Failure Mode\n");
+			ret = EINVAL;
+			goto close_fd;
+	       }
+	}
 
 	if (cfg.sanact == NVME_SANITIZE_ACT_OVERWRITE) {
-		if (cfg.owpass >= 0 && cfg.owpass <= 16) {
-			sanitize_cdw10 |= (cfg.owpass << NVME_SANITIZE_OWPASS_SHIFT);
-		} else {
-			fprintf(stderr, "owpass out of range [0-16] or sanitize action is not set to overwrite\n");
-			ret = -1;
+		if (!(cfg.owpass >= 0 && cfg.owpass <= 16)) {
+			fprintf(stderr, "OWPASS out of range [0-16]\n");
+			ret = EINVAL;
+			goto close_fd;
+		}
+	} else {
+		if (cfg.owpass || cfg.oipbp || cfg.ovrpat) {
+			fprintf(stderr, "SANACT is not Overwrite\n");
+			ret = EINVAL;
 			goto close_fd;
 		}
-		if (cfg.oipbp)
-			sanitize_cdw10 |= NVME_SANITIZE_OIPBP;
 	}
 
-	if (cfg.sanact != NVME_SANITIZE_ACT_EXIT && cfg.no_dealloc)
-		sanitize_cdw10 |= NVME_SANITIZE_NO_DEALLOC;
-
-	memset(&admin_cmd, 0, sizeof (admin_cmd));
-	admin_cmd.opcode = nvme_admin_sanitize_nvm;
-	admin_cmd.cdw10 = sanitize_cdw10;
-	admin_cmd.cdw11 = sanitize_cdw11;
-
-	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
-
-	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+	ret = nvme_sanitize(fd, cfg.sanact, cfg.ause, cfg.owpass, cfg.oipbp,
+			    cfg.no_dealloc, cfg.ovrpat);
+	if (ret)
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(ret), ret);
 
  close_fd:
 	close(fd);
-- 
2.7.4
