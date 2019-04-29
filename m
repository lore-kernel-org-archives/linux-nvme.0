From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Apr 2019 16:25:48 -0700
Subject: [PATCH] nvme-tcp: fix possible null deref on a timed out io queue
 connect
Message-ID: <20190429232548.9280-1-sagi@grimberg.me>

If I/O queue connect times out, we might have freed the queue socket
already, so check for that on the error path in nvme_tcp_start_queue.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1a5217c85158..e04017f92eaf 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1431,7 +1431,8 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	if (!ret) {
 		set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
 	} else {
-		__nvme_tcp_stop_queue(&ctrl->queues[idx]);
+		if (test_bit(NVME_TCP_Q_ALLOCATED, &ctrl->queues[idx].flags))
+			__nvme_tcp_stop_queue(&ctrl->queues[idx]);
 		dev_err(nctrl->device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
-- 
2.17.1
