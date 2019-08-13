From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 13 Aug 2019 16:17:31 +0300
Subject: [PATCH 5/5] nvmet-tcp: Add TOS for tcp transport
In-Reply-To: <1565702251-17198-1-git-send-email-israelr@mellanox.com>
References: <1565702251-17198-1-git-send-email-israelr@mellanox.com>
Message-ID: <1565702251-17198-7-git-send-email-israelr@mellanox.com>

Set the outgoing packets type of service (TOS) according to the
receiving TOS.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Suggested-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/tcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 69b83fa..fdf10ee 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1410,6 +1410,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
+	struct inet_sock *inet = inet_sk(sock->sk);
 	struct linger sol = { .l_onoff = 1, .l_linger = 0 };
 	int ret;
 
@@ -1433,6 +1434,16 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret)
 		return ret;
 
+	/* Set socket type of service */
+	if (inet->rcv_tos > 0) {
+		int tos = inet->rcv_tos;
+
+		ret = kernel_setsockopt(sock, SOL_IP, IP_TOS,
+				(char *)&tos, sizeof(tos));
+		if (ret)
+			return ret;
+	}
+
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	sock->sk->sk_user_data = queue;
 	queue->data_ready = sock->sk->sk_data_ready;
-- 
1.8.3.1
