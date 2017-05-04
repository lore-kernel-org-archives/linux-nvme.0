From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:07 +0300
Subject: [PATCH 03/11] nvme-rdma: Make queue flags bit numbers and not shifts
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-4-git-send-email-sagi@grimberg.me>

bitops accept bit numbers.

Reported-by: Vijay Immanuel <vijayi at attalasystems.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1cd7a21f63f4..5a29e1ea1934 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -80,10 +80,10 @@ struct nvme_rdma_request {
 };
 
 enum nvme_rdma_queue_flags {
-	NVME_RDMA_Q_CONNECTED = (1 << 0),
-	NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
-	NVME_RDMA_Q_DELETING = (1 << 2),
-	NVME_RDMA_Q_LIVE = (1 << 3),
+	NVME_RDMA_Q_CONNECTED		= 0,
+	NVME_RDMA_IB_QUEUE_ALLOCATED	= 1,
+	NVME_RDMA_Q_DELETING		= 2,
+	NVME_RDMA_Q_LIVE		= 3,
 };
 
 struct nvme_rdma_queue {
-- 
2.7.4
