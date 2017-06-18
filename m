From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 17:28:09 +0300
Subject: [PATCH v2 3/4] nvme-pci: factor out the cqe reading mechanics from
 __nvme_process_cq
In-Reply-To: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497796090-14808-4-git-send-email-sagi@grimberg.me>

Also, maintain a consumed counter to rely on for doorbell and
cqe_seen update instead of directly relying on the cq head and phase.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26eb1743f8bc..d309b6c90511 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -770,36 +770,40 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
-static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
+static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
+		struct nvme_completion *cqe)
 {
-	u16 head, phase;
-
-	head = nvmeq->cq_head;
-	phase = nvmeq->cq_phase;
-
-	while (nvme_cqe_valid(nvmeq, head, phase)) {
-		struct nvme_completion cqe = nvmeq->cqes[head];
+	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
+		*cqe = nvmeq->cqes[nvmeq->cq_head];
 
-		if (++head == nvmeq->q_depth) {
-			head = 0;
-			phase = !phase;
+		if (++nvmeq->cq_head == nvmeq->q_depth) {
+			nvmeq->cq_head = 0;
+			nvmeq->cq_phase = !nvmeq->cq_phase;
 		}
-
-		if (tag && *tag == cqe.command_id)
-			*tag = -1;
-
-		nvme_handle_cqe(nvmeq, &cqe);
+		return true;
 	}
+	return false;
+}
 
-	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
-		return;
+static void __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
+{
+	struct nvme_completion cqe;
+	int consumed = 0;
 
-	nvmeq->cq_head = head;
-	nvmeq->cq_phase = phase;
+	while (nvme_read_cqe(nvmeq, &cqe)) {
+		nvme_handle_cqe(nvmeq, &cqe);
+		consumed++;
 
-	nvme_ring_cq_doorbell(nvmeq);
+		if (tag && *tag == cqe.command_id) {
+			*tag = -1;
+			break;
+		}
+	}
 
-	nvmeq->cqe_seen = 1;
+	if (consumed) {
+		nvme_ring_cq_doorbell(nvmeq);
+		nvmeq->cqe_seen = 1;
+	}
 }
 
 static void nvme_process_cq(struct nvme_queue *nvmeq)
-- 
2.7.4
