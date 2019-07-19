From: sashal@kernel.org (Sasha Levin)
Date: Thu, 18 Jul 2019 23:56:08 -0400
Subject: [PATCH AUTOSEL 5.2 137/171] nvme-tcp: don't use sendpage for SLAB
 pages
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
Message-ID: <20190719035643.14300-137-sashal@kernel.org>

From: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>

[ Upstream commit 37c15219599f7a4baa73f6e3432afc69ba7cc530 ]

According to commit a10674bf2406 ("tcp: detecting the misuse of
.sendpage for Slab objects") and previous discussion, tcp_sendpage
should not be used for pages that is managed by SLAB, as SLAB is not
taking page reference counters into consideration.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/tcp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08a2501b9357..606b13d35d16 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -860,7 +860,14 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE;
 
-		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
+		/* can't zcopy slab pages */
+		if (unlikely(PageSlab(page))) {
+			ret = sock_no_sendpage(queue->sock, page, offset, len,
+					flags);
+		} else {
+			ret = kernel_sendpage(queue->sock, page, offset, len,
+					flags);
+		}
 		if (ret <= 0)
 			return ret;
 
-- 
2.20.1
