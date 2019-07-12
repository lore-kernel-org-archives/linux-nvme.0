From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 12 Jul 2019 17:57:38 -0600
Subject: [PATCH blktests 08/12] check: Add the ability to call a cleanup
 function after a test ends
In-Reply-To: <20190712235742.22646-1-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
Message-ID: <20190712235742.22646-9-logang@deltatee.com>

In order to ensure tests properly clean themselves up, even if
they are subject to interruption, add the ability to call a test
specified function at cleanup time.

Any test can call _register_test_cleanup with the first argument
as a function to call after the test ends or is interrupted
(similar to using 'trap <func> EXIT').

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 check | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/check b/check
index 029095e7cf38..981058c59c12 100755
--- a/check
+++ b/check
@@ -288,7 +288,15 @@ _output_test_run() {
 	) | column -t -s $'\t'
 }
 
+_register_test_cleanup() {
+	TEST_CLEANUP=$1
+}
+
 _cleanup() {
+	if [[ -v TEST_CLEANUP ]]; then
+		${TEST_CLEANUP}
+	fi
+
 	if [[ "${TMPDIR:-}" ]]; then
 		rm -rf "$TMPDIR"
 		unset TMPDIR
@@ -337,6 +345,7 @@ _call_test() {
 	fi
 	$LOGGER_PROG "run blktests $TEST_NAME"
 
+	unset TEST_CLEANUP
 	trap _cleanup EXIT
 	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
 		return
-- 
2.17.1
