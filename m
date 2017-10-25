From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:37 -0700
Subject: [PATCH V2 20/46] nvmftests-tests: add user config file
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-21-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a centralized config file which can be used to
specify different parameters for the execution of the test.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../nvmftests/tests/config/nvmftests.json          | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/tests/config/nvmftests.json

diff --git a/tools/testing/selftests/nvmftests/tests/config/nvmftests.json b/tools/testing/selftests/nvmftests/tests/config/nvmftests.json
new file mode 100644
index 0000000..7dccdad
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/tests/config/nvmftests.json
@@ -0,0 +1,83 @@
+{
+	"mount_path" : "/mnt/",
+	"data_size"  : "128MB",
+	"block_size" : "4KB",
+	"nr_dev" : "5",
+	"nr_target_subsys" : "1",
+	"nr_ns_per_subsys" : "1",
+	"target_config_file" : "loop.json",
+	"target_type" : "loop",
+	"fio_read": {
+		"IO_TYPE": "fio",
+		"group_reporting": "1",
+		"rw": "randread",
+		"bs": "4k",
+		"numjobs": "4",
+		"iodepth": "8",
+		"runtime": "30",
+		"loop": "1",
+		"ioengine": "libaio",
+		"direct": "1",
+		"invalidate": "1",
+		"randrepeat": "1",
+		"size": "100M",
+		"filename": "XXX",
+		"name": "test1",
+		"THREAD": "XXX",
+		"RC": "0"
+	},
+	"fio_fs_write": {
+		"IO_TYPE": "fio",
+		"group_reporting": "1",
+		"rw": "randwrite",
+		"bs": "4k",
+		"numjobs": "4",
+		"iodepth": "8",
+		"runtime": "30",
+		"loop": "1",
+		"ioengine": "libaio",
+		"direct": "1",
+		"invalidate": "1",
+		"randrepeat": "1",
+		"size": "10M",
+		"directory": "XXX",
+		"name": "test1",
+		"THREAD": "XXX",
+		"RC": "0"
+	},
+	"dd_read": {
+		"IO_TYPE": "dd",
+		"IODIR": "read",
+		"THREAD": "XXX",
+		"IF": "XXX",
+		"OF": "/dev/null",
+		"BS": "4K",
+		"COUNT": "XXX",
+		"RC": "0"
+	},
+	"dd_write": {
+		"IO_TYPE": "dd",
+		"IODIR": "write",
+		"THREAD": "XXX",
+		"IF": "/dev/zero",
+		"OF": "XXX",
+		"BS": "4K",
+		"COUNT": "XXX",
+		"RC": "0"
+	},
+	"block_dev_pool": [
+		"/dev/nvme0n1"
+	],
+	"log": {
+		"host" : "DEBUG",
+		"host_subsystem" : "DEBUG",
+		"host_ns" : "DEBUG",
+		"target" : "DEBUG",
+		"target_subsystem" : "DEBUG",
+		"target_ns" : "DEBUG",
+		"port" : "DEBUG",
+		"nvme_pci": "DEBUG",
+		"loopback": "DEBUG",
+		"gen_blk": "DEBUG"
+	}
+}
-- 
1.8.3.1
