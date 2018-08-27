From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 27 Aug 2018 15:31:26 -0700
Subject: [PATCH 1/4] nvme-cli: use uniform error message for open
In-Reply-To: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
References: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180827223129.2741-2-chaitanya.kulkarni@wdc.com>

This patch adds errno based error message after open() system call
when open() system call fails.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 fabrics.c |  9 ++++++++-
 nvme.c    | 35 +++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/fabrics.c b/fabrics.c
index 514082e..af4d746 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -235,6 +235,8 @@ static int remove_ctrl_by_path(char *sysfs_path)
 	fd = open(sysfs_path, O_WRONLY);
 	if (fd < 0) {
 		ret = errno;
+		fprintf(stderr, "Failed to open %s: %s\n", sysfs_path,
+				strerror(errno));
 		goto out;
 	}
 
@@ -286,6 +288,8 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
 	fd = open(dev_path, O_RDWR);
 	if (fd < 0) {
 		error = -errno;
+		fprintf(stderr, "Failed to open %s: %s\n",
+				dev_path, strerror(errno));
 		goto out;
 	}
 
@@ -921,8 +925,11 @@ static int disconnect_subsys(char *nqn, char *ctrl)
 		goto free;
 
 	fd = open(sysfs_nqn_path, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open %s: %s\n",
+				sysfs_nqn_path, strerror(errno));
 		goto free;
+	}
 
 	if (read(fd, subsysnqn, NVMF_NQN_SIZE) < 0)
 		goto close;
diff --git a/nvme.c b/nvme.c
index f149bab..1981444 100644
--- a/nvme.c
+++ b/nvme.c
@@ -346,7 +346,8 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 
 	output = open(cfg.file_name, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (output < 0) {
-		fprintf(stderr, "Failed to open output file!\n");
+		fprintf(stderr, "Failed to open output file %s: %s!\n",
+				cfg.file_name, strerror(errno));
 		err = output;
 		goto close_fd;
 	}
@@ -1225,7 +1226,8 @@ static void *get_registers(void)
 		fd = open(path, O_RDONLY);
 	}
 	if (fd < 0) {
-		fprintf(stderr, "%s did not find a pci resource\n", base);
+		fprintf(stderr, "%s did not find a pci resource, open failed %s\n",
+				base, strerror(errno));
 		return NULL;
 	}
 
@@ -1251,8 +1253,11 @@ static char *get_nvme_subsnqn(char *path)
 	snprintf(sspath, sizeof(sspath), "%s/subsysnqn", path);
 
 	fd = open(sspath, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open %s: %s\n",
+				sspath, strerror(errno));
 		return NULL;
+	}
 
 	subsysnqn = calloc(1, 256);
 	if (!subsysnqn)
@@ -1289,8 +1294,11 @@ static char *get_nvme_ctrl_transport(char *path)
 		goto err_free_trpath;
 
 	fd = open(trpath, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open %s: %s\n",
+				trpath, strerror(errno));
 		goto err_free_tr;
+	}
 
 	ret = read(fd, transport, 1024);
 	if (ret < 0)
@@ -1331,8 +1339,11 @@ static char *get_nvme_ctrl_address(char *path)
 		goto err_free_addrpath;
 
 	fd = open(addrpath, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open %s: %s\n",
+				addrpath, strerror(errno));
 		goto err_free_addr;
+	}
 
 	ret = read(fd, address, 1024);
 	if (ret < 0)
@@ -1659,7 +1670,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 		snprintf(path, sizeof(path), "%s%s", dev, devices[i]->d_name);
 		fd = open(path, O_RDONLY);
 		if (fd < 0) {
-			fprintf(stderr, "can not open %s: %s\n", path,
+			fprintf(stderr, "Failed to open %s: %s\n", path,
 					strerror(errno));
 			return errno;
 		}
@@ -2293,7 +2304,8 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	fw_fd = open(cfg.fw, O_RDONLY);
 	cfg.offset <<= 2;
 	if (fw_fd < 0) {
-		fprintf(stderr, "no firmware file provided\n");
+		fprintf(stderr, "Failed to open firmware file %s: %s\n",
+				cfg.fw, strerror(errno));
 		err = EINVAL;
 		goto close_fd;
 	}
@@ -2968,7 +2980,8 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 		if (strlen(cfg.file)) {
 			ffd = open(cfg.file, O_RDONLY);
 			if (ffd <= 0) {
-				fprintf(stderr, "no firmware file provided\n");
+				fprintf(stderr, "Failed to open file %s: %s\n",
+						cfg.file, strerror(errno));
 				err = EINVAL;
 				goto free;
 			}
@@ -3059,7 +3072,8 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 
 	sec_fd = open(cfg.file, O_RDONLY);
 	if (sec_fd < 0) {
-		fprintf(stderr, "no firmware file provided\n");
+		fprintf(stderr, "Failed to open %s: %s\n",
+				cfg.file, strerror(errno));
 		err = EINVAL;
 		goto close_fd;
 	}
@@ -3209,7 +3223,8 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
                 if (strlen(cfg.file)) {
                         ffd = open(cfg.file, O_RDONLY);
                         if (ffd <= 0) {
-                                fprintf(stderr, "no firmware file provided\n");
+				fprintf(stderr, "Failed to open file %s: %s\n",
+						cfg.file, strerror(errno));
 				err = EINVAL;
 				goto free;
                         }
-- 
2.17.0
