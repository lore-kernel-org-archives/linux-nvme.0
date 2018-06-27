From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 17:43:13 -0600
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
Message-ID: <20180627234313.GB10657@localhost.localdomain>

On Wed, Jun 27, 2018@11:06:22AM +0300, Sagi Grimberg wrote:
> 
> > > Not related to your patch, but I did notice that the req->q->id isn't
> > > really useful here since that's not the hardware context identifier.
> > > That's just some ida assigned software identifier. For the admin command
> > > completion trace, it's actually a little confusing to see the qid in the
> > > trace.
> > 
> > It was actually requested by Martin so we can easily see which request
> > got dispatched/completed on which request queue.
> 
> Would be good in the future to display the hwqid, but we'll need to work
> before we can do that.

I'd really like to see nvme qid, and it would allow for nice trace
filters.  We could use a little help from blk-mq to get the hctx's
queue_num from a struct request. I think following should get us that
(haven't tested just yet)

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d515b568..c6478833464d 100644
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
index 46df030b2c3f..6a30c154aa99 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -653,7 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 
 	cmd->common.command_id = req->tag;
 	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+		trace_nvme_setup_nvm_cmd(req, cmd);
 	else
 		trace_nvme_setup_admin_cmd(cmd);
 	return ret;
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0e1671..95ebe803424b 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -79,6 +79,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 	    TP_PROTO(struct nvme_command *cmd),
 	    TP_ARGS(cmd),
 	    TP_STRUCT__entry(
+		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
 		    __field(u16, cid)
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __entry->qid = 0;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -93,16 +95,16 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("qid=%d, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->qid, __entry->cid, __entry->flags, __entry->metadata,
 		      show_admin_opcode_name(__entry->opcode),
 		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd),
+	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
 		    __field(int, qid)
 		    __field(u8, opcode)
@@ -113,7 +115,7 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = qid;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -141,7 +143,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = req->q->id;
+		    __entry->qid = blk_mq_request_hctx_idx(req) + !!req->rq_disk;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		    __entry->retries = nvme_req(req)->retries;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..af91b2d31a04 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -248,6 +248,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 }
 
 
+unsigned int blk_mq_request_hctx_idx(struct request *rq);
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
--
