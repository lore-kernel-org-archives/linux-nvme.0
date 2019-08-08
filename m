From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  8 Aug 2019 13:55:22 -0700
Subject: [PATCH 2/2] nvmet-tcp: fix possible memory leak
In-Reply-To: <20190808205522.24638-1-sagi@grimberg.me>
References: <20190808205522.24638-1-sagi@grimberg.me>
Message-ID: <20190808205522.24638-2-sagi@grimberg.me>

when we uninit a command in error flow we also need to
free an iovec if it was allocated.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 0d63f3da0117..76e43750b9e5 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1309,6 +1309,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 {
 	nvmet_req_uninit(&cmd->req);
 	nvmet_tcp_unmap_pdu_iovec(cmd);
+	kfree(cmd->iov);
 	if (cmd->req.sg_cnt)
 		sgl_free(cmd->req.sg);
 }
-- 
2.17.1
