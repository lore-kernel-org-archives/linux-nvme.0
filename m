From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  3 May 2018 17:00:54 +0200
Subject: [PATCH blktests 3/3] nvme: add test for resetting the loopback
 controller
In-Reply-To: <20180503150054.14022-1-jthumshirn@suse.de>
References: <20180503150054.14022-1-jthumshirn@suse.de>
Message-ID: <20180503150054.14022-3-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 tests/nvme/005     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/005.out |  2 ++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/nvme/005
 create mode 100644 tests/nvme/005.out

diff --git a/tests/nvme/005 b/tests/nvme/005
new file mode 100755
index 000000000000..77f843fed692
--- /dev/null
+++ b/tests/nvme/005
@@ -0,0 +1,77 @@
+#!/bin/bash
+#
+# Regression test for patch "nvmet: switch loopback target state to connecting
+# when resetting"
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
+DESCRIPTION="reset local loopback target"
+
+QUICK=1
+
+requires() {
+ 	_have_module nvme-loop && _have_module nvmet && _have_module loop && \
+		_have_configfs && _have_module nvme-core && \
+		_have_module_param nvme-core multipath
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	# Clean up all stale modules
+	modprobe -r nvme-loop
+	modprobe -r nvme-core
+	modprobe -r nvmet
+
+	modprobe nvme-core multipath=1
+	modprobe nvmet
+	modprobe nvme-loop
+
+	local port
+	port=$(_create_nvmet_port "loop")
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
+
+	nvme connect -t loop -n blktests-subsystem-1
+
+	local nvmedev
+	nvmedev="$(_find_nvme_loop_dev)"
+
+	udevadm settle
+
+	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
+
+	nvme disconnect -d "${nvmedev}"
+	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_subsystem "blktests-subsystem-1"
+	losetup -d "$loop_dev"
+	rm "$TMPDIR/img"
+
+	modprobe -r nvme-loop
+	modprobe -r nvme-core
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/005.out b/tests/nvme/005.out
new file mode 100644
index 000000000000..6146a7b8b1a7
--- /dev/null
+++ b/tests/nvme/005.out
@@ -0,0 +1,2 @@
+Running nvme/005
+Test complete
-- 
2.16.3
