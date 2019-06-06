From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri,  7 Jun 2019 04:45:12 +0900
Subject: [RFC PATCH V7 7/7] nvmet: introduce target-side trace
In-Reply-To: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606194512.11020-8-minwoo.im.dev@gmail.com>

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
 drivers/nvme/target/trace.c  | 222 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/trace.h  | 140 ++++++++++++++++++++++
 4 files changed, 373 insertions(+)
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
index 0587707b1a25..dad0243c7c96 100644
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
@@ -691,6 +694,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 
 	if (unlikely(status))
 		nvmet_set_error(req, status);
+
+	trace_nvmet_req_complete(req);
+
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
 	req->ops->queue_response(req);
@@ -850,6 +856,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 
+	trace_nvmet_req_init(req, req->cmd);
+
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
new file mode 100644
index 000000000000..60108fcdf7d5
--- /dev/null
+++ b/drivers/nvme/target/trace.c
@@ -0,0 +1,222 @@
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
+
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
+const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	/*
+	 * XXX: We don't know the controller instance before executing the
+	 * connect command itself because the connect command for the admin
+	 * queue will not provide the cntlid which will be allocated in this
+	 * command.  In case of io queues, the controller instance will be
+	 * mapped by the extra data of the connect command.
+	 * If we can know the extra data of the connect command in this stage,
+	 * we can update this print statement later.
+	 */
+	if (ctrl)
+		trace_seq_printf(p, "%d", ctrl->cntlid);
+	else
+		trace_seq_printf(p, "_");
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
new file mode 100644
index 000000000000..94d5b42d8ff8
--- /dev/null
+++ b/drivers/nvme/target/trace.h
@@ -0,0 +1,140 @@
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
+const char *nvme_trace_parse_common(struct trace_seq *p,
+		struct nvme_command *req);
+
+#define parse_nvme_common(cmd)					\
+	nvme_trace_parse_common(p, cmd)
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
+const char *nvmet_trace_ctrl_name(struct trace_seq *p, struct nvmet_ctrl *ctrl);
+#define __print_ctrl_name(ctrl)				\
+	nvmet_trace_ctrl_name(p, ctrl)
+
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
+#define __print_disk_name(name)				\
+	nvme_trace_disk_name(p, name)
+
+#ifndef TRACE_HEADER_MULTI_READ
+static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
+{
+	return req->sq->ctrl;
+}
+
+static inline void __assign_disk_name(char *name, struct nvmet_req *req,
+		bool init)
+{
+	struct nvmet_ctrl *ctrl = nvmet_req_to_ctrl(req);
+	struct nvmet_ns *ns;
+
+	if ((init && req->sq->qid) || (!init && req->cq->qid)) {
+		ns = nvmet_find_namespace(ctrl, req->cmd->rw.nsid);
+		strncpy(name, ns->device_path, DISK_NAME_LEN);
+		return;
+	}
+
+	memset(name, 0, DISK_NAME_LEN);
+}
+#endif
+
+TRACE_EVENT(nvmet_req_init,
+	TP_PROTO(struct nvmet_req *req, struct nvme_command *cmd),
+	TP_ARGS(req, cmd),
+	TP_STRUCT__entry(
+		__field(struct nvme_command *, cmd)
+		__field(struct nvmet_ctrl *, ctrl)
+		__array(char, disk, DISK_NAME_LEN)
+		__field(int, qid)
+		__field(u16, cid)
+		__field(u8, opcode)
+		__field(u8, fctype)
+		__array(u8, cdw10, 24)
+	),
+	TP_fast_assign(
+		__entry->cmd = cmd;
+		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__assign_disk_name(__entry->disk, req, true);
+		__entry->qid = req->sq->qid;
+		__entry->cid = le16_to_cpu(cmd->common.command_id);
+		__entry->opcode = cmd->common.opcode;
+		__entry->fctype = cmd->fabrics.fctype;
+		memcpy(__entry->cdw10, &cmd->common.cdw10,
+			sizeof(__entry->cdw10));
+	),
+	TP_printk("nvmet%s: %sqid=%d, cmdid=%u%s cmd=(%s, %s)",
+		__print_ctrl_name(__entry->ctrl),
+		__print_disk_name(__entry->disk),
+		__entry->qid, __entry->cid,
+		parse_nvme_common(__entry->cmd),
+		show_opcode_name(__entry->qid, __entry->opcode,
+				__entry->fctype),
+		parse_nvme_cmd(__entry->qid, __entry->opcode,
+				__entry->fctype, __entry->cdw10))
+);
+
+TRACE_EVENT(nvmet_req_complete,
+	TP_PROTO(struct nvmet_req *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(
+		__field(struct nvmet_ctrl *, ctrl)
+		__array(char, disk, DISK_NAME_LEN)
+		__field(int, qid)
+		__field(int, cid)
+		__field(u64, result)
+		__field(u16, status)
+	),
+	TP_fast_assign(
+		__entry->ctrl = nvmet_req_to_ctrl(req);
+		__entry->qid = req->cq->qid;
+		__entry->cid = req->cqe->command_id;
+		__entry->result = le64_to_cpu(req->cqe->result.u64);
+		__entry->status = le16_to_cpu(req->cqe->status) >> 1;
+		__assign_disk_name(__entry->disk, req, false);
+	),
+	TP_printk("nvmet%s: %sqid=%d, cmdid=%u, res=%#llx, status=%#x",
+		__print_ctrl_name(__entry->ctrl),
+		__print_disk_name(__entry->disk),
+		__entry->qid, __entry->cid, __entry->result, __entry->status)
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
