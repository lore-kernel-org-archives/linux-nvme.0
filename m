From: gthelen@google.com (Greg Thelen)
Date: Thu, 26 Apr 2018 11:19:31 -0700
Subject: [PATCH 2/6] nvmet-rdma: depend on INFINIBAND_ADDR_TRANS
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
Message-ID: <20180426181935.32977-3-gthelen@google.com>

NVME_TARGET_RDMA code depends on INFINIBAND_ADDR_TRANS provided symbols.
So declare the kconfig dependency.  This is necessary to allow for
enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen at google.com>
Cc: Tarick Bedeir <tarick at google.com>
---
 drivers/nvme/target/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 5f4f8b16685f..3c7b61ddb0d1 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -27,7 +27,7 @@ config NVME_TARGET_LOOP
 
 config NVME_TARGET_RDMA
 	tristate "NVMe over Fabrics RDMA target support"
-	depends on INFINIBAND
+	depends on INFINIBAND && INFINIBAND_ADDR_TRANS
 	depends on NVME_TARGET
 	select SGL_ALLOC
 	help
-- 
2.17.0.484.g0c8726318c-goog
