From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  6 Jun 2019 15:32:29 +0900
Subject: [RFC PATCH V6 3/3] nvmet: introduce target-side trace
In-Reply-To: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
References: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606063229.17258-4-minwoo.im.dev@gmail.com>

This patch introduces target-side request tracing.  As Christoph
suggested, the trace would not be in a core or module to avoid
disadvantages like cache miss:
  http://lists.infradead.org/pipermail/linux-nvme/2019-June/024721.html

The target-side trace code is totally based on the Johannes's trace code
from the host side.  It has lots of codes duplicated, but it would be
better than having advantages mentioned above.

It also traces not only fabrics commands, but also nvme normal commands.
Once the codes to be shared gets bigger, then we can make it common as
suggsted.

This also removed the create_sq and create_cq trace parsing functions
because it will be done by the connect fabrics command.

Example:
  echo 1 > /sys/kernel/debug/tracing/event/nvmet/nvmet_req_init/enable
  echo 1 > /sys/kernel/debug/tracing/event/nvmet/nvmet_req_complete/enable
  cat /sys/kernel/debug/tracing/trace

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/target/Makefile |   3 +
 drivers/nvme/target/core.c   |   8 ++
 drivers/nvme/target/trace.c  | 179 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/trace.h  | 184 +++++++++++++++++++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 drivers/nvme/target/trace.c
 create mode 100644 drivers/nvme/target/trace.h

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 8c3ad0fb6860..2b33836f3d3e 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+ccflags-y				+= -I$(src)
+
 obj-$(CONFIG_NVME_TARGET)		+= nvmet.o
 obj-$(CONFIG_NVME_TARGET_LOOP)		+= nvme-loop.o
 obj-$(CONFIG_NVME_TARGET_RDMA)		+= nvmet-rdma.o
@@ -14,3 +16,4 @@ nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
 nvme-fcloop-y	+= fcloop.o
 nvmet-tcp-y	+= tcp.o
+nvmet-$(CONFIG_TRACING)	+= trace.o
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7734a6acff85..0e7f5849ce38 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -10,6 +10,9 @@
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #include "nvmet.h"
 
 struct workqueue_struct *buffered_io_wq;
@@ -689,6 +692,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 
 	if (unlikely(status))
 		nvmet_set_error(req, status);
+
+	trace_nvmet_req_complete(req);
+
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
 	req->ops->queue_response(req);
