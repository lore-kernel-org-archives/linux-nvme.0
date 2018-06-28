From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 14:56:01 -0600
Subject: [PATCH 5/5] nvme/trace: add disk name to tracepoints
In-Reply-To: <20180628205601.13742-1-keith.busch@intel.com>
References: <20180628205601.13742-1-keith.busch@intel.com>
Message-ID: <20180628205601.13742-5-keith.busch@intel.com>

This will print the disk name if the disk name for disk based requests
so a user can better distinguish traffic to different disks. This allows
disk based filters. For example, to see only nvme0n2 traffic:

  echo "disk_name == nvme0n2" > /sys/kernel/debug/tracing/events/nvme/filter

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/trace.c | 11 +++++++++++
 drivers/nvme/host/trace.h | 27 ++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 41944bbef835..796a5bcf67b8 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -128,3 +128,14 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_common(p, cdw10);
 	}
 }
+
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (name[0] != 0)
+		trace_seq_printf(p, "disk=%-.*s, ", DISK_NAME_LEN, name);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 57344980af16..e9c886f4e6d9 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -75,10 +75,15 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 #define __parse_nvme_cmd(opcode, cdw10) \
 	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
 
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
+#define __print_nvme_disk_name(name) \
+	nvme_trace_disk_name(p, name)
+
 TRACE_EVENT(nvme_setup_nvm_cmd,
 	    TP_PROTO(struct request *req, struct nvme_command *cmd),
 	    TP_ARGS(req, cmd),
 	    TP_STRUCT__entry(
+		    __array(char, disk_name, DISK_NAME_LEN)
 		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(u8, opcode)
@@ -98,10 +103,14 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
 		    __entry->metadata = le64_to_cpu(cmd->common.metadata);
 		    memcpy(__entry->cdw10, cmd->common.cdw10,
 			   sizeof(__entry->cdw10));
+		    req->rq_disk ?
+			memcpy(__entry->disk_name, req->rq_disk->disk_name, DISK_NAME_LEN) :
+			memset(__entry->disk_name, 0, DISK_NAME_LEN);
 	    ),
-	    TP_printk("nvme%d: qid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
-		      __entry->ctrl_id, __entry->qid, __entry->nsid,
-		      __entry->cid, __entry->flags, __entry->metadata,
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->ctrl_id, __print_nvme_disk_name(__entry->disk_name),
+		      __entry->qid, __entry->nsid, __entry->cid,
+		      __entry->flags, __entry->metadata,
 		      __entry->qid ?
 				show_opcode_name(__entry->opcode) :
 				show_admin_opcode_name(__entry->opcode),
@@ -114,6 +123,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		    __array(char, disk_name, DISK_NAME_LEN)
 		    __field(int, ctrl_id)
 		    __field(int, qid)
 		    __field(int, cid)
@@ -130,11 +140,14 @@ TRACE_EVENT(nvme_complete_rq,
 		    __entry->retries = nvme_req(req)->retries;
 		    __entry->flags = nvme_req(req)->flags;
 		    __entry->status = nvme_req(req)->status;
+		    req->rq_disk ?
+			memcpy(__entry->disk_name, req->rq_disk->disk_name, DISK_NAME_LEN) :
+			memset(__entry->disk_name, 0, DISK_NAME_LEN);
 	    ),
-	    TP_printk("nvme%d: qid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
-		      __entry->ctrl_id,  __entry->qid, __entry->cid,
-		      __entry->result, __entry->retries, __entry->flags,
-		      __entry->status)
+	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
+		      __entry->ctrl_id,  __print_nvme_disk_name(__entry->disk_name),
+		      __entry->qid, __entry->cid, __entry->result,
+		      __entry->retries, __entry->flags, __entry->status)
 
 );
 
-- 
2.14.3
