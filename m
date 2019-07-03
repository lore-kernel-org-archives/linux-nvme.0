From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Wed, 3 Jul 2019 12:47:09 +0200
Subject: [PATCH 3/3] nvme-tcp: replace sendpage calls with sendmsg calls for
 SLAB chunks
In-Reply-To: <cover.1562234605.git.mskorzhinskiy@solarflare.com>
References: <cover.1562234605.git.mskorzhinskiy@solarflare.com>
Message-ID: <cdce4bc7cedc11a80c01e457a4b18933b73017e2.1562234605.git.mskorzhinskiy@solarflare.com>

According to commit a10674bf2406 ("tcp: detecting the misuse of .sendpage
for Slab objects") and previous discussion[1][2], tcp_sendpage should not
be used for pages that is managed by SLAB, as SLAB is not taking page
reference counters into consideration.

This change prevents sendpage calls for payload sending too, although this
is true only for admin commands, so actual data transfer performance
should be untouched.

[1] https://www.spinics.net/lists/netdev/msg553616.html
[2] https://www.spinics.net/lists/netdev/msg553285.html

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
---
 drivers/nvme/host/tcp.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08a2501b9357..8cca9967d909 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -844,6 +844,24 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_DATA_XFER_ERROR);
 }
 
+static int nvme_tcp_sendpage(struct nvme_tcp_request *req, struct page *page,
+			      size_t offset, size_t len, int flags)
+{
+	struct nvme_tcp_queue *queue = req->queue;
+
+	if (PageSlab(page)) {
+		struct msghdr msg = { .msg_flags = flags };
+		struct kvec iov =  {
+				    .iov_base = page_to_virt(page) + offset,
+				    .iov_len = len
+		};
+
+		return kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
+	} else {
+		return kernel_sendpage(queue->sock, page, offset, len, flags);
+	}
+}
+
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
@@ -860,7 +878,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE;
 
-		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
+		ret = nvme_tcp_sendpage(req, page, offset, len, flags);
 		if (ret <= 0)
 			return ret;
 
@@ -885,6 +903,19 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 	return -EAGAIN;
 }
 
+static inline int nvme_tcp_try_send_pdu(struct nvme_tcp_request *req,
+					int len, int flags)
+{
+	struct nvme_tcp_queue *queue = req->queue;
+	struct msghdr msg = { .msg_flags = flags };
+	struct kvec iov = {
+			   .iov_base = req->pdu + req->offset,
+			   .iov_len = len,
+	};
+
+	return kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
+}
+
 static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
@@ -898,8 +929,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,  flags);
+	ret = nvme_tcp_try_send_pdu(req, len, flags);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -931,9 +961,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,
-			MSG_DONTWAIT | MSG_MORE);
+	ret = nvme_tcp_try_send_pdu(req, len, MSG_DONTWAIT | MSG_MORE);
 	if (unlikely(ret <= 0))
 		return ret;
 
-- 
2.16.4
