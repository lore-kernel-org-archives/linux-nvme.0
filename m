From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 12 Jul 2019 17:57:33 -0600
Subject: [PATCH blktests 03/12] nvme: Add new test to verify the generation
 counter
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
Message-ID: <20190712235742.22646-4-logang@deltatee.com>

Now that the other discovery tests ignore the generation counter value,
create a new test to specifically check that it increments when
subsystems are added or removed from ports and when allow_any_host
is set/unset.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 tests/nvme/030     | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/030.out |  2 ++
 tests/nvme/rc      |  5 +++
 3 files changed, 83 insertions(+)
 create mode 100755 tests/nvme/030
 create mode 100644 tests/nvme/030.out

diff --git a/tests/nvme/030 b/tests/nvme/030
new file mode 100755
index 000000000000..963e1ad7118c
--- /dev/null
+++ b/tests/nvme/030
@@ -0,0 +1,76 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Logan Gunthorpe
+#
+# Test nvme discovery generation counter
+
+. tests/nvme/rc
+
+DESCRIPTION="ensure the discovery generation counter is updated appropriately"
+QUICK=1
+
+requires() {
+	_have_program nvme &&
+	_have_modules loop nvme-loop nvmet &&
+	_have_configfs
+}
+
+
+checkgenctr() {
+	local last=$1
+	local msg=$2
+	local genctr
+
+	genctr=$(_discovery_genctr)
+	if (( "${genctr}" <= "${last}" )); then
+		echo "Generation counter not incremented when ${msg} (${genctr} <= ${last})"
+	fi
+
+	echo "${genctr}"
+}
+
+test() {
+	local port
+	local genctr
+	local subsys="blktests-subsystem-"
+
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	port="$(_create_nvmet_port "loop")"
+
+	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
+
+	genctr=$(_discovery_genctr)
+
+	_create_nvmet_subsystem "${subsys}2" "$(losetup -f)"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}2"
+
+	genctr=$(checkgenctr "${genctr}" "adding a subsystem to a port")
+
+	echo 0 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
+
+	genctr=$(checkgenctr "${genctr}" "clearing attr_allow_any_host")
+
+	echo 1 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
+
+	genctr=$(checkgenctr "${genctr}" "setting attr_allow_any_host")
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
+	_remove_nvmet_subsystem "${subsys}2"
+
+	genctr=$(checkgenctr "${genctr}" "removing a subsystem from a port")
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
+	_remove_nvmet_subsystem "${subsys}1"
+
+	_remove_nvmet_port "${port}"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/030.out b/tests/nvme/030.out
new file mode 100644
index 000000000000..93e51905b5d4
--- /dev/null
+++ b/tests/nvme/030.out
@@ -0,0 +1,2 @@
+Running nvme/030
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 60dc05869726..39b2c2e2b91c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -123,3 +123,8 @@ _filter_discovery() {
 	sed -r -e "s/Generation counter [0-9]+/Generation counter X/" |
 		grep 'Discovery Log Number\|Log Entry\|trtype\|subnqn'
 }
+
+_discovery_genctr() {
+	nvme discover -t loop |
+		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
+}
-- 
2.17.1
