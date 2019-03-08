From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:43:12 -0700
Subject: [PATCH 7/8] nvme/pci: Remove volatile from cqe
In-Reply-To: <20190308174313.5134-1-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
Message-ID: <20190308174313.5134-7-keith.busch@intel.com>

The cqe isn't volatile once we confirm the phase bit. Remove the volatile
keyword and let the compiler optimize out an unnecessary additional read
to the command id.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3481f3e3d6a1..9108a2ceb2c5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -956,7 +956,7 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 {
-	volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
+	struct nvme_completion *cqe = (struct nvme_completion *)&nvmeq->cqes[idx];
 	struct request *req;
 
 	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
-- 
2.14.4
