From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 17 Jan 2018 11:53:36 +0100
Subject: [PATCH v3 2/2] nvme: add tracepoint for nvme_complete_rq
In-Reply-To: <20180117105336.8666-1-jthumshirn@suse.de>
References: <20180117105336.8666-1-jthumshirn@suse.de>
Message-ID: <20180117105336.8666-3-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>

---
Changes to v2:
* Pass the whole struct request to the tracepoint
* Removed spaces after parenthesis (Christoph)
---
 drivers/nvme/host/core.c  |  2 ++
 drivers/nvme/host/trace.h | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9c5d476c8c6d..c61014d56279 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -193,6 +193,8 @@ static inline bool nvme_req_needs_retry(struct request *req)
 
 void nvme_complete_rq(struct request *req)
 {
+	trace_nvme_complete_rq(req);
+
 	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
 		if (nvme_req_needs_failover(req)) {
 			nvme_failover_req(req);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index a168d806d494..b416dc0760c1 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -22,6 +22,8 @@
 #include <linux/tracepoint.h>
 #include <linux/trace_seq.h>
 
+#include "nvme.h"
+
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
 #define show_opcode_name(val)					\
 	__print_symbolic(val,					\
@@ -66,6 +68,30 @@ TRACE_EVENT(nvme_setup_cmd,
 		      __parse_nvme_cmd(__entry->cmnd))
 );
 
+TRACE_EVENT(nvme_complete_rq,
+	    TP_PROTO(struct request *req),
+	    TP_ARGS(req),
+	    TP_STRUCT__entry(
+		    __field(int, cid)
+		    __field(__le64, result)
+		    __field(u8, retries)
+		    __field(u8, flags)
+		    __field(u16, status)
+	    ),
+	    TP_fast_assign(
+		    __entry->cid = req->tag;
+		    __entry->result = nvme_req(req)->result.u64;
+		    __entry->retries = nvme_req(req)->retries;
+		    __entry->flags = nvme_req(req)->flags;
+		    __entry->status = nvme_req(req)->status;
+	    ),
+	    TP_printk("cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->cid,
+		      le64_to_cpu(__entry->result),
+		      __entry->retries, __entry->flags, __entry->status)
+
+);
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.12.3
