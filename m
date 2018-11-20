From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:27:32 +0100
Subject: [PATCH 1/3] nvme: enable multipathing by default
In-Reply-To: <20181120162734.2013-1-hch@lst.de>
References: <20181120162734.2013-1-hch@lst.de>
Message-ID: <20181120162734.2013-2-hch@lst.de>

And make it a little more clear that the only reason to disable it is
to optimize for size in constrained environment.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 88a8b5916624..d2ae6954ce7e 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -16,12 +16,20 @@ config BLK_DEV_NVME
 config NVME_MULTIPATH
 	bool "NVMe multipath support"
 	depends on NVME_CORE
+	default y
 	---help---
 	   This option enables support for multipath access to NVMe
 	   subsystems.  If this option is enabled only a single
 	   /dev/nvmeXnY device will show up for each NVMe namespaces,
 	   even if it is accessible through multiple controllers.
 
+	   Say Y here unless you need to optimize for size in embedded
+	   systems that are never going to see multi-port NVMe devices.
+
+	   If you say N multiple ports of the same subsystem will show
+	   up as separate devices, and none of the normal block device
+	   exclusion mechanisms will work.
+
 config NVME_FABRICS
 	tristate
 
-- 
2.19.1
