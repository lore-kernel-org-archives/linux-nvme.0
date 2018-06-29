From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 Jun 2018 16:50:02 -0600
Subject: [PATCHv4 3/4] nvme: add controller name to trace events
In-Reply-To: <20180629225003.16567-1-keith.busch@intel.com>
References: <20180629225003.16567-1-keith.busch@intel.com>
Message-ID: <20180629225003.16567-4-keith.busch@intel.com>

This appends the controller instance to the nvme trace buffer to
distinguish which controller is dispatching and completing a command.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/trace.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 6f9ee5fe5e09..b171b54f4b0e 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -95,6 +95,7 @@ TRACE_EVENT(nvme_setup_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		__field(int, ctrl_id)
 		__field(int, qid)
 		__field(u8, opcode)
 		__field(u8, flags)
@@ -105,6 +106,7 @@ TRACE_EVENT(nvme_setup_cmd,
 	    ),
 	    TP_fast_assign(
 		__assign_nvme_qid(req, __entry->qid);
+		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->opcode = cmd->common.opcode;
 		__entry->flags = cmd->common.flags;
 		__entry->cid = cmd->common.command_id;
@@ -113,9 +115,9 @@ TRACE_EVENT(nvme_setup_cmd,
 		memcpy(__entry->cdw10, cmd->common.cdw10,
 		       sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->cid, __entry->nsid,
-		      __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __entry->qid, __entry->cid,
+		      __entry->nsid, __entry->flags, __entry->metadata,
 		      show_opcode_name(__entry->qid, __entry->opcode),
 		      parse_nvme_cmd(__entry->qid, __entry->opcode, __entry->cdw10))
 );
@@ -124,6 +126,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		__field(int, ctrl_id)
 		__field(int, qid)
 		__field(int, cid)
 		__field(u64, result)
@@ -133,15 +136,17 @@ TRACE_EVENT(nvme_complete_rq,
 	    ),
 	    TP_fast_assign(
 		__assign_nvme_qid(req, __entry->qid);
+		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->cid = req->tag;
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
 		__entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->qid, __entry->cid, __entry->result,
-		      __entry->retries, __entry->flags, __entry->status)
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->ctrl_id,  __entry->qid, __entry->cid,
+		      __entry->result, __entry->retries, __entry->flags,
+		      __entry->status)
 
 );
 
-- 
2.14.3
