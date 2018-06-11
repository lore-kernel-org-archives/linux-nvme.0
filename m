From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 05:15:46 -0400
Subject: [PATCH V2 06/14] blktests: add fio data verification routine
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611091554.19639-7-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 common/fio | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/fio b/common/fio
index e83258d..abe5ee2 100644
--- a/common/fio
+++ b/common/fio
@@ -162,10 +162,17 @@ _fio_perf() {
 # tests that should run for a specific amount of time.
 _run_fio() {
 	local args=("--output=$TMPDIR/fio_perf" "--output-format=terse" "--terse-version=4" "--group_reporting=1")
+
 	if [[ -v TIMEOUT ]]; then
 		args+=("--runtime=$TIMEOUT")
 	fi
+
 	fio "${args[@]}" "$@"
+
+	if [ $? -ne 0 ]; then
+		echo "error fio failed"
+		cat "$TMPDIR"/fio_perf
+	fi
 }
 
 # Wrapper around _run_fio used if you need some I/O but don't really care much
@@ -175,6 +182,11 @@ _run_fio_rand_io() {
 		--name=reads --direct=1 "$@"
 }
 
+_run_fio_verify_io() {
+	_run_fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio --bs=4k \
+		      --norandommap --iodepth=16 --verify=crc32c "$@"
+}
+
 _fio_perf_report() {
 	# If there is more than one group, we don't know what to report.
 	if [[ $(wc -l < "$TMPDIR/fio_perf") -gt 1 ]]; then
-- 
2.17.0
