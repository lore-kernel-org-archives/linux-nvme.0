From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 27 Jan 2018 00:36:01 +0900
Subject: [PATCH] nvme-cli: fix leaks in subcommands
Message-ID: <1516980961-12897-1-git-send-email-minwoo.im.dev@gmail.com>

Fix leaks(a single memory leak, file descriptors leaks) in subcommands
by adding explicit close for opened things.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme.c | 474 +++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 345 insertions(+), 129 deletions(-)

diff --git a/nvme.c b/nvme.c
index aa2b8ec..8eda8cc 100644
--- a/nvme.c
+++ b/nvme.c
@@ -201,8 +201,10 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
@@ -220,6 +222,10 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 					nvme_status_to_string(err), err);
 	else
 		perror("smart log");
+
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -256,14 +262,15 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 
 	if (!cfg.file_name) {
 		fprintf(stderr, "Please provide an output file!\n");
-		close(fd);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	output = open(cfg.file_name, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (output < 0) {
 		fprintf(stderr, "Failed to open output file!\n");
-		return output;
+		err = output;
+		goto close_fd;
 	}
 
 	cfg.host_gen = !!cfg.host_gen;
@@ -277,18 +284,17 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 			nvme_status_to_string(err), err);
 		fprintf(stderr, "Failed to aquire telemetry header %d!\n", err);
 		free(hdr);
-		goto close_out;
+		goto close_output;
 	}
 
 	err = write(output, (void *) hdr, 4096);
 	if (err != 4096) {
 		fprintf(stderr, "Failed to flush all data to file!");
-		goto close_out;
+		goto free_hdr;
 	}
 
 	num_blocks = max(hdr->dalb1, max(hdr->dalb2, hdr->dalb3));
 
-	free(hdr);
 	full_size = num_blocks * 512;
 	/* Round to page boundary */
 	full_size += (4096 - (full_size % 4096));
@@ -301,7 +307,7 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 		fprintf(stderr, "Failed to allocate %zu bytes for log\n",
 			full_size);
 		err = ENOMEM;
-		goto close_out;
+		goto free_hdr;
 	}
 
 	while (full_size) {
@@ -310,22 +316,25 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 			fprintf(stderr, "Failed to aquire full telemetry log!\n");
 			fprintf(stderr, "NVMe Status:%s(%x)\n",
 				nvme_status_to_string(err), err);
-			goto out;
+			break;
 		}
 
 		err = write(output, (void *) page_log, 4096);
 		if (err != 4096) {
 			fprintf(stderr, "Failed to flush all data to file!");
-			goto out;
+			break;
 		}
 		full_size -= 4096;
 		offset += 4096;
 	}
- out:
+
 	free(page_log);
- close_out:
-	close(fd);
+ free_hdr:
+	free(hdr);
+ close_output:
 	close(output);
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -362,8 +371,10 @@ static int get_effects_log(int argc, char **argv, struct command *cmd, struct pl
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
@@ -384,6 +395,9 @@ static int get_effects_log(int argc, char **argv, struct command *cmd, struct pl
 				nvme_status_to_string(err), err);
 	else
 		perror("effects log page");
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -420,14 +434,17 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
 	if (!cfg.log_entries) {
 		fprintf(stderr, "non-zero log-entries is required param\n");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_identify_ctrl(fd, &ctrl);
@@ -443,7 +460,8 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 		err_log = calloc(cfg.log_entries, sizeof(struct nvme_error_log_page));
 		if (!err_log) {
 			fprintf(stderr, "could not alloc buffer for error log\n");
-			return ENOMEM;
+			err = ENOMEM;
+			goto close_fd;
 		}
 
 		err = nvme_error_log(fd, cfg.log_entries, err_log);
@@ -462,6 +480,9 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 			perror("error log");
 		free(err_log);
 	}
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -493,8 +514,10 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
@@ -512,6 +535,9 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
 				nvme_status_to_string(err), err);
 	else
 		perror("fw log");
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -569,14 +595,15 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 
 	if (!cfg.log_len) {
 		fprintf(stderr, "non-zero log-len is required param\n");
-		return EINVAL;
+		err = EINVAL;
 	} else {
 		unsigned char *log;
 
 		log = malloc(cfg.log_len);
 		if (!log) {
 			fprintf(stderr, "could not alloc buffer for log\n");
-			return EINVAL;
+			err = EINVAL;
+			goto close_fd;
 		}
 
 		err = nvme_get_log13(fd, cfg.namespace_id, cfg.log_id,
@@ -596,8 +623,11 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 		else
 			perror("log page");
 		free(log);
-		return err;
 	}
+
+ close_fd:
+	close(fd);
+	return err;
 }
 
 static int sanitize_log(int argc, char **argv, struct command *command, struct plugin *plugin)
