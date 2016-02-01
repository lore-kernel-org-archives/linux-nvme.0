From: mail_weber_wang@163.com (Wenbo Wang)
Date: Mon,  1 Feb 2016 10:42:04 -0500
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been suspended
Message-ID: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>

If __nvme_submit_cmd races with nvme_dev_disable, nvmeq
could have been suspended and dev->bar could have been
unmapped. Do not touch sq door bell in this case.

Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
CC: linux-nvme at lists.infradead.org
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8b1a725..2288712 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -325,7 +325,8 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, nvmeq->q_db);
+	if (likely(nvmeq->cq_vector >= 0))
+		writel(tail, nvmeq->q_db);
 	nvmeq->sq_tail = tail;
 }
 
-- 
1.8.3.1
