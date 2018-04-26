From: gthelen@google.com (Greg Thelen)
Date: Thu, 26 Apr 2018 11:19:33 -0700
Subject: [PATCH 4/6] cifs: smbd: depend on INFINIBAND_ADDR_TRANS
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
Message-ID: <20180426181935.32977-5-gthelen@google.com>

CIFS_SMB_DIRECT code depends on INFINIBAND_ADDR_TRANS provided symbols.
So declare the kconfig dependency.  This is necessary to allow for
enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen at google.com>
Cc: Tarick Bedeir <tarick at google.com>
Reviewed-by: Long Li <longli at microsoft.com>
---
 fs/cifs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index 741749a98614..5f132d59dfc2 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -197,7 +197,7 @@ config CIFS_SMB311
 
 config CIFS_SMB_DIRECT
 	bool "SMB Direct support (Experimental)"
-	depends on CIFS=m && INFINIBAND || CIFS=y && INFINIBAND=y
+	depends on CIFS=m && INFINIBAND && INFINIBAND_ADDR_TRANS || CIFS=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
 	help
 	  Enables SMB Direct experimental support for SMB 3.0, 3.02 and 3.1.1.
 	  SMB Direct allows transferring SMB packets over RDMA. If unsure,
-- 
2.17.0.484.g0c8726318c-goog