@@ -633,8 +663,10 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		ret = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
@@ -655,6 +687,9 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
 	else
 		perror("sanitize status log");
 
+ close_fd:
+	close(fd);
+
 	return ret;
 }
 
@@ -706,6 +741,8 @@ static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *
 
 	free(cntlist);
 
+	close(fd);
+
 	return err;
 }
 
@@ -748,6 +785,9 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 			nvme_status_to_string(err), err, cfg.namespace_id);
 	else
 		perror("id namespace list");
+
+	close(fd);
+
 	return err;
 }
 
@@ -782,7 +822,8 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	if (!cfg.namespace_id) {
 		fprintf(stderr, "%s: namespace-id parameter required\n",
 						cmd->name);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_ns_delete(fd, cfg.namespace_id);
@@ -794,6 +835,10 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 					nvme_status_to_string(err), err);
 	else
 		perror("delete namespace");
+
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -827,7 +872,8 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 	if (!cfg.namespace_id) {
 		fprintf(stderr, "%s: namespace-id parameter required\n",
 						cmd->name);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	num = argconfig_parse_comma_sep_array(cfg.cntlist,
@@ -847,6 +893,10 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 					nvme_status_to_string(err), err);
 	else
 		perror(attach ? "attach namespace" : "detach namespace");
+
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -917,6 +967,9 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 					nvme_status_to_string(err), err);
 	else
 		perror("create namespace");
+
+	close(fd);
+
 	return err;
 }
 
@@ -958,8 +1011,10 @@ static void *get_registers(void)
 	membase = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, fd, 0);
 	if (membase == MAP_FAILED) {
 		fprintf(stderr, "%s failed to map\n", base);
-		return NULL;
+		membase = NULL;
 	}
+
+	close(fd);
 	return membase;
 }
 
@@ -1503,8 +1558,10 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary) {
 		fprintf(stderr, "binary output\n");
 		fmt = BINARY;
@@ -1532,6 +1589,9 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
 	else
 		perror("identify controller");
 
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -1572,8 +1632,10 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 	if (!cfg.namespace_id)
@@ -1581,7 +1643,8 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 
 	if (posix_memalign(&nsdescs, getpagesize(), 0x1000)) {
 		fprintf(stderr, "can not allocate controller list payload\n");
-		return ENOMEM;
+		err = ENOMEM;
+		goto close_fd;
 	}
 
 	err = nvme_identify_ns_descs(fd, cfg.namespace_id, nsdescs);
@@ -1603,6 +1666,9 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 
 	free(nsdescs);
 
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -1650,8 +1716,10 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 	if (cfg.vendor_specific)
@@ -1680,6 +1748,10 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 			nvme_status_to_string(err), err, cfg.namespace_id);
 	else
 		perror("identify namespace");
+
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -1698,9 +1770,12 @@ static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *
 	nsid = nvme_get_nsid(fd);
 	if (nsid <= 0) {
 		perror(devicename);
+		close(fd);
 		return errno;
 	}
 	printf("%s: namespace-id:%d\n", devicename, nsid);
+
+	close(fd);
 	return 0;
 }
 
