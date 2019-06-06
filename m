From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri,  7 Jun 2019 04:45:10 +0900
Subject: [RFC PATCH V7 5/7] nvme: trace: filter out unnecessary fields for
 fabrics
In-Reply-To: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606194512.11020-6-minwoo.im.dev@gmail.com>

If the given command is for fabrics command, then it should not print
out the following fields which are for the !fabrics commands:
  1) "flags" (FUSE, PSDT).
  2) "nsid" which is reserved in fabrics command.
  3) "metadata" which is also reserved in fabrics.

To make !fabrics commands clear, don't print them out in case of fabrics
commands.

Examples:
  1) !fabrics commands (e.g. read):
    nvme_setup_cmd: nvme1: disk=nvme1c1n1, qid=5, cmdid=65, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read slba=0, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
  2) fabrics commands (e.g. connect):
    nvme_setup_cmd: nvme1: qid=0, cmdid=0 cmd=(nvme_fabrics_type_connect recfmt=0, qid=0, sqsize=31, cattr=0, kato=15000)

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/trace.c | 20 ++++++++++++++++++++
 drivers/nvme/host/trace.h | 20 +++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 02c09774ad91..e5e695b0db80 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -213,4 +213,24 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 	return ret;
 }
 
+const char *nvme_trace_parse_common(struct trace_seq *p,
+				    struct nvme_command *cmd)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	/*
+	 * Fabrics command capsule does not have the following fields which
+	 * is for !fabrics commands.
+	 */
+	if (!nvme_is_fabrics(cmd)) {
+		trace_seq_printf(p, ", nsid=%#x, flags=%#x, meta=%#llx",
+				le32_to_cpu(cmd->common.nsid),
+				cmd->common.flags,
+				le64_to_cpu(cmd->common.metadata));
+	}
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index da45cef2c31c..fd90fc8fd3f7 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -16,6 +16,12 @@
 
 #include "nvme.h"
 
+const char *nvme_trace_parse_common(struct trace_seq *p,
+		struct nvme_command *cmd);
+
+#define parse_nvme_common(cmd)					\
+	nvme_trace_parse_common(p, cmd)
+
 const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
 		u8 *cdw10);
 const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
@@ -48,34 +54,30 @@ TRACE_EVENT(nvme_setup_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		__field(struct nvme_command *, cmd)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, ctrl_id)
 		__field(int, qid)
 		__field(u8, opcode)
-		__field(u8, flags)
 		__field(u8, fctype)
 		__field(u16, cid)
-		__field(u32, nsid)
-		__field(u64, metadata)
 		__array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
+		__entry->cmd = cmd;
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->qid = nvme_req_qid(req);
 		__entry->opcode = cmd->common.opcode;
-		__entry->flags = cmd->common.flags;
 		__entry->cid = le16_to_cpu(cmd->common.command_id);
-		__entry->nsid = le32_to_cpu(cmd->common.nsid);
-		__entry->metadata = le64_to_cpu(cmd->common.metadata);
 		__entry->fctype = cmd->fabrics.fctype;
 		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
 			sizeof(__entry->cdw10));
 	    ),
-	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u%s cmd=(%s %s)",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
-		      __entry->qid, __entry->cid, __entry->nsid,
-		      __entry->flags, __entry->metadata,
+		      __entry->qid, __entry->cid,
+		      parse_nvme_common(__entry->cmd),
 		      show_opcode_name(__entry->qid, __entry->opcode,
 				__entry->fctype),
 		      parse_nvme_cmd(__entry->qid, __entry->opcode,
-- 
2.21.0
