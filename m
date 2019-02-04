From: Dong.Ho@wdc.com (Dong Ho)
Date: Mon, 4 Feb 2019 19:54:05 +0000
Subject: [PATCH 2/2] wdc: Update file parameter checking
In-Reply-To: <1549310038-13075-1-git-send-email-dong.ho@wdc.com>
References: <1549310038-13075-1-git-send-email-dong.ho@wdc.com>
Message-ID: <1549310038-13075-2-git-send-email-dong.ho@wdc.com>

---
 plugins/wdc/wdc-nvme.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 2f9a541..99ca5bd 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -1154,15 +1154,6 @@ static int wdc_do_cap_diag(int fd, char *file, __u32 xfer_size)
 	__u32 e6_log_hdr_size = WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE;
 	struct wdc_e6_log_hdr *log_hdr;
 	__u32 cap_diag_length;
-	int verify_file;
-
- 	/* verify the passed in file name and path is valid before getting the dump data */
-	verify_file = open(file, O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	if (verify_file < 0) {
-		fprintf(stderr, "ERROR : WDC: open : %s\n", strerror(errno));
-		return -1;
-	}
-	close(verify_file);
 
 	log_hdr = (struct wdc_e6_log_hdr *) malloc(e6_log_hdr_size);
 	if (log_hdr == NULL) {
@@ -1608,6 +1599,15 @@ static int wdc_vs_internal_fw_log(int argc, char **argv, struct command *command
 	}
 
 	if (cfg.file != NULL) {
+		int verify_file;
+
+		/* verify the passed in file name and path is valid before getting the dump data */
+		verify_file = open(cfg.file, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+		if (verify_file < 0) {
+			fprintf(stderr, "ERROR : WDC: open : %s\n", strerror(errno));
+			return -1;
+		}
+		close(verify_file);
 		strncpy(f, cfg.file, PATH_MAX - 1);
 	} else {
 		wdc_UtilsGetTime(&timeInfo);
-- 
2.7.4
