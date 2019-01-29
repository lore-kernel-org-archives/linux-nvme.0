From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 28 Jan 2019 23:12:02 -0800
Subject: [PATCH] nvme-cli: minor cleanup for sibmit_io()
Message-ID: <20190129071202.174535-1-chaitanya.kulkarni@wdc.com>

This is a cleanup patch which adds errno based error messages when
write() failure, this also fixes minor typo and removes unnecessary
braces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/nvme.c b/nvme.c
index 7cf65a9..b6f8478 100644
--- a/nvme.c
+++ b/nvme.c
@@ -4314,7 +4314,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 		dsmgmt |= ((__u32)cfg.dspec) << 16;
 	}
 
-	if (strlen(cfg.data)){
+	if (strlen(cfg.data)) {
 		dfd = open(cfg.data, flags, mode);
 		if (dfd < 0) {
 			perror(cfg.data);
@@ -4323,7 +4323,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 		}
 		mfd = dfd;
 	}
-	if (strlen(cfg.metadata)){
+	if (strlen(cfg.metadata)) {
 		mfd = open(cfg.metadata, flags, mode);
 		if (mfd < 0) {
 			perror(cfg.metadata);
@@ -4345,9 +4345,8 @@ static int submit_io(int opcode, char *command, const char *desc,
 	if (cfg.data_size < buffer_size) {
 		fprintf(stderr, "Rounding data size to fit block count (%lld bytes)\n",
 				buffer_size);
-	} else {
+	} else
 		buffer_size = cfg.data_size;
-	}
 
 	if (posix_memalign(&buffer, getpagesize(), buffer_size)) {
 		fprintf(stderr, "can not allocate io payload\n");
@@ -4416,11 +4415,13 @@ static int submit_io(int opcode, char *command, const char *desc,
 		printf("%s:%s(%04x)\n", command, nvme_status_to_string(err), err);
 	else {
 		if (!(opcode & 1) && write(dfd, (void *)buffer, cfg.data_size) < 0) {
-			fprintf(stderr, "failed to write buffer to output file\n");
+			fprintf(stderr, "write: %s: failed to write buffer to output file\n",
+					strerror(errno));
 			err = EINVAL;
 		} else if (!(opcode & 1) && cfg.metadata_size &&
 				write(mfd, (void *)mbuffer, cfg.metadata_size) < 0) {
-			fprintf(stderr, "failed to write meta-data buffer to output file\n");
+			fprintf(stderr, "write: %s: failed to write meta-data buffer to output file\n",
+					strerror(errno));
 			err = EINVAL;
 		} else
 			fprintf(stderr, "%s: Success\n", command);
-- 
2.20.0
