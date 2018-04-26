From: gthelen@google.com (Greg Thelen)
Date: Thu, 26 Apr 2018 11:19:32 -0700
Subject: [PATCH 3/6] ib_srpt: depend on INFINIBAND_ADDR_TRANS
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
Message-ID: <20180426181935.32977-4-gthelen@google.com>

INFINIBAND_SRPT code depends on INFINIBAND_ADDR_TRANS provided symbols.
So declare the kconfig dependency.  This is necessary to allow for
enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen at google.com>
Cc: Tarick Bedeir <tarick at google.com>
---
 drivers/infiniband/ulp/srpt/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/Kconfig b/drivers/infiniband/ulp/srpt/Kconfig
index 31ee83d528d9..fb8b7182f05e 100644
--- a/drivers/infiniband/ulp/srpt/Kconfig
+++ b/drivers/infiniband/ulp/srpt/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_SRPT
 	tristate "InfiniBand SCSI RDMA Protocol target support"
-	depends on INFINIBAND && TARGET_CORE
+	depends on INFINIBAND && INFINIBAND_ADDR_TRANS && TARGET_CORE
 	---help---
 
 	  Support for the SCSI RDMA Protocol (SRP) Target driver. The
-- 
2.17.0.484.g0c8726318c-goog
