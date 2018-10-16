From: Dong.Ho@wdc.com (Dong Ho)
Date: Tue, 16 Oct 2018 19:26:19 +0000
Subject: [PATCH 1/2] nvme-cli: Add get and set timestamp commands
Message-ID: <1539743178-6573-1-git-send-email-dong.ho@wdc.com>

---
 Makefile       |   2 +-
 nvme-builtin.h |   2 +
 nvme.c         | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 433bc41..645ce5c 100644
--- a/Makefile
+++ b/Makefile
@@ -37,7 +37,7 @@ OBJS := argconfig.o suffix.o parser.o nvme-print.o nvme-ioctl.o \
 	huawei-nvme.o netapp-nvme.o  toshiba-nvme.o micron-nvme.o seagate-nvme.o
 
 nvme: nvme.c nvme.h $(OBJS) NVME-VERSION-FILE
-	$(CC) $(CPPFLAGS) $(CFLAGS) nvme.c -o $(NVME) $(OBJS) $(LDFLAGS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) nvme.c -o $(NVME) $(OBJS) $(LDFLAGS) -lm -lrt
 
 nvme.o: nvme.c nvme.h nvme-print.h nvme-ioctl.h argconfig.h suffix.h nvme-lightnvm.h fabrics.h
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c $<
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 7cf10ef..e66a2c2 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -67,6 +67,8 @@ COMMAND_LIST(
 	ENTRY("gen-hostnqn", "Generate NVMeoF host NQN", gen_hostnqn_cmd)
 	ENTRY("dir-receive", "Submit a Directive Receive command, return results", dir_receive)
 	ENTRY("dir-send", "Submit a Directive Send command, return results", dir_send)
+	ENTRY("set-timestamp", "Submit a Timestamp set feature command", set_timestamp)
+	ENTRY("get-timestamp", "Submit a Timestamp get feature command", get_timestamp)
 );
 
 #endif
diff --git a/nvme.c b/nvme.c
index a239322..5a1a4ae 100644
--- a/nvme.c
+++ b/nvme.c
@@ -36,6 +36,7 @@
 #include <unistd.h>
 #include <math.h>
 #include <dirent.h>
+#include <time.h>
 
 #include <linux/fs.h>
 
@@ -4623,6 +4624,141 @@ static int admin_passthru(int argc, char **argv, struct command *cmd, struct plu
 	return passthru(argc, argv, NVME_IOCTL_ADMIN_CMD, desc, cmd);
 }
 
+
+long get_current_time_in_ms(void)
+{
+    long            ms; // Milliseconds
+    time_t          s;  // Seconds
+    long            ts; // returned timestamp in ms
+    struct timespec spec;
+
+    clock_gettime(CLOCK_REALTIME, &spec);
+
+    s  = spec.tv_sec;
+    ms = round(spec.tv_nsec / 1.0e6); // Convert nanoseconds to milliseconds
+    if (ms > 999) {
+        s++;
+        ms = 0;
+    }
+
+    ts = 1000*s + ms;
+
+    return ts;
+}
+
+static int set_timestamp(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "Sends a Timestamp set feature command\n";
+	int err, fd;
+	struct nvme_id_ctrl ctrl;
+	__le64 ts;
+	__u32 result;
+	const char *time_stamp = "64-bit Timestamp value in milliseconds since the Epoch";
+
+	struct config {
+		__u64 time_stamp;
+	};
+
+	struct config cfg = {
+		.time_stamp     = -1,
+	};
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{"timestamp",  't', "NUM", CFG_LONG_SUFFIX, &cfg.time_stamp,  required_argument, time_stamp},
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	err = nvme_identify_ctrl(fd, &ctrl);
+	if (err < 0) {
+		perror("Identify Controller");
+		return errno;
+	} else	if (!err) {
+		if (!(ctrl.oncs & NVME_CTRL_ONCS_TIMESTAMP)) {
+			fprintf(stderr, "Timestamp Set Feature not supported\n");
+			return 0;
+		}
+	}
+	else if (err > 0) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(err), err);
+	}
+
+	if (cfg.time_stamp == -1)
+		ts = get_current_time_in_ms();
+	else
+		ts = cfg.time_stamp;
+
+	err = nvme_set_feature(fd, 0, NVME_FEAT_TIMESTAMP, 0, 0,
+			0, sizeof(ts), &ts, &result);
+	if (err < 0) {
+		perror("Set Timestamp");
+		return errno;
+	} else if (!err) {
+		printf("set-feature: %02x (%s), value:%ld\n", NVME_FEAT_TIMESTAMP,
+				nvme_feature_to_string(NVME_FEAT_TIMESTAMP), (long)ts);
+	} else if (err > 0) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(err), err);
+	}
+
+	return err;
+}
+
+static int get_timestamp(int argc, char **argv, struct command *cmd, struct plugin *plugin)
+{
+	const char *desc = "Sends a Timestamp get feature command\n";
+	int err, fd;
+	struct nvme_id_ctrl ctrl;
+ 	__le64 ts, data;
+ 	int origin_synch;
+	__u32 result;
+
+	const struct argconfig_commandline_options command_line_options[] = {
+		{NULL}
+	};
+
+	fd = parse_and_open(argc, argv, desc, command_line_options, NULL, 0);
+	if (fd < 0)
+		return fd;
+
+	err = nvme_identify_ctrl(fd, &ctrl);
+	if (err < 0) {
+		perror("Identify Controller");
+		return errno;
+	} else	if (!err) {
+		if (!(ctrl.oncs & NVME_CTRL_ONCS_TIMESTAMP)) {
+			fprintf(stderr, "Timestamp Get Feature not supported\n");
+			return 0;
+		}
+	}
+	else if (err > 0) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(err), err);
+	}
+
+	err = nvme_get_feature(fd, 0, NVME_FEAT_TIMESTAMP, 0, 0,
+			sizeof(data), &data, &result);
+	if (err < 0) {
+		perror("Get Timestamp");
+		return errno;
+	} else if (!err) {
+		ts = data & 0x0000FFFFFFFFFFFF;
+		origin_synch = ((data & 0x00FF000000000000) >> 48);
+
+		printf("get-feature: %02x (%s), timestamp: %ld, origin/synch: 0x%x\n", NVME_FEAT_TIMESTAMP,
+			nvme_feature_to_string(NVME_FEAT_TIMESTAMP), (long)ts, origin_synch);
+	} else if (err > 0) {
+		fprintf(stderr, "NVMe Status:%s(%x)\n",
+				nvme_status_to_string(err), err);
+	}
+
+	return err;
+}
+
 #ifdef LIBUUID
 static int gen_hostnqn_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
-- 
1.8.3.1
