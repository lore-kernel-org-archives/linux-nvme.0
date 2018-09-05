From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  5 Sep 2018 12:46:23 -0700
Subject: [PATCH] nvme-cli: make malloc error handling uniform
Message-ID: <20180905194623.24233-1-chaitanya.kulkarni@wdc.com>

This patch makes malloc() memory handling uniform by using errno based
error message.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 argconfig.c   | 10 +++++++++-
 nvme-ioctl.c  | 10 +++++++---
 nvme-models.c |  6 ++++--
 nvme.c        | 12 ++++++++----
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/argconfig.c b/argconfig.c
index 2689cd3..984b3d0 100644
--- a/argconfig.c
+++ b/argconfig.c
@@ -148,6 +148,7 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 	const struct argconfig_commandline_options *s;
 	int c, option_index = 0, short_index = 0, options_count = 0;
 	void *value_addr;
+	int ret = -EINVAL;
 
 	errno = 0;
 	for (s = options; s->option != NULL; s++)
@@ -156,6 +157,13 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
 	long_opts = malloc(sizeof(struct option) * (options_count + 2));
 	short_opts = malloc(sizeof(*short_opts) * (options_count * 3 + 4));
 
+	if (!long_opts || !short_opts) {
+		fprintf(stderr, "failed to allocate memory for opts: %s\n",
+				strerror(errno));
+		ret = -errno;
+		goto out;
+	}
+
 	for (s = options; (s->option != NULL) && (option_index < options_count);
 	     s++) {
 		if (s->short_option != 0) {
@@ -365,7 +373,7 @@ int argconfig_parse(int argc, char *argv[], const char *program_desc,
  out:
 	free(short_opts);
 	free(long_opts);
-	return -EINVAL;
+	return ret;
 }
 
 int argconfig_parse_subopt_string(char *string, char **options,
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 60b8eed..03842d2 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -251,8 +251,10 @@ struct nvme_dsm_range *nvme_setup_dsm_range(__u32 *ctx_attrs, __u32 *llbas,
 	int i;
 	struct nvme_dsm_range *dsm = malloc(nr_ranges * sizeof(*dsm));
 
-	if (!dsm)
+	if (!dsm) {
+		fprintf(stderr, "malloc: %s\n", strerror(errno));
 		return NULL;
+	}
 	for (i = 0; i < nr_ranges; i++) {
 		dsm[i].cattr = cpu_to_le32(ctx_attrs[i]);
 		dsm[i].nlb = cpu_to_le32(llbas[i]);
@@ -599,8 +601,10 @@ int nvme_get_properties(int fd, void **pbar)
 	int size = getpagesize();
 
 	*pbar = malloc(size);
-	if (!*pbar)
-		return ret;
+	if (!*pbar) {
+		fprintf(stderr, "malloc: %s\n", strerror(errno));
+		return -ENOMEM;
+	}
 
 	memset(*pbar, 0xff, size);
 	for (offset = NVME_REG_CAP; offset <= NVME_REG_CMBSZ; offset += advance) {
diff --git a/nvme-models.c b/nvme-models.c
index 43ab50a..5dd1b9f 100644
--- a/nvme-models.c
+++ b/nvme-models.c
@@ -308,8 +308,10 @@ char *nvme_product_name(int id)
 		goto error0;
 
 	line = malloc(1024);
-	if (!line)
+	if (!line) {
+		fprintf(stderr, "malloc: %s\n", strerror(errno));
 		goto error0;
+	}
 
 	while ((amnt = getline(&line, &size, file)) != -1) {
 		if (is_comment(line) && !is_class_info(line))
@@ -332,5 +334,5 @@ char *nvme_product_name(int id)
 error0:
 	fclose(file);
 error1:
-	return strdup("Unknown Device");
+	return !line ? strdup("NULL") : strdup("Unknown Device");
 }
diff --git a/nvme.c b/nvme.c
index d7be2e0..2ed2d1a 100644
--- a/nvme.c
+++ b/nvme.c
@@ -356,7 +356,8 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 	hdr = malloc(bs);
 	page_log = malloc(bs);
 	if (!hdr || !page_log) {
-		fprintf(stderr, "Failed to allocate %zu bytes for log\n", bs);
+		fprintf(stderr, "Failed to allocate %zu bytes for log: %s\n",
+				bs, strerror(errno));
 		err = ENOMEM;
 		goto free_mem;
 	}
@@ -805,7 +806,8 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 
 		log = malloc(cfg.log_len);
 		if (!log) {
-			fprintf(stderr, "could not alloc buffer for log\n");
+			fprintf(stderr, "could not alloc buffer for log: %s\n",
+					strerror(errno));
 			err = EINVAL;
 			goto close_fd;
 		}
@@ -4049,7 +4051,8 @@ static int submit_io(int opcode, char *command, const char *desc,
 	if (cfg.metadata_size) {
 		mbuffer = malloc(cfg.metadata_size);
 		if (!mbuffer) {
-			fprintf(stderr, "can not allocate io metadata payload\n");
+			fprintf(stderr, "can not allocate io metadata "
+					"payload: %s\n", strerror(errno));
 			err = ENOMEM;
 			goto free_buffer;
 		}
@@ -4477,7 +4480,8 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	if (cfg.metadata_len) {
 		metadata = malloc(cfg.metadata_len);
 		if (!metadata) {
-			fprintf(stderr, "can not allocate metadata payload\n");
+			fprintf(stderr, "can not allocate metadata "
+					"payload: %s\n", strerror(errno));
 			err = ENOMEM;
 			goto close_wfd;
 		}
-- 
2.17.0
