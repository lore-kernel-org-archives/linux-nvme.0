From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  2 Feb 2017 16:38:05 +0100
Subject: [PATCH nvme-cli] Documentation: fix location of device reset
Message-ID: <20170202153805.16406-1-jthumshirn@suse.de>

Fix the location of the device reset sysfs path.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 Documentation/nvme-fw-activate.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nvme-fw-activate.txt b/Documentation/nvme-fw-activate.txt
index 57c29c3..92d9116 100644
--- a/Documentation/nvme-fw-activate.txt
+++ b/Documentation/nvme-fw-activate.txt
@@ -31,7 +31,7 @@ driver are recent enough, you can activate the firmware by issuing a
 reset through Linux sysfs, for example:
 
 ------------
- # echo 1 > /sys/class/misc/nvme0/device/reset
+ # echo 1 > /sys/class/nvme/nvme0/device/reset
 ------------
 
 If your kernel is not recent enough, you will need to remove and add
-- 
2.10.2
