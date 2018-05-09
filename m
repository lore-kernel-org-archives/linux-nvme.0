From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 9 May 2018 07:34:22 -0700
Subject: [PATCH RFC 2/2] nvmet-rdma: Support 8K inline
In-Reply-To: <cover.1525880285.git.swise@opengridcomputing.com>
References: <cover.1525880285.git.swise@opengridcomputing.com>
Message-ID: <d6a3324a813a3ac4a1b43bf82e91794f335c24a7.1525880285.git.swise@opengridcomputing.com>

Allow up to 2 pages of inline for NVMF WRITE operations.  This reduces
latency for 8K WRITEs by removing the need to issue a READ WR for IB,
or a REG_MR+READ WR chain for iWarp.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/target/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 52e0c5d..9e3f08a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -33,9 +33,9 @@
 #include "nvmet.h"
 
 /*
- * We allow up to a page of inline data to go with the SQE
+ * We allow up to 2 pages of inline data to go with the SQE
  */
-#define NVMET_RDMA_INLINE_DATA_SIZE	PAGE_SIZE
+#define NVMET_RDMA_INLINE_DATA_SIZE    (PAGE_SIZE << 1)
 
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[2];
-- 
1.8.3.1
