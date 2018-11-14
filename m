From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Wed, 14 Nov 2018 14:40:24 +0300
Subject: [PATCH 1/2] nvmet-tcp: add protection for already completed requests
 on h2c path
In-Reply-To: <cover.1542805437.git.mskorzhinskiy@solarflare.com>
References: <cover.1542805437.git.mskorzhinskiy@solarflare.com>
Message-ID: <d19e363f484fe1fc50cb410c53b375c336c8816a.1542805437.git.mskorzhinskiy@solarflare.com>

Handling H2C requests pushing completion to block layer in case of
errors. But sometimes these request have no representation in a block
layer, since they are already completed or was never allocated.

This protection causing immediate fatal error but no response to
initiator since there are no API for sending transport error responses
yet.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
---
 drivers/nvme/target/tcp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index fbfda1da52c7..02159713a5a1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -46,6 +46,7 @@ struct nvmet_tcp_send_ctx {
 
 enum {
 	NVMET_TCP_F_INIT_FAILED = (1 << 0),
+	NVMET_TCP_F_PENDING_DATA = (1 << 1),
 };
 
 struct nvmet_tcp_cmd {
@@ -398,6 +399,8 @@ static void nvmet_setup_r2t_pdu(struct nvmet_tcp_cmd *cmd)
 	struct nvmet_tcp_queue *queue = cmd->queue;
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 
+	cmd->flags |= NVMET_TCP_F_PENDING_DATA;
+
 	cmd->snd.offset = 0;
 	cmd->snd.state = NVMET_TCP_SEND_R2T;
 
@@ -835,6 +838,12 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 
 	cmd = &queue->cmds[data->ttag];
 
+	if (!(cmd->flags & NVMET_TCP_F_PENDING_DATA)) {
+		pr_err("queue %d unexpected h2c with ttag %u\n",
+			queue->idx, data->ttag);
+		return -EPROTO;
+	}
+
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("queue %d ttag %u unexpected data offset %u (expected %u)\n",
 			queue->idx, data->ttag, le32_to_cpu(data->data_offset),
@@ -1021,6 +1030,12 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 	queue->rcv.state = NVMET_TCP_RECV_DDGST;
 }
 
+static void nvmet_tcp_req_execute(struct nvmet_tcp_cmd *cmd)
+{
+	cmd->flags &= ~NVMET_TCP_F_PENDING_DATA;
+	nvmet_req_execute(&cmd->req);
+}
+
 static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd  *cmd = queue->rcv.cmd;
@@ -1044,7 +1059,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			nvmet_tcp_prep_recv_ddgst(cmd);
 			return 0;
 		} else {
-			nvmet_req_execute(&cmd->req);
+			nvmet_tcp_req_execute(cmd);
 		}
 	}
 
@@ -1085,7 +1100,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len)
-		nvmet_req_execute(&cmd->req);
+		nvmet_tcp_req_execute(cmd);
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
-- 
2.16.4
