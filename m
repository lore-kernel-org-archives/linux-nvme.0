From: jsmart2021@gmail.com (James Smart)
Date: Tue, 26 Sep 2017 21:09:58 -0700
Subject: [PATCH] nvmet_fc: Reduce work_q count
Message-ID: <20170927040958.5981-1-jsmart2021@gmail.com>

Instead of a work_q per controller queue, use a global workqueue.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 58e010bdda3e..75b1752e8375 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -139,7 +139,6 @@ struct nvmet_fc_tgt_queue {
 	struct list_head		fod_list;
 	struct list_head		pending_cmd_list;
 	struct list_head		avail_defer_list;
-	struct workqueue_struct		*work_q;
 	struct kref			ref;
 } __aligned(sizeof(unsigned long long));
 
@@ -220,6 +219,7 @@ static DEFINE_SPINLOCK(nvmet_fc_tgtlock);
 static LIST_HEAD(nvmet_fc_target_list);
 static DEFINE_IDA(nvmet_fc_tgtport_cnt);
 
+static struct workqueue_struct *nvmet_fc_io_wq;
 
 static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
 static void nvmet_fc_handle_fcp_rqst_work(struct work_struct *work);
@@ -496,6 +496,7 @@ nvmet_fc_queue_fcp_req(struct nvmet_fc_tgtport *tgtport,
 		       struct nvmefc_tgt_fcp_req *fcpreq)
 {
 	struct nvmet_fc_fcp_iod *fod = fcpreq->nvmet_fc_private;
+	int cpu;
 
 	/*
 	 * put all admin cmds on hw queue id 0. All io commands go to
@@ -504,9 +505,11 @@ nvmet_fc_queue_fcp_req(struct nvmet_fc_tgtport *tgtport,
 	fcpreq->hwqid = queue->qid ?
 			((queue->qid - 1) % tgtport->ops->max_hw_queues) : 0;
 
-	if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR)
-		queue_work_on(queue->cpu, queue->work_q, &fod->work);
-	else
+	if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR) {
+		cpu = (queue->cpu == WORK_CPU_UNBOUND) ?
+					get_cpu() : queue->cpu;
+		queue_work_on(cpu, nvmet_fc_io_wq, &fod->work);
+	} else
 		nvmet_fc_handle_fcp_rqst(tgtport, fod);
 }
 
@@ -620,12 +623,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (!nvmet_fc_tgt_a_get(assoc))
 		goto out_free_queue;
 
-	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
-				assoc->tgtport->fc_target_port.port_num,
-				assoc->a_id, qid);
-	if (!queue->work_q)
-		goto out_a_put;
-
 	queue->fod = (struct nvmet_fc_fcp_iod *)&queue[1];
 	queue->qid = qid;
 	queue->sqsize = sqsize;
@@ -657,8 +654,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 
 out_fail_iodlist:
 	nvmet_fc_destroy_fcp_iodlist(assoc->tgtport, queue);
-	destroy_workqueue(queue->work_q);
-out_a_put:
 	nvmet_fc_tgt_a_put(assoc);
 out_free_queue:
 	kfree(queue);
@@ -681,8 +676,6 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 
 	nvmet_fc_tgt_a_put(queue->assoc);
 
-	destroy_workqueue(queue->work_q);
-
 	kfree(queue);
 }
 
@@ -765,7 +758,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	}
 	spin_unlock_irqrestore(&queue->qlock, flags);
 
-	flush_workqueue(queue->work_q);
+	flush_workqueue(nvmet_fc_io_wq);
 
 	if (disconnect)
 		nvmet_sq_destroy(&queue->nvme_sq);
@@ -2052,11 +2045,15 @@ nvmet_fc_xmt_fcp_op_done(struct nvmefc_tgt_fcp_req *fcpreq)
 {
 	struct nvmet_fc_fcp_iod *fod = fcpreq->nvmet_fc_private;
 	struct nvmet_fc_tgt_queue *queue = fod->queue;
+	int cpu;
 
-	if (fod->tgtport->ops->target_features & NVMET_FCTGTFEAT_OPDONE_IN_ISR)
+	if (fod->tgtport->ops->target_features &
+				NVMET_FCTGTFEAT_OPDONE_IN_ISR) {
+		cpu = (queue->cpu == WORK_CPU_UNBOUND) ?
+					get_cpu() : queue->cpu;
 		/* context switch so completion is not in ISR context */
-		queue_work_on(queue->cpu, queue->work_q, &fod->done_work);
-	else
+		queue_work_on(cpu, nvmet_fc_io_wq, &fod->done_work);
+	} else
 		nvmet_fc_fod_op_done(fod);
 }
 
@@ -2558,6 +2555,11 @@ static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 
 static int __init nvmet_fc_init_module(void)
 {
+	nvmet_fc_io_wq = alloc_workqueue("nvmet-fc",
+				WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE, 0);
+	if (!nvmet_fc_io_wq)
+		return -ENOMEM;
+
 	return nvmet_register_transport(&nvmet_fc_tgt_fcp_ops);
 }
 
@@ -2569,6 +2571,8 @@ static void __exit nvmet_fc_exit_module(void)
 
 	nvmet_unregister_transport(&nvmet_fc_tgt_fcp_ops);
 
+	destroy_workqueue(nvmet_fc_io_wq);
+
 	ida_destroy(&nvmet_fc_tgtport_cnt);
 }
 
-- 
2.13.1
