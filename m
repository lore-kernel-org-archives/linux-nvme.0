From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  9 Jan 2019 14:56:32 -0800
Subject: [PATCH] nvmet-tcp: fix uninitialized variable access
Message-ID: <20190109225632.24160-1-sagi@grimberg.me>

If we end up in nvmet_tcp_try_recv_one with a bogus state
queue receive state we will access result which is uninitialized.

Initialize restult to 0 which will be considered as if no data
was received by the tcp socket.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 44b37b202e39..ad0df786fe93 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1089,7 +1089,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 
 static int nvmet_tcp_try_recv_one(struct nvmet_tcp_queue *queue)
 {
-	int result;
+	int result = 0;
 
 	if (unlikely(queue->rcv_state == NVMET_TCP_RECV_ERR))
 		return 0;
-- 
2.17.1
