From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 24 Jan 2018 09:28:27 +0100
Subject: [PATCH v7 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180124082828.364-1-jthumshirn@suse.de>
References: <20180124082828.364-1-jthumshirn@suse.de>
Message-ID: <20180124082828.364-2-jthumshirn@suse.de>

Add tracepoints for nvme_setup_cmd() for tracing admin and/or nvm commands.

Examples of the two tracepoints are as follows for trace_nvme_setup_admin_cmd():
kworker/u8:0-5     [003] ....     2.998792: nvme_setup_admin_cmd: cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=1, qsize=1023, cq_flags=0x3, irq_vector=0)

and trace_nvme_setup_nvm_cmd():
dd-205   [001] ....     3.503929: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=989, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=4096, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Hannes Reinecke <hare at suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/Makefile |   4 ++
 drivers/nvme/host/core.c   |   7 +++
 drivers/nvme/host/trace.c  | 131 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h  | 141 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 283 insertions(+)
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index a25fd43650ad..441e67e3a9d7 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+ccflags-y				+= -I$(src)
+
 obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
 obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
 obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
@@ -6,6 +9,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 
 nvme-core-y				:= core.o
+nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fde6fd2e7eef..358dfdc1f6da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -29,6 +29,9 @@
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -628,6 +631,10 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
+	if (ns)
+		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
+	else
+		trace_nvme_setup_admin_cmd(cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
new file mode 100644
index 000000000000..87beb77dcc6c
--- /dev/null
+++ b/drivers/nvme/host/trace.c
@@ -0,0 +1,131 @@
+/*
+ * NVM Express device driver tracepoints
+ * Copyright (c) 2018 Johannes Thumshirn, SUSE Linux GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include "trace.h"
+
+static const char *nvme_trace_create_sq(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	__le16 qsize = cdw10[0] >> 16;
+	__le16 sqid = cdw10[0] & 0xffff;
+	__le16 cqid = cdw10[1] >> 16;
+	__le16 sq_flags = cdw10[1] & 0xffff;
+
+	trace_seq_printf(p, "sqid=%u, qsize=%u, sq_flags=0x%x, cqid=%u",
+			 le16_to_cpu(sqid), le16_to_cpu(qsize),
+			 le16_to_cpu(sq_flags), le16_to_cpu(cqid));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_create_cq(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	__le16 qsize = cdw10[0] >> 16;
+	__le16 cqid = cdw10[0] & 0xffff;
+	__le16 irq_vector = cdw10[1] >> 16;
+	__le16 cq_flags = cdw10[1] & 0xffff;
+
+	trace_seq_printf(p, "cqid=%u, qsize=%u, cq_flags=0x%x, irq_vector=%u",
+			 le16_to_cpu(cqid), le16_to_cpu(qsize),
+			 le16_to_cpu(cq_flags), le16_to_cpu(irq_vector));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_admin_identify(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	__u8 cns = (cdw10[0] >> 24) & 0xff;
+	__le16 ctrlid = cdw10[0] & 0xffff;
+
+	trace_seq_printf(p, "cns=%u, ctrlid=%u", cns, le16_to_cpu(ctrlid));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+
+
+static const char *nvme_trace_read_write(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	__le64 slba = ((u64)cdw10[1] << 32) | cdw10[0];
+	__le16 control = cdw10[2] >> 16;
+	__le16 length = cdw10[2] & 0xffff;
+	__le32 dsmgmt = cdw10[3];
+	__le32 reftag = cdw10[4];
+
+	trace_seq_printf(p,
+			 "slba=%llu, len=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+			 le64_to_cpu(slba), le16_to_cpu(length),
+			 le16_to_cpu(control), le32_to_cpu(dsmgmt),
+			 le32_to_cpu(reftag));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_dsm(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "nr=%u, attributes=%u",
+			 le32_to_cpu(cdw10[0]), le32_to_cpu(cdw10[1]));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_common(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "cdw10=%*ph", 6, cdw10);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
+				       u8 opcode, __le32 *cdw10)
+{
+	switch (opcode) {
+	case nvme_admin_create_sq:
+		return nvme_trace_create_sq(p, cdw10);
+	case nvme_admin_create_cq:
+		return nvme_trace_create_cq(p, cdw10);
+	case nvme_admin_identify:
+		return nvme_trace_admin_identify(p, cdw10);
+	default:
+		return nvme_trace_common(p, cdw10);
+	}
+}
+
+const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
+				     u8 opcode, __le32 *cdw10)
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
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
new file mode 100644
index 000000000000..f17dbfbead5a
--- /dev/null
+++ b/drivers/nvme/host/trace.h
@@ -0,0 +1,141 @@
+/*
+ * NVM Express device driver tracepoints
+ * Copyright (c) 2018 Johannes Thumshirn, SUSE Linux GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nvme
+
+#if !defined(_TRACE_NVME_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NVME_H
+
+#include <linux/nvme.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "nvme.h"
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
+const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
+				       __le32 *cdw10);
+#define __parse_nvme_admin_cmd(opcode, cdw10) \
+	nvme_trace_parse_admin_cmd(p, opcode, cdw10)
+
+#define nvme_opcode_name(opcode)	{ opcode, #opcode }
+#define show_opcode_name(val)					\
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
+const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
+				     __le32 *cdw10);
+#define __parse_nvme_cmd(opcode, cdw10) \
+	nvme_trace_parse_nvm_cmd(p, opcode, cdw10)
+
+TRACE_EVENT(nvme_setup_admin_cmd,
+	    TP_PROTO(struct nvme_command *cmd),
+	    TP_ARGS(cmd),
+	    TP_STRUCT__entry(
+		    __field(__u8, opcode)
+		    __field(__u8, flags)
+		    __field(__u16, cid)
+		    __field(__le64, metadata)
+		    __array(__le32, cdw10, 6)
+	    ),
+	    TP_fast_assign(
+		    __entry->opcode = cmd->common.opcode;
+		    __entry->flags = cmd->common.flags;
+		    __entry->cid = cmd->common.command_id;
+		    __entry->metadata = cmd->common.metadata;
+		    memcpy(__entry->cdw10, cmd->common.cdw10,
+			   sizeof(__entry->cdw10));
+	    ),
+	    TP_printk(" cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->cid, __entry->flags,
+		      le64_to_cpu(__entry->metadata),
+		      show_admin_opcode_name(__entry->opcode),
+		      __parse_nvme_admin_cmd(__entry->opcode, __entry->cdw10))
+);
+
+
+TRACE_EVENT(nvme_setup_nvm_cmd,
+	    TP_PROTO(int qid, struct nvme_command *cmd),
+	    TP_ARGS(qid, cmd),
+	    TP_STRUCT__entry(
+		    __field(int, qid)
+		    __field(__u8, opcode)
+		    __field(__u8, flags)
+		    __field(__u16, cid)
+		    __field(__le32, nsid)
+		    __field(__le64, metadata)
+		    __array(__le32, cdw10, 6)
+	    ),
+	    TP_fast_assign(
+		    __entry->qid = qid;
+		    __entry->opcode = cmd->common.opcode;
+		    __entry->flags = cmd->common.flags;
+		    __entry->cid = cmd->common.command_id;
+		    __entry->nsid = cmd->common.nsid;
+		    __entry->metadata = cmd->common.metadata;
+		    memcpy(__entry->cdw10, cmd->common.cdw10,
+			   sizeof(__entry->cdw10));
+	    ),
+	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      __entry->qid, le32_to_cpu(__entry->nsid), __entry->cid,
+		      __entry->flags, le64_to_cpu(__entry->metadata),
+		      show_opcode_name(__entry->opcode),
+		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
+);
+
+#endif /* _TRACE_NVME_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.13.6
