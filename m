From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 28 May 2019 02:53:46 +0900
Subject: [RFC PATCH 5/5] nvme-trace: Add tracing for req_comp in target
In-Reply-To: <20190527175346.29972-1-minwoo.im.dev@gmail.com>
References: <20190527175346.29972-1-minwoo.im.dev@gmail.com>
Message-ID: <20190527175346.29972-6-minwoo.im.dev@gmail.com>

We can have the common tracing code with different event entries.
  - nvme_complete_rq
  - nvmet_req_complete

This patch updates existing TRACE_EVENT to a template to provide a
common tracing interface.

We can have it as a common code because most of the fields need to be
printed out for both host and target system.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/target/core.c |  3 +++
 drivers/nvme/trace.c       |  1 +
 drivers/nvme/trace.h       | 51 ++++++++++++++++++++++++++++++--------
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a94c7f9b02ae..722737f5486f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -690,6 +690,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 
 	if (unlikely(status))
 		nvmet_set_error(req, status);
+
+	trace_nvmet_req_complete(req);
+
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
 	req->ops->queue_response(req);
diff --git a/drivers/nvme/trace.c b/drivers/nvme/trace.c
index 8fe2dcee6a42..8071b60ec71d 100644
--- a/drivers/nvme/trace.c
+++ b/drivers/nvme/trace.c
@@ -222,3 +222,4 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_async_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvmet_req_init);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvmet_req_complete);
diff --git a/drivers/nvme/trace.h b/drivers/nvme/trace.h
index 9af674ee0c3a..bd239434de09 100644
--- a/drivers/nvme/trace.h
+++ b/drivers/nvme/trace.h
@@ -193,10 +193,11 @@ DEFINE_EVENT(nvme__cmd_begin, nvmet_req_init,
 	TP_ARGS(req, cmd, NVME_TRACE_TARGET)
 );
 
-TRACE_EVENT(nvme_complete_rq,
-	    TP_PROTO(struct request *req),
+DECLARE_EVENT_CLASS(nvme__cmd_end,
+	    TP_PROTO(void *req, ...),
 	    TP_ARGS(req),
 	    TP_STRUCT__entry(
+		__field(enum nvme_trace_type, type)
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, ctrl_id)
 		__field(int, qid)
@@ -207,20 +208,50 @@ TRACE_EVENT(nvme_complete_rq,
 		__field(u16, status)
 	    ),
 	    TP_fast_assign(
-		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
-		__entry->qid = nvme_req_qid(req);
-		__entry->cid = req->tag;
-		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
-		__entry->retries = nvme_req(req)->retries;
-		__entry->flags = nvme_req(req)->flags;
-		__entry->status = nvme_req(req)->status;
-		__assign_disk_name(__entry->disk, req->rq_disk);
+		set_trace_type(__entry->type, req);
+		if (__entry->type != NVME_TRACE_TARGET) {
+			struct request *req = (struct request *) req;
+
+			__entry->ctrl_id = nvme_req(req)->ctrl->instance;
+			__entry->qid = nvme_req_qid(req);
+			__entry->cid = req->tag;
+			__entry->result =
+					le64_to_cpu(nvme_req(req)->result.u64);
+			__entry->retries = nvme_req(req)->retries;
+			__entry->flags = nvme_req(req)->flags;
+			__entry->status = nvme_req(req)->status;
+			__assign_disk_name(__entry->disk, req->rq_disk);
+		} else {
+			struct nvmet_ctrl *ctrl = nvmet_req_to_ctrl(req);
+			struct nvmet_cq *cq = ((struct nvmet_req *) req)->cq;
+			struct nvme_completion *cqe =
+					((struct nvmet_req *) req)->cqe;
+			struct nvmet_ns *ns = ((struct nvmet_req *) req)->ns;
+
+			__entry->ctrl_id = ctrl ? ctrl->cntlid : 0;
+			__entry->qid = cq->qid;
+			__entry->cid = cqe->command_id;
+			__entry->result = cqe->result.u64;
+			__entry->flags = 0;
+			__entry->status = cqe->status >> 1;
+			__assign_disk_name(__entry->disk, ns ?
+						ns->bdev->bd_disk : NULL);
+		}
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
 		      __entry->qid, __entry->cid, __entry->result,
 		      __entry->retries, __entry->flags, __entry->status)
+);
+
+DEFINE_EVENT(nvme__cmd_end, nvme_complete_rq,
+	TP_PROTO(void *req, ...),
+	TP_ARGS(req, NVME_TRACE_HOST)
+);
 
+DEFINE_EVENT(nvme__cmd_end, nvmet_req_complete,
+	TP_PROTO(void *req, ...),
+	TP_ARGS(req, NVME_TRACE_TARGET)
 );
 
 #define aer_name(aer) { aer, #aer }
-- 
2.21.0
