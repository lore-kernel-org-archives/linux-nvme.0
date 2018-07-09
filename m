From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  9 Jul 2018 12:49:05 +0300
Subject: [PATCH for 4.19 1/3] nvme-rdma: unquiesce queues when deleting the
 controller
In-Reply-To: <20180709094907.8683-1-sagi@grimberg.me>
References: <20180709094907.8683-1-sagi@grimberg.me>
Message-ID: <20180709094907.8683-2-sagi@grimberg.me>

If the controller is going away, we need to unquiesce the IO queues so
that all pending request can fail gracefully before moving forward with
controller deletion. Do that before we destroy the IO queues so
blk_cleanup_queue won't block in freeze.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2d4a51a80e8f..2b683b8d4763 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1759,6 +1759,8 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_rdma_stop_io_queues(ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
+		if (shutdown)
+			nvme_start_queues(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
-- 
2.14.1
