From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:06 +0300
Subject: [PATCH 01/17] IB/isert: fix T10-pi check mask setting
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-2-git-send-email-maxg@mellanox.com>

A copy/paste bug (probably) caused setting of an app_tag check mask
in case where a ref_tag check was needed.

Fixes: 38a2d0d429f1 ("IB/isert: convert to the generic RDMA READ/WRITE API")
Fixes: 9e961ae73c2c ("IB/isert: Support T10-PI protected transactions")
Cc: stable at vger.kernel.org
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index fff40b0..d8b6bde 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2108,7 +2108,7 @@
 
 	sig_attrs->check_mask =
 	       (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? 0xc0 : 0) |
-	       (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x30 : 0) |
+	       (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? 0x30 : 0) |
 	       (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x0f : 0);
 	return 0;
 }
-- 
1.8.3.1
