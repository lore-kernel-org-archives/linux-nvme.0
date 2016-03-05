From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Sat, 5 Mar 2016 08:23:15 +0100 (CET)
Subject: [PATCH] nvme: avoid cqe corruption when update at the same time as
 read
In-Reply-To: <1963234885.1121305.1457109031908.JavaMail.zimbra@kalray.eu>
References: <1963234885.1121305.1457109031908.JavaMail.zimbra@kalray.eu>
Message-ID: <1380738962.1128342.1457162595145.JavaMail.zimbra@kalray.eu>

The cqe structure read normally happens from lower to upper addresses
and the validity bit (status) is at the highest address. If the PCI
updates the memory when the cqe is read by multiple non-atomic loads,
the structure may be corrupted. Avoid this by reading the status
first and then the whole structure.

Signed-off-by: Marta Rybczynska <marta.rybczynska at kalray.eu>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a128672..cf74ffe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -729,12 +729,13 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 	phase = nvmeq->cq_phase;
 
 	for (;;) {
-		struct nvme_completion cqe = nvmeq->cqes[head];
-		u16 status = le16_to_cpu(cqe.status);
+		struct nvme_completion cqe;
+		u16 status = le16_to_cpu(nvmeq->cqes[head].status);
 		struct request *req;
 
 		if ((status & 1) != phase)
 			break;
+		cqe = nvmeq->cqes[head];
 		nvmeq->sq_head = le16_to_cpu(cqe.sq_head);
 		if (++head == nvmeq->q_depth) {
 			head = 0;
-- 
2.1.4
