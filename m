From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 12 Jul 2019 17:57:40 -0600
Subject: [PATCH blktests 10/12] nvme: Ensure all ports and subsystems are
 removed on cleanup
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
Message-ID: <20190712235742.22646-11-logang@deltatee.com>

This ensures any test that fails or is interrupted will cleanup
their subsystems. This will prevent the system from being left
in an inconsistent state that will fail subsequent tests.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 tests/nvme/rc | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index b8f7571c7170..1c9e4af0cbe5 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -25,6 +25,49 @@ _test_dev_is_nvme() {
 }
 
 _cleanup_nvmet() {
+	local dev
+	local port
+	local subsys
+	local transport
+	local name
+
+	if [[ ! -d "${NVMET_CFS}" ]]; then
+		return 0
+	fi
+
+	# Don't let successive Ctrl-Cs interrupt the cleanup processes
+	stty -isig
+
+	shopt -s nullglob
+
+	for dev in /sys/class/nvme/nvme*; do
+		dev="$(basename "$dev")"
+		transport="$(cat "/sys/class/nvme/${dev}/transport")"
+		if [[ "$transport" == "loop" ]]; then
+			echo "WARNING: Test did not clean up loop device: ${dev}"
+			nvme disconnect -d "${dev}"
+		fi
+	done
+
+	for port in "${NVMET_CFS}"/ports/*; do
+		name=$(basename "${port}")
+		echo "WARNING: Test did not clean up port: ${name}"
+		rm -f "${port}"/subsystems/*
+		rmdir "${port}"
+	done
+
+	for subsys in "${NVMET_CFS}"/subsystems/*; do
+		name=$(basename "${subsys}")
+		echo "WARNING: Test did not clean up subsystem: ${name}"
+		for ns in "${subsys}"/namespaces/*; do
+			rmdir "${ns}"
+		done
+		rmdir "${subsys}"
+	done
+
+	shopt -u nullglob
+	stty isig
+
 	modprobe -r nvme-loop
 	modprobe -r nvmet
 }
-- 
2.17.1
