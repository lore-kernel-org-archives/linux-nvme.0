From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Mar 2019 08:54:14 +0100
Subject: [PATCH] nvme-tcp: fix an endianess miss-annotation
Message-ID: <20190315075414.30158-1-hch@lst.de>

nvme_tcp_end_request just takes the status value and the converts
it to little endian as well as shifting for the phase bit.

Fixes: 43ce38a6d823 ("nvme-tcp: support C2HData with SUCCESS flag")
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e7e08889865e..68c49dd67210 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -627,7 +627,7 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	return ret;
 }
 
-static inline void nvme_tcp_end_request(struct request *rq, __le16 status)
+static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
 	union nvme_result res = {};
 
-- 
2.20.1
