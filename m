From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 18 Jun 2019 22:12:10 +0900
Subject: [PATCH V7 1/7] nvme: Do not return in the middle of the subcommand
In-Reply-To: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
References: <20190618131216.3661-1-minwoo.im.dev@gmail.com>
Message-ID: <20190618131216.3661-2-minwoo.im.dev@gmail.com>

To make nvme-cli subcommand return a mapped errno value to main(), it
should return the error status in a single place because it would be
great if the return statements and free operations are in an one shot
place.

This patch makes all the subcommands in nvme module return the error
which means internal error which should be in negative and nvme error
status which is in positive at the end of the subcommand.

Most of the changed parts are file descriptors which is returned from
parse_and_open() function.  The "fd" could be in a negative value so
that it needs to be mapped to a uniformed errno value which will be
applied by the next patches.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme.c | 427 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 278 insertions(+), 149 deletions(-)

diff --git a/nvme.c b/nvme.c
index 2fd4362..bb61322 100644
--- a/nvme.c
+++ b/nvme.c
@@ -193,8 +193,10 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -220,6 +222,7 @@ static int get_smart_log(int argc, char **argv, struct command *cmd, struct plug
  close_fd:
 	close(fd);
 
+ ret:
 	return err;
 }
 
@@ -249,8 +252,10 @@ static int get_ana_log(int argc, char **argv, struct command *cmd,
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -292,6 +297,7 @@ static int get_ana_log(int argc, char **argv, struct command *cmd,
 	free(ana_log);
 close_fd:
 	close(fd);
+ret:
 	return err;
 }
 
@@ -330,8 +336,10 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.file_name) {
 		fprintf(stderr, "Please provide an output file!\n");
@@ -419,6 +427,7 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
 	free(page_log);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -449,8 +458,10 @@ static int get_endurance_log(int argc, char **argv, struct command *cmd, struct
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -473,6 +484,7 @@ static int get_endurance_log(int argc, char **argv, struct command *cmd, struct
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -505,8 +517,10 @@ static int get_effects_log(int argc, char **argv, struct command *cmd, struct pl
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -535,6 +549,7 @@ static int get_effects_log(int argc, char **argv, struct command *cmd, struct pl
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -567,8 +582,10 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -619,6 +636,7 @@ static int get_error_log(int argc, char **argv, struct command *cmd, struct plug
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -646,8 +664,10 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -673,6 +693,7 @@ static int get_fw_log(int argc, char **argv, struct command *cmd, struct plugin
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -701,8 +722,10 @@ static int get_changed_ns_list_log(int argc, char **argv, struct command *cmd, s
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -728,7 +751,7 @@ static int get_changed_ns_list_log(int argc, char **argv, struct command *cmd, s
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -780,8 +803,10 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.aen) {
 		cfg.log_len = 4096;
@@ -828,6 +853,7 @@ static int get_log(int argc, char **argv, struct command *cmd, struct plugin *pl
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -860,8 +886,10 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		ret = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -890,7 +918,7 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
 
  close_fd:
 	close(fd);
-
+ ret:
 	return ret;
 }
 
@@ -919,8 +947,10 @@ static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (posix_memalign((void *)&cntlist, getpagesize(), 0x1000)) {
 		fprintf(stderr, "can not allocate controller list payload\n");
@@ -944,7 +974,7 @@ static int list_ctrl(int argc, char **argv, struct command *cmd, struct plugin *
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -973,8 +1003,10 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.namespace_id) {
 		err = -EINVAL;
@@ -996,7 +1028,7 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -1041,8 +1073,10 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
@@ -1068,7 +1102,7 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -1096,8 +1130,10 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.namespace_id) {
 		fprintf(stderr, "%s: namespace-id parameter required\n",
@@ -1133,7 +1169,7 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -1203,8 +1239,10 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.flbas != 0xff && cfg.bs != 0x00) {
 		fprintf(stderr,
@@ -1261,7 +1299,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -1699,7 +1737,7 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 
 	ret = argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
 	if (ret < 0)
-		return ret;
+		goto ret;
 
 	devicename = NULL;
 	if (optind < argc) {
@@ -1711,29 +1749,30 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 			   &cfg.namespace_id) != 2) {
 			fprintf(stderr, "%s is not a NVMe namespace device\n",
 				argv[optind]);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto ret;
 		}
 		sprintf(path, "/sys/block/%s/device", devicename);
 		subsysnqn = get_nvme_subsnqn(path);
 		if (!subsysnqn) {
 			fprintf(stderr, "Cannot read subsys NQN from %s\n",
 				devicename);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto ret;
 		}
 		optind++;
 	}
 
 	if (ret < 0) {
 		argconfig_print_help(desc, opts);
-		if (subsysnqn)
-			free(subsysnqn);
-		return ret;
+		goto free;
 	}
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt != JSON && fmt != NORMAL) {
 		if (subsysnqn)
 			free(subsysnqn);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free;
 	}
 
 	slist = get_subsys_list(&subcnt, subsysnqn, cfg.namespace_id);
@@ -1744,8 +1783,11 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 		show_nvme_subsystem_list(slist, subcnt);
 
 	free_subsys_list(slist, subcnt);
+free:
 	if (subsysnqn)
 		free(subsysnqn);
+
+ret:
 	return ret;
 }
 
@@ -1817,17 +1859,20 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 
 	ret = argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
 	if (ret < 0)
-		return ret;
+		goto ret;
 
 	fmt = validate_output_format(cfg.output_format);
 
-	if (fmt != JSON && fmt != NORMAL)
-		return -EINVAL;
+	if (fmt != JSON && fmt != NORMAL) {
+		ret = -EINVAL;
+		goto ret;
+	}
 
 	n = scandir(dev, &devices, scan_dev_filter, alphasort);
 	if (n < 0) {
 		fprintf(stderr, "no NVMe device(s) detected.\n");
-		return n;
+		ret = n;
+		goto ret;
 	}
 
 	list_items = calloc(n, sizeof(*list_items));
@@ -1875,7 +1920,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	for (i = 0; i < n; i++)
 		free(devices[i]);
 	free(devices);
-
+ ret:
 	return ret;
 }
 
@@ -1913,8 +1958,10 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -1949,7 +1996,7 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -1986,8 +2033,10 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -2030,7 +2079,7 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2074,8 +2123,10 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -2117,7 +2168,7 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2148,8 +2199,10 @@ static int id_nvmset(int argc, char **argv, struct command *cmd, struct plugin *
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -2173,15 +2226,15 @@ static int id_nvmset(int argc, char **argv, struct command *cmd, struct plugin *
 	else
 		perror("identify nvm set list");
 
- close_fd:
+close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
 static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
-	int nsid, fd;
+	int err = 0, nsid, fd;
 	const char *desc = "Get namespce ID of a the block device.";
 
 	const struct argconfig_commandline_options command_line_options[] = {
@@ -2189,18 +2242,23 @@ static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
+
 	nsid = nvme_get_nsid(fd);
 	if (nsid <= 0) {
 		perror(devicename);
-		close(fd);
-		return errno;
+		err = errno;
+		goto close_fd;
 	}
 	printf("%s: namespace-id:%d\n", devicename, nsid);
 
+ close_fd:
 	close(fd);
-	return 0;
+ ret:
+	return err;
 }
 
 static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugin *plugin)
@@ -2248,8 +2306,10 @@ static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugi
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	cfg.cdw10 = cfg.cntlid << 16;
 	cfg.cdw10 = cfg.cdw10 | (cfg.rt << 8);
@@ -2264,6 +2324,7 @@ static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugi
 		perror("virt-mgmt");
 
 	close(fd);
+ret:
 	return err;
 
 }
@@ -2301,8 +2362,10 @@ static int list_secondary_ctrl(int argc, char **argv, struct command *cmd, struc
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -2340,7 +2403,7 @@ static int list_secondary_ctrl(int argc, char **argv, struct command *cmd, struc
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -2374,8 +2437,10 @@ static int device_self_test(int argc, char **argv, struct command *cmd, struct p
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	err = nvme_self_test_start(fd, cfg.namespace_id, cfg.cdw10);
 	if (!err) {
@@ -2389,6 +2454,7 @@ static int device_self_test(int argc, char **argv, struct command *cmd, struct p
 		perror("Device self-test");
 
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -2414,8 +2480,10 @@ static int self_test_log(int argc, char **argv, struct command *cmd, struct plug
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -2444,7 +2512,7 @@ static int self_test_log(int argc, char **argv, struct command *cmd, struct plug
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2500,8 +2568,10 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.sel > 7) {
 		fprintf(stderr, "invalid 'select' param:%d\n", cfg.sel);
@@ -2575,7 +2645,7 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2617,8 +2687,10 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fw_fd = open(cfg.fw, O_RDONLY);
 	cfg.offset <<= 2;
@@ -2680,7 +2752,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	close(fw_fd);
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2726,8 +2798,10 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.slot > 7) {
 		fprintf(stderr, "invalid slot:%d\n", cfg.slot);
@@ -2773,7 +2847,7 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2787,21 +2861,22 @@ static int subsystem_reset(int argc, char **argv, struct command *cmd, struct pl
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	err = nvme_subsystem_reset(fd);
 	if (err < 0) {
-		close(fd);
 		if (errno == ENOTTY)
 			fprintf(stderr,
 				"Subsystem-reset: NVM Subsystem Reset not supported.\n");
 		else
 			perror("Subsystem-reset");
-		return errno;
 	}
 
 	close(fd);
+ret:
 	return err;
 }
 
@@ -2815,17 +2890,17 @@ static int reset(int argc, char **argv, struct command *cmd, struct plugin *plug
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	err = nvme_reset_controller(fd);
-	if (err < 0) {
-		close(fd);
+	if (err < 0)
 		perror("Reset");
-		return errno;
-	}
 
 	close(fd);
+ret:
 	return err;
 }
 
@@ -2839,17 +2914,17 @@ static int ns_rescan(int argc, char **argv, struct command *cmd, struct plugin *
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	err = nvme_ns_rescan(fd);
-	if (err < 0) {
-		close(fd);
+	if (err < 0)
 		perror("Namespace Rescan");
-		return errno;
-	}
 
 	close(fd);
+ret:
 	return err;
 }
 
@@ -2895,8 +2970,10 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		ret = fd;
+		goto ret;
+	}
 
 	switch (cfg.sanact) {
 	case NVME_SANITIZE_ACT_CRYPTO_ERASE:
@@ -2941,7 +3018,7 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 
  close_fd:
 	close(fd);
-
+ ret:
 	return ret;
 }
 
@@ -2973,8 +3050,10 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -3014,7 +3093,7 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3046,8 +3125,10 @@ static int get_property(int argc, char **argv, struct command *cmd, struct plugi
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.offset == -1) {
 		fprintf(stderr, "offset required param");
@@ -3066,7 +3147,7 @@ static int get_property(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3095,8 +3176,10 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.offset == -1) {
 		fprintf(stderr, "offset required param");
@@ -3121,7 +3204,7 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3181,8 +3264,10 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.lbaf != 0xff && cfg.bs !=0) {
 		fprintf(stderr,
@@ -3282,7 +3367,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3340,8 +3425,10 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.feature_id) {
 		fprintf(stderr, "feature-id required param\n");
@@ -3402,6 +3489,7 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 		free(buf);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3451,8 +3539,10 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	sec_fd = open(cfg.file, O_RDONLY);
 	if (sec_fd < 0) {
@@ -3498,6 +3588,7 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 	close(sec_fd);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3558,8 +3649,10 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	switch (cfg.dtype) {
 	case NVME_DIR_IDENTIFY:
@@ -3649,6 +3742,7 @@ free:
 		free(buf);
 close_fd:
 	close(fd);
+ret:
 	return err;
 }
 
@@ -3681,8 +3775,10 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
@@ -3703,7 +3799,7 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -3761,8 +3857,10 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.prinfo > 0xf) {
 		err = EINVAL;
@@ -3795,6 +3893,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3855,8 +3954,10 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	nc = argconfig_parse_comma_sep_array(cfg.ctx_attrs, ctx_attrs, ARRAY_SIZE(ctx_attrs));
 	nb = argconfig_parse_comma_sep_array(cfg.blocks, nlbs, ARRAY_SIZE(nlbs));
@@ -3895,6 +3996,7 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3922,8 +4024,10 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (S_ISBLK(nvme_stat.st_mode)) {
 		cfg.namespace_id = get_nsid(fd);
@@ -3942,6 +4046,7 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 		printf("NVMe Flush: success\n");
 close_fd:
 	close(fd);
+ret:
 	return err;
 }
 
@@ -3989,8 +4094,10 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
@@ -4016,6 +4123,7 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4060,8 +4168,10 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
@@ -4093,6 +4203,7 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4139,8 +4250,10 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (!cfg.namespace_id) {
 		cfg.namespace_id = get_nsid(fd);
@@ -4166,6 +4279,7 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4209,8 +4323,10 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	fmt = validate_output_format(cfg.output_format);
 	if (fmt < 0) {
@@ -4260,6 +4376,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4353,8 +4470,10 @@ static int submit_io(int opcode, char *command, const char *desc,
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	dfd = mfd = opcode & 1 ? STDIN_FILENO : STDOUT_FILENO;
 	if (cfg.prinfo > 0xf) {
@@ -4505,6 +4624,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 	close(dfd);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4579,8 +4699,10 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (cfg.size) {
 		if (posix_memalign(&sec_buf, getpagesize(), cfg.size)) {
@@ -4611,6 +4733,7 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4664,8 +4787,10 @@ static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	switch (cfg.dtype) {
 	case NVME_DIR_IDENTIFY:
@@ -4741,6 +4866,7 @@ free:
 		free(buf);
 close_fd:
 	close(fd);
+ret:
 	return err;
 }
 
@@ -4845,8 +4971,10 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	};
 
 	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
-	if (fd < 0)
-		return fd;
+	if (fd < 0) {
+		err = fd;
+		goto ret;
+	}
 
 	if (strlen(cfg.input_file)){
 		wfd = open(cfg.input_file, O_RDONLY,
@@ -4941,6 +5069,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		close(wfd);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
-- 
2.21.0
