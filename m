From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 18 Jan 2019 00:04:19 +0000
Subject: [PATCH blktests 2/2] nvme: test resize of a namespace with
 file-backed ns
In-Reply-To: <20190117125906.15479-2-jthumshirn@suse.de>
References: <20190117125906.15479-1-jthumshirn@suse.de>,
 <20190117125906.15479-2-jthumshirn@suse.de>
Message-ID: <BYAPR04MB4502DFB8875F3D6835086C6086830@BYAPR04MB4502.namprd04.prod.outlook.com>


Thanks for the test, I actually have a patch for this one, if Christoph and Sagi okay with that I can work on it.
Although, not sure if we want that sort of management code in the target.


From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org> on behalf of Johannes Thumshirn <jthumshirn@suse.de>
Sent: Thursday, January 17, 2019 4:59 AM
To: Omar Sandoval
Cc: Linux Block Layer Mailinglist; Linux NVMe Mailinglist; Anthony Iliopoulos; Johannes Thumshirn
Subject: [PATCH blktests 2/2] nvme: test resize of a namespace with file-backed ns
? 
 
Test resizing of a NVMe namespace by creating a file backed namespace over
nvme-loop with 1G size, connecting to it and then resizing it to 2G.

Check if /proc/partitions and blkdev --getsz $DEVICE see the updated size.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
?tests/nvme/029???? | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
?tests/nvme/029.out | 10 ++++++++
?2 files changed, 77 insertions(+)
?create mode 100755 tests/nvme/029
?create mode 100644 tests/nvme/029.out

diff --git a/tests/nvme/029 b/tests/nvme/029
new file mode 100755
index 000000000000..8c94af039d0f
--- /dev/null
+++ b/tests/nvme/029
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2019 Johannes Thumshirn
+#
+# Test resize of a namespace with file-backed ns
+
+. tests/nvme/rc
+
+DESCRIPTION="test resize of a namespace with file-backed ns"
+QUICK=1
+
+requires() {
+?????? _have_program nvme && _have_modules loop nvme-loop nvmet && \
+?????????????? _have_configfs
do we really need loop module here ?
also missinghave_program blockdev ?
+}
+
+test() {
+?????? echo "Running ${TEST_NAME}"
+
+?????? modprobe nvmet
+?????? modprobe nvme-loop
+
+?????? local port
+?????? local nvmedev
+?????? local namespace
+?????? local file_path="$TMPDIR/img"
+?????? local subsys_name="blktests-subsystem-1"
+
+?????? truncate -s 1G "${file_path}"
+
+?????? _create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+?????????????? "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+?????? port="$(_create_nvmet_port "loop")"
+?????? _add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+?????? nvme connect -t loop -n "${subsys_name}"
+
+?????? nvmedev="$(_find_nvme_loop_dev)"
+?????? namespace="${nvmedev}n1"
+?????? cat "/sys/block/${namespace}/uuid"
+?????? cat "/sys/block/${namespace}/wwid"
+
+?????? cat /proc/partitions | grep ${namespace} | awk '{ print $3 }'
+?????? blockdev --getsz /dev/${namespace}
+
+?????? echo "Resizing"
+?????? truncate -s +1G "${file_path}"
+?????? printf 0 > ${NVMET_CFS}/subsystems/${subsys_name}/namespaces/1/enable
+?????? printf 1 > ${NVMET_CFS}/subsystems/${subsys_name}/namespaces/1/enable
+?????? sleep 1
+
+?????? cat /proc/partitions | grep ${namespace} | awk '{ print $3 }'
+?????? blockdev --getsz /dev/${namespace}
+
+?????? nvme disconnect -n "${subsys_name}"
+
+?????? _remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+?????? _remove_nvmet_subsystem "${subsys_name}"
+?????? _remove_nvmet_port "${port}"
+
+?????? rm -f "${file_path}"
+
+?????? modprobe -r nvme-loop
+?????? modprobe -r nvmet
+
+?????? echo "Test complete"
+}
diff --git a/tests/nvme/029.out b/tests/nvme/029.out
new file mode 100644
index 000000000000..e9571c7c9300
--- /dev/null
+++ b/tests/nvme/029.out
@@ -0,0 +1,10 @@
+Running nvme/029
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+1048576
+2097152
+Resizing
+2097152
+4194304
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.16.4

    
