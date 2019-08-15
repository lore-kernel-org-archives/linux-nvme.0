From: israelr@mellanox.com (Israel Rukshin)
Date: Thu, 15 Aug 2019 16:33:45 +0300
Subject: [PATCH 3/5] nvme-tcp: Use struct nvme_ctrl directly
In-Reply-To: <1565876027-25092-1-git-send-email-israelr@mellanox.com>
References: <1565876027-25092-1-git-send-email-israelr@mellanox.com>
Message-ID: <1565876027-25092-5-git-send-email-israelr@mellanox.com>

This patch doesn't change any functionality.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d..feed0dc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1255,7 +1255,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	queue->queue_size = queue_size;
 
 	if (qid > 0)
-		queue->cmnd_capsule_len = ctrl->ctrl.ioccsz * 16;
+		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
@@ -1263,7 +1263,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
-		dev_err(ctrl->ctrl.device,
+		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
 		return ret;
 	}
@@ -1273,7 +1273,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	ret = kernel_setsockopt(queue->sock, IPPROTO_TCP, TCP_SYNCNT,
 			(char *)&opt, sizeof(opt));
 	if (ret) {
-		dev_err(ctrl->ctrl.device,
+		dev_err(nctrl->device,
 			"failed to set TCP_SYNCNT sock opt %d\n", ret);
 		goto err_sock;
 	}
@@ -1283,7 +1283,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	ret = kernel_setsockopt(queue->sock, IPPROTO_TCP,
 			TCP_NODELAY, (char *)&opt, sizeof(opt));
 	if (ret) {
-		dev_err(ctrl->ctrl.device,
+		dev_err(nctrl->device,
 			"failed to set TCP_NODELAY sock opt %d\n", ret);
 		goto err_sock;
 	}
@@ -1296,7 +1296,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	ret = kernel_setsockopt(queue->sock, SOL_SOCKET, SO_LINGER,
 			(char *)&sol, sizeof(sol));
 	if (ret) {
-		dev_err(ctrl->ctrl.device,
+		dev_err(nctrl->device,
 			"failed to set SO_LINGER sock opt %d\n", ret);
 		goto err_sock;
 	}
@@ -1314,11 +1314,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	queue->pdu_offset = 0;
 	sk_set_memalloc(queue->sock->sk);
 
-	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR) {
+	if (nctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
 		ret = kernel_bind(queue->sock, (struct sockaddr *)&ctrl->src_addr,
 			sizeof(ctrl->src_addr));
 		if (ret) {
-			dev_err(ctrl->ctrl.device,
+			dev_err(nctrl->device,
 				"failed to bind queue %d socket %d\n",
 				qid, ret);
 			goto err_sock;
@@ -1330,7 +1330,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	if (queue->hdr_digest || queue->data_digest) {
 		ret = nvme_tcp_alloc_crypto(queue);
 		if (ret) {
-			dev_err(ctrl->ctrl.device,
+			dev_err(nctrl->device,
 				"failed to allocate queue %d crypto\n", qid);
 			goto err_sock;
 		}
@@ -1344,13 +1344,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		goto err_crypto;
 	}
 
-	dev_dbg(ctrl->ctrl.device, "connecting queue %d\n",
+	dev_dbg(nctrl->device, "connecting queue %d\n",
 			nvme_tcp_queue_id(queue));
 
 	ret = kernel_connect(queue->sock, (struct sockaddr *)&ctrl->addr,
 		sizeof(ctrl->addr), 0);
 	if (ret) {
-		dev_err(ctrl->ctrl.device,
+		dev_err(nctrl->device,
 			"failed to connect socket: %d\n", ret);
 		goto err_rcv_pdu;
 	}
-- 
1.8.3.1
