From: gthelen@google.com (Greg Thelen)
Date: Thu, 26 Apr 2018 11:19:34 -0700
Subject: [PATCH 5/6] ib_srp: depend on INFINIBAND_ADDR_TRANS
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
Message-ID: <20180426181935.32977-6-gthelen@google.com>

INFINIBAND_SRP code depends on INFINIBAND_ADDR_TRANS provided symbols.
So declare the kconfig dependency.  This is necessary to allow for
enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen at google.com>
Cc: Tarick Bedeir <tarick at google.com>
---
 drivers/infiniband/ulp/srp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/Kconfig b/drivers/infiniband/ulp/srp/Kconfig
index c74ee9633041..99db8fe5173a 100644
--- a/drivers/infiniband/ulp/srp/Kconfig
+++ b/drivers/infiniband/ulp/srp/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_SRP
 	tristate "InfiniBand SCSI RDMA Protocol"
-	depends on SCSI
+	depends on SCSI && INFINIBAND_ADDR_TRANS
 	select SCSI_SRP_ATTRS
 	---help---
 	  Support for the SCSI RDMA Protocol over InfiniBand.  This
-- 
2.17.0.484.g0c8726318c-goog
