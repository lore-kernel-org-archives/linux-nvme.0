From: yupeng0921@gmail.com (yupeng)
Date: Mon, 17 Dec 2018 00:06:05 -0800
Subject: [PATCH v3 2/2] trace nvme submit queue status
In-Reply-To: <20181217080605.16867-1-yupeng0921@gmail.com>
References: <20181217080605.16867-1-yupeng0921@gmail.com>
Message-ID: <20181217080605.16867-2-yupeng0921@gmail.com>

export nvme disk name, queue id, sq_head, sq_tail to trace event
usage example:
go to the event directory:
cd /sys/kernel/debug/tracing/events/nvme/nvme_sq
filter by disk name:
echo 'disk=="nvme1n1"' > filter
enable the event:
echo 1 > enable
check results from trace_pipe:
cat /sys/kernel/debug/tracing/trace_pipe
In practice, this patch help me debug hardware related
performant issue.

Signed-off-by: yupeng <yupeng0921 at gmail.com>
---
 drivers/nvme/host/pci.c       |  7 +++++
 drivers/nvme/host/trace_pci.h | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 drivers/nvme/host/trace_pci.h

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..974cb05b3592 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -32,6 +32,9 @@
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace_pci.h"
+
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -899,6 +902,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	trace_nvme_sq(req->rq_disk,
+		nvmeq->qid,
+		le16_to_cpu(cqe->sq_head),
+		nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
diff --git a/drivers/nvme/host/trace_pci.h b/drivers/nvme/host/trace_pci.h
new file mode 100644
index 000000000000..70fa853397f6
--- /dev/null
+++ b/drivers/nvme/host/trace_pci.h
@@ -0,0 +1,57 @@
+/*
+ * NVM Express device driver tracepoints
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
+const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
+#define __print_disk_name(name)				\
+	nvme_trace_disk_name(p, name)
+
+TRACE_EVENT(nvme_sq,
+	    TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
+	    TP_ARGS(rq_disk, qid, sq_head, sq_tail),
+	    TP_STRUCT__entry(
+		 __array(char, disk, DISK_NAME_LEN)
+		 __field(int, qid)
+		 __field(int, sq_head)
+		 __field(int, sq_tail)),
+	    TP_fast_assign(
+		__entry->qid = qid;
+		__entry->sq_head = sq_head;
+		__entry->sq_tail = sq_tail;
+		__assign_disk_name(__entry->disk, rq_disk);
+	    ),
+	    TP_printk("nvme: %s qid=%d head=%d tail=%d",
+		      __print_disk_name(__entry->disk),
+		      __entry->qid, __entry->sq_head, __entry->sq_tail)
+);
+
+#endif /* _TRACE_NVME_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace_pci
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1
