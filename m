From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 17 Jan 2018 11:53:35 +0100
Subject: [PATCH v3 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180117105336.8666-1-jthumshirn@suse.de>
References: <20180117105336.8666-1-jthumshirn@suse.de>
Message-ID: <20180117105336.8666-2-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

---
Changes to v2:
* Don't cast le64_to_cpu() conversions to unsigned long long (Christoph)
* Add proper copyright header (Christoph)
* Move trace decoding into own file (Christoph)
* Include the src directory in the Makefile for trace (Christoph)
* Removed spaces before and after parenthesis (Christoph)
* Reduced print lines to fit the 80 char limit (Christoph)

Changes to v1:
* Fix typo (Hannes)
* move include/trace/events/nvme.h -> drivers/nvme/host/trace.h (Christoph)
---
 drivers/nvme/host/Makefile |  5 ++-
 drivers/nvme/host/core.c   |  4 +++
 drivers/nvme/host/trace.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h  | 77 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index a25fd43650ad..3e42ed0e1be5 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,11 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
+
+ccflags-y				+= -I$(src)
+
 obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
 obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
 obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
 obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 
-nvme-core-y				:= core.o
+nvme-core-y				:= trace.o core.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 839650e0926a..9c5d476c8c6d 100644
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
+	trace_nvme_setup_cmd(cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
new file mode 100644
index 000000000000..9400cf53c43a
--- /dev/null
+++ b/drivers/nvme/host/trace.c
@@ -0,0 +1,82 @@
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
+static const char *nvme_trace_read_write(struct trace_seq *p,
+					 struct nvme_rw_command rw)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p,
+			 "slba=%llu, len=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+			 le64_to_cpu(rw.slba), le16_to_cpu(rw.length),
+			 le16_to_cpu(rw.control), le32_to_cpu(rw.dsmgmt),
+			 le32_to_cpu(rw.reftag));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_dsm(struct trace_seq *p, struct nvme_dsm_cmd dsm)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "nr=%u, attributes=%u",
+			 le32_to_cpu(dsm.nr), le32_to_cpu(dsm.attributes));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_write_zeroes(struct trace_seq *p,
+					   struct nvme_write_zeroes_cmd wz)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p,
+			 "slba=%llu, len=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+			 le64_to_cpu(wz.slba), le16_to_cpu(wz.length),
+			 le16_to_cpu(wz.control), le32_to_cpu(wz.dsmgmt),
+			 le32_to_cpu(wz.reftag));
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_common(struct trace_seq *p,
+				     struct nvme_common_command c)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "cdw2=%*ph, cdw10=%*ph", 4, c.cdw2, 24, c.cdw10);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *nvme_trace_parse_cmd(struct trace_seq *p, struct nvme_command cmd)
+{
+	switch (cmd.common.opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+		return nvme_trace_read_write(p, cmd.rw);
+	case nvme_cmd_dsm:
+		return nvme_trace_dsm(p, cmd.dsm);
+	case nvme_cmd_write_zeroes:
+		return nvme_trace_write_zeroes(p, cmd.write_zeroes);
+	default:
+		return nvme_trace_common(p, cmd.common);
+	}
+}
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
new file mode 100644
index 000000000000..a168d806d494
--- /dev/null
+++ b/drivers/nvme/host/trace.h
@@ -0,0 +1,77 @@
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
+const char *nvme_trace_parse_cmd(struct trace_seq *p, struct nvme_command cmnd);
+#define __parse_nvme_cmd(cmd) nvme_trace_parse_cmd(p, cmd)
+
+TRACE_EVENT(nvme_setup_cmd,
+	    TP_PROTO(struct nvme_command *cmd),
+	    TP_ARGS(cmd),
+	    TP_STRUCT__entry(
+		    __field(__u8, opcode)
+		    __field(__u8, flags)
+		    __field(__u16, cid)
+		    __field(__le32, nsid)
+		    __field(__le64, metadata)
+		    __field_struct( struct nvme_command, cmnd )
+	    ),
+	    TP_fast_assign(
+		    __entry->opcode = cmd->common.opcode;
+		    __entry->flags = cmd->common.flags;
+		    __entry->cid = cmd->common.command_id;
+		    __entry->nsid = cmd->common.nsid;
+		    __entry->metadata = cmd->common.metadata;
+		    memcpy(&__entry->cmnd, cmd, sizeof(__entry->cmnd));
+	    ),
+	    TP_printk("nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
+		      le32_to_cpu(__entry->nsid), __entry->cid, __entry->flags,
+		      le64_to_cpu(__entry->metadata),
+		      show_opcode_name(__entry->opcode),
+		      __parse_nvme_cmd(__entry->cmnd))
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
