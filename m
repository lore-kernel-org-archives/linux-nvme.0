From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 15:49:55 -0600
Subject: [PATCHv2 3/4] nvme: trace controller name
In-Reply-To: <20180628214956.13877-1-keith.busch@intel.com>
References: <20180628214956.13877-1-keith.busch@intel.com>
Message-ID: <20180628214956.13877-4-keith.busch@intel.com>

This appends the controller instance to the trace buffer for nvme commands
to distinguish what controller is dispatching and completing a command.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/trace.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 42c99445dd96..a99b2929794a 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -79,6 +79,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
@@ -88,6 +89,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		    __entry->qid = blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + !!req->rq_disk;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
@@ -97,9 +99,9 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid,
-		      __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __entry->qid, __entry->nsid,
+		      __entry->cid, __entry->flags, __entry->metadata,
 		      __entry->qid ?
 				show_opcode_name(__entry->opcode) :
 				show_admin_opcode_name(__entry->opcode),
@@ -112,6 +114,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(int, cid)
 		    __field(u64, result)
@@ -120,6 +123,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		    __entry->qid = blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + !!req->rq_disk;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -127,9 +131,10 @@ TRACE_EVENT(nvme_complete_rq,
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
