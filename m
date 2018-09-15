From: yupeng0921@gmail.com (yupeng)
Date: Sat, 15 Sep 2018 19:33:41 +0000
Subject: [PATCH] trace nvme submit queue status
Message-ID: <20180915193341.1221-1-yupeng0921@gmail.com>

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
 drivers/nvme/host/trace.h | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682f91df..11743c65a83f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -31,6 +31,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
 
+#include "trace.h"
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
@@ -894,6 +895,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
+	trace_nvme_sq(req->rq_disk,
+		      nvmeq->qid,
+		      le16_to_cpu(cqe->sq_head),
+		      nvmeq->sq_tail);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index a490790d6691..13e33184cf93 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -156,6 +156,24 @@ TRACE_EVENT(nvme_complete_rq,
 
 );
 
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
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.17.1
