From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 22 Sep 2017 18:04:43 -0700
Subject: [PATCH] nvme: use menu Kconfig interface
Message-ID: <1c39a10d-6782-3737-80f7-e29fe0d12980@infradead.org>

From: Randy Dunlap <rdunlap@infradead.org>

Add a menu interface for NVME host and target support so that it is
presented to users more like other Kconfig symbols.
This makes the Device Driver menu less cluttered (easier to read)
and keeps all of these symbols grouped together.

Signed-off-by: Randy Dunlap <rdunlap at infradead.org>
Cc: Jay Sternberg <jay.e.sternberg at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org
---
 drivers/nvme/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- lnx-414-rc1.orig/drivers/nvme/Kconfig
+++ lnx-414-rc1/drivers/nvme/Kconfig
@@ -1,2 +1,6 @@
+menu "NVME Support"
+
 source "drivers/nvme/host/Kconfig"
 source "drivers/nvme/target/Kconfig"
+
+endmenu
