From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 12 Jul 2019 17:57:35 -0600
Subject: [PATCH blktests 05/12] nvme/005: Don't rely on modprobing to set the
 multipath paramater
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
Message-ID: <20190712235742.22646-6-logang@deltatee.com>

On test systems with existing nvme drives or built-in modules it may not
be possible to remove nvme-core in order to re-probe it with
multipath=1.

Instead, skip the test if the multipath parameter is not already set
ahead of time.

Note: the multipath parameter of nvme-core is set by default if
CONFIG_NVME_MULTIPATH is set so this will only affect systems
that explicitly disable it via the module parameter.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 common/rc      | 16 ++++++++++++++++
 tests/nvme/005 | 10 ++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index 5dd2c9512fd2..49050c71dabf 100644
--- a/common/rc
+++ b/common/rc
@@ -55,6 +55,22 @@ _have_module_param() {
 	return 0
 }
 
+_have_module_param_value() {
+	local value
+
+	if ! _have_module_param "$1" "$2"; then
+		return 1
+	fi
+
+	value=$(cat "/sys/module/$1/parameters/$2")
+	if [[ "${value}" != "$3" ]]; then
+		SKIP_REASON="$1 module parameter $2 must be set to $3"
+		return 1
+	fi
+
+	return 0
+}
+
 _have_program() {
 	if command -v "$1" >/dev/null 2>&1; then
 		return 0
diff --git a/tests/nvme/005 b/tests/nvme/005
index e72fc809c936..91c164de73e6 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -12,18 +12,13 @@ QUICK=1
 
 requires() {
 	_have_modules loop nvme-core nvme-loop nvmet && \
-		_have_module_param nvme-core multipath && _have_configfs
+		_have_module_param_value nvme_core multipath Y && \
+		_have_configfs
 }
 
 test() {
 	echo "Running ${TEST_NAME}"
 
-	# Clean up all stale modules
-	modprobe -r nvme-loop
-	modprobe -r nvme-core
-	modprobe -r nvmet
-
-	modprobe nvme-core multipath=1
 	modprobe nvmet
 	modprobe nvme-loop
 
@@ -57,7 +52,6 @@ test() {
 	rm "$TMPDIR/img"
 
 	modprobe -r nvme-loop
-	modprobe -r nvme-core
 	modprobe -r nvmet
 
 	echo "Test complete"
-- 
2.17.1
