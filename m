From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 14:55:58 -0600
Subject: [PATCH 2/5] nvme: trace nvme queue identifiers
In-Reply-To: <20180628205601.13742-1-keith.busch@intel.com>
References: <20180628205601.13742-1-keith.busch@intel.com>
Message-ID: <20180628205601.13742-2-keith.busch@intel.com>

We can not match up a command to its completion based on the command
id alone. We need to pair this up with the submitting queue identifier,
so this patch adds that to the trace buffer.

This patch is also collapsing the admin and io submission traces into
a single one since we don't need to duplicate this and creating
unnecessary code branches.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c  |  7 +++----
 drivers/nvme/host/trace.h | 41 ++++++++++-------------------------------
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..398a5fb26603 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -97,6 +97,8 @@ static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
+static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
+					   unsigned nsid);
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
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
index 01390f0e1671..bca3451caa37 100644
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
-- 
2.14.3
