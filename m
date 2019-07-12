From: sschricker@suse.de (Simon Schricker)
Date: Fri, 12 Jul 2019 17:34:57 +0200
Subject: [PATCH] nvme-vendor: fix c99 declarations in vendor plugins
Message-ID: <20190712153457.13877-1-sschricker@suse.de>

We can't use c99 declarations with older compilers.

Signed-off-by: Simon Schricker <sschricker at suse.de>
---
 plugins/micron/micron-nvme.c   | 3 ++-
 plugins/toshiba/toshiba-nvme.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/plugins/micron/micron-nvme.c b/plugins/micron/micron-nvme.c
index c827bae..b0762f0 100644
--- a/plugins/micron/micron-nvme.c
+++ b/plugins/micron/micron-nvme.c
@@ -40,6 +40,7 @@ static int micron_selective_download(int argc, char **argv, struct command *cmd,
 	void *fw_buf;
     int fd, selectNo,fw_fd,fw_size,err,offset = 0;
     struct stat sb;
+	int i;
 
 	struct config {
 		char  *fw;
@@ -68,7 +69,7 @@ static int micron_selective_download(int argc, char **argv, struct command *cmd,
         goto out;
     }
 
-    for(int i=0;i<3;i++) 
+    for(i=0;i<3;i++)
     {
         cfg.select[i] = toupper(cfg.select[i]);
     }
diff --git a/plugins/toshiba/toshiba-nvme.c b/plugins/toshiba/toshiba-nvme.c
index a22a4d6..e27653f 100644
--- a/plugins/toshiba/toshiba-nvme.c
+++ b/plugins/toshiba/toshiba-nvme.c
@@ -192,10 +192,11 @@ static int d_raw_to_fd(const unsigned char *buf, unsigned len, int fd)
 static void progress_runner(float progress)
 {
     const size_t barWidth = 70;
+    size_t i;
 
     fprintf(stdout, "[");
     size_t pos = barWidth * progress;
-    for (size_t i = 0; i < barWidth; ++i) {
+    for (i = 0; i < barWidth; ++i) {
         if (i <= pos) {
         	fprintf(stdout, "=");
         } else {
@@ -216,6 +217,8 @@ static int nvme_get_internal_log(int fd, const char* const filename, bool curren
 	// By trial and error it seems that the largest transfer chunk size
 	// is 128 * 32 =  4k sectors = 2MB
 	const __u32 max_pages = 128;
+	size_t i;
+	unsigned j;
 	err = nvme_sct_command_transfer_log(fd, current);
 	if (err) {
 		fprintf(stderr, "%s: SCT command transfer failed\n", __func__);
@@ -267,7 +270,7 @@ static int nvme_get_internal_log(int fd, const char* const filename, bool curren
 		}
 	}
 	// Now read the rest
-	for (size_t i = 1; i < pages;) {
+	for (i = 1; i < pages;) {
 		__u32 pages_chunk = max_pages;
 		if (pages_chunk + i >= pages) {
 			pages_chunk = pages - i;
@@ -280,7 +283,7 @@ static int nvme_get_internal_log(int fd, const char* const filename, bool curren
 		progress = (float) (i) / (float) (pages);
 		progress_runner(progress);
 		if (filename == NULL) {
-			for (unsigned j = 0; j < pages_chunk; ++j) {
+			for (j = 0; j < pages_chunk; ++j) {
 				fprintf(stdout, "Page: %zu of %zu\n", i + j, pages);
 				d(page_data + (j * page_data_len), page_data_len, 16, 1);
 			}
-- 
2.22.0