@@ -848,6 +854,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 
+	trace_nvmet_req_init(req, req->cmd);
+
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
new file mode 100644
index 000000000000..83cbb3702deb
--- /dev/null
+++ b/drivers/nvme/target/trace.c
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NVM Express target device driver tracepoints
+ * Copyright (c) 2018 Johannes Thumshirn, SUSE Linux GmbH
+ */
+
+#include <asm/unaligned.h>
+#include "trace.h"
+
+static const char *nvme_trace_admin_identify(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 cns = cdw10[0];
+	u16 ctrlid = get_unaligned_le16(cdw10 + 2);
+
+	trace_seq_printf(p, "cns=%u, ctrlid=%u", cns, ctrlid);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_admin_get_features(struct trace_seq *p,
+						 u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 fid = cdw10[0];
+	u8 sel = cdw10[1] & 0x7;
+	u32 cdw11 = get_unaligned_le32(cdw10 + 4);
+
+	trace_seq_printf(p, "fid=0x%x sel=0x%x cdw11=0x%x", fid, sel, cdw11);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u16 length = get_unaligned_le16(cdw10 + 8);
+	u16 control = get_unaligned_le16(cdw10 + 10);
+	u32 dsmgmt = get_unaligned_le32(cdw10 + 12);
+	u32 reftag = get_unaligned_le32(cdw10 +  16);
+
+	trace_seq_printf(p,
+			 "slba=%llu, len=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+			 slba, length, control, dsmgmt, reftag);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "nr=%u, attributes=%u",
+			 get_unaligned_le32(cdw10),
+			 get_unaligned_le32(cdw10 + 4));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_common(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "cdw10=%*ph", 24, cdw10);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
+				       u8 opcode, u8 *cdw10)
+{
+	switch (opcode) {
+	case nvme_admin_identify:
+		return nvme_trace_admin_identify(p, cdw10);
+	case nvme_admin_get_features:
+		return nvme_trace_admin_get_features(p, cdw10);
+	default:
+		return nvme_trace_common(p, cdw10);
+	}
+}
+
+const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
+				     u8 opcode, u8 *cdw10)
+{
+	switch (opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+	case nvme_cmd_write_zeroes:
+		return nvme_trace_read_write(p, cdw10);
+	case nvme_cmd_dsm:
+		return nvme_trace_dsm(p, cdw10);
+	default:
+		return nvme_trace_common(p, cdw10);
+	}
+}
+
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
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (*name)
+		trace_seq_printf(p, "disk=%s, ", name);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
new file mode 100644
index 000000000000..1709737aceb3
--- /dev/null
+++ b/drivers/nvme/target/trace.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NVM Express target device driver tracepoints
+ * Copyright (c) 2018 Johannes Thumshirn, SUSE Linux GmbH
+ *
+ * This is totally based on drivers/nvme/host/trace.h
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nvmet
+
+#if !defined(_TRACE_NVMET_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NVMET_H
+
+#include <linux/nvme.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "nvmet.h"
+
+#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
+#define show_admin_opcode_name(val)					\
+	__print_symbolic(val,						\
+		nvme_admin_opcode_name(nvme_admin_delete_sq),		\
+		nvme_admin_opcode_name(nvme_admin_create_sq),		\
+		nvme_admin_opcode_name(nvme_admin_get_log_page),	\
+		nvme_admin_opcode_name(nvme_admin_delete_cq),		\
+		nvme_admin_opcode_name(nvme_admin_create_cq),		\
+		nvme_admin_opcode_name(nvme_admin_identify),		\
+		nvme_admin_opcode_name(nvme_admin_abort_cmd),		\
+		nvme_admin_opcode_name(nvme_admin_set_features),	\
+		nvme_admin_opcode_name(nvme_admin_get_features),	\
+		nvme_admin_opcode_name(nvme_admin_async_event),		\
+		nvme_admin_opcode_name(nvme_admin_ns_mgmt),		\
+		nvme_admin_opcode_name(nvme_admin_activate_fw),		\
+		nvme_admin_opcode_name(nvme_admin_download_fw),		\
+		nvme_admin_opcode_name(nvme_admin_ns_attach),		\
+		nvme_admin_opcode_name(nvme_admin_keep_alive),		\
+		nvme_admin_opcode_name(nvme_admin_directive_send),	\
+		nvme_admin_opcode_name(nvme_admin_directive_recv),	\
+		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
+		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
+		nvme_admin_opcode_name(nvme_admin_security_send),	\
+		nvme_admin_opcode_name(nvme_admin_security_recv),	\
+		nvme_admin_opcode_name(nvme_admin_sanitize_nvm))
+
+#define nvme_opcode_name(opcode)	{ opcode, #opcode }
+#define show_nvm_opcode_name(val)				\
+	__print_symbolic(val,					\
+		nvme_opcode_name(nvme_cmd_flush),		\
+		nvme_opcode_name(nvme_cmd_write),		\
+		nvme_opcode_name(nvme_cmd_read),		\
+		nvme_opcode_name(nvme_cmd_write_uncor),		\
+		nvme_opcode_name(nvme_cmd_compare),		\
+		nvme_opcode_name(nvme_cmd_write_zeroes),	\
+		nvme_opcode_name(nvme_cmd_dsm),			\
+		nvme_opcode_name(nvme_cmd_resv_register),	\
+		nvme_opcode_name(nvme_cmd_resv_report),		\
+		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_resv_release))
+
+#define nvme_fabrics_type_name(type)	{ type, #type }
+#define show_fabrics_type_name(type)					\
+	__print_symbolic(type,						\
+		nvme_fabrics_type_name(nvme_fabrics_type_property_set),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_connect),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_property_get))
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
+const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
+		u8 *cdw10);
+const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
+		u8 *cdw10);
+const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p, u8 fctype,
+		u8 *spc);
+
+#define parse_nvme_cmd(qid, opcode, fctype, cdw10)			\
+	((opcode != nvme_fabrics_command) ?				\
+		(qid ?							\
+			nvme_trace_parse_nvm_cmd(p, opcode, cdw10) :	\
+			nvme_trace_parse_admin_cmd(p, opcode, cdw10)) :	\
+		nvme_trace_parse_fabrics_cmd(p, fctype, cdw10))
+
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
+#define __print_disk_name(name)				\
+	nvme_trace_disk_name(p, name)
+
+#ifndef TRACE_HEADER_MULTI_READ
+static inline void __assign_disk_name(char *name, struct gendisk *disk)
+{
+	if (disk)
+		memcpy(name, disk->disk_name, DISK_NAME_LEN);
+	else
+		memset(name, 0, DISK_NAME_LEN);
+}
+#endif
+
+TRACE_EVENT(nvmet_req_init,
+	TP_PROTO(struct nvmet_req *req, struct nvme_command *cmd),
+	TP_ARGS(req, cmd),
+	TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
+		__field(int, ctrl_id)
+		__field(int, qid)
+		__field(u8, opcode)
+		__field(u8, flags)
+		__field(u16, cid)
+		__field(u32, nsid)
+		__field(u8, fctype)
+		__field(u64, metadata)
+		__array(u8, cdw10, 24)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvmet_req_to_ctrl(req) ?
+					nvmet_req_to_ctrl(req)->cntlid : 0;
+		__entry->qid = req->sq ? req->sq->qid : 0;
+		__entry->opcode = cmd->common.opcode;
+		__entry->flags = cmd->common.flags;
+		__entry->cid = cmd->common.command_id;
+		__entry->nsid = le32_to_cpu(cmd->common.nsid);
+		__entry->fctype = __entry->nsid & 0xff;
+		__entry->metadata = le64_to_cpu(cmd->common.metadata);
+		__assign_disk_name(__entry->disk, req->ns ?
+					req->ns->bdev->bd_disk : NULL);
+		memcpy(__entry->cdw10, &cmd->common.cdw10,
+					sizeof(__entry->cdw10));
+	),
+	TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, "
+		  "meta=0x%llx, cmd=(%s %s)",
+		__entry->ctrl_id, __print_disk_name(__entry->disk),
+		__entry->qid, __entry->cid, __entry->nsid,
+		__entry->flags, __entry->metadata,
+		show_opcode_name(__entry->qid, __entry->opcode,
+					__entry->fctype),
+		parse_nvme_cmd(__entry->qid, __entry->opcode,
+					__entry->fctype, __entry->cdw10))
+);
+
+TRACE_EVENT(nvmet_req_complete,
+	TP_PROTO(struct nvmet_req *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
+		__field(int, ctrl_id)
+		__field(int, qid)
+		__field(int, cid)
+		__field(u64, result)
+		__field(u16, status)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvmet_req_to_ctrl(req) ?
+					nvmet_req_to_ctrl(req)->cntlid : 0;
+		__entry->qid = req->cq->qid;
+		__entry->cid = req->cqe->command_id;
+		__entry->result = req->cqe->result.u64;
+		__entry->status = le16_to_cpu(req->cqe->status) >> 1;
+		__assign_disk_name(__entry->disk, req->ns ?
+					req->ns->bdev->bd_disk : NULL);
+	),
+	TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%#llx, status=%#x",
+		__entry->ctrl_id, __print_disk_name(__entry->disk),
+		__entry->qid, __entry->cid, __entry->result,
+		__entry->status)
+
+);
+
+#endif /* _TRACE_NVMET_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.21.0
