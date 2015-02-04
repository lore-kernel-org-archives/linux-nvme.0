From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Wed, 4 Feb 2015 22:00:29 +0000
Subject: [PATCH][QEMU-NVME] Fixed NVM Express device versioning.
Message-ID: <36F6EBABA23FEF4391AF72944D2289019EA8725A@BBYEXM01.pmc-sierra.internal>

The NVMe specification indicates how the minor and major version
numbers should be represented in the version field of the NVMe
controller registers. We correct the code to align with the
specification.

If CMB is requested we advertise as a 1.2 drive, if not we advertise
1.1.

Signed-off-by: Stephen Bates <stephen.bates at pmcs.com>
---
hw/block/nvme.c |    8 +++++++-
1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4e81fb1..2e4ac19 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -68,6 +68,9 @@
  * and fail to load if there is a conflict or a configuration the emulated
  * device is unable to handle.
  *
+ * Note that when a CMB is requested the NVMe version is set to 1.2,
+ * for all other cases it is set to 1.1.
+ *
  */

/**
@@ -1959,7 +1962,10 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     NVME_CAP_SET_MPSMIN(n->bar.cap, n->mpsmin);
     NVME_CAP_SET_MPSMAX(n->bar.cap, n->mpsmax);

-    n->bar.vs = 0x00010001;
+    if (n->cmb)
+        n->bar.vs = 0x00010200;
+    else
+        n->bar.vs = 0x00010100;
     n->bar.intmc = n->bar.intms = 0;
     n->temperature = NVME_TEMPERATURE;
}
--
1.7.10.4

Cheers

Stephen
