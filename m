From: s.chawdhary@samsung.com (Swati C)
Date: Thu, 30 Oct 2014 15:50:49 +0530
Subject: [PATCH] nvme-user: Minor enhancement and fixes
Message-ID: <1414664449-3288-1-git-send-email-s.chawdhary@samsung.com>

Not sure what's the correct forum for nvme-user patches, hence posting them here.
Also, it appears that nvme-user is not actively maintained anymore. Is there any plan for the same?

Minor enhancement & fixes to nvme-user utils.
- nvme_smart
  - GetLogPage CDW10 is a 0's based value.
- nvme_format_ns
  - Secure Erase Settings(SES) support.
  - During Format, if LBA Format Metadata Size(MS) is 0, set Metadata Settings to Extended LBA.

Signed-off-by: Swati C <s.chawdhary at samsung.com>
---
 nvme_format_ns.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 nvme_smart.c     |  3 ++-
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/nvme_format_ns.c b/nvme_format_ns.c
index 4d81ce4..f7ae2e6 100644
--- a/nvme_format_ns.c
+++ b/nvme_format_ns.c
@@ -14,11 +14,12 @@ int main(int argc, char **argv)
 {
 	static const char *perrstr;
 	struct nvme_admin_cmd cmd;
-	int err, fd, nsid, fmt, i;
+	int err, fd, nsid, fmt, i, ses;
+	struct nvme_id_ctrl ctrl;
 	struct nvme_id_ns ns;
 
 	if (argc < 2) {
-		fprintf(stderr, "Usage: %s <device> [<lbaf>]\n",
+		fprintf(stderr, "Usage: %s <device> [<lbaf>] [<ses>]\n",
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
@@ -38,7 +44,13 @@ int main(int argc, char **argv)
 	if (err < 0)
 		goto perror;
 
-	if (argc == 2) {
+	if (argc == 4) {
+		fmt = atoi(argv[2]);
+		ses = atoi(argv[3]);
+	} else if (argc == 3) {
+		fmt = atoi(argv[2]);
+	} else {
+		/* User Input for LBAF */
 		printf("LBA formats:\n");
 		for (i = 0; i <= ns.nlbaf; i++) {
 			printf("lbaf %2d : ms:%-2d ds:%-2d rp:%#x %s\n", i,
@@ -51,20 +63,57 @@ int main(int argc, char **argv)
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
+	if (argc < 4) {
+		/* User Input for Secure Erase Settings */
+		printf("\nSecure Erase Settings(ses):\n");
+		printf("No Secure Erase		 0 :\n");
+		printf("User Data Erase		 1 :\n");
+		printf("Cryptographic Erase	 2 :\n");
+		printf("Enter ses index: ");
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
+	printf("\nEntered format index %d, ses index %d, formatting namespace\n", fmt, ses);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = nvme_admin_format_nvm;
 	cmd.nsid = nsid;
 	cmd.cdw10 = fmt;
 
+	/* Set Secure Erase Settings */
+	if (ses)
+		cmd.cdw10 |= (ses << 9);
+	/*
+	 * Set metadata settings to extended data lba, 
+	 * if ms=0 for the selected lbaf
+	 */
+	if (!ns.lbaf[fmt].ms)
+		cmd.cdw10 |= (1 << 4);
+
 	perrstr = "Format NVM";
 	err = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
 	if (err < 0)
@@ -78,4 +127,3 @@ int main(int argc, char **argv)
 	perror(perrstr);
 	return 1;
 }
-
diff --git a/nvme_smart.c b/nvme_smart.c
index c7a25f8..ef5ecc8 100644
--- a/nvme_smart.c
+++ b/nvme_smart.c
@@ -105,7 +105,8 @@ int main(int argc, char **argv)
 	cmd.opcode = nvme_admin_get_log_page;
 	cmd.addr = (unsigned long)smart_log;
 	cmd.data_len = sizeof(*smart_log);
-	cmd.cdw10 = 0x2 | ((sizeof(*smart_log) / 4) << 16);
+	/* NUMD is a 0's based value */
+	cmd.cdw10 = 0x2 | (((sizeof(*smart_log) / 4) - 1) << 16);
 
 	if (ctrl->lpa & 1 && nsid != 0) {
 		/* supports smart log on individual namespaces */
-- 
1.8.3.2
