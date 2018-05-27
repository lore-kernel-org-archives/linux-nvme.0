From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:09 +0300
Subject: [PATCH 04/17] IB/isert: use T10-PI check mask definitions from core
 layer
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-5-git-send-email-maxg@mellanox.com>

No reason to use hard-coded protection information checks in ib_isert driver.
Use check masks from RDMA core driver.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index d8b6bde..8a0cda6 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2107,9 +2107,9 @@
 	}
 
 	sig_attrs->check_mask =
-	       (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? 0xc0 : 0) |
-	       (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? 0x30 : 0) |
-	       (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x0f : 0);
+	       (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? IB_SIG_CHECK_GUARD : 0)  |
+	       (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? IB_SIG_CHECK_APPTAG : 0) |
+	       (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? IB_SIG_CHECK_REFTAG : 0);
 	return 0;
 }
 
-- 
1.8.3.1
