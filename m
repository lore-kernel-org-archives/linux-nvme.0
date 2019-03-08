From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  8 Mar 2019 15:41:21 -0800
Subject: [PATCH 2/2] nvmet-tcp: implement C2HData SUCCESS optimization
In-Reply-To: <20190308234121.1347-1-sagi@grimberg.me>
References: <20190308234121.1347-1-sagi@grimberg.me>
Message-ID: <20190308234121.1347-3-sagi@grimberg.me>

TP 8000 says that the use of the SUCCESS flag depends on weather the
controller support disabling sq_head pointer updates. Given that we
support it by default, makes sense that we go the extra mile to actually
use the SUCCESS flag.

When we create the C2HData PDU header, we check if sqhd_disabled is set
on our queue, if so, we set the SUCCESS flag in the PDU header and
skip sending a completion response capsule.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/tcp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ad0df786fe93..0a941abf56ec 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -371,7 +371,8 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 	cmd->state = NVMET_TCP_SEND_DATA_PDU;
 
 	pdu->hdr.type = nvme_tcp_c2h_data;
-	pdu->hdr.flags = NVME_TCP_F_DATA_LAST;
+	pdu->hdr.flags = NVME_TCP_F_DATA_LAST | (queue->nvme_sq.sqhd_disabled ?
+						NVME_TCP_F_DATA_SUCCESS : 0);
 	pdu->hdr.hlen = sizeof(*pdu);
 	pdu->hdr.pdo = pdu->hdr.hlen + hdgst;
 	pdu->hdr.plen =
@@ -542,8 +543,19 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
 		cmd->state = NVMET_TCP_SEND_DDGST;
 		cmd->offset = 0;
 	} else {
-		nvmet_setup_response_pdu(cmd);
+		if (queue->nvme_sq.sqhd_disabled) {
+			cmd->queue->snd_cmd = NULL;
+			nvmet_tcp_put_cmd(cmd);
+		} else {
+			nvmet_setup_response_pdu(cmd);
+		}
 	}
+
+	if (queue->nvme_sq.sqhd_disabled) {
+		kfree(cmd->iov);
+		sgl_free(cmd->req.sg);
+	}
+
 	return 1;
 
 }
@@ -619,7 +631,13 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd)
 		return ret;
 
 	cmd->offset += ret;
-	nvmet_setup_response_pdu(cmd);
+
+	if (queue->nvme_sq.sqhd_disabled) {
+		cmd->queue->snd_cmd = NULL;
+		nvmet_tcp_put_cmd(cmd);
+	} else {
+		nvmet_setup_response_pdu(cmd);
+	}
 	return 1;
 }
 
-- 
2.17.1
