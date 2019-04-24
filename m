From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 11:53:16 -0700
Subject: [PATCH 1/4] nvmet-tcp: don't fail maxr2t greater than 1
In-Reply-To: <20190424185319.18942-1-sagi@grimberg.me>
References: <20190424185319.18942-1-sagi@grimberg.me>
Message-ID: <20190424185319.18942-2-sagi@grimberg.me>

The host may support it, but nothing prevents us from
sending a single r2t at a time like we do anyways.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/tcp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 0a941abf56ec..02e9444565ea 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -774,12 +774,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 		return -EPROTO;
 	}
 
-	if (icreq->maxr2t != 0) {
-		pr_err("queue %d: unsupported maxr2t %d\n", queue->idx,
-			le32_to_cpu(icreq->maxr2t) + 1);
-		return -EPROTO;
-	}
-
 	queue->hdr_digest = !!(icreq->digest & NVME_TCP_HDR_DIGEST_ENABLE);
 	queue->data_digest = !!(icreq->digest & NVME_TCP_DATA_DIGEST_ENABLE);
 	if (queue->hdr_digest || queue->data_digest) {
-- 
2.17.1
