From: mlin@kernel.org (Ming Lin)
Date: Tue, 28 Jun 2016 11:17:57 -0700
Subject: [PATCH -nvmeof] selftest: Add test for keep-alive expired with live io
Message-ID: <1467137877-20899-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Reproduces RDMA target driver crash resulting by keep-alive expired
event and removing nvmet_rdma_rsp from free_list.

Example:
./009.sh -T 192.168.2.2 -d iw_cxgb4 -i eth3 -N 5

Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 tools/testing/selftests/nvmef/009.sh | 149 +++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100755 tools/testing/selftests/nvmef/009.sh

diff --git a/tools/testing/selftests/nvmef/009.sh b/tools/testing/selftests/nvmef/009.sh
new file mode 100755
index 0000000..9fad51c
--- /dev/null
+++ b/tools/testing/selftests/nvmef/009.sh
@@ -0,0 +1,149 @@
+#!/bin/bash
+# Test ifconfig up/down NIC when running fio
+
+set -e
+. ./nvmf_lib.sh
+
+NAME=selftest-nic-up-down
+TARGET_DEVICE=/dev/nullb0
+TARGET_HOST=
+
+#CLEANUP_ONLY=FALSE
+#CLEANUP_SKIP=TRUE
+
+TARGET_DRIVER=
+HOST_NIC=
+NUM_TEST=10
+
+nvmf_help()
+{
+    echo $0 ": Help and Usage"
+    echo
+    echo "ifconfig up/down NIC when running fio (RDMA)"
+    echo
+    echo "usage: $0 [options]"
+    echo
+    echo "Options"
+    echo "-------"
+    echo
+    echo "  -h             : Show this help message"
+    echo "  -n NAME        : Controller name on target side"
+    echo "  -b TARGET_BLK  : Block device to use on target side"
+    echo "  -T TARGET_HOST : Hostname or IP of target side"
+    echo "  -d TARGET_DRIVER : rdma device driver"
+    echo "  -i HOST_NIC    : Host network interface"
+    echo "  -N NUM_TEST    : Number of ifconfig down/up test"
+    echo
+}
+
+while getopts "hn:b:T:d:i:N:" opt; do
+    case "$opt" in
+	h)  nvmf_help
+	    exit 0
+	    ;;
+	n)  NAME=${OPTARG}
+            ;;
+	t)  TARGET_DEVICE=${OPTARG}
+            ;;
+	T)  TARGET_HOST=${OPTARG}
+            ;;
+	d)  TARGET_DRIVER=${OPTARG}
+            ;;
+	i)  HOST_NIC=${OPTARG}
+            ;;
+	N)  NUM_TEST=${OPTARG}
+            ;;
+	\?)
+	    echo "Invalid option: -$OPTARG" >&2
+	    exit 1
+	    ;;
+	:)
+	    echo "Option -$OPTARG requires an argument." >&2
+	    exit 1
+	    ;;
+    esac
+done
+
+NQN=${NAME}
+
+if [ "${TARGET_HOST}" == "" ]; then
+    echo "nmvf: No target host specified. Use the -T option."
+    exit 1
+fi
+
+if [ "${TARGET_DRIVER}" == "" ]; then
+    echo "nmvf: No target driver specified. Use the -d option."
+    exit 1
+fi
+
+if [ "${HOST_NIC}" == "" ]; then
+    echo "nmvf: No host NIC specified. Use the -i option."
+    exit 1
+fi
+
+  # XXXXX. For now we assume the DUT in a fresh state with none of the
+  # relevant modules loaded. We will add checks for this to the script
+  # over time.
+
+CONNECTION=$(ssh ${TARGET_HOST} echo \$SSH_CONNECTION)
+REMOTE_NODE=$(ssh ${TARGET_HOST} uname -n)
+REMOTE_KERNEL=$(ssh ${TARGET_HOST} uname -r)
+CARGS=( $CONNECTION )
+REMOTE_IP=${CARGS[2]}
+LOCAL_IP=${CARGS[0]}
+echo "Remote Address: ${REMOTE_IP} ($REMOTE_NODE)"
+echo "Remote Device:  ${TARGET_DEVICE}"
+echo "Remote Kernel:  ${REMOTE_KERNEL}"
+echo
+echo "Local Address:  ${LOCAL_IP} ($(uname -n))"
+echo "Local Kernel:   $(uname -r)"
+echo
+
+nvmf_trap_exit
+
+  # Setup the NVMf target and host.
+
+nvmf_remote_cmd ${TARGET_HOST} nvmf_check_configfs_mount
+nvmf_remote_cmd ${TARGET_HOST} nvmf_check_target_device ${TARGET_DEVICE}
+nvmf_remote_cmd ${TARGET_HOST} nvmf_rdma_target ${NAME} ${REMOTE_IP}
+nvmf_remote_cmd ${TARGET_HOST} nvmf_namespace ${NAME} 1 ${TARGET_DEVICE}
+
+HOST_CTRL=$(nvmf_rdma_host ${NQN} ${REMOTE_IP} 1023)
+HOST_CHAR=/dev/${HOST_CTRL}
+HOST_DEVICE=/dev/${HOST_CTRL}n1
+
+# run fio in the bg
+echo "Running fio in the background"
+BS=4k
+PATTERN=randread
+THREADS=4
+IODEPTH=32
+DURATION=999999
+nvmf_run_fio_bg ${BS} ${PATTERN} ${THREADS} ${IODEPTH} ${DURATION} ${HOST_DEVICE}
+FIO_PID=$$
+echo $FIO_PID
+
+# Let IO resume
+sleep 5
+
+echo "Running ifconfig $HOST_NIC up/down for $NUM_TEST times"
+for i in `seq $NUM_TEST` ; do
+	ifconfig $HOST_NIC down
+	sleep $(( 10 + ($RANDOM & 0x7) ))
+	ifconfig $HOST_NIC up
+	sleep $(( 10 + ($RANDOM & 0x7) ))
+done
+
+sleep 5
+killall -9 fio
+
+# delete the host ctrl
+echo "Deleting ${HOST_CTRL}"
+nvmf_cleanup_host ${NAME}
+echo "Done deleting ${HOST_CTRL}"
+
+# cleanup the target ctrl
+echo "Cleaning ${NAME}"
+nvmf_remote_cmd ${TARGET_HOST} nvmf_cleanup_target ${NAME}
+echo "Done cleaning ${NAME}"
+
-- 
1.9.1
