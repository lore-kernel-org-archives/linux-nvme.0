From: jeff.lien@wdc.com (Jeff Lien)
Date: Fri,  2 Feb 2018 13:50:20 -0600
Subject: [PATCH] NVMe-CLI Fix command failures in regress script
Message-ID: <20180202195021.8560-1-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 regress | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/regress b/regress
index aa7820c..0278d1d 100755
--- a/regress
+++ b/regress
@@ -89,7 +89,7 @@ if $LIST ; then
     run_test nvme list
 fi
 run_test nvme id-ctrl ${DEVICE}
-run_test nvme id-ns -raw-binary ${DEVICE}
+run_test nvme id-ns -n 1 -raw-binary ${DEVICE}
 run_test nvme list-ns -n 1 ${DEVICE}
 run_test nvme get-ns-id ${DEVICE}
 run_test nvme get-log ${DEVICE}  --log-id=2 --log-len=512
@@ -98,13 +98,13 @@ run_test nvme fw-log ${DEVICE} -b
 run_test nvme smart-log ${DEVICE}
 run_test nvme error-log ${DEVICE}
 run_test nvme get-feature ${DEVICE} -f 7
-run_test nvme flush ${DEVICE}
+run_test nvme flush -n 1 ${DEVICE}
 
 if $WRITE ; then
     run_test dd if=/dev/urandom of=${RAND_WFILE} bs=${RAND_SIZE} count=1
-    run_test nvme write ${DEVICE} --start-block=0 --block-count=0 --data-size=${RAND_SIZE} --data ${RAND_WFILE}
+    run_test nvme write ${DEVICE}n1 --start-block=0 --block-count=0 --data-size=${RAND_SIZE} --data ${RAND_WFILE}
 fi
-run_test nvme read ${DEVICE} --start-block=0 --block-count=0 --data-size=${RAND_SIZE} --data ${RAND_RFILE} --latency
+run_test nvme read ${DEVICE}n1 --start-block=0 --block-count=0 --data-size=${RAND_SIZE} --data ${RAND_RFILE} --latency
 if $WRITE ; then
     run_test diff ${RAND_RFILE} ${RAND_WFILE}
     rm ${RAND_WFILE} > /dev/null
-- 
2.14.2.746.g8fb8a94
