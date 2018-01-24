From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 24 Jan 2018 09:28:28 +0100
Subject: [PATCH v7 2/2] nvme: add tracepoint for nvme_complete_rq
In-Reply-To: <20180124082828.364-1-jthumshirn@suse.de>
References: <20180124082828.364-1-jthumshirn@suse.de>
Message-ID: <20180124082828.364-3-jthumshirn@suse.de>

Add a tracepoint in nvme_complete_rq() for completions of NVMe commands. An
expmale output of the trace-point is as follows:

<idle>-0     [001] d.h.     3.505266: nvme_complete_rq: cmdid=989, qid=1, res=0, retries=0, flags=0x0, status=0

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c  |  2 ++
 drivers/nvme/host/trace.h | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 358dfdc1f6da..7cbd4a260d30 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -220,6 +220,8 @@ void nvme_complete_rq(struct request *req)
 {
 	blk_status_t status = nvme_error_status(req);
 
+	trace_nvme_complete_rq(req);
+
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
 		if (nvme_req_needs_failover(req, status)) {
 			nvme_failover_req(req);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index f17dbfbead5a..afd87235311b 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -130,6 +130,32 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
 );
 
+TRACE_EVENT(nvme_complete_rq,
+	    TP_PROTO(struct request *req),
+	    TP_ARGS(req),
+	    TP_STRUCT__entry(
+		    __field(int, qid)
+		    __field(int, cid)
+		    __field(__le64, result)
+		    __field(u8, retries)
+		    __field(u8, flags)
+		    __field(u16, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->qid = req->q->id;
+		    __entry->cid = req->tag;
+		    __entry->result = nvme_req(req)->result.u64;
+		    __entry->retries = nvme_req(req)->retries;
+		    __entry->flags = nvme_req(req)->flags;
+		    __entry->status = nvme_req(req)->status;
+	    ),
+	    TP_printk("cmdid=%u, qid=%d, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->cid, __entry->qid,
+		      le64_to_cpu(__entry->result),
+		      __entry->retries, __entry->flags, __entry->status)
+
+);
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.13.6
