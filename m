From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 20:36:05 -0400
Subject: [PATCH 3/5] nvme-cli: code cleanup for passthru() handlers
In-Reply-To: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
References: <20180820003607.21899-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180820003607.21899-4-chaitanya.kulkarni@wdc.com>

Get rid of the duplicate free of the metadata pointer in case memory
allocation fails for the data pointer.

Close wfd file in case of any resource allocation failure if
applicable.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/nvme.c b/nvme.c
index 4233d9c..f149bab 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4451,13 +4451,11 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		if (!metadata) {
 			fprintf(stderr, "can not allocate metadata payload\n");
 			err = ENOMEM;
-			goto close_fd;
+			goto close_wfd;
 		}
 	}
 	if (cfg.data_len) {
 		if (posix_memalign(&data, getpagesize(), cfg.data_len)) {
-			if (metadata)
-				free(metadata);
 			fprintf(stderr, "can not allocate data payload\n");
 			err = ENOMEM;
 			goto free_metadata;
@@ -4524,6 +4522,10 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
  free_metadata:
 	if (cfg.metadata_len)
 		free(metadata);
+
+ close_wfd:
+	if (strlen(cfg.input_file))
+		close(wfd);
  close_fd:
 	close(fd);
 	return err;
-- 
2.14.1
