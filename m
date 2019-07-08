From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Mon, 8 Jul 2019 12:31:29 +0200
Subject: [PATCH v2 2/2] nvme-tcp: don't use sendpage for SLAB pages
In-Reply-To: <cover.1562586804.git.mskorzhinskiy@solarflare.com>
References: <cover.1562586804.git.mskorzhinskiy@solarflare.com>
Message-ID: <3206ec8102d4dae933f4638652e84349dcc50ee4.1562586804.git.mskorzhinskiy@solarflare.com>

According to commit a10674bf2406 ("tcp: detecting the misuse of .sendpage
for Slab objects") and previous discussion, tcp_sendpage should not be
used for pages that is managed by SLAB, as SLAB is not taking page
reference counters into consideration.

This change prevents sendpage calls for payload sending too, although this
is true only for admin commands, so actual data transfer performance
should be untouched.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
---
 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08a2501b9357..c4acdbdca520 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -860,7 +860,12 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE;
 
-		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
+		/* can't zcopy slab pages */
+		if (unlikely(PageSlab(page))) {
+			ret = sock_no_sendpage(queue->sock, page, offset, len, flags);
+		} else {
+			ret = kernel_sendpage(queue->sock, page, offset, len, flags);
+		}
 		if (ret <= 0)
 			return ret;
 
-- 
2.16.4
