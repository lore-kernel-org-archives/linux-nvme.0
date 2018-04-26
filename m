From: gthelen@google.com (Greg Thelen)
Date: Thu, 26 Apr 2018 11:19:35 -0700
Subject: [PATCH 6/6] IB: make INFINIBAND_ADDR_TRANS configurable
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
Message-ID: <20180426181935.32977-7-gthelen@google.com>

Allow INFINIBAND without INFINIBAND_ADDR_TRANS because fuzzing has been
finding fair number of CM bugs.  So provide option to disable it.

Signed-off-by: Greg Thelen <gthelen at google.com>
Cc: Tarick Bedeir <tarick at google.com>
---
 drivers/infiniband/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index ee270e065ba9..2a972ed6851b 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -61,9 +61,12 @@ config INFINIBAND_ON_DEMAND_PAGING
 	  pages on demand instead.
 
 config INFINIBAND_ADDR_TRANS
-	bool
+	bool "RDMA/CM"
 	depends on INFINIBAND
 	default y
+	---help---
+	  Support for RDMA communication manager (CM).
+	  This allows for a generic connection abstraction over RDMA.
 
 config INFINIBAND_ADDR_TRANS_CONFIGFS
 	bool
-- 
2.17.0.484.g0c8726318c-goog