@@ -1761,11 +1836,13 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 
 	if (cfg.sel > 7) {
 		fprintf(stderr, "invalid 'select' param:%d\n", cfg.sel);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (!cfg.feature_id) {
 		fprintf(stderr, "feature-id required param\n");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	
 	switch (cfg.feature_id) {
@@ -1792,7 +1869,8 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 	if (cfg.data_len) {
 		if (posix_memalign(&buf, getpagesize(), cfg.data_len)) {
 			fprintf(stderr, "can not allocate feature payload\n");
-			return ENOMEM;
+			err = ENOMEM;
+			goto close_fd;
 		}
 		memset(buf, 0, cfg.data_len);
 	}
@@ -1818,6 +1896,10 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 
 	if (buf)
 		free(buf);
+
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -1866,28 +1948,33 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	cfg.offset <<= 2;
 	if (fw_fd < 0) {
 		fprintf(stderr, "no firmware file provided\n");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = fstat(fw_fd, &sb);
 	if (err < 0) {
 		perror("fstat");
-		return errno;
+		goto close_fw_fd;
 	}
 
 	fw_size = sb.st_size;
 	if (fw_size & 0x3) {
 		fprintf(stderr, "Invalid size:%d for f/w image\n", fw_size);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fw_fd;
 	}
 	if (posix_memalign(&fw_buf, getpagesize(), fw_size)) {
 		fprintf(stderr, "No memory for f/w size:%d\n", fw_size);
-		return ENOMEM;
+		err = ENOMEM;
+		goto close_fw_fd;
 	}
 	if (cfg.xfer == 0 || cfg.xfer % 4096)
 		cfg.xfer = 4096;
-	if (read(fw_fd, fw_buf, fw_size) != ((ssize_t)(fw_size)))
-		return EIO;
+	if (read(fw_fd, fw_buf, fw_size) != ((ssize_t)(fw_size))) {
+		err = EIO;
+		goto free;
+	}
 
 	while (fw_size > 0) {
 		cfg.xfer = min(cfg.xfer, fw_size);
@@ -1908,7 +1995,12 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	if (!err)
 		printf("Firmware download success\n");
 
+ free:
 	free(fw_buf);
+ close_fw_fd:
+	close(fw_fd);
+ close_fd:
+	close(fd);
 
 	return err;
 }
@@ -1960,15 +2052,18 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
 
 	if (cfg.slot > 7) {
 		fprintf(stderr, "invalid slot:%d\n", cfg.slot);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.action > 7 || cfg.action == 4 || cfg.action == 5) {
 		fprintf(stderr, "invalid action:%d\n", cfg.action);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.bpid > 1) {
 		fprintf(stderr, "invalid boot partition id:%d\n", cfg.bpid);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_fw_commit(fd, cfg.slot, cfg.action, cfg.bpid);
@@ -1997,6 +2092,10 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
 			printf(" bpid:%d", cfg.bpid);
 		printf("\n");
 	}
+
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -2015,9 +2114,12 @@ static int subsystem_reset(int argc, char **argv, struct command *cmd, struct pl
 
 	err = nvme_subsystem_reset(fd);
 	if (err < 0) {
+		close(fd);
 		perror("Subsystem-reset");
 		return errno;
 	}
+
+	close(fd);
 	return err;
 }
 
@@ -2036,9 +2138,12 @@ static int reset(int argc, char **argv, struct command *cmd, struct plugin *plug
 
 	err = nvme_reset_controller(fd);
 	if (err < 0) {
+		close(fd);
 		perror("Reset");
 		return errno;
 	}
+
+	close(fd);
 	return err;
 }
 
@@ -2057,9 +2162,12 @@ static int ns_rescan(int argc, char **argv, struct command *cmd, struct plugin *
 
 	err = nvme_ns_rescan(fd);
 	if (err < 0) {
+		close(fd);
 		perror("Namespace Rescan");
 		return errno;
 	}
+
+	close(fd);
 	return err;
 }
 
@@ -2124,7 +2232,8 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 		break;
 	default:
 		fprintf(stderr, "Invalid Sanitize Action\n");
-		return -1;
+		ret = -1;
+		goto close_fd;
 	}
 
 	if (cfg.sanact != NVME_SANITIZE_ACT_EXIT && cfg.ause)
@@ -2135,7 +2244,8 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 			sanitize_cdw10 |= (cfg.owpass << NVME_SANITIZE_OWPASS_SHIFT);
 		} else {
 			fprintf(stderr, "owpass out of range [0-16] or sanitize action is not set to overwrite\n");
-			return -1;
+			ret = -1;
+			goto close_fd;
 		}
 		if (cfg.oipbp)
 			sanitize_cdw10 |= NVME_SANITIZE_OIPBP;
@@ -2152,6 +2262,10 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 	ret = nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &admin_cmd);
 
 	fprintf(stderr, "NVMe Status:%s(%x)\n", nvme_status_to_string(ret), ret);
+
+ close_fd:
+	close(fd);
+
 	return ret;
 }
 
