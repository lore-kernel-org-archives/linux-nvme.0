From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 19 Feb 2017 19:59:05 +0200
Subject: [PATCH 1/2] nvme-rdma: move nvme cm status helper to .h file
Message-ID: <1487527146-5358-1-git-send-email-maxg@mellanox.com>

This will enable the usage also for nvme rdma target.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/host/rdma.c  |   22 ----------------------
 include/linux/nvme-rdma.h |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 557f29b..3c9fd9b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -42,28 +42,6 @@
 
 #define NVME_RDMA_MAX_INLINE_SEGMENTS	1
 
-static const char *const nvme_rdma_cm_status_strs[] = {
-	[NVME_RDMA_CM_INVALID_LEN]	= "invalid length",
-	[NVME_RDMA_CM_INVALID_RECFMT]	= "invalid record format",
-	[NVME_RDMA_CM_INVALID_QID]	= "invalid queue ID",
-	[NVME_RDMA_CM_INVALID_HSQSIZE]	= "invalid host SQ size",
-	[NVME_RDMA_CM_INVALID_HRQSIZE]	= "invalid host RQ size",
-	[NVME_RDMA_CM_NO_RSC]		= "resource not found",
-	[NVME_RDMA_CM_INVALID_IRD]	= "invalid IRD",
-	[NVME_RDMA_CM_INVALID_ORD]	= "Invalid ORD",
-};
-
-static const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
-{
-	size_t index = status;
-
-	if (index < ARRAY_SIZE(nvme_rdma_cm_status_strs) &&
-	    nvme_rdma_cm_status_strs[index])
-		return nvme_rdma_cm_status_strs[index];
-	else
-		return "unrecognized reason";
-};
-
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index bf240a3..e679204 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -29,6 +29,21 @@ enum nvme_rdma_cm_status {
 	NVME_RDMA_CM_INVALID_ORD	= 0x08,
 };
 
+static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
+{
+	switch (status) {
+	case NVME_RDMA_CM_INVALID_LEN: return "invalid length";
+	case NVME_RDMA_CM_INVALID_RECFMT: return "invalid record format";
+	case NVME_RDMA_CM_INVALID_QID: return "invalid queue ID";
+	case NVME_RDMA_CM_INVALID_HSQSIZE: return "invalid host SQ size";
+	case NVME_RDMA_CM_INVALID_HRQSIZE: return "invalid host RQ size";
+	case NVME_RDMA_CM_NO_RSC: return "resource not found";
+	case NVME_RDMA_CM_INVALID_IRD: return "invalid IRD";
+	case NVME_RDMA_CM_INVALID_ORD: return "Invalid ORD";
+	default: return "unrecognized reason";
+	}
+}
+
 /**
  * struct nvme_rdma_cm_req - rdma connect request
  *
-- 
1.7.1
