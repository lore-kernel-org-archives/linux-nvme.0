From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 8 Nov 2016 09:16:02 -0800
Subject: [PATCH] nvme-rdma: stop and free io queues on connect failure
Message-ID: <20161108200724.3F817E09E2@smtp.ogc.us>

While testing nvme-rdma with the spdk nvmf target over iw_cxgb4, I
configured the target (mistakenly) to generate an error creating the
NVMF IO queues.  This resulted a "Invalid SQE Parameter" error sent back
to the host on the first IO queue connect:

[ 9610.928182] nvme nvme1: queue_size 128 > ctrl maxcmd 120, clamping down
[ 9610.938745] nvme nvme1: creating 32 I/O queues.

So nvmf_connect_io_queue() returns an error to
nvmf_connect_io_queue() / nvmf_connect_io_queues(), and that
is returned to nvme_rdma_create_io_queues().  In the error path,
nvmf_rdma_create_io_queues() frees the queue tagset memory _before_
stopping and freeing the IB queues, which causes yet another
touch-after-free crash due to SQ CQEs being flushed after the ib_cqe
structs pointed-to by the flushed WRs have been freed (since they are
part of the nvme_rdma_request struct).

The fix is to stop and free the queues in nvmf_connect_io_queues()
if there is an error connecting any of the queues.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index af1c114..0504f39 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -624,11 +624,18 @@ static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
-		if (ret)
-			break;
+		if (ret) {
+			dev_info(ctrl->ctrl.device,
+				"failed to connect i/o queue: %d\n", ret);
+			goto out_free_queues;
+		}
 		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
+	return 0;
+
+out_free_queues:
+	nvme_rdma_free_io_queues(ctrl);
 	return ret;
 }
 
-- 
2.7.0
