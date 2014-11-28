From: s.chawdhary@samsung.com (Swati C)
Date: Fri, 28 Nov 2014 19:20:36 +0530
Subject: [PATCH v2] nvme-user: Minor enhancement and fixes
Message-ID: <1417182636-2990-1-git-send-email-s.chawdhary@samsung.com>

Addressing comments from -
[PATCH] nvme-user: Minor enhancement and fixes
(http://lists.infradead.org/pipermail/linux-nvme/2014-November/001214.html)

Minor enhancements to nvme_format_ns.c
	- Make Metadata Settings a user settable value.
	- Support for Secure Erase Settings.

Signed-off-by: Swati C <s.chawdhary at samsung.com>
---
 nvme_format_ns.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/nvme_format_ns.c b/nvme_format_ns.c
index 4d81ce4..232bb36 100644
--- a/nvme_format_ns.c
+++ b/nvme_format_ns.c
@@ -14,11 +14,12 @@ int main(int argc, char **argv)
 {
 	static const char *perrstr;
 	struct nvme_admin_cmd cmd;
-	int err, fd, nsid, fmt, i;
+	int err, fd, nsid, fmt, i, ms, ses;
+	struct nvme_id_ctrl ctrl;
 	struct nvme_id_ns ns;
 
 	if (argc < 2) {
-		fprintf(stderr, "Usage: %s <device> [<lbaf>]\n",
+		fprintf(stderr, "Usage: %s <device> [<lbaf>] [<ms>] [<ses>]\n",
 			argv[0]);
 		return 1;
 	}
@@ -28,6 +29,11 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		goto perror;
 
+	perrstr = "Identifying controller";
+	err = identify(fd, 0, &ctrl, 1);
+	if (err < 0)
+		goto perror;
+
 	perrstr = "Getting namespace ID";
 	nsid = ioctl(fd, NVME_IOCTL_ID);
 	if (nsid < 0 )
@@ -38,7 +44,17 @@ int main(int argc, char **argv)
 	if (err < 0)
 		goto perror;
 
-	if (argc == 2) {
+	if (argc == 5) {
+		fmt = atoi(argv[2]);
+		ms = atoi(argv[3]);
+		ses = atoi(argv[4]);
+	} else if (argc == 4) {
+		fmt = atoi(argv[2]);
+		ms = atoi(argv[3]);
+	} else if (argc == 3) {
+		fmt = atoi(argv[2]);
+	} else {
+		/* User Input for LBAF */
 		printf("LBA formats:\n");
 		for (i = 0; i <= ns.nlbaf; i++) {
 			printf("lbaf %2d : ms:%-2d ds:%-2d rp:%#x %s\n", i,
@@ -51,20 +67,71 @@ int main(int argc, char **argv)
 			printf("Invalid input for format\n");
 			return -1;
 		}
-	} else if (argc == 3) {
-		fmt = atoi(argv[2]);
 	}
+	
 	if (fmt < 0 || fmt > ns.nlbaf) {
 		printf("Invalid format:%d\n", fmt);
 		return -1;
 	}
-	printf("Entered %d, formatting namespace\n", fmt);
+
+        if (argc < 4) {
+                /* User Input for Metadata Settings */
+                printf("\nMetadata Settings(ms):\n");
+                printf("Separate buffer		0 :\n");
+                printf("Extended data LBA	1 :\n");
+                printf("Enter ms: ");
+
+                if (scanf("%d", &ms) != 1) {
+                        printf("Invalid input for metadata settings\n");
+                        return -1;
+                }
+        }
+	
+	if (ms < 0 || ms > 1) {
+		printf("Invalid ms:%d\n", ms);
+		return -1;
+	}
+		
+	if (argc < 5) {
+		/* User Input for Secure Erase Settings */
+		printf("\nSecure Erase Settings(ses):\n");
+		printf("No Secure Erase		 0 :\n");
+		printf("User Data Erase		 1 :\n");
+		printf("Cryptographic Erase	 2 :\n");
+		printf("Enter ses: ");
+
+		if (scanf("%d", &ses) != 1) {
+			printf("Invalid input for secure erase settings\n");
+			return -1;
+		}
+	}
+	
+	if (ses < 0 || ses > 2) {
+		printf("Invalid ses:%d\n", ses);
+		return -1;
+	}
+	
+	if (ses == 2) {
+		/* Check if cryptographic erase is supported or not */
+		if (!(ctrl.fna & (1 << 2))) {
+			printf("Cryptographic Erase not supported\n");
+			return -1;
+		}
+	}
+	
+	printf("\nEntered format index %d, ms %d, ses %d, formatting namespace\n", fmt, ms, ses);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = nvme_admin_format_nvm;
 	cmd.nsid = nsid;
 	cmd.cdw10 = fmt;
 
+	/* Metadata Settings */
+	cmd.cdw10 |= (ms << 4);
+
+	/* Secure Erase Settings */
+	cmd.cdw10 |= (ses << 9);
+
 	perrstr = "Format NVM";
 	err = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
 	if (err < 0)
@@ -78,4 +145,3 @@ int main(int argc, char **argv)
 	perror(perrstr);
 	return 1;
 }
-
-- 
1.8.3.2
