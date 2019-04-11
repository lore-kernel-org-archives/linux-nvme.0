From: sschricker@suse.de (Simon Schricker)
Date: Thu, 11 Apr 2019 10:41:40 +0200
Subject: [PATCH] nvme-cli: fix typo, removing duplicate 'are'
Message-ID: <20190411084140.29946-1-sschricker@suse.de>

Signed-off-by: Simon Schricker <sschricker at suse.de>
---
 Documentation/nvme-netapp-ontapdevices.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nvme-netapp-ontapdevices.1 b/Documentation/nvme-netapp-ontapdevices.1
index 94c4ac2..d277791 100644
--- a/Documentation/nvme-netapp-ontapdevices.1
+++ b/Documentation/nvme-netapp-ontapdevices.1
@@ -36,7 +36,7 @@ nvme-netapp-ontapdevices \- Display information about ONTAP devices
 .fi
 .SH "DESCRIPTION"
 .sp
-Display information about ONTAP devices on the host\&. The ONTAP devices are are identified using the Identify Controller data\&.
+Display information about ONTAP devices on the host\&. The ONTAP devices are identified using the Identify Controller data\&.
 .SH "OPTIONS"
 .PP
 \-o <fmt>, \-\-output\-format=<fmt>
-- 
2.16.4
