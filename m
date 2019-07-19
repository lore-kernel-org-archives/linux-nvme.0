From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Jul 2019 12:46:46 -0700
Subject: [PATCH] nvme-tcp: cleanup nvme_tcp_recv_pdu
Message-ID: <20190719194646.24826-1-sagi@grimberg.me>

Can return directly in the switch statement

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 361e4bd6338e..8d4965031399 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -611,23 +611,18 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 	switch (hdr->type) {
 	case nvme_tcp_c2h_data:
-		ret = nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
-		break;
+		return nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
 	case nvme_tcp_rsp:
 		nvme_tcp_init_recv_ctx(queue);
-		ret = nvme_tcp_handle_comp(queue, (void *)queue->pdu);
-		break;
+		return nvme_tcp_handle_comp(queue, (void *)queue->pdu);
 	case nvme_tcp_r2t:
 		nvme_tcp_init_recv_ctx(queue);
-		ret = nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
-		break;
+		return nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"unsupported pdu type (%d)\n", hdr->type);
 		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
-- 
2.17.1
