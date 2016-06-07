From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:26 +0200
Subject: [PATCH 10/11] Implement disconnect command
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-11-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

Example usage:

Disconnect by NQN,
nvme disconnect -n nqn.testiqn

or by device name,
nvme disconnect -d nvme0

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
Tested-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
---
 fabrics.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fabrics.h |   1 +
 nvme.c    |   7 ++++
 3 files changed, 122 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 84dde2b..0a60258 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -46,6 +46,7 @@ struct config {
 	char *traddr;
 	char *trsvcid;
 	char *raw;
+	char *device;
 } cfg = { 0 };
 
 #define BUF_SIZE		4096
@@ -452,3 +453,116 @@ int connect(const char *desc, int argc, char **argv)
 		return instance;
 	return 0;
 }
+
+static int disconnect_subsys(struct udev_enumerate *enumerate, char *nqn)
+{
+	struct udev_list_entry *list_entry;
+	const char *subsysnqn;
+	char *sysfs_path;
+	int ret = 1;
+
+	udev_list_entry_foreach(list_entry, udev_enumerate_get_list_entry(enumerate)) {
+		struct udev_device *device;
+
+		device = udev_device_new_from_syspath(udev_enumerate_get_udev(enumerate),
+						udev_list_entry_get_name(list_entry));
+		if (device != NULL) {
+			subsysnqn = udev_device_get_sysattr_value(device, "subsysnqn");
+			if (subsysnqn && !strcmp(subsysnqn, nqn)) {
+				if (asprintf(&sysfs_path, "%s/delete_controller",
+						udev_device_get_syspath(device)) < 0) {
+					ret = errno;
+					udev_device_unref(device);
+					break;
+				}
+				udev_device_unref(device);
+				ret = remove_ctrl_by_path(sysfs_path);
+				free(sysfs_path);
+				break;
+			}
+			udev_device_unref(device);
+		}
+	}
+
+	return ret;
+}
+
+static int disconnect_by_nqn(char *nqn)
+{
+	struct udev *udev;
+	struct udev_enumerate *udev_enumerate;
+	int ret;
+
+	if (strlen(nqn) > NVMF_NQN_SIZE) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	udev = udev_new();
+	if (!udev) {
+		fprintf(stderr, "failed to create udev\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	udev_enumerate = udev_enumerate_new(udev);
+	if (udev_enumerate == NULL) {
+		ret = -ENOMEM;
+		goto free_udev;
+	}
+
+	udev_enumerate_add_match_subsystem(udev_enumerate, "nvme");
+	udev_enumerate_scan_devices(udev_enumerate);
+	ret = disconnect_subsys(udev_enumerate, nqn);
+	udev_enumerate_unref(udev_enumerate);
+
+free_udev:
+	udev_unref(udev);
+exit:
+	return ret;
+}
+
+static int disconnect_by_device(char *device)
+{
+	int instance;
+	int ret;
+
+	ret = sscanf(device, "nvme%d", &instance);
+	if (ret < 0)
+		return ret;
+
+	return remove_ctrl(instance);
+}
+
+int disconnect(const char *desc, int argc, char **argv)
+{
+	const char *nqn = "nqn name";
+	const char *device = "nvme device";
+	int ret = 0;
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"nqn", 'n', "LIST", CFG_STRING, &cfg.nqn, required_argument, nqn},
+		{"device", 'd', "LIST", CFG_STRING, &cfg.device, required_argument, device},
+		{0},
+	};
+
+	argconfig_parse(argc, argv, desc, command_line_options, &cfg, sizeof(cfg));
+	if (!cfg.nqn && !cfg.device) {
+		fprintf(stderr, "need a -n or -d argument\n");
+		return -EINVAL;
+	}
+
+	if (cfg.nqn) {
+		ret = disconnect_by_nqn(cfg.nqn);
+		if (ret)
+			fprintf(stderr, "Failed to disconnect by NQN: %s\n", cfg.nqn);
+	}
+
+	if (cfg.device) {
+		ret = disconnect_by_device(cfg.device);
+		if (ret)
+			fprintf(stderr, "Failed to disconnect by device name: %s\n", cfg.device);
+	}
+
+	return ret;
+}
diff --git a/fabrics.h b/fabrics.h
index 43072a1..7e3eb19 100644
--- a/fabrics.h
+++ b/fabrics.h
@@ -3,5 +3,6 @@
 
 extern int discover(const char *desc, int argc, char **argv);
 extern int connect(const char *desc, int argc, char **argv);
+extern int disconnect(const char *desc, int argc, char **argv);
 
 #endif
diff --git a/nvme.c b/nvme.c
index 902d84b..e403022 100644
--- a/nvme.c
+++ b/nvme.c
@@ -116,6 +116,7 @@ static const char nvme_version_string[] = NVME_VERSION;
 	ENTRY(LNVM_BBTBL_SET, "lnvm-diag-set-bbtbl", "Update bad block table", lnvm_set_bbtbl) \
 	ENTRY(DISCOVER, "discover", "Discover NVMeoF subsystems", discover_cmd) \
 	ENTRY(CONNECT, "connect", "Connect to NVMeoF subsystem", connect_cmd) \
+	ENTRY(DISCONNECT, "disconnect", "Disconnect from NVMeoF subsystem", disconnect_cmd) \
 	ENTRY(VERSION, "version", "Shows the program version", version) \
 	ENTRY(HELP, "help", "Display this help", help)
 
@@ -2853,6 +2854,12 @@ static int connect_cmd(int argc, char **argv)
 	return connect(desc, argc, argv);
 }
 
+static int disconnect_cmd(int argc, char **argv)
+{
+	const char *desc = "Disconnect from NVMeoF subsystem";
+	return disconnect(desc, argc, argv);
+}
+
 static void usage()
 {
 	printf("usage: nvme <command> [<device>] [<args>]\n");
-- 
2.1.4
