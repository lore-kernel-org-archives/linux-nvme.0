From: sashal@kernel.org (Sasha Levin)
Date: Sat,  9 Feb 2019 13:48:23 -0500
Subject: [PATCH AUTOSEL 4.19 15/28] nvme-pci: fix out of bounds access in
 nvme_cqe_pending
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
Message-ID: <20190209184840.126418-15-sashal@kernel.org>

From: Hongbo Yao <yaohongbo@huawei.com>

[ Upstream commit dcca1662727220d18fa351097ddff33f95f516c5 ]

There is an out of bounds array access in nvme_cqe_peding().

When enable irq_thread for nvme interrupt, there is racing between the
nvmeq->cq_head updating and reading.

nvmeq->cq_head is updated in nvme_update_cq_head(), if nvmeq->cq_head
equals nvmeq->q_depth and before its value set to zero, nvme_cqe_pending()
uses its value as an array index, the index will be out of bounds.

Signed-off-by: Hongbo Yao <yaohongbo at huawei.com>
[hch: slight coding style update]
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 40f76b4f08fc..f46313f441ec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -908,9 +908,11 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	if (++nvmeq->cq_head == nvmeq->q_depth) {
+	if (nvmeq->cq_head == nvmeq->q_depth - 1) {
 		nvmeq->cq_head = 0;
 		nvmeq->cq_phase = !nvmeq->cq_phase;
+	} else {
+		nvmeq->cq_head++;
 	}
 }
 
-- 
2.19.1
