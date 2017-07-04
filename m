From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Jul 2017 10:57:33 +0300
Subject: [PATCH v2 5/8] nvme-rdma: update tagset nr_hw_queues after
 reconnecting/resetting
In-Reply-To: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
References: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499155056-11241-6-git-send-email-sagi@grimberg.me>

We might have more/less queues once we reconnect/reset. For
example due to cpu going online/offline or controller constraints.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2ab0cdb4d881..cfb22531fc16 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -741,6 +741,9 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 		ret = nvme_rdma_connect_io_queues(ctrl);
 		if (ret)
 			goto requeue;
+
+		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
+				ctrl->ctrl.queue_count - 1);
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1727,6 +1730,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		ret = nvme_rdma_connect_io_queues(ctrl);
 		if (ret)
 			goto del_dead_ctrl;
+
+		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
+				ctrl->ctrl.queue_count - 1);
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-- 
2.7.4
