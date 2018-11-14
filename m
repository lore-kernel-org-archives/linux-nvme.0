From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Wed, 14 Nov 2018 14:48:40 +0300
Subject: [PATCH 2/2] nvme-tcp: add protection against target sending more then
 maxr2t
In-Reply-To: <cover.1542805437.git.mskorzhinskiy@solarflare.com>
References: <cover.1542805437.git.mskorzhinskiy@solarflare.com>
Message-ID: <67fb3fd498dac3488064b1847a364a141af1c0a6.1542805437.git.mskorzhinskiy@solarflare.com>

This is a simple protection against misbehaving targets to protect the
initiator from R2T sent on a wrong time.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
---
 drivers/nvme/host/tcp.c  | 19 ++++++++++++++++++-
 include/linux/nvme-tcp.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e28b9dd8c448..834243fa8359 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -32,6 +32,7 @@ struct nvme_tcp_send_ctx {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+	int                     r2t_cnt;
 };
 
 struct nvme_tcp_recv_ctx {
@@ -566,12 +567,21 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (req->snd.r2t_cnt > NVME_TCP_MAX_R2T) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d tag %#x sent %d r2t while only %d is supported!\n",
+			nvme_tcp_queue_id(queue), pdu->command_id,
+			req->snd.r2t_cnt + 1, NVME_TCP_MAX_R2T);
+		return -ENOENT;
+	}
+
 	ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
 	if (unlikely(ret))
 		return ret;
 
 	req->snd.state = NVME_TCP_SEND_H2C_PDU;
 	req->snd.offset = 0;
+	req->snd.r2t_cnt++;
 
 	nvme_tcp_queue_request(req);
 
@@ -849,6 +859,11 @@ static void nvme_tcp_state_change(struct sock *sk)
 
 static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 {
+	struct nvme_tcp_request *request = queue->request;
+
+	if (request->snd.state == NVME_TCP_SEND_H2C_PDU)
+		request->snd.r2t_cnt--;
+
 	queue->request = NULL;
 }
 
@@ -1176,7 +1191,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	icreq->hdr.pdo = 0;
 	icreq->hdr.plen = cpu_to_le32(icreq->hdr.hlen);
 	icreq->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
-	icreq->maxr2t = 0; /* single inflight r2t supported */
+	icreq->maxr2t = NVME_TCP_MAX_R2T;
 	icreq->hpda = 0; /* no alignment constraint */
 	if (queue->hdr_digest)
 		icreq->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
@@ -1981,6 +1996,7 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	cmd->common.flags |= NVME_CMD_SGL_METABUF;
 	nvme_tcp_set_sg_null(cmd);
 
+	ctrl->async_req.snd.r2t_cnt = 0;
 	ctrl->async_req.snd.state = NVME_TCP_SEND_CMD_PDU;
 	ctrl->async_req.snd.offset = 0;
 	ctrl->async_req.snd.curr_bio = NULL;
@@ -2053,6 +2069,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 
 	req->snd.state = NVME_TCP_SEND_CMD_PDU;
+	req->snd.r2t_cnt = 0;
 	req->snd.offset = 0;
 	req->snd.data_sent = 0;
 	req->pdu_len = 0;
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 685780d1ed04..f659a87299ae 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -13,6 +13,9 @@
 #define NVME_TCP_ADMIN_CCSZ	SZ_8K
 #define NVME_TCP_DIGEST_LENGTH	4
 
+/* single inflight r2t supported */
+#define NVME_TCP_MAX_R2T        cpu_to_le16(0)
+
 enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
 };
-- 
2.16.4