@@ -2186,13 +2300,19 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 		bar = get_registers();
 		fabrics = false;
 	}
-	if (!bar)
-		return ENODEV;
+	if (!bar) {
+		err = ENODEV;
+		goto close_fd;
+	}
 	show_ctrl_registers(bar, cfg.human_readable ? HUMAN : 0, fabrics);
 
 	if (fabrics)
 		free(bar);
-	return 0;
+
+ close_fd:
+	close(fd);
+
+	return err;
 }
 
 static int set_property(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2225,17 +2345,18 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
 
 	if (cfg.offset == -1) {
 		fprintf(stderr, "offset required param");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.value == -1) {
 		fprintf(stderr, "value required param");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_set_property(fd, cfg.offset, cfg.value);
 	if (err < 0) {
 		perror("set-property");
-		return errno;
 	} else if (!err) {
 		printf("set-property: %02x (%s), value: %#08x\n", cfg.offset,
 				nvme_register_to_string(cfg.offset), cfg.value);
@@ -2244,6 +2365,9 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
 				nvme_status_to_string(err), err);
 	}
 
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -2322,23 +2446,28 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	/* ses & pi checks set to 7 for forward-compatibility */
 	if (cfg.ses > 7) {
 		fprintf(stderr, "invalid secure erase settings:%d\n", cfg.ses);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.lbaf > 15) {
 		fprintf(stderr, "invalid lbaf:%d\n", cfg.lbaf);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.pi > 7) {
 		fprintf(stderr, "invalid pi:%d\n", cfg.pi);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.pil > 1) {
 		fprintf(stderr, "invalid pil:%d\n", cfg.pil);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.ms > 1) {
 		fprintf(stderr, "invalid ms:%d\n", cfg.ms);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_format(fd, cfg.namespace_id, cfg.lbaf, cfg.ses, cfg.pi,
@@ -2354,6 +2483,10 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 		if (cfg.reset && S_ISCHR(nvme_stat.st_mode))
 			nvme_reset_controller(fd);
 	}
+
+ close_fd:
+	close(fd);
+
 	return err;
 }
 
@@ -2413,14 +2546,16 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 
 	if (!cfg.feature_id) {
 		fprintf(stderr, "feature-id required param\n");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.feature_id == NVME_FEAT_LBA_RANGE)
 		cfg.data_len = 4096;
 	if (cfg.data_len) {
 		if (posix_memalign(&buf, getpagesize(), cfg.data_len)) {
 			fprintf(stderr, "can not allocate feature payload\n");
-			return ENOMEM;
+			err = ENOMEM;
+			goto close_fd;
 		}
 		memset(buf, 0, cfg.data_len);
 	}
@@ -2437,7 +2572,7 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 		if (read(ffd, (void *)buf, cfg.data_len) < 0) {
 			fprintf(stderr, "failed to read data buffer from input file\n");
 			err = EINVAL;
-			goto free;
+			goto close_ffd;
 		}
 	}
 
