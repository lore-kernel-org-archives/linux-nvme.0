From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:22:55 -0700
Subject: [PATCH 04/18] dynamically allocate log page buffers
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-5-git-send-email-hch@lst.de>

A device can report large logs.  Better dynamically allocate the buffer we
pass to the kernel instead of doing a gigantic stack allocation.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/nvme.c b/nvme.c
index e7b50b8..dac9d7d 100644
--- a/nvme.c
+++ b/nvme.c
@@ -299,7 +299,13 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 		fprintf(stderr, "could not identify controller\n");
 		return ENODEV;
 	} else {
-		struct nvme_error_log_page err_log[cfg.log_entries];
+		struct nvme_error_log_page *err_log;
+
+		err_log = calloc(cfg.log_entries, sizeof(struct nvme_error_log_page));
+		if (!err_log) {
+			fprintf(stderr, "could not alloc buffer for error log\n");
+			return ENOMEM;
+		}
 
 		err = nvme_error_log(fd, cfg.namespace_id, cfg.log_entries, err_log);
 		if (!err) {
@@ -313,6 +319,7 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 		else if (err > 0)
 			fprintf(stderr, "NVMe Status:%s(%x)\n",
 						nvme_status_to_string(err), err);
+		free(err_log);
 	}
 	return err;
 }
@@ -403,7 +410,13 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 		fprintf(stderr, "non-zero log-len is required param\n");
 		return EINVAL;
 	} else {
-		unsigned char log[cfg.log_len];
+		unsigned char *log;
+
+		log = malloc(cfg.log_len);
+		if (!log) {
+			fprintf(stderr, "could not alloc buffer for log\n");
+			return EINVAL;
+		}
 
 		err = nvme_get_log(fd, cfg.namespace_id, cfg.log_id, cfg.log_len, log);
 		if (!err) {
@@ -417,6 +430,7 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 		} else if (err > 0)
 			fprintf(stderr, "NVMe Status:%s(%x)\n",
 						nvme_status_to_string(err), err);
+		free(log);
 		return err;
 	}
 }
-- 
2.1.4
