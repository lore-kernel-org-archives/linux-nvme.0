From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 27 Mar 2018 11:31:47 +0200
Subject: [PATCH] test/nvme/003: add test case for patch "nvme: don't send
 keep-alives to the discovery controller"
In-Reply-To: <20180327092848.10404-1-jthumshirn@suse.de>
References: <20180327092848.10404-1-jthumshirn@suse.de>
Message-ID: <20180327093147.10684-1-jthumshirn@suse.de>

Add a regression test for the patch titled "nvme: don't send
keep-alives to the discovery controller".

This patch creates a local loopback nvme target and then connects to
it. If the patch is not applied we see two error messages in dmesg:
"failed nvme_keep_alive_end_io error=" from the nvme host and "nvmet:
unsupported cmd 24" from the nvme target. If the patch is applied
dmesg is quiet.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 tests/nvme/003     | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/003.out |  2 ++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/nvme/003
 create mode 100644 tests/nvme/003.out

diff --git a/tests/nvme/003 b/tests/nvme/003
new file mode 100755
index 000000000000..5353de5ae9c3
--- /dev/null
+++ b/tests/nvme/003
@@ -0,0 +1,61 @@
+#!/bin/bash
+#
+# Regression test for patch "nvme: don't send keep-alives to the discovery
+# controller"
+#
+# Copyright (C) 2018 Johannes Thumshirn
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+DESCRIPTION="Test if we're sending keep-alives to a discovery controller"
+
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module loop \
+		&& _have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	port=$(_create_nvmet_port "loop")
+
+	loop_dev="$(losetup -f)"
+
+	_create_nvmet_subsystem "blktests-subsystem-1" ${loop_dev}
+	_add_nvmet_subsys_to_port ${port} "blktests-subsystem-1"
+
+	nvme connect -t loop -n nqn.2014-08.org.nvmexpress.discovery
+
+	# This is ugly but checking for the absence of error messages is ...
+	sleep 10
+
+	if dmesg | grep -q "failed nvme_keep_alive_end_io error="; then
+		echo "Fail"
+	fi
+
+	if dmesg | grep -q "nvmet: unsupported cmd 24"; then
+		echo "Fail"
+	fi
+
+	_remove_nvmet_subsystem_from_port ${port} "blktests-subsystem-1"
+	_remove_nvmet_subsystem "blktests-subsystem-1"
+	_remove_nvmet_port ${port}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/003.out b/tests/nvme/003.out
new file mode 100644
index 000000000000..01b275612159
--- /dev/null
+++ b/tests/nvme/003.out
@@ -0,0 +1,2 @@
+Running nvme/003
+Test complete
-- 
2.12.3