@@ -2445,7 +2580,6 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 				cfg.data_len, buf, &result);
 	if (err < 0) {
 		perror("set-feature");
-		goto free;
 	} else if (!err) {
 		printf("set-feature:%02x (%s), value:%#08x\n", cfg.feature_id,
 			nvme_feature_to_string(cfg.feature_id), cfg.value);
@@ -2460,9 +2594,13 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 		fprintf(stderr, "NVMe Status:%s(%x)\n",
 				nvme_status_to_string(err), err);
 
-free:
+ close_ffd:
+	close(ffd);
+ free:
 	if (buf)
 		free(buf);
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -2518,19 +2656,21 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 	sec_fd = open(cfg.file, O_RDONLY);
 	if (sec_fd < 0) {
 		fprintf(stderr, "no firmware file provided\n");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = fstat(sec_fd, &sb);
 	if (err < 0) {
 		perror("fstat");
-		return errno;
+		goto close_sec_fd;
 	}
 
 	sec_size = sb.st_size;
 	if (posix_memalign(&sec_buf, getpagesize(), sec_size)) {
 		fprintf(stderr, "No memory for security size:%d\n", sec_size);
-		return ENOMEM;
+		err = ENOMEM;
+		goto close_sec_fd;
 	}
 
 	if (read(sec_fd, sec_buf, sec_size) < 0) {
@@ -2549,8 +2689,12 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 	else
 		printf("NVME Security Send Command Success:%d\n", result);
 
-free:
+ free:
 	free(sec_buf);
+ close_sec_fd:
+	close(sec_fd);
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -2620,13 +2764,15 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
                 case NVME_DIR_SND_ID_OP_ENABLE:
                         if (!cfg.ttype) {
                                 fprintf(stderr, "target-dir required param\n");
-                                return EINVAL;
+                                err = EINVAL;
+				goto close_fd;
                         }
                         dw12 = cfg.ttype << 8 | cfg.endir;
                         break;
                 default:
                         fprintf(stderr, "invalid directive operations for Identify Directives\n");
-                        return EINVAL;
+                        err = EINVAL;
+			goto close_fd;
                 }
                 break;
         case NVME_DIR_STREAMS:
@@ -2636,19 +2782,22 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
                         break;
                 default:
                         fprintf(stderr, "invalid directive operations for Streams Directives\n");
-                        return EINVAL;
+                        err = EINVAL;
+			goto close_fd;
                 }
                 break;
         default:
                 fprintf(stderr, "invalid directive type\n");
-                return EINVAL;
-                break;
+                err = EINVAL;
+		goto close_fd;
         }
 
 
         if (cfg.data_len) {
-                if (posix_memalign(&buf, getpagesize(), cfg.data_len))
-                        exit(ENOMEM);
+                if (posix_memalign(&buf, getpagesize(), cfg.data_len)) {
+			err = ENOMEM;
+			goto close_fd;
+		}
                 memset(buf, 0, cfg.data_len);
         }
 
@@ -2664,7 +2813,7 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
                 if (read(ffd, (void *)buf, cfg.data_len) < 0) {
                         fprintf(stderr, "failed to read data buffer from input file\n");
 			err = EINVAL;
-			goto free;
+			goto close_ffd;
                 }
         }
 
@@ -2672,7 +2821,7 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
                                 cfg.data_len, dw12, buf, &result);
         if (err < 0) {
                 perror("dir-send");
-		goto free;
+		goto close_ffd;
         }
         if (!err) {
                 printf("dir-send: type %#x, operation %#x, spec_val %#x, nsid %#x, result %#x \n",
@@ -2688,9 +2837,13 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
                 fprintf(stderr, "NVMe Status:%s(%x)\n",
                                 nvme_status_to_string(err), err);
 
-free:
+ close_ffd:
+	close(ffd);
+ free:
         if (buf)
                 free(buf);
+ close_fd:
+	close(fd);
         return err;
 }
 
@@ -2738,6 +2891,9 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 					nvme_status_to_string(err), err);
 	else
 		printf("NVME Write Uncorrectable Success\n");
+
+	close(fd);
+
 	return err;
 }
 
@@ -2798,8 +2954,10 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 	if (fd < 0)
 		return fd;
 
-	if (cfg.prinfo > 0xf)
-		return EINVAL;
+	if (cfg.prinfo > 0xf) {
+		err = EINVAL;
+		goto close_fd;
+	}
 
 	control |= (cfg.prinfo << 10);
 	if (cfg.limited_retry)
