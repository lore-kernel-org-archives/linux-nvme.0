From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 27 Jun 2018 14:53:24 +0200
Subject: [PATCH v5 2/2] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180627125324.22064-1-jthumshirn@suse.de>
References: <20180627125324.22064-1-jthumshirn@suse.de>
Message-ID: <20180627125324.22064-3-jthumshirn@suse.de>

Add disk name to tracepoints so we can better distinguish between
individual disks in the trace output and admin commands which
are represented without a disk name.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c  |  4 ++--
 drivers/nvme/host/trace.h | 39 +++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99dd62c1076c..ada04870e613 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -654,9 +654,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	cmd->common.command_id = req->tag;
 
 	if (ns)
-		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+		trace_nvme_setup_nvm_cmd(req, cmd, ns->disk->disk_name);
 	else
-		trace_nvme_setup_admin_cmd(cmd);
+		trace_nvme_setup_admin_cmd(req, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 01390f0e1671..371a816cd225 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -76,9 +76,10 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
 
 TRACE_EVENT(nvme_setup_admin_cmd,
-	    TP_PROTO(struct nvme_command *cmd),
-	    TP_ARGS(cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd),
+	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(u8, opcode)
 		    __field(u8, flags)
 		    __field(u16, cid)
@@ -86,6 +87,7 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -93,17 +95,21 @@ TRACE_EVENT(nvme_setup_admin_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __entry->cid, __entry->flags,
+		      __entry->metadata,
 		      show_admin_opcode_name(__entry->opcode),
 		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
 );
 
 
 TRACE_EVENT(nvme_setup_nvm_cmd,
-	    TP_PROTO(int qid, struct nvme_command *cmd),
-	    TP_ARGS(qid, cmd),
+	    TP_PROTO(struct request *req, struct nvme_command *cmd,
+		     char *disk_name),
+	    TP_ARGS(req, cmd, disk_name),
 	    TP_STRUCT__entry(
+		    __string(name, disk_name)
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(u8, opcode)
 		    __field(u8, flags)
@@ -113,7 +119,9 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		    __entry->qid = qid;
+		    __assign_str(name, disk_name);
+		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
+		    __entry->qid = req->q->id;
 		    __entry->opcode = cmd->common.opcode;
 		    __entry->flags = cmd->common.flags;
 		    __entry->cid = cmd->common.command_id;
@@ -122,10 +130,10 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->qid, __entry->nsid, __entry->cid,
-		      __entry->flags, __entry->metadata,
-		      show_opcode_name(__entry->opcode),
+	    TP_printk("nvme%d: disk=%s, qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __get_str(name), __entry->qid,
+		      __entry->nsid, __entry->cid, __entry->flags,
+		      __entry->metadata, show_opcode_name(__entry->opcode),
 		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
 );
 
@@ -133,6 +141,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(int, cid)
 		    __field(u64, result)
@@ -141,6 +150,7 @@ TRACE_EVENT(nvme_complete_rq,
 		    __field(u16, status)
 	    ),
 	    TP_fast_assign(
+		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
 		    __entry->qid = req->q->id;
 		    __entry->cid = req->tag;
 		    __entry->result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -148,9 +158,10 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
 	    ),
-	    TP_printk("qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->qid, __entry->cid, __entry->result,
-		      __entry->retries, __entry->flags, __entry->status)
+	    TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->ctrl_id, __entry->qid, __entry->cid,
+		      __entry->result,  __entry->retries, __entry->flags,
+		      __entry->status)
 
 );
 
-- 
2.16.4
