From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri,  7 Jun 2019 04:45:09 +0900
Subject: [RFC PATCH V7 4/7] nvme: trace: support for fabrics commands in
 host-side
In-Reply-To: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606194512.11020-5-minwoo.im.dev@gmail.com>

This patch introduces fabrics commands tracing feature from host-side.
This patch does not include any changes for the previous host-side
tracing, but just add fabrics commands parsing in cmd=() format.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/trace.c | 67 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h | 20 ++++++++----
 include/linux/nvme.h      | 20 ++++++++++--
 3 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 14b0d2993cbe..02c09774ad91 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -135,6 +135,73 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 	}
 }
 
+static const char *nvme_trace_fabrics_property_set(struct trace_seq *p, u8 *spc)
+{
+       const char *ret = trace_seq_buffer_ptr(p);
+       u8 attrib = spc[0];
+       u32 ofst = get_unaligned_le32(spc + 4);
+       u64 value = get_unaligned_le64(spc + 8);
+
+       trace_seq_printf(p, "attrib=%u, ofst=0x%x, value=0x%llx",
+                               attrib, ofst, value);
+       trace_seq_putc(p, 0);
+
+       return ret;
+}
+
+static const char *nvme_trace_fabrics_connect(struct trace_seq *p, u8 *spc)
+{
+       const char *ret = trace_seq_buffer_ptr(p);
+       u16 recfmt = get_unaligned_le16(spc);
+       u16 qid = get_unaligned_le16(spc + 2);
+       u16 sqsize = get_unaligned_le16(spc + 4);
+       u8 cattr = spc[6];
+       u32 kato = get_unaligned_le32(spc + 8);
+
+       trace_seq_printf(p, "recfmt=%u, qid=%u, sqsize=%u, cattr=%u, kato=%u",
+                               recfmt, qid, sqsize, cattr, kato);
+       trace_seq_putc(p, 0);
+
+       return ret;
+}
+
+static const char *nvme_trace_fabrics_property_get(struct trace_seq *p, u8 *spc)
+{
+       const char *ret = trace_seq_buffer_ptr(p);
+       u8 attrib = spc[0];
+       u32 ofst = get_unaligned_le32(spc + 4);
+
+       trace_seq_printf(p, "attrib=%u, ofst=0x%x", attrib, ofst);
+       trace_seq_putc(p, 0);
+
+       return ret;
+}
+
+static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc)
+{
+       const char *ret = trace_seq_buffer_ptr(p);
+
+       trace_seq_printf(p, "spcecific=%*ph", 24, spc);
+       trace_seq_putc(p, 0);
+
+       return ret;
+}
+
+const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p,
+                                        u8 fctype, u8 *spc)
+{
+       switch (fctype) {
+       case nvme_fabrics_type_property_set:
+               return nvme_trace_fabrics_property_set(p, spc);
+       case nvme_fabrics_type_connect:
+               return nvme_trace_fabrics_connect(p, spc);
+       case nvme_fabrics_type_property_get:
+               return nvme_trace_fabrics_property_get(p, spc);
+       default:
+               return nvme_trace_fabrics_common(p, spc);
+       }
+}
+
 const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 59323e68c393..da45cef2c31c 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -20,11 +20,15 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
 		u8 *cdw10);
 const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 		u8 *cdw10);
+const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p, u8 fctype,
+		u8 *spc);
 
-#define parse_nvme_cmd(qid, opcode, cdw10) 			\
-	(qid ?							\
-	 nvme_trace_parse_nvm_cmd(p, opcode, cdw10) : 		\
-	 nvme_trace_parse_admin_cmd(p, opcode, cdw10))
+#define parse_nvme_cmd(qid, opcode, fctype, cdw10)			\
+	((opcode != nvme_fabrics_command) ?				\
+		(qid ?							\
+			nvme_trace_parse_nvm_cmd(p, opcode, cdw10) :	\
+			nvme_trace_parse_admin_cmd(p, opcode, cdw10)) :	\
+		nvme_trace_parse_fabrics_cmd(p, fctype, cdw10))
 
 const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
 #define __print_disk_name(name)				\
@@ -49,6 +53,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__field(int, qid)
 		__field(u8, opcode)
 		__field(u8, flags)
+		__field(u8, fctype)
 		__field(u16, cid)
 		__field(u32, nsid)
 		__field(u64, metadata)
@@ -62,6 +67,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->cid = le16_to_cpu(cmd->common.command_id);
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
+		__entry->fctype = cmd->fabrics.fctype;
 		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
 			sizeof(__entry->cdw10));
@@ -70,8 +76,10 @@ TRACE_EVENT(nvme_setup_cmd,
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
 		      __entry->qid, __entry->cid, __entry->nsid,
 		      __entry->flags, __entry->metadata,
-		      show_opcode_name(__entry->qid, __entry->opcode),
-		      parse_nvme_cmd(__entry->qid, __entry->opcode, __entry->cdw10))
+		      show_opcode_name(__entry->qid, __entry->opcode,
+				__entry->fctype),
+		      parse_nvme_cmd(__entry->qid, __entry->opcode,
+				__entry->fctype, __entry->cdw10))
 );
 
 TRACE_EVENT(nvme_complete_rq,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 86b3d04baf20..6badb45b2889 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -836,9 +836,6 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_security_recv),	\
 		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
 
-#define show_opcode_name(qid, opcode)					\
-	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
-
 enum {
 	NVME_QUEUE_PHYS_CONTIG	= (1 << 0),
 	NVME_CQ_IRQ_ENABLED	= (1 << 1),
@@ -1053,6 +1050,23 @@ enum nvmf_capsule_command {
 	nvme_fabrics_type_property_get	= 0x04,
 };
 
+#define nvme_fabrics_type_name(type)   { type, #type }
+#define show_fabrics_type_name(type)                                   \
+       __print_symbolic(type,                                          \
+               nvme_fabrics_type_name(nvme_fabrics_type_property_set), \
+               nvme_fabrics_type_name(nvme_fabrics_type_connect),      \
+               nvme_fabrics_type_name(nvme_fabrics_type_property_get))
+
+/*
+ * If not fabrics command, fctype will be ignored.
+ */
+#define show_opcode_name(qid, opcode, fctype)			\
+	((opcode != nvme_fabrics_command) ?			\
+		(qid ?						\
+			show_nvm_opcode_name(opcode) :		\
+			show_admin_opcode_name(opcode)) :	\
+		show_fabrics_type_name(fctype))
+
 struct nvmf_common_command {
 	__u8	opcode;
 	__u8	resv1;
-- 
2.21.0
