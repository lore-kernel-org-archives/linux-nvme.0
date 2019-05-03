From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri,  3 May 2019 12:28:28 -0600
Subject: [PATCH] blktests: Use old variable check for Bash <4.2
Message-ID: <1556908108-16475-1-git-send-email-jonathan.derrick@intel.com>

Bash 4.2 and above supports -v variable checks, which returns true for
set or null. Instead use an older bashism that is compatible with bash
4.1 and earlier but only returns true if the variable is set non-null.
This inherently adds a sanity check in case of null variables.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 check         |   20 ++++++++++----------
 common/cgroup |    2 +-
 common/fio    |    2 +-
 common/rc     |    2 +-
 tests/meta/rc |    4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/check b/check
index a623892..add8f7e 100755
--- a/check
+++ b/check
@@ -196,7 +196,7 @@ _output_status() {
 
 	if (( RUN_FOR_ZONED )); then zoned=" (zoned) "; fi
 
-	if [[ -v DESCRIPTION ]]; then
+	if [[ "${DESCRIPTION:-}" ]]; then
 		printf '%-60s' "${test}${zoned}($DESCRIPTION)"
 	else
 		printf '%-60s' "${test}${zoned}"
@@ -233,7 +233,7 @@ _output_notrun() {
 }
 
 _output_last_test_run() {
-	if [[ -v TEST_DEV ]]; then
+	if [[ "${TEST_DEV:-}" ]]; then
 		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" ""
 	else
 		_output_status "$TEST_NAME" ""
@@ -258,7 +258,7 @@ _output_test_run() {
 		tput cuu $((${#LAST_TEST_RUN[@]} - 3))
 	fi
 
-	if [[ -v TEST_DEV ]]; then
+	if [[ "${TEST_DEV:-}" ]]; then
 		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" "${TEST_RUN["status"]}ed"
 	else
 		_output_status "$TEST_NAME" "${TEST_RUN["status"]}ed"
@@ -288,7 +288,7 @@ _output_test_run() {
 }
 
 _cleanup() {
-	if [[ -v TMPDIR ]]; then
+	if [[ "${TMPDIR:-}" ]]; then
 		rm -rf "$TMPDIR"
 		unset TMPDIR
 	fi
@@ -300,7 +300,7 @@ _cleanup() {
 		unset TEST_DEV_QUEUE_SAVED["$key"]
 	done
 
-	if [[ -v RESTORE_CPUS_ONLINE ]]; then
+	if [[ "${RESTORE_CPUS_ONLINE:-}" ]]; then
 		local cpu
 		for cpu in "${!CPUS_ONLINE_SAVED[@]}"; do
 			echo "${CPUS_ONLINE_SAVED["$cpu"]}" >"/sys/devices/system/cpu/cpu$cpu/online"
@@ -659,18 +659,18 @@ fi
 : "${QUICK_RUN:=0}"
 : "${RUN_ZONED_TESTS:=0}"
 : "${OUTPUT:=results}"
-if [[ -v EXCLUDE ]] && ! declare -p EXCLUDE | grep -q '^declare -a'; then
+if [[ "${EXCLUDE:-}" ]] && ! declare -p EXCLUDE | grep -q '^declare -a'; then
 	# If EXCLUDE was not defined as an array, convert it to one.
 	# shellcheck disable=SC2190,SC2206
 	EXCLUDE=($EXCLUDE)
-elif [[ ! -v EXCLUDE ]]; then
+elif [[ ! "${EXCLUDE:-}" ]]; then
 	EXCLUDE=()
 fi
-if [[ -v TEST_DEVS ]] && ! declare -p TEST_DEVS | grep -q '^declare -a'; then
+if [[ "${TEST_DEVS:-}" ]] && ! declare -p TEST_DEVS | grep -q '^declare -a'; then
 	# If TEST_DEVS was not defined as an array, convert it to one.
 	# shellcheck disable=SC2206
 	TEST_DEVS=($TEST_DEVS)
-elif [[ ! -v TEST_DEVS ]]; then
+elif [[ ! "${TEST_DEVS:-}" ]]; then
 	TEST_DEVS=()
 fi
 
@@ -709,7 +709,7 @@ while true; do
 	esac
 done
 
-if [[ $QUICK_RUN -ne 0 && ! -v TIMEOUT ]]; then
+if [[ $QUICK_RUN -ne 0 && ! "${TIMEOUT:-}" ]]; then
 	_error "QUICK_RUN specified without TIMEOUT"
 fi
 
diff --git a/common/cgroup b/common/cgroup
index 554ebf7..c34bffd 100644
--- a/common/cgroup
+++ b/common/cgroup
@@ -22,7 +22,7 @@ _init_cgroup2()
 
 _exit_cgroup2()
 {
-	if [[ -v CGROUP2_DIR ]]; then
+	if [[ "${CGROUP2_DIR:-}" ]]; then
 		find "$CGROUP2_DIR" -type d -delete
 		unset CGROUP2_DIR
 	fi
diff --git a/common/fio b/common/fio
index 2b4f6e2..2e81b26 100644
--- a/common/fio
+++ b/common/fio
@@ -161,7 +161,7 @@ _fio_perf() {
 _run_fio() {
 	local args=("--output=$TMPDIR/fio_perf" "--output-format=terse" "--terse-version=4" "--group_reporting=1")
 
-	if [[ -v TIMEOUT ]]; then
+	if [[ "${TIMEOUT:-}" ]]; then
 		args+=("--runtime=$TIMEOUT")
 	fi
 
diff --git a/common/rc b/common/rc
index 71e27c3..5dd2c95 100644
--- a/common/rc
+++ b/common/rc
@@ -15,7 +15,7 @@ shopt -s extglob
 # for TIMEOUT / number of subtests.
 _divide_timeout() {
 	local num_tests="$1"
-	if [[ -v TIMEOUT ]]; then
+	if [[ "${TIMEOUT:-}" ]]; then
 		((TIMEOUT = (TIMEOUT + num_tests - 1) / num_tests))
 	fi
 }
diff --git a/tests/meta/rc b/tests/meta/rc
index da584d6..093edd1 100644
--- a/tests/meta/rc
+++ b/tests/meta/rc
@@ -7,7 +7,7 @@
 . common/rc
 
 group_requires() {
-	if [[ -v META_REQUIRES_SKIP ]]; then
+	if [[ "${META_REQUIRES_SKIP:-}" ]]; then
 		SKIP_REASON="META_REQUIRES_SKIP was set"
 		return 1
 	fi
@@ -15,7 +15,7 @@ group_requires() {
 }
 
 group_device_requires() {
-	if [[ -v META_DEVICE_REQUIRES_SKIP ]]; then
+	if [[ "${META_DEVICE_REQUIRES_SKIP:-}" ]]; then
 		SKIP_REASON="META_DEVICE_REQUIRES_SKIP was set"
 		return 1
 	fi
-- 
1.7.1
