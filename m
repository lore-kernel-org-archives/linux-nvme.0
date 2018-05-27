From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:08 +0300
Subject: [PATCH 03/17] IB/iser: use T10-PI check mask definitions from core
 layer
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-4-git-send-email-maxg@mellanox.com>

No reason to re-define protection information check in ib_iser driver.
Use check masks from RDMA core driver.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h  | 4 ----
 drivers/infiniband/ulp/iser/iser_memory.c | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index c1ae4ae..e13765d 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -383,10 +383,6 @@ struct iser_device {
 	bool                         remote_inv_sup;
 };
 
-#define ISER_CHECK_GUARD	0xc0
-#define ISER_CHECK_REFTAG	0x0f
-#define ISER_CHECK_APPTAG	0x30
-
 /**
  * struct iser_reg_resources - Fast registration recources
  *
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 322209d..ca844a9 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -362,9 +362,9 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 {
 	*mask = 0;
 	if (sc->prot_flags & SCSI_PROT_REF_CHECK)
-		*mask |= ISER_CHECK_REFTAG;
+		*mask |= IB_SIG_CHECK_REFTAG;
 	if (sc->prot_flags & SCSI_PROT_GUARD_CHECK)
-		*mask |= ISER_CHECK_GUARD;
+		*mask |= IB_SIG_CHECK_GUARD;
 }
 
 static inline void
-- 
1.8.3.1
