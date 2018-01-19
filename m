From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 19 Jan 2018 15:18:18 +0100
Subject: [PATCH v4 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180119141819.11938-1-jthumshirn@suse.de>
References: <20180119141819.11938-1-jthumshirn@suse.de>
Message-ID: <20180119141819.11938-2-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Hannes Reinecke <hare at suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>

---
Changes to v2:
* Don't cast le64_to_cpu() conversions to unsigned long long (Christoph)
* Add proper copyright header (Christoph)
* Move trace decoding into own file (Christoph)
* Include the src directory in the Makefile for trace (Christoph)
* Removed spaces before and after parenthesis (Christoph)
* Reduced print lines to fit the 80 char limit (Christoph)
* Only build trace.o when CONFIG_TRACE=y (Christoph)
* Only copy non-common command fields to trace decoder (Christoph)
* Merge write_zeros decoder into rw decoder
* Don't decode admin commands as I/O commands

Changes to v1:
* Fix typo (Hannes)
* move include/trace/events/nvme.h -> drivers/nvme/host/trace.h (Christoph)
---
 drivers/nvme/host/Makefile |   4 ++
 drivers/nvme/host/core.c   |   4 ++
 drivers/nvme/host/trace.c  | 161 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h  | 112 +++++++++++++++++++++++++++++++
 4 files changed, 281 insertions(+)
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
index 839650e0926a..1ca515720216 100644
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
 
@@ -591,6 +594,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
+	trace_nvme_setup_cmd(cmd, ns ? 0 : 1);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
new file mode 100644
index 000000000000..1cdc2edee81e
--- /dev/null
+++ b/drivers/nvme/host/trace.c
@@ -0,0 +1,161 @@
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
+struct rw_cmd {
+	__le64 slba;
+	__le16 length;
+	__le16 control;
+	__le32 dsmgmt;
+	__le32 reftag;
+	__le16 apptag;
+	__le16 appmask;
+};
+
+struct dsm_cmd {
+	__le32 nr;
+	__le32 attributes;
+	__u32 rsvd12[4];
+};
+
+struct create_sq {
+	__le16 sqid;
+	__le16 qsize;
+	__le16 sq_flags;
+	__le16 cqid;
+	__u32 rsvd12[4];
+};
+
+struct create_cq {
+	__le16 cqid;
+	__le16 qsize;
+	__le16 cq_flags;
+	__le16 irq_vector;
+	__u32 rsvd12[4];
+};
+
+struct identify {
+	__u8 cns;
+	__u8 rsvd;
+	__le16 ctrlid;
+	u32 rsvd2[5];
+};
+
+static const char *nvme_trace_create_sq(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	struct create_sq *csq = (struct create_sq *) cdw10;
+
+	trace_seq_printf(p, "sqid=%u, qsize=%u, sq_flags=0x%x, cqid=%u",
+			 le16_to_cpu(csq->sqid), le16_to_cpu(csq->qsize),
+			 le16_to_cpu(csq->sq_flags), le16_to_cpu(csq->cqid));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_create_cq(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	struct create_cq *ccq = (struct create_cq *) cdw10;
+
+	trace_seq_printf(p, "cqid=%u, qsize=%u, cq_flags=0x%x, irq_vector=%u",
+			 le16_to_cpu(ccq->cqid), le16_to_cpu(ccq->qsize),
+			 le16_to_cpu(ccq->cq_flags),
+			 le16_to_cpu(ccq->irq_vector));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_admin_identify(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	struct identify *idf = (struct identify *) cdw10;
+
+	trace_seq_printf(p, "cns=%u, ctrlid=%u",
+			 idf->cns, le16_to_cpu(idf->ctrlid));
+
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
+	struct rw_cmd *rw = (struct rw_cmd *) cdw10;
+
+	trace_seq_printf(p,
+			 "slba=%llu, len=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+			 le64_to_cpu(rw->slba), le16_to_cpu(rw->length),
+			 le16_to_cpu(rw->control), le32_to_cpu(rw->dsmgmt),
+			 le32_to_cpu(rw->reftag));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_dsm(struct trace_seq *p, __le32 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	struct dsm_cmd *dsm = (struct dsm_cmd *) cdw10;
+
+	trace_seq_printf(p, "nr=%u, attributes=%u",
+			 le32_to_cpu(dsm->nr), le32_to_cpu(dsm->attributes));
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
+const char *nvme_trace_parse_cmd(struct trace_seq *p, bool admin,
+				 u8 opcode, __le32 *cdw10)
+{
+	if (admin) {
+		switch (opcode) {
+		case nvme_admin_create_sq:
+			return nvme_trace_create_sq(p, cdw10);
+		case nvme_admin_create_cq:
+			return nvme_trace_create_cq(p, cdw10);
+		case nvme_admin_identify:
+			return nvme_trace_admin_identify(p, cdw10);
+		default:
+			return nvme_trace_common(p, cdw10);
+		}
+	} else {
+		switch (opcode) {
+		case nvme_cmd_read:
+		case nvme_cmd_write:
+		case nvme_cmd_write_zeroes:
+			return nvme_trace_read_write(p, cdw10);
+		case nvme_cmd_dsm:
+			return nvme_trace_dsm(p, cdw10);
+		default:
+			return nvme_trace_common(p, cdw10);
+		}
+	}
+}
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
new file mode 100644
index 000000000000..69e054c2e791
--- /dev/null
+++ b/drivers/nvme/host/trace.h
@@ -0,0 +1,112 @@
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
+const char *nvme_trace_parse_cmd(struct trace_seq *p, bool admin, u8 opcode,
+				 __le32 *cdw10);
+#define __parse_nvme_cmd(admin, opcode, cdw10) \
+	nvme_trace_parse_cmd(p, admin, opcode, cdw10)
+
+TRACE_EVENT(nvme_setup_cmd,
+	    TP_PROTO(struct nvme_command *cmd, bool admin),
+	    TP_ARGS(cmd, admin),
+	    TP_STRUCT__entry(
+		    __field(bool, admin)
+		    __field(__u8, opcode)
+		    __field(__u8, flags)
+		    __field(__u16, cid)
+		    __field(__le32, nsid)
+		    __field(__le64, metadata)
+		    __array(__le32, cdw10, 6)
+	    ),
+	    TP_fast_assign(
+		    __entry->admin = admin;
+		    __entry->opcode = cmd->common.opcode;
+		    __entry->flags = cmd->common.flags;
+		    __entry->cid = cmd->common.command_id;
+		    __entry->nsid = cmd->common.nsid;
+		    __entry->metadata = cmd->common.metadata;
+		    memcpy(__entry->cdw10, cmd->common.cdw10,
+			   sizeof(__entry->cdw10));
+	    ),
+	    TP_printk("nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      le32_to_cpu(__entry->nsid), __entry->cid, __entry->flags,
+		      le64_to_cpu(__entry->metadata),
+		      __entry->admin ? show_admin_opcode_name(__entry->opcode)
+			    : show_opcode_name(__entry->opcode),
+		      __parse_nvme_cmd(__entry->admin, __entry->opcode,
+				       __entry->cdw10))
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
2.12.3