@@ -2820,6 +2978,9 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 					nvme_status_to_string(err), err);
 	else
 		printf("NVME Write Zeroes Success\n");
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -2889,7 +3050,8 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 	nr = max(nc, max(nb, ns));
 	if (!nr || nr > 256) {
 		fprintf(stderr, "No range definition provided\n");
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	if (!cfg.namespace_id)
@@ -2900,7 +3062,8 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 	dsm = nvme_setup_dsm_range((__u32 *)ctx_attrs, (__u32 *)nlbs, (__u64 *)slbas, nr);
 	if (!dsm) {
 		fprintf(stderr, "failed to allocate data set payload\n");
-		return ENOMEM;
+		err = ENOMEM;
+		goto close_fd;
 	}
 
 	err = nvme_dsm(fd, cfg.namespace_id, cfg.cdw11, dsm, nr);
@@ -2911,6 +3074,9 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 				nvme_status_to_string(err), err);
 	else
 		printf("NVMe DSM: success\n");
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -3004,7 +3170,8 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 		cfg.namespace_id = get_nsid(fd);
 	if (cfg.racqa > 7) {
 		fprintf(stderr, "invalid racqa:%d\n", cfg.racqa);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_resv_acquire(fd, cfg.namespace_id, cfg.rtype, cfg.racqa,
@@ -3015,6 +3182,9 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 		fprintf(stderr, "NVME IO command error:%s(%x)\n", nvme_status_to_string(err), err);
 	else
 		printf("NVME Reservation Acquire success\n");
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -3066,7 +3236,8 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 		cfg.namespace_id = get_nsid(fd);
 	if (cfg.cptpl > 3) {
 		fprintf(stderr, "invalid cptpl:%d\n", cfg.cptpl);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_resv_register(fd, cfg.namespace_id, cfg.rrega, cfg.cptpl,
@@ -3077,6 +3248,9 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 		fprintf(stderr, "NVME IO command error:%s(%x)\n", nvme_status_to_string(err), err);
 	else
 		printf("NVME Reservation  success\n");
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -3130,11 +3304,13 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 		cfg.namespace_id = get_nsid(fd);
 	if (cfg.iekey > 1) {
 		fprintf(stderr, "invalid iekey:%d\n", cfg.iekey);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 	if (cfg.rrela > 7) {
 		fprintf(stderr, "invalid rrela:%d\n", cfg.rrela);
-		return EINVAL;
+		err = EINVAL;
+		goto close_fd;
 	}
 
 	err = nvme_resv_release(fd, cfg.namespace_id, cfg.rtype, cfg.rrela,
@@ -3145,6 +3321,9 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 		fprintf(stderr, "NVME IO command error:%s(%x)\n", nvme_status_to_string(err), err);
 	else
 		printf("NVME Reservation Release success\n");
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -3192,8 +3371,10 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 		return fd;
 
 	fmt = validate_output_format(cfg.output_format);
-	if (fmt < 0)
-		return fmt;
+	if (fmt < 0) {
+		err = fmt;
+		goto close_fd;
+	}
 	if (cfg.raw_binary)
 		fmt = BINARY;
 
@@ -3206,7 +3387,8 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 
 	if (posix_memalign((void **)&status, getpagesize(), cfg.numd << 2)) {
 		fprintf(stderr, "No memory for resv report:%d\n", cfg.numd << 2);
-		return ENOMEM;
+		err = ENOMEM;
+		goto close_fd;
 	}
 	memset(status, 0, cfg.numd << 2);
 
@@ -3226,6 +3408,9 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 		}
 	}
 	free(status);
+
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -3323,8 +3508,10 @@ static int submit_io(int opcode, char *command, const char *desc,
 		return fd;
 
 	dfd = mfd = opcode & 1 ? STDIN_FILENO : STDOUT_FILENO;
-	if (cfg.prinfo > 0xf)
-		return EINVAL;
+	if (cfg.prinfo > 0xf) {
+		err = EINVAL;
+		goto close_fd;
+	}
 
 	dsmgmt = cfg.dsmgmt;
 	control |= (cfg.prinfo << 10);
@@ -3336,7 +3523,8 @@ static int submit_io(int opcode, char *command, const char *desc,
 		if (cfg.dtype > 0xf) {
 			fprintf(stderr, "Invalid directive type, %x\n",
 				cfg.dtype);
-			return EINVAL;
+			err = EINVAL;
+			goto close_fd;
 		}
 		control |= cfg.dtype << 4;
 		dsmgmt |= ((__u32)cfg.dspec) << 16;
@@ -3346,7 +3534,8 @@ static int submit_io(int opcode, char *command, const char *desc,
 		dfd = open(cfg.data, flags, mode);
 		if (dfd < 0) {
 			perror(cfg.data);
-			return EINVAL;
+			err = EINVAL;
+			goto close_fd;
 		}
 		mfd = dfd;
 	}
@@ -3354,17 +3543,19 @@ static int submit_io(int opcode, char *command, const char *desc,
 		mfd = open(cfg.metadata, flags, mode);
 		if (mfd < 0) {
 			perror(cfg.metadata);
-			return EINVAL;
+			err = EINVAL;
+			goto close_dfd;
 		}
 	}
 
 	if (!cfg.data_size)	{
 		fprintf(stderr, "data size not provided\n");
-		return EINVAL;
+		err = EINVAL;
+		goto close_mfd;
 	}
 
 	if (ioctl(fd, BLKPBSZGET, &phys_sector_size) < 0)
-		return errno;
+		goto close_mfd;
 
 	buffer_size = (cfg.block_count + 1) * phys_sector_size;
 	if (cfg.data_size < buffer_size) {
@@ -3376,30 +3567,31 @@ static int submit_io(int opcode, char *command, const char *desc,
 
 	if (posix_memalign(&buffer, getpagesize(), buffer_size)) {
 		fprintf(stderr, "can not allocate io payload\n");
-		return ENOMEM;
+		err = ENOMEM;
+		goto close_mfd;
 	}
 	memset(buffer, 0, cfg.data_size);
 
 	if (cfg.metadata_size) {
 		mbuffer = malloc(cfg.metadata_size);
 		if (!mbuffer) {
- 			free(buffer);
 			fprintf(stderr, "can not allocate io metadata payload\n");
-			return ENOMEM;
+			err = ENOMEM;
+			goto free_buffer;
 		}
 	}
 
 	if ((opcode & 1) && read(dfd, (void *)buffer, cfg.data_size) < 0) {
 		fprintf(stderr, "failed to read data buffer from input file\n");
 		err = EINVAL;
-		goto free_and_return;
+		goto free_mbuffer;
 	}
 
 	if ((opcode & 1) && cfg.metadata_size &&
 				read(mfd, (void *)mbuffer, cfg.metadata_size) < 0) {
 		fprintf(stderr, "failed to read meta-data buffer from input file\n");
 		err = EINVAL;
-		goto free_and_return;
+		goto free_mbuffer;
 	}
 
 	if (cfg.show) {
@@ -3416,7 +3608,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 		printf("apptag       : %04x\n", cfg.app_tag);
 		printf("appmask      : %04x\n", cfg.app_tag_mask);
 		if (cfg.dry_run)
-			goto free_and_return;
+			goto free_mbuffer;
 	}
 
 	gettimeofday(&start_time, NULL);
@@ -3434,19 +3626,26 @@ static int submit_io(int opcode, char *command, const char *desc,
 		if (!(opcode & 1) && write(dfd, (void *)buffer, cfg.data_size) < 0) {
 			fprintf(stderr, "failed to write buffer to output file\n");
 			err = EINVAL;
-			goto free_and_return;
 		} else if (!(opcode & 1) && cfg.metadata_size &&
 				write(mfd, (void *)mbuffer, cfg.metadata_size) < 0) {
 			fprintf(stderr, "failed to write meta-data buffer to output file\n");
 			err = EINVAL;
-			goto free_and_return;
 		} else
 			fprintf(stderr, "%s: Success\n", command);
 	}
- free_and_return:
-	free(buffer);
+
+ free_mbuffer:
 	if (cfg.metadata_size)
 		free(mbuffer);
+ free_buffer:
+	free(buffer);
+ close_mfd:
+	if (strlen(cfg.metadata))
+		close(mfd);
+ close_dfd:
+	close(dfd);
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -3528,7 +3727,8 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
 		if (posix_memalign(&sec_buf, getpagesize(), cfg.size)) {
 			fprintf(stderr, "No memory for security size:%d\n",
 								cfg.size);
-			return ENOMEM;
+			err = ENOMEM;
+			goto close_fd;
 		}
 	}
 
@@ -3550,6 +3750,8 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
 
 	free(sec_buf);
 
+ close_fd:
+	close(fd);
 	return err;
 }
 
@@ -3615,7 +3817,8 @@ static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin
                         break;
                 default:
                         fprintf(stderr, "invalid directive operations for Identify Directives\n");
-                        return EINVAL;
+                        err = EINVAL;
+			goto close_fd;
                 }
                 break;
         case NVME_DIR_STREAMS:
@@ -3633,18 +3836,21 @@ static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin
                         break;
                 default:
                         fprintf(stderr, "invalid directive operations for Streams Directives\n");
-                        return EINVAL;
+                        err = EINVAL;
+			goto close_fd;
                 }
                 break;
         default:
                 fprintf(stderr, "invalid directive type\n");
-                return EINVAL;
-                break;
+                err = EINVAL;
+		goto close_fd;
         }
 
         if (cfg.data_len) {
-                if (posix_memalign(&buf, getpagesize(), cfg.data_len))
-                        exit(ENOMEM);
+                if (posix_memalign(&buf, getpagesize(), cfg.data_len)) {
+			err = ENOMEM;
+			goto close_fd;
+		}
                 memset(buf, 0, cfg.data_len);
         }
 
@@ -3672,10 +3878,12 @@ static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin
         else if (err > 0)
                 fprintf(stderr, "NVMe Status:%s(%x)\n",
                                 nvme_status_to_string(err), err);
-free:
-        if (buf)
-                free(buf);
-        return err;
+ free:
+	if (cfg.data_len)
+		free(buf);
+ close_fd:
+	close(fd);
+	return err;
 }
 
 static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, struct command *cmd)
@@ -3787,7 +3995,8 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 			   S_IRUSR | S_IRGRP | S_IROTH);
 		if (wfd < 0) {
 			perror(cfg.input_file);
-			return EINVAL;
+			err = EINVAL;
+			goto close_fd;
 		}
 	}
 
