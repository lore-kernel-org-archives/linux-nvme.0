From: jeff.lien@wdc.com (jeffreyalien)
Date: Fri, 22 Sep 2017 16:51:45 -0500
Subject: [PATCH 1/2] nvme-cli : Add Namespace Rescan Command
Message-ID: <1506117105-21330-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: jeffreyalien <jeff.lien at wdc.com>
---
 nvme-builtin.h |  1 +
 nvme-ioctl.c   | 10 ++++++++++
 nvme-ioctl.h   |  1 +
 nvme.c         | 21 +++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/nvme-builtin.h b/nvme-builtin.h
index b24c25b..a96d42e 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -46,6 +46,7 @@ COMMAND_LIST(
 	ENTRY("sanitize-log", "Retrive sanitize log, show it", sanitize_log)
 	ENTRY("reset", "Resets the controller", reset)
 	ENTRY("subsystem-reset", "Resets the controller", subsystem_reset)
+	ENTRY("ns-rescan", "Rescans the NVME namespaces", ns_rescan)
 	ENTRY("show-regs", "Shows the controller registers. Requires admin character device", show_registers)
 	ENTRY("discover", "Discover NVMeoF subsystems", discover_cmd)
 	ENTRY("connect-all", "Discover and Connect to NVMeoF subsystems", connect_all_cmd)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 52243fa..1843faf 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -58,6 +58,16 @@ int nvme_reset_controller(int fd)
 	return ioctl(fd, NVME_IOCTL_RESET);
 }
 
+int nvme_ns_rescan(int fd)
+{
+	int ret;
+
+	ret = nvme_verify_chr(fd);
+	if (ret)
+		return ret;
+	return ioctl(fd, NVME_IOCTL_RESCAN);
+}
+
 int nvme_get_nsid(int fd)
 {
 	static struct stat nvme_stat;
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 4aee90a..6b3e0b4 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -115,6 +115,7 @@ int nvme_sec_recv(int fd, __u32 nsid, __u8 nssf, __u16 spsp,
 
 int nvme_subsystem_reset(int fd);
 int nvme_reset_controller(int fd);
+int nvme_ns_rescan(int fd);
 
 int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
diff --git a/nvme.c b/nvme.c
index d495cbb..6ff5002 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1501,6 +1501,27 @@ static int reset(int argc, char **argv, struct command *cmd, struct plugin *plug
 	return err;
 }
 
+static int ns_rescan(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "Rescans the NVMe namespaces\n";
+	int err, fd;
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	err = nvme_ns_rescan(fd);
+	if (err < 0) {
+		perror("Namespace Rescan");
+		return errno;
+	}
+	return err;
+}
+
 static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *plugin)
 {
 	char *desc = "Send a sanitize command.";
-- 
1.8.3.1
