From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Thu, 14 Jun 2018 17:24:22 -0600
Subject: [PATCH] nvme-cli: Implemented virtualization management admin command
Message-ID: <20180614232422.5570-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 nvme-builtin.h |  1 +
 nvme-ioctl.c   | 11 +++++++++
 nvme-ioctl.h   |  1 +
 nvme.c         | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/nvme-builtin.h b/nvme-builtin.h
index 86b0fff..c7f1812 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -63,6 +63,7 @@ COMMAND_LIST(
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
+	ENTRY("virtualization-management", "Manage the resource virtualization in controller", virtual_mgmt)
 );
 
 #endif
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 63ff8fb..3e1ed07 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -817,3 +817,14 @@ int nvme_self_test_start(int fd, __u32 nsid, __u32 cdw10)
 
 	return nvme_submit_admin_passthru(fd, &cmd);
 }
+
+int nvme_virtual_mgmt(int fd, __u32 cdw10, __u32 cdw11)
+{
+	struct nvme_admin_cmd cmd = {
+		.opcode = nvme_admin_virtual_mgmt,
+		.cdw10  = cdw10,
+		.cdw11  = cdw11,
+	};
+
+	return nvme_submit_admin_passthru(fd, &cmd);
+}
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 6d4ac95..78d05fd 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -138,4 +138,5 @@ int nvme_sanitize(int fd, __u8 sanact, __u8 ause, __u8 owpass, __u8 oipbp,
 		  __u8 no_dealloc, __u32 ovrpat);
 int nvme_self_test_start(int fd, __u32 nsid, __u32 cdw10);
 int nvme_self_test_log(int fd, struct nvme_self_test_log *self_test_log);
+int nvme_virtual_mgmt(int fd, __u32 cdw10, __u32 cdw11);
 #endif				/* _NVME_LIB_H */
diff --git a/nvme.c b/nvme.c
index db0337a..09f55b2 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1881,6 +1881,69 @@ static int get_ns_id(int argc, char **argv, struct command *cmd, struct plugin *
 	return 0;
 }
 
+static int virtual_mgmt(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc  = "The Virtualization Management command is supported by primary controllers "\
+		"that support the Virtualization Enhancements capability.This command is used for "\
+		"1. Modifying Flexible Resource allocation for the primary controller  "\
+		"2. Assigning Flexible Resources for secondary controllers; and "\
+		"3. Setting the Online and Offline state for secondary controllers";
+	const char *cntlid = "This field indicates the controller for which controller resources "\
+		"are to be modified.";
+	const char *rt = "Indicate the Resource Type (RT) : \n"\
+		"1. 0 - VQ Resources.\n"\
+		"2. 1 - VI Resources.\n\n";
+	const char *act = "Indicate the Action (ACT) : \n"\
+		"1. 1 - Primary Controller Flexible Allocation\n"\
+		"2. 7 - Secondary Controller Offline\n"\
+		"3. 8 - Secondary Controller Assign\n"\
+		"4. 9 - Secondary Controller Online";
+	const char *cdw11 = "Indicate the Number of Controller Resources (NR)";
+	int fd, err;
+
+	struct config {
+		int	cntlid;
+		int	rt;
+		int 	act;
+		__u32	cdw10;
+		__u32	cdw11;
+	};
+
+	struct config cfg = {
+		.cntlid 	= 0,
+		.rt 		= 0,
+		.act		= 0,
+		.cdw10		= 0,
+		.cdw11		= 0,
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"Controller-identifier",	   'c', "NUM", CFG_POSITIVE, &cfg.cntlid, required_argument, cntlid},
+		{"Resource-type", 		   'r', "NUM", CFG_POSITIVE, &cfg.rt,     required_argument, rt},
+		{"Action", 			   'a', "NUM", CFG_POSITIVE, &cfg.act,    required_argument, act},
+		{"Number-of-controller-resources", 'n', "NUM", CFG_POSITIVE, &cfg.cdw11,  required_argument, cdw11},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (fd < 0)
+		return fd;
+
+	cfg.cdw10 = cfg.cntlid << 16;
+	cfg.cdw10 = cfg.cdw10 | (cfg.rt << 8);
+	cfg.cdw10 = cfg.cdw10 | cfg.act;
+
+	err = nvme_virtual_mgmt(fd, cfg.cdw10, cfg.cdw11);
+	if (err > 0) {
+		fprintf(stderr, "NVMe Status:%s(%x) \n",
+			nvme_status_to_string(err), err);
+	} else if (err < 0)
+		perror("Virtualization Management command");
+
+	close(fd);
+	return err;
+}
+
 static int device_self_test(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	const char *desc  = "Implementing the device self-test feature"\
-- 
2.17.1
