From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun,  3 Jun 2018 15:01:26 -0400
Subject: [PATCH] blktests: nvme/00[2 | 3 | 4] add module cleanup
Message-ID: <20180603190126.26338-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/002 | 2 ++
 tests/nvme/003 | 2 ++
 tests/nvme/004 | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 45e1ab7..786505e 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -53,5 +53,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 
+	modprobe -r nvme-loop
+	modprobe -r nvmet
 	echo "Test complete"
 }
diff --git a/tests/nvme/003 b/tests/nvme/003
index 5639804..9634130 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -59,5 +59,7 @@ test() {
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
 
+	modprobe -r nvme-loop
+	modprobe -r nvmet
 	echo "Test complete"
 }
diff --git a/tests/nvme/004 b/tests/nvme/004
index 2f970b3..ad268e2 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -58,5 +58,7 @@ test() {
 	losetup -d "$loop_dev"
 	rm "$TMPDIR/img"
 
+	modprobe -r nvme-loop
+	modprobe -r nvmet
 	echo "Test complete"
 }
-- 
2.9.5
