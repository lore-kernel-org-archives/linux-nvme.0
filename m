From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 26 Apr 2018 13:49:26 -0600
Subject: [PATCH] nvme: change order of qid and cmdid in completion trace
Message-ID: <20180426194926.18767-1-jthumshirn@suse.de>

Keith reported that command submission and command completion
tracepoints have the order of the cmdid and qid fileds swapped.

While it isn't easily possible to change the command submission
tracepoint, as there is a regression test parsing it in blktests we
can swap the command completion tracepoint to have the fileds aligned.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reported-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index ea91fccd1bc0..01390f0e1671 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -148,8 +148,8 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("cmdid=%u, qid=%d, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->cid, __entry->qid, __entry->result,
+	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->qid, __entry->cid, __entry->result,
 		      __entry->retries, __entry->flags, __entry->status)
 
 );
-- 
2.16.3
