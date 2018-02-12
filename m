From: thomas.tai@oracle.com (Thomas Tai)
Date: Mon, 12 Feb 2018 11:47:25 -0500
Subject: [PATCH] Documentation: nvme: Correct typo in nvme fault injection
 example
Message-ID: <1518454045-3825-1-git-send-email-thomas.tai@oracle.com>

The debugfs entry for DNR should have been dont_retry.

Signed-off-by: Thomas Tai <thomas.tai at oracle.com>
---
 Documentation/fault-injection/nvme-fault-injection.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fault-injection/nvme-fault-injection.txt b/Documentation/fault-injection/nvme-fault-injection.txt
index e37b9c7..8fbf3bf 100644
--- a/Documentation/fault-injection/nvme-fault-injection.txt
+++ b/Documentation/fault-injection/nvme-fault-injection.txt
@@ -73,7 +73,7 @@ mount /dev/nvme0n1 /mnt
 echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
 echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
 echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/status
-echo 0 > /sys/kernel/debug/nvme0n1/fault_inject/no_retry
+echo 0 > /sys/kernel/debug/nvme0n1/fault_inject/dont_retry
 
 cp a.file /mnt
 
-- 
1.8.3.1
