From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:51:05 +0100
Subject: [PATCH 1/3] nvmet-tcp: fix endianess annotations
In-Reply-To: <20181213085107.17183-1-hch@lst.de>
References: <20181213085107.17183-1-hch@lst.de>
Message-ID: <20181213085107.17183-2-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d31bec260160..44b37b202e39 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -758,7 +758,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 
 	if (icreq->maxr2t != 0) {
 		pr_err("queue %d: unsupported maxr2t %d\n", queue->idx,
-			le16_to_cpu(icreq->maxr2t) + 1);
+			le32_to_cpu(icreq->maxr2t) + 1);
 		return -EPROTO;
 	}
 
@@ -776,7 +776,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	icresp->hdr.pdo = 0;
 	icresp->hdr.plen = cpu_to_le32(icresp->hdr.hlen);
 	icresp->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
-	icresp->maxdata = 0xffff; /* FIXME: support r2t */
+	icresp->maxdata = cpu_to_le32(0xffff); /* FIXME: support r2t */
 	icresp->cpda = 0;
 	if (queue->hdr_digest)
 		icresp->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
-- 
2.19.2
