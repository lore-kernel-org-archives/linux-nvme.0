From: roland@kernel.org (Roland Dreier)
Date: Wed,  1 Mar 2017 18:22:01 -0800
Subject: [PATCH] nvme: Correct NVMF enum values to match NVMe-oF rev 1.0
Message-ID: <20170302022201.2946-1-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

The enum values for QPTYPE, PRTYPE and CMS are off by 1 from the
values defined in figure 42 of the NVM Express over Fabrics 1.0:

    http://www.nvmexpress.org/wp-content/uploads/NVMe_over_Fabrics_1_0_Gold_20160605-1.pdf

Fix our enums to match the final spec.

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 include/linux/nvme.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c43d435d4225..9061780b141f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -64,26 +64,26 @@ enum {
  * RDMA_QPTYPE field
  */
 enum {
-	NVMF_RDMA_QPTYPE_CONNECTED	= 0, /* Reliable Connected */
-	NVMF_RDMA_QPTYPE_DATAGRAM	= 1, /* Reliable Datagram */
+	NVMF_RDMA_QPTYPE_CONNECTED	= 1, /* Reliable Connected */
+	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
 };
 
 /* RDMA QP Service Type codes for Discovery Log Page entry TSAS
  * RDMA_QPTYPE field
  */
 enum {
-	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 0, /* No Provider Specified */
-	NVMF_RDMA_PRTYPE_IB		= 1, /* InfiniBand */
-	NVMF_RDMA_PRTYPE_ROCE		= 2, /* InfiniBand RoCE */
-	NVMF_RDMA_PRTYPE_ROCEV2		= 3, /* InfiniBand RoCEV2 */
-	NVMF_RDMA_PRTYPE_IWARP		= 4, /* IWARP */
+	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 1, /* No Provider Specified */
+	NVMF_RDMA_PRTYPE_IB		= 2, /* InfiniBand */
+	NVMF_RDMA_PRTYPE_ROCE		= 3, /* InfiniBand RoCE */
+	NVMF_RDMA_PRTYPE_ROCEV2		= 4, /* InfiniBand RoCEV2 */
+	NVMF_RDMA_PRTYPE_IWARP		= 5, /* IWARP */
 };
 
 /* RDMA Connection Management Service Type codes for Discovery Log Page
  * entry TSAS RDMA_CMS field
  */
 enum {
-	NVMF_RDMA_CMS_RDMA_CM	= 0, /* Sockets based enpoint addressing */
+	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
 };
 
 #define NVMF_AQ_DEPTH		32
-- 
2.10.2
