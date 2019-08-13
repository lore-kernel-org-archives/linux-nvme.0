From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 13 Aug 2019 16:17:28 +0300
Subject: [PATCH 2/5] nvme-rdma: Add TOS for rdma transport
In-Reply-To: <1565702251-17198-1-git-send-email-israelr@mellanox.com>
References: <1565702251-17198-1-git-send-email-israelr@mellanox.com>
Message-ID: <1565702251-17198-4-git-send-email-israelr@mellanox.com>

For RDMA transports, TOS is an extension of IB QoS to provide clients
the ability to segregate traffic flows for different type of data.
RDMA CM abstract it for ULPs using rdma_set_service_type().
Internally, each traffic flow is represented by a connection with all of
its independent resources like that of a normal connection, and is
differentiated by service type. In other words, there can be multiple qp
connections between an IP pair and each supports a unique service type.

One of the TOS usage is bandwidth management which allows setting bandwidth
limits for QoS classes, e.g. 80% bandwidth to controllers at QoS class A
and 20% to controllers at QoS class B.

Note: In addition to the TOS configuration, QOS must be configured on the
relevant HCA on the target (send RDMA commands) and initiator to effect
the traffic.

usage examples:
nvme connect --tos=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a249db5..9fd3d33 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1541,16 +1541,18 @@ static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
 
 static int nvme_rdma_addr_resolved(struct nvme_rdma_queue *queue)
 {
+	struct nvme_ctrl *ctrl = &queue->ctrl->ctrl;
 	int ret;
 
 	ret = nvme_rdma_create_queue_ib(queue);
 	if (ret)
 		return ret;
 
+	if (ctrl->opts->tos >= 0)
+		rdma_set_service_type(queue->cm_id, ctrl->opts->tos);
 	ret = rdma_resolve_route(queue->cm_id, NVME_RDMA_CONNECT_TIMEOUT_MS);
 	if (ret) {
-		dev_err(queue->ctrl->ctrl.device,
-			"rdma_resolve_route failed (%d).\n",
+		dev_err(ctrl->device, "rdma_resolve_route failed (%d).\n",
 			queue->cm_error);
 		goto out_destroy_queue;
 	}
-- 
1.8.3.1
