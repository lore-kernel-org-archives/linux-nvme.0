From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 12:35:02 -0700
Subject: [PATCH v4 8/8] nvmet_rdma: log the connection reject message
In-Reply-To: <cover.1477426743.git.swise@opengridcomputing.com>
References: <cover.1477426743.git.swise@opengridcomputing.com>
Message-ID: <e6b79fbb52407dd4b3b9193f4cda3016069eb571.1477426743.git.swise@opengridcomputing.com>

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/target/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1cbe6e0..8315224 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1358,6 +1358,9 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		ret = nvmet_rdma_device_removal(cm_id, queue);
 		break;
 	case RDMA_CM_EVENT_REJECTED:
+		pr_debug("Connection rejected: %s\n",
+			 rdma_reject_msg(cm_id, event->status));
+		/* FALLTHROUGH */
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 		nvmet_rdma_queue_connect_fail(cm_id, queue);
-- 
2.7.0
