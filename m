From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 27 Sep 2018 16:13:58 -0700
Subject: [PATCH] nvme-cli: make read error handling uniform
Message-ID: <20180927231358.3230-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 84 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 32 deletions(-)

diff --git a/nvme.c b/nvme.c
index 8b95a99..1635277 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1275,6 +1275,8 @@ static char *get_nvme_subsnqn(char *path)
 
 	ret = read(fd, subsysnqn, 256);
 	if (ret < 0) {
+		fprintf(stderr, "Failed to read %s: %s\n", sspath,
+				strerror(errno));
 		free(subsysnqn);
 		subsysnqn = NULL;
 	}
@@ -1311,8 +1313,10 @@ static char *get_nvme_ctrl_transport(char *path)
 	}
 
 	ret = read(fd, transport, 1024);
-	if (ret < 0)
+	if (ret < 0) {
+		fprintf(stderr, "read :%s :%s\n", trpath, strerror(errno));
 		goto err_close_fd;
+	}
 
 	if (transport[strlen(transport) - 1] == '\n')
 		transport[strlen(transport) - 1] = '\0';
@@ -1356,8 +1360,10 @@ static char *get_nvme_ctrl_address(char *path)
 	}
 
 	ret = read(fd, address, 1024);
-	if (ret < 0)
+	if (ret < 0) {
+		fprintf(stderr, "read :%s :%s\n", addrpath, strerror(errno));
 		goto err_close_fd;
+	}
 
 	if (address[strlen(address) - 1] == '\n')
 		address[strlen(address) - 1] = '\0';
@@ -2362,7 +2368,8 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	if (cfg.xfer == 0 || cfg.xfer % 4096)
 		cfg.xfer = 4096;
 	if (read(fw_fd, fw_buf, fw_size) != ((ssize_t)(fw_size))) {
-		err = EIO;
+		err = -errno;
+		fprintf(stderr, "read :%s :%s\n", cfg.fw, strerror(errno));
 		goto free;
 	}
 
@@ -3021,9 +3028,11 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 				goto free;
 			}
 		}
-		if (read(ffd, (void *)buf, cfg.data_len) < 0) {
-			fprintf(stderr, "failed to read data buffer from input file\n");
-			err = EINVAL;
+		err = read(ffd, (void *)buf, cfg.data_len);
+		if (err < 0) {
+			err = -errno;
+			fprintf(stderr, "failed to read data buffer from input"
+					" file: %s\n", strerror(errno));
 			goto close_ffd;
 		}
 	}
@@ -3126,10 +3135,11 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 		goto close_sec_fd;
 	}
 
-	if (read(sec_fd, sec_buf, sec_size) < 0) {
-		fprintf(stderr, "Failed to read data from security file with %s\n",
-			strerror(errno));
-		err = EINVAL;
+	err = read(sec_fd, sec_buf, sec_size);
+	if (err < 0) {
+		err = -errno;
+		fprintf(stderr, "Failed to read data from security file"
+				" %s with %s\n", cfg.file, strerror(errno));
 		goto free;
 	}
 
@@ -3254,22 +3264,24 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
                 memset(buf, 0, cfg.data_len);
         }
 
-        if (buf) {
-                if (strlen(cfg.file)) {
-                        ffd = open(cfg.file, O_RDONLY);
-                        if (ffd <= 0) {
+	if (buf) {
+		if (strlen(cfg.file)) {
+			ffd = open(cfg.file, O_RDONLY);
+			if (ffd <= 0) {
 				fprintf(stderr, "Failed to open file %s: %s\n",
 						cfg.file, strerror(errno));
 				err = EINVAL;
 				goto free;
-                        }
-                }
-                if (read(ffd, (void *)buf, cfg.data_len) < 0) {
-                        fprintf(stderr, "failed to read data buffer from input file\n");
-			err = EINVAL;
+			}
+		}
+		err = read(ffd, (void *)buf, cfg.data_len);
+		if (err < 0) {
+			err = -errno;
+			fprintf(stderr, "failed to read data buffer from input"
+					" file %s\n", strerror(errno));
 			goto close_ffd;
-                }
-        }
+		}
+	}
 
         err = nvme_dir_send(fd, cfg.namespace_id, cfg.dspec, cfg.dtype, cfg.doper,
                                 cfg.data_len, dw12, buf, &result);
@@ -4084,17 +4096,24 @@ static int submit_io(int opcode, char *command, const char *desc,
 		}
 	}
 
-	if ((opcode & 1) && read(dfd, (void *)buffer, cfg.data_size) < 0) {
-		fprintf(stderr, "failed to read data buffer from input file\n");
-		err = EINVAL;
-		goto free_mbuffer;
+	if ((opcode & 1)) {
+		err = read(dfd, (void *)buffer, cfg.data_size);
+		if (err < 0) {
+			err = -errno;
+			fprintf(stderr, "failed to read data buffer from input"
+					" file %s\n", strerror(errno));
+			goto free_mbuffer;
+		}
 	}
 
-	if ((opcode & 1) && cfg.metadata_size &&
-				read(mfd, (void *)mbuffer, cfg.metadata_size) < 0) {
-		fprintf(stderr, "failed to read meta-data buffer from input file\n");
-		err = EINVAL;
-		goto free_mbuffer;
+	if ((opcode & 1) && cfg.metadata_size) {
+		err = read(mfd, (void *)mbuffer, cfg.metadata_size);
+		if (err < 0) {
+			err = -errno;
+			fprintf(stderr, "failed to read meta-data buffer from"
+					" input file %s\n", strerror(errno));
+			goto free_mbuffer;
+		}
 	}
 
 	if (cfg.show) {
@@ -4526,8 +4545,9 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 			goto free_data;
 		} else if (cfg.write) {
 			if (read(wfd, data, cfg.data_len) < 0) {
-				fprintf(stderr, "failed to read write buffer\n");
-				err = EINVAL;
+				err = -errno;
+				fprintf(stderr, "failed to read write buffer "
+						"%s\n", strerror(errno));
 				goto free_data;
 			}
 		}
-- 
2.17.0
