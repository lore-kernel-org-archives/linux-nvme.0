From: keith.busch@intel.com (Keith Busch)
Date: Wed,  6 Jun 2018 08:13:05 -0600
Subject: [PATCH 2/6] nvme-pci: Remove unnecessary completion doorbell check
In-Reply-To: <20180606141309.19389-1-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
Message-ID: <20180606141309.19389-3-keith.busch@intel.com>

The nvme pci driver never unmaps the doorbell registers while the requests
are active, so we can always safely update the completion queue head.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d42a1c361162..94d9abbe2d45 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -920,11 +920,9 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 {
 	u16 head = nvmeq->cq_head;
 
-	if (likely(nvmeq->cq_vector >= 0)) {
-		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
-						      nvmeq->dbbuf_cq_ei))
-			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
-	}
+	if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
+					      nvmeq->dbbuf_cq_ei))
+		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 }
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
-- 
2.14.3
