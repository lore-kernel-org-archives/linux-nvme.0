From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  8 Mar 2019 15:41:20 -0800
Subject: [PATCH 1/2] nvme-tcp: support C2HData with SUCCESS flag
In-Reply-To: <20190308234121.1347-1-sagi@grimberg.me>
References: <20190308234121.1347-1-sagi@grimberg.me>
Message-ID: <20190308234121.1347-2-sagi@grimberg.me>

A C2HData PDU with the SUCCESS flag set indicates that the I/O was
completed by the controller successfully and means that a subsequent
completion response capsule PDU will be ommitted.

If we see this flag, fisrt we check that LAST_PDU flag is set as well,
and then we complete the request when the data transfer (and data digest
verification if its on) is done.

While we're at it, reuse a bit of code with nvme_fail_request.

Suggested-by: Oliver Smith-Denny <osmithde at cisco.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 208ee518af65..e7e08889865e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -463,6 +463,15 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 
 	queue->data_remaining = le32_to_cpu(pdu->data_length);
 
+	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS &&
+	    unlikely(!(pdu->hdr.flags & NVME_TCP_F_DATA_LAST))) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d tag %#x SUCCESS set but not last PDU\n",
+			nvme_tcp_queue_id(queue), rq->tag);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		return -EPROTO;
+	}
+
 	return 0;
 
 }
@@ -618,6 +627,14 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	return ret;
 }
 
+static inline void nvme_tcp_end_request(struct request *rq, __le16 status)
+{
+	union nvme_result res = {};
+
+	nvme_end_request(rq, cpu_to_le16(status << 1), res);
+}
+
+
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
@@ -685,6 +702,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
+			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS)
+				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
 			nvme_tcp_init_recv_ctx(queue);
 		}
 	}
@@ -695,6 +714,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 		struct sk_buff *skb, unsigned int *offset, size_t *len)
 {
+	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
@@ -718,6 +738,13 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 		return -EIO;
 	}
 
+	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
+		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
+						pdu->command_id);
+
+		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+	}
+
 	nvme_tcp_init_recv_ctx(queue);
 	return 0;
 }
@@ -815,10 +842,7 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 {
-	union nvme_result res = {};
-
-	nvme_end_request(blk_mq_rq_from_pdu(req),
-		cpu_to_le16(NVME_SC_DATA_XFER_ERROR), res);
+	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_DATA_XFER_ERROR);
 }
 
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
-- 
2.17.1
