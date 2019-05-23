From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 23 May 2019 23:57:45 +0900
Subject: [PATCH V5 1/6] nvme: Do not return in the middle of the subcommand
In-Reply-To: <20190523145750.27425-1-minwoo.im.dev@gmail.com>
References: <20190523145750.27425-1-minwoo.im.dev@gmail.com>
Message-ID: <20190523145750.27425-2-minwoo.im.dev@gmail.com>

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
Cc: Chaitanya Kulkarni <chaitanya.Kulkarni at wdc.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme.c | 425 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 277 insertions(+), 148 deletions(-)

diff --git a/nvme.c b/nvme.c
index 9819fcb..88b2cfc 100644
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
 
 	err = nvme_identify_ns_list(fd, cfg.namespace_id, !!cfg.all, ns_list);
 	if (!err) {
@@ -988,7 +1020,7 @@ static int list_ns(int argc, char **argv, struct command *cmd, struct plugin *pl
 		perror("id namespace list");
 
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -1033,8 +1065,10 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
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
@@ -1060,7 +1094,7 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -1088,8 +1122,10 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
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
@@ -1125,7 +1161,7 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -1195,8 +1231,10 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
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
@@ -1253,7 +1291,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -1691,7 +1729,7 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 
 	ret = argconfig_parse(argc, argv, desc, opts, &cfg, sizeof(cfg));
 	if (ret < 0)
-		return ret;
+		goto ret;
 
 	devicename = NULL;
 	if (optind < argc) {
@@ -1703,29 +1741,30 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
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
@@ -1736,8 +1775,11 @@ static int list_subsys(int argc, char **argv, struct command *cmd,
 		show_nvme_subsystem_list(slist, subcnt);
 
 	free_subsys_list(slist, subcnt);
+ free:
 	if (subsysnqn)
 		free(subsysnqn);
+
+ ret:
 	return ret;
 }
 
@@ -1809,17 +1851,20 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 
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
@@ -1867,7 +1912,7 @@ static int list(int argc, char **argv, struct command *cmd, struct plugin *plugi
 	for (i = 0; i < n; i++)
 		free(devices[i]);
 	free(devices);
-
+ ret:
 	return ret;
 }
 
@@ -1905,8 +1950,10 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
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
@@ -1941,7 +1988,7 @@ int __id_ctrl(int argc, char **argv, struct command *cmd, struct plugin *plugin,
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -1978,8 +2025,10 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
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
@@ -2022,7 +2071,7 @@ static int ns_descs(int argc, char **argv, struct command *cmd, struct plugin *p
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2066,8 +2115,10 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
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
@@ -2109,7 +2160,7 @@ static int id_ns(int argc, char **argv, struct command *cmd, struct plugin *plug
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2140,8 +2191,10 @@ static int id_nvmset(int argc, char **argv, struct command *cmd, struct plugin *
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
@@ -2167,13 +2220,13 @@ static int id_nvmset(int argc, char **argv, struct command *cmd, struct plugin *
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
 static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
-	int nsid, fd;
+	int err = 0, nsid, fd;
 	const char *desc = "Get namespce ID of a the block device.";
 
 	const struct argconfig_commandline_options command_line_options[] = {
@@ -2181,18 +2234,23 @@ static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *
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
@@ -2240,8 +2298,10 @@ static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugi
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
@@ -2256,6 +2316,7 @@ static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugi
 		perror("virt-mgmt");
 
 	close(fd);
+ ret:
 	return err;
 
 }
@@ -2293,8 +2354,10 @@ static int list_secondary_ctrl(int argc, char **argv, struct command *cmd, struc
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
@@ -2332,7 +2395,7 @@ static int list_secondary_ctrl(int argc, char **argv, struct command *cmd, struc
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -2366,8 +2429,10 @@ static int device_self_test(int argc, char **argv, struct command *cmd, struct p
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
@@ -2381,6 +2446,7 @@ static int device_self_test(int argc, char **argv, struct command *cmd, struct p
 		perror("Device self-test");
 
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -2406,8 +2472,10 @@ static int self_test_log(int argc, char **argv, struct command *cmd, struct plug
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
@@ -2436,7 +2504,7 @@ static int self_test_log(int argc, char **argv, struct command *cmd, struct plug
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2492,8 +2560,10 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
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
@@ -2567,7 +2637,7 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2609,8 +2679,10 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
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
@@ -2672,7 +2744,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	close(fw_fd);
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2718,8 +2790,10 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
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
@@ -2765,7 +2839,7 @@ static int fw_commit(int argc, char **argv, struct command *cmd, struct plugin *
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -2779,21 +2853,22 @@ static int subsystem_reset(int argc, char **argv, struct command *cmd, struct pl
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
+ ret:
 	return err;
 }
 
@@ -2807,17 +2882,17 @@ static int reset(int argc, char **argv, struct command *cmd, struct plugin *plug
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
+ ret:
 	return err;
 }
 
@@ -2831,17 +2906,17 @@ static int ns_rescan(int argc, char **argv, struct command *cmd, struct plugin *
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
+ ret:
 	return err;
 }
 
@@ -2887,8 +2962,10 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
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
@@ -2933,7 +3010,7 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 
  close_fd:
 	close(fd);
-
+ ret:
 	return ret;
 }
 
@@ -2965,8 +3042,10 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
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
@@ -3006,7 +3085,7 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3038,8 +3117,10 @@ static int get_property(int argc, char **argv, struct command *cmd, struct plugi
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
@@ -3058,7 +3139,7 @@ static int get_property(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3087,8 +3168,10 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
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
@@ -3113,7 +3196,7 @@ static int set_property(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3173,8 +3256,10 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
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
@@ -3274,7 +3359,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 
  close_fd:
 	close(fd);
-
+ ret:
 	return err;
 }
 
@@ -3332,8 +3417,10 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
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
@@ -3394,6 +3481,7 @@ static int set_feature(int argc, char **argv, struct command *cmd, struct plugin
 		free(buf);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3443,8 +3531,10 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
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
@@ -3490,6 +3580,7 @@ static int sec_send(int argc, char **argv, struct command *cmd, struct plugin *p
 	close(sec_fd);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3550,8 +3641,10 @@ static int dir_send(int argc, char **argv, struct command *cmd, struct plugin *p
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
@@ -3641,6 +3734,7 @@ free:
 		free(buf);
 close_fd:
 	close(fd);
+ret:
 	return err;
 }
 
@@ -3673,8 +3767,10 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
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
@@ -3695,7 +3791,7 @@ static int write_uncor(int argc, char **argv, struct command *cmd, struct plugin
 
 close_fd:
 	close(fd);
-
+ret:
 	return err;
 }
 
@@ -3753,8 +3849,10 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
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
@@ -3787,6 +3885,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3847,8 +3946,10 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
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
@@ -3887,6 +3988,7 @@ static int dsm(int argc, char **argv, struct command *cmd, struct plugin *plugin
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -3914,8 +4016,10 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
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
@@ -3934,6 +4038,7 @@ static int flush(int argc, char **argv, struct command *cmd, struct plugin *plug
 		printf("NVMe Flush: success\n");
 close_fd:
 	close(fd);
+ret:
 	return err;
 }
 
@@ -3981,8 +4086,10 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
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
@@ -4008,6 +4115,7 @@ static int resv_acquire(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4052,8 +4160,10 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
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
@@ -4085,6 +4195,7 @@ static int resv_register(int argc, char **argv, struct command *cmd, struct plug
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4131,8 +4242,10 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
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
@@ -4158,6 +4271,7 @@ static int resv_release(int argc, char **argv, struct command *cmd, struct plugi
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4201,8 +4315,10 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
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
@@ -4252,6 +4368,7 @@ static int resv_report(int argc, char **argv, struct command *cmd, struct plugin
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4345,8 +4462,10 @@ static int submit_io(int opcode, char *command, const char *desc,
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
@@ -4497,6 +4616,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 	close(dfd);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4571,8 +4691,10 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
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
@@ -4603,6 +4725,7 @@ static int sec_recv(int argc, char **argv, struct command *cmd, struct plugin *p
 
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
@@ -4656,8 +4779,10 @@ static int dir_receive(int argc, char **argv, struct command *cmd, struct plugin
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
@@ -4733,6 +4858,7 @@ free:
 		free(buf);
 close_fd:
 	close(fd);
+ret:
 	return err;
 }
 
@@ -4837,8 +4963,10 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
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
@@ -4933,6 +5061,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		close(wfd);
  close_fd:
 	close(fd);
+ ret:
 	return err;
 }
 
-- 
2.21.0
