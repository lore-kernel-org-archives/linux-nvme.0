From: yupeng0921@gmail.com (yupeng)
Date: Mon, 17 Dec 2018 20:51:38 -0800
Subject: [PATCH v4 2/2] trace nvme submit queue status
In-Reply-To: <20181218045138.4282-1-yupeng0921@gmail.com>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
Message-ID: <20181218045138.4282-2-yupeng0921@gmail.com>

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
 drivers/nvme/host/pci.c   |  5 +++++
 drivers/nvme/host/trace.c |  2 ++
 drivers/nvme/host/trace.h | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..52df2f7fef37 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -32,6 +32,7 @@
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
+#include "trace.h"
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -899,6 +900,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	trace_nvme_sq(req->rq_disk,
+		nvmeq->qid,
+		le16_to_cpu(cqe->sq_head),
+		nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 8ca7079ed2bc..7bfaace23e1e 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -142,3 +142,5 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
+
+EXPORT_TRACEPOINT_SYMBOL(nvme_sq);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 196d5bd56718..3606cd7000f4 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -184,6 +184,27 @@ TRACE_EVENT(nvme_async_event,
 
 #undef aer_name
 
+TRACE_EVENT(nvme_sq,
+	TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
+	TP_ARGS(rq_disk, qid, sq_head, sq_tail),
+	TP_STRUCT__entry(
+		__array(char, disk, DISK_NAME_LEN)
+		__field(int, qid)
+		__field(int, sq_head)
+		__field(int, sq_tail)
+	),
+	TP_fast_assign(
+		__assign_disk_name(__entry->disk, rq_disk);
+		__entry->qid = qid;
+		__entry->sq_head = sq_head;
+		__entry->sq_tail = sq_tail;
+	),
+	TP_printk("nvme: %s qid=%d head=%d tail=%d",
+		__print_disk_name(__entry->disk),
+		__entry->qid, __entry->sq_head, __entry->sq_tail
+	)
+);
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.1
