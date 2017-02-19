From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 19 Feb 2017 20:08:03 +0200
Subject: [PATCHv2 1/1] nvme-rdma: add support for host_traddr
Message-ID: <1487527683-10108-1-git-send-email-maxg@mellanox.com>

This will enable the user to control the specific interface for
connection establishment in case the host has more than 1 interface
under the same subnet.
E.g:
Host interfaces configured as:
 - ib0 1.1.1.1/16
 - ib1 1.1.1.2/16

Target interfaces configured as:
 - ib0 1.1.1.3/16 (listener interface)
 - ib1 1.1.1.4/16

the following connect command will go through host iface ib0 (default):
nvme connect -t rdma -n testsubsystem -a 1.1.1.3 -s 1023

but the following command will go through host iface ib1:
nvme connect -t rdma -n testsubsystem -a 1.1.1.3 -s 1023 -w 1.1.1.2

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Parav Pandit <parav at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---

Changes from v1:
 - break lines after 80 characters
 - Add Christoph as reviewer

---
 drivers/nvme/host/rdma.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 557f29b..96285ef 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -155,6 +155,10 @@ struct nvme_rdma_ctrl {
 		struct sockaddr addr;
 		struct sockaddr_in addr_in;
 	};
+	union {
+		struct sockaddr src_addr;
+		struct sockaddr_in src_addr_in;
+	};
 
 	struct nvme_ctrl	ctrl;
 };
@@ -567,6 +571,7 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 		int idx, size_t queue_size)
 {
 	struct nvme_rdma_queue *queue;
+	struct sockaddr *src_addr = NULL;
 	int ret;
 
 	queue = &ctrl->queues[idx];
@@ -589,7 +594,10 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 	}
 
 	queue->cm_error = -ETIMEDOUT;
-	ret = rdma_resolve_addr(queue->cm_id, NULL, &ctrl->addr,
+	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
+		src_addr = &ctrl->src_addr;
+
+	ret = rdma_resolve_addr(queue->cm_id, src_addr, &ctrl->addr,
 			NVME_RDMA_CONNECT_TIMEOUT_MS);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
@@ -1905,6 +1913,16 @@ static int nvme_rdma_parse_ipaddr(struct sockaddr_in *in_addr, char *p)
 		goto out_free_ctrl;
 	}
 
+	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
+		ret = nvme_rdma_parse_ipaddr(&ctrl->src_addr_in,
+				opts->host_traddr);
+		if (ret) {
+			pr_err("malformed src IP address passed: %s\n",
+			       opts->host_traddr);
+			goto out_free_ctrl;
+		}
+	}
+
 	if (opts->mask & NVMF_OPT_TRSVCID) {
 		u16 port;
 
@@ -2016,7 +2034,8 @@ static int nvme_rdma_parse_ipaddr(struct sockaddr_in *in_addr, char *p)
 static struct nvmf_transport_ops nvme_rdma_transport = {
 	.name		= "rdma",
 	.required_opts	= NVMF_OPT_TRADDR,
-	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY,
+	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
+			  NVMF_OPT_HOST_TRADDR,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
1.7.1
