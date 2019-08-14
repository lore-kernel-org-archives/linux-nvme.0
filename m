From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 14 Aug 2019 13:19:40 +0300
Subject: [PATCH 4/5] nvme-tcp: Add TOS for tcp transport
In-Reply-To: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
References: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
Message-ID: <1565777981-18755-6-git-send-email-israelr@mellanox.com>

TOS provide clients the ability to segregate traffic flows for
different type of data.
One of the TOS usage is bandwidth management which allows setting bandwidth
limits for QoS classes, e.g. 80% bandwidth to controllers at QoS class A
and 20% to controllers at QoS class B.

usage example:
nvme connect --tos=0 --transport=tcp --traddr=10.0.1.1 --nqn=test-nvme

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index feed0dc..229017f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1301,6 +1301,18 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		goto err_sock;
 	}
 
+	/* Set socket type of service */
+	if (nctrl->opts->tos >= 0) {
+		opt = nctrl->opts->tos;
+		ret = kernel_setsockopt(queue->sock, SOL_IP, IP_TOS,
+				(char *)&opt, sizeof(opt));
+		if (ret) {
+			dev_err(nctrl->device,
+				"failed to set IP_TOS sock opt %d\n", ret);
+			goto err_sock;
+		}
+	}
+
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	if (!qid)
 		n = 0;
-- 
1.8.3.1
