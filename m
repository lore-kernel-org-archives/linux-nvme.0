From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 31 Jul 2019 17:47:08 -0600
Subject: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Message-ID: <20190731234708.5450-1-logang@deltatee.com>

A number of bug fixes have been submitted to the kernel to
fix bugs when a controller is removed immediately after it is
set up. This new test ensures this doesn't regress.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---

All of the fixes required for this test to pass have been on the
list for a couple weeks, but not all of them have been merged.

I'm not sure what the policy is for blktests for patches that
aren't yet upstream but this patch is here for when it makes
sense to pick it up.

 tests/nvme/031     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/031.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/nvme/031
 create mode 100644 tests/nvme/031.out

diff --git a/tests/nvme/031 b/tests/nvme/031
new file mode 100755
index 000000000000..16390dcb380e
--- /dev/null
+++ b/tests/nvme/031
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+#
+# Regression test for the following patches:
+#    nvme: fix controller removal race with scan work
+#    nvme: fix regression upon hot device removal and insertion
+#    nvme-core: Fix extra device_put() call on error path
+#    nvmet-loop: Flush nvme_delete_wq when removing the port
+#    nvmet: Fix use-after-free bug when a port is removed
+#
+# All these patches fix issues related to deleting a controller
+# immediately after setting it up.
+
+. tests/nvme/rc
+
+DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
+QUICK=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules loop nvme-loop nvmet &&
+	_have_configfs
+}
+
+test() {
+	local subsys="blktests-subsystem-"
+	local iterations=10
+	local loop_dev
+	local port
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	port="$(_create_nvmet_port "loop")"
+
+	for ((i = 0; i < iterations; i++)); do
+		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
+		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
+		nvme connect -t loop -n "${subsys}$i"
+		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
+		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
+		_remove_nvmet_subsystem "${subsys}$i"
+	done
+
+	_remove_nvmet_port "${port}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/031.out b/tests/nvme/031.out
new file mode 100644
index 000000000000..ae902bdd36d4
--- /dev/null
+++ b/tests/nvme/031.out
@@ -0,0 +1,2 @@
+Running nvme/031
+Test complete
--
2.20.1
