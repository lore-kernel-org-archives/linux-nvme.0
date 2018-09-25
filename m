From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Tue, 25 Sep 2018 14:45:07 +0000
Subject: [PATCH] Fix nvme test device selection to use controller value
 defined in the config.json file.  Before this fix, the value was hard coded
 to nvme0.
Message-ID: <1537886685-26554-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 tests/nvme_test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme_test.py b/tests/nvme_test.py
index d735863..d4409ec 100644
--- a/tests/nvme_test.py
+++ b/tests/nvme_test.py
@@ -76,7 +76,8 @@ class TestNVMe(object):
             - Returns:
                 - None
         """
-        cmd = cmd = "find /sys/devices -name \\*nvme0 | grep -i pci"
+        x1, x2, dev = self.ctrl.split('/')
+        cmd = cmd = "find /sys/devices -name \\*" + dev + " | grep -i pci"
         err = subprocess.call(cmd, shell=True)
         assert_equal(err, 0, "ERROR : Only NVMe PCI subsystem is supported")
 
-- 
1.8.3.1
