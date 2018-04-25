From: gthelen@google.com (Greg Thelen)
Date: Wed, 25 Apr 2018 15:32:41 -0700
Subject: [PATCH 1/5] nvme: depend on INFINIBAND_ADDR_TRANS
Message-ID: <20180425223241.206434-1-gthelen@google.com>

NVME_RDMA code depends on INFINIBAND_ADDR_TRANS provided symbols.  So
declare the kconfig dependency.  This is necessary to allow for enabling
INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen at google.com>
Cc: Tarick Bedeir <tarick at google.com>
---
 drivers/nvme/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index b979cf3bce65..88a8b5916624 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -27,7 +27,7 @@ config NVME_FABRICS
 
 config NVME_RDMA
 	tristate "NVM Express over Fabrics RDMA host driver"
-	depends on INFINIBAND && BLOCK
+	depends on INFINIBAND && INFINIBAND_ADDR_TRANS && BLOCK
 	select NVME_CORE
 	select NVME_FABRICS
 	select SG_POOL
-- 
2.17.0.441.gb46fe60e1d-goog