@@ -3795,7 +4004,8 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		metadata = malloc(cfg.metadata_len);
 		if (!metadata) {
 			fprintf(stderr, "can not allocate metadata payload\n");
-			return ENOMEM;
+			err = ENOMEM;
+			goto close_fd;
 		}
 	}
 	if (cfg.data_len) {
@@ -3803,19 +4013,20 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 			if (metadata)
 				free(metadata);
 			fprintf(stderr, "can not allocate data payload\n");
-			return ENOMEM;
+			err = ENOMEM;
+			goto free_metadata;
 		}
 
 		memset(data, cfg.prefill, cfg.data_len);
 		if (!cfg.read && !cfg.write) {
 			fprintf(stderr, "data direction not given\n");
 			err = EINVAL;
-			goto free_and_return;
+			goto free_data;
 		} else if (cfg.write) {
 			if (read(wfd, data, cfg.data_len) < 0) {
 				fprintf(stderr, "failed to read write buffer\n");
 				err = EINVAL;
-				goto free_and_return;
+				goto free_data;
 			}
 		}
 	}
@@ -3839,7 +4050,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		printf("cdw15        : %08x\n", cfg.cdw15);
 		printf("timeout_ms   : %08x\n", cfg.timeout);
 		if (cfg.dry_run)
-			goto free_and_return;
+			goto free_data;
 	}
 
 	err = nvme_passthru(fd, ioctl_cmd, cfg.opcode, cfg.flags, cfg.rsvd,
@@ -3861,9 +4072,14 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 			d_raw((unsigned char *)data, cfg.data_len);
 	}
 
-free_and_return:
-	free(data);
-	free(metadata);
+ free_data:
+	if (cfg.data_len)
+		free(data);
+ free_metadata:
+	if (cfg.metadata_len)
+		free(metadata);
+ close_fd:
+	close(fd);
 	return err;
 }
 
-- 
2.7.4
