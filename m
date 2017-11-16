From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 16 Nov 2017 19:21:24 +0200
Subject: [PATCH 2/3] nvmet-rdma: use srq pointer in rdma_cmd
In-Reply-To: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
References: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
Message-ID: <1510852885-25519-3-git-send-email-maxg@mellanox.com>

This is a preparetion patch that creates an infrastructure in post
recv mechanism for the SRQ per completion vector feature.

Change-Id: I0b0130920580e6999f0517400a45a1078e9553c9
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4991290..3ecfc12 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -45,6 +45,7 @@ struct nvmet_rdma_cmd {
 	struct page		*inline_page;
 	struct nvme_command     *nvme_cmd;
 	struct nvmet_rdma_queue	*queue;
+	struct ib_srq		*srq;
 };
 
 enum {
@@ -442,8 +443,8 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 		cmd->sge[0].addr, cmd->sge[0].length,
 		DMA_FROM_DEVICE);
 
-	if (ndev->srq)
-		return ib_post_srq_recv(ndev->srq, &cmd->wr, &bad_wr);
+	if (cmd->srq)
+		return ib_post_srq_recv(cmd->srq, &cmd->wr, &bad_wr);
 	return ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
 }
 
@@ -821,8 +822,10 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 	ndev->srq = srq;
 	ndev->srq_size = srq_size;
 
-	for (i = 0; i < srq_size; i++)
+	for (i = 0; i < srq_size; i++) {
+		ndev->srq_cmds[i].srq = srq;
 		nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
+	}
 
 	return 0;
 
-- 
1.8.3.1
