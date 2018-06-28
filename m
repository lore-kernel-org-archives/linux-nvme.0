From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 18:59:43 -0600
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180627234313.GB10657@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
Message-ID: <20180628005943.GC10657@localhost.localdomain>

Thinking more on this, not using the hw qid really limits the utility
out of using these trace events: We may not be able to match a completion
to the submission without it since cmdid alone isn't enough to match up
the two events.

Here's an updated proposal and actually tested. I was also able to
combine admin and io submissions.

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d51..c647883 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -466,6 +466,12 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq)
+{
+	return blk_mq_map_queue(rq->q, rq->mq_ctx->cpu)->queue_num;
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_hctx_idx);
+
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030..f46bde2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -652,10 +654,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
-	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
-	else
-		trace_nvme_setup_admin_cmd(cmd);
+	trace_nvme_setup_nvm_cmd(req, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0..bca3451 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -75,34 +75,9 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 #define __parse_nvme_cmd(opcode, cdw10) \
 	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
 
-TRACE_EVENT(nvme_setup_admin_cmd,
-	    TP_PROTO(struct nvme_command *cmd),
-	    TP_ARGS(cmd),
-	    TP_STRUCT__entry(
-		    __field(u8, opcode)
-		    __field(u8, flags)
-		    __field(u16, cid)
-		    __field(u64, metadata)
-		    __array(u8, cdw10, 24)
-	    ),
-	    TP_fast_assign(
-		    __entry->opcode = cmd->common.opcode;
-		    __entry->flags = cmd->common.flags;
-		    __entry->cid = cmd->common.command_id;
-		    __entry->metadata = le64_to_cpu(cmd->common.metadata);
-		    memcpy(__entry->cdw10, cmd->common.cdw10,
-			   sizeof(__entry->cdw10));
-	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
-		      show_admin_opcode_name(__entry->opcode),
-		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
-);
-
-
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd),
+	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
 		    __field(int, qid)
 		    __field(u8, opcode)
@@ -113,7 +88,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = qid;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -125,8 +100,12 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
 		      __entry->qid, __entry->nsid, __entry->cid,
 		      __entry->flags, __entry->metadata,
-		      show_opcode_name(__entry->opcode),
-		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
+		      __entry->qid ?
+				show_opcode_name(__entry->opcode) :
+				show_admin_opcode_name(__entry->opcode),
+		      __entry->qid ?
+				__parse_nvme_cmd(__entry->opcode, __entry->cdw10) :
+				__parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 TRACE_EVENT(nvme_complete_rq,
@@ -141,7 +120,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = req->q->id;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		    __entry->retries = nvme_req(req)->retries;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb..af91b2d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq);
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
--
