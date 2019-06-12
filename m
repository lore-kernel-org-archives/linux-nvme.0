From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 12 Jun 2019 21:45:32 +0900
Subject: [PATCH V8 4/5] nvme: trace: print result and status in hex format
In-Reply-To: <20190612124533.10299-1-minwoo.im.dev@gmail.com>
References: <20190612124533.10299-1-minwoo.im.dev@gmail.com>
Message-ID: <20190612124533.10299-5-minwoo.im.dev@gmail.com>

The "result" field is in 64bit to be printed out which means it could be
like:
  nvme_complete_rq: nvme0: qid=0, cmdid=0, res=18446612684158962624, etries=0, flags=0x0, status=0

Also the "status" field would be great to be parsed if it's in hex
format.

This patch makes them to be printed out in hexa format.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 19a18c87fb7b..daaf700eae79 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -105,7 +105,7 @@ TRACE_EVENT(nvme_complete_rq,
 		__entry->status = nvme_req(req)->status;
 		__assign_disk_name(__entry->disk, req->rq_disk);
 	    ),
-	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%#llx, retries=%u, flags=0x%x, status=%#x",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
 		      __entry->qid, __entry->cid, __entry->result,
 		      __entry->retries, __entry->flags, __entry->status)
-- 
2.21.0
