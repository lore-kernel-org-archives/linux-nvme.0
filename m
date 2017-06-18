From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 17:28:07 +0300
Subject: [PATCH v2 1/4] nvme-pci: Introduce nvme_ring_cq_doorbell
In-Reply-To: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497796090-14808-2-git-send-email-sagi@grimberg.me>

Nice abstraction of the actual mechanics of how to do it.
Note the change that we call it after we assign nvmeq->cq_head
to avoid passing it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0f09a2d5cf7a..042cfe5ef8e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -730,6 +730,17 @@ static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
 	return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
 }
 
+static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
+{
+	u16 head = nvmeq->cq_head;
+
+	if (likely(nvmeq->cq_vector >= 0)) {
+		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
+						      nvmeq->dbbuf_cq_ei))
+			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	}
+}
+
 static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 {
 	u16 head, phase;
@@ -776,13 +787,11 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return;
 
-	if (likely(nvmeq->cq_vector >= 0))
-		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
-						      nvmeq->dbbuf_cq_ei))
-			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
+	nvme_ring_cq_doorbell(nvmeq);
+
 	nvmeq->cqe_seen = 1;
 }
 
-- 
2.7.4
