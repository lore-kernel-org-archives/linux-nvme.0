From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  6 Jun 2019 15:32:28 +0900
Subject: [RFC PATCH V6 2/3] nvme: trace: do not EXPORT_SYMBOL for a trace
 function
In-Reply-To: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
References: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606063229.17258-3-minwoo.im.dev@gmail.com>

nvme_trace_disk_name() is now already being invoked with the function
prototype in trace.h.  We don't need to export this symbol at all.

The following patches are going to provide target-side trace feature
with the exactly same function with this so that this patch removes the
EXPORT_SYMBOL() for this function.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 5f24ea7a28eb..14b0d2993cbe 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -145,6 +145,5 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
-- 
2.21.0
