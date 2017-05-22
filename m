From: jsmart2021@gmail.com (James Smart)
Date: Mon, 22 May 2017 15:28:43 -0700
Subject: [PATCH v3 2/3] nvmet_fc: Reduce work_q count
In-Reply-To: <20170522222844.22494-1-jsmart2021@gmail.com>
References: <20170522222844.22494-1-jsmart2021@gmail.com>
Message-ID: <20170522222844.22494-3-jsmart2021@gmail.com>

Instead of a work_q per controller queue, use system workqueues.
Create "work lists" per cpu that driver ISR posts to and workqueue
pulls from.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
This is the 5th version of this patch: 
v2:
converted to use DEFINE_PER_CPU()
reworked do {} while into more readable for loop in
 nvmet_fc_do_work_on_cpu()
renamed create/delete_threads to create/delete_workqueues

v3:recut on nvme-4.12

v4:use per_cpu_ptr() instead of per_cpu()

v5:remove own workqueues, use system workqueues.
renamed create/delete_workqueues to create/delete_worklists

 drivers/nvme/target/fc.c | 206 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 156 insertions(+), 50 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 2006fae61980..c5417d3a1797 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -20,6 +20,7 @@
 #include <linux/blk-mq.h>
 #include <linux/parser.h>
 #include <linux/random.h>
+#include <linux/threads.h>
 #include <uapi/scsi/fc/fc_fs.h>
 #include <uapi/scsi/fc/fc_els.h>
 
@@ -81,6 +82,7 @@ struct nvmet_fc_fcp_iod {
 	u32				offset;
 	enum nvmet_fcp_datadir		io_dir;
 	bool				active;
+	bool				started;
 	bool				abort;
 	bool				aborted;
 	bool				writedataactive;
@@ -88,12 +90,12 @@ struct nvmet_fc_fcp_iod {
 
 	struct nvmet_req		req;
 	struct work_struct		work;
-	struct work_struct		done_work;
 
 	struct nvmet_fc_tgtport		*tgtport;
 	struct nvmet_fc_tgt_queue	*queue;
 
-	struct list_head		fcp_list;	/* tgtport->fcp_list */
+	struct list_head		fcp_list;	/* queue->fod_list */
+	struct list_head		work_list;	/* workcpu->work_list */
 };
 
 struct nvmet_fc_tgtport {
@@ -132,7 +134,6 @@ struct nvmet_fc_tgt_queue {
 	struct nvmet_fc_tgt_assoc	*assoc;
 	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
 	struct list_head		fod_list;
-	struct workqueue_struct		*work_q;
 	struct kref			ref;
 } __aligned(sizeof(unsigned long long));
 
@@ -145,6 +146,21 @@ struct nvmet_fc_tgt_assoc {
 	struct kref			ref;
 };
 
+enum nvmet_fc_workcpu_flags {
+	NVMET_FC_CPU_RUNNING		= (1 << 0),
+	NVMET_FC_CPU_TERMINATING	= (1 << 1),
+};
+
+struct nvmet_fc_work_by_cpu {
+	struct list_head		fod_list;
+	spinlock_t			clock;
+	int				cpu;
+	bool				running;
+	struct work_struct		cpu_work;
+};
+
+#define NVMET_FC_MAX_WORK_BUDGET	4096
+
 
 static inline int
 nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
@@ -213,10 +229,11 @@ static DEFINE_SPINLOCK(nvmet_fc_tgtlock);
 static LIST_HEAD(nvmet_fc_target_list);
 static DEFINE_IDA(nvmet_fc_tgtport_cnt);
 
+static u32 nvmet_fc_cpu_cnt;
+static DEFINE_PER_CPU(struct nvmet_fc_work_by_cpu, nvmet_fc_cpu_workcpu);
+#define nvmet_fc_workcpu(cpu)	per_cpu_ptr(&nvmet_fc_cpu_workcpu, cpu)
 
 static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
-static void nvmet_fc_handle_fcp_rqst_work(struct work_struct *work);
-static void nvmet_fc_fcp_rqst_op_done_work(struct work_struct *work);
 static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
 static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
@@ -417,11 +434,10 @@ nvmet_fc_prep_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
 	int i;
 
 	for (i = 0; i < queue->sqsize; fod++, i++) {
-		INIT_WORK(&fod->work, nvmet_fc_handle_fcp_rqst_work);
-		INIT_WORK(&fod->done_work, nvmet_fc_fcp_rqst_op_done_work);
 		fod->tgtport = tgtport;
 		fod->queue = queue;
 		fod->active = false;
+		fod->started = false;
 		fod->abort = false;
 		fod->aborted = false;
 		fod->fcpreq = NULL;
@@ -498,6 +514,7 @@ nvmet_fc_free_fcp_iod(struct nvmet_fc_tgt_queue *queue,
 	spin_lock_irqsave(&queue->qlock, flags);
 	list_add_tail(&fod->fcp_list, &fod->queue->fod_list);
 	fod->active = false;
+	fod->started = false;
 	fod->abort = false;
 	fod->aborted = false;
 	fod->writedataactive = false;
@@ -556,12 +573,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
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
@@ -591,8 +602,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 
 out_fail_iodlist:
 	nvmet_fc_destroy_fcp_iodlist(assoc->tgtport, queue);
-	destroy_workqueue(queue->work_q);
-out_a_put:
 	nvmet_fc_tgt_a_put(assoc);
 out_free_queue:
 	kfree(queue);
@@ -615,8 +624,6 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 
 	nvmet_fc_tgt_a_put(queue->assoc);
 
-	destroy_workqueue(queue->work_q);
-
 	kfree(queue);
 }
 
@@ -668,8 +675,6 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	}
 	spin_unlock_irqrestore(&queue->qlock, flags);
 
-	flush_workqueue(queue->work_q);
-
 	if (disconnect)
 		nvmet_sq_destroy(&queue->nvme_sq);
 
@@ -1962,24 +1967,27 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 }
 
 static void
-nvmet_fc_fcp_rqst_op_done_work(struct work_struct *work)
-{
-	struct nvmet_fc_fcp_iod *fod =
-		container_of(work, struct nvmet_fc_fcp_iod, done_work);
-
-	nvmet_fc_fod_op_done(fod);
-}
-
-static void
 nvmet_fc_xmt_fcp_op_done(struct nvmefc_tgt_fcp_req *fcpreq)
 {
 	struct nvmet_fc_fcp_iod *fod = fcpreq->nvmet_fc_private;
 	struct nvmet_fc_tgt_queue *queue = fod->queue;
+	struct nvmet_fc_work_by_cpu *workcpu = nvmet_fc_workcpu(queue->cpu);
+	unsigned long flags;
+	bool running;
 
-	if (fod->tgtport->ops->target_features & NVMET_FCTGTFEAT_OPDONE_IN_ISR)
-		/* context switch so completion is not in ISR context */
-		queue_work_on(queue->cpu, queue->work_q, &fod->done_work);
-	else
+	if (fod->tgtport->ops->target_features &
+				NVMET_FCTGTFEAT_OPDONE_IN_ISR) {
+		/* context switch for processing */
+
+		spin_lock_irqsave(&workcpu->clock, flags);
+		list_add_tail(&fod->work_list, &workcpu->fod_list);
+		running = workcpu->running;
+		workcpu->running = true;
+		spin_unlock_irqrestore(&workcpu->clock, flags);
+
+		if (!running)
+			schedule_work_on(workcpu->cpu, &workcpu->cpu_work);
+	} else
 		nvmet_fc_fod_op_done(fod);
 }
 
@@ -2069,6 +2077,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	 * layer until we have both based on csn.
 	 */
 
+	fod->started = true;
 	fod->fcpreq->done = nvmet_fc_xmt_fcp_op_done;
 
 	fod->total_length = be32_to_cpu(cmdiu->data_len);
@@ -2144,19 +2153,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	nvmet_fc_abort_op(tgtport, fod);
 }
 
-/*
- * Actual processing routine for received FC-NVME LS Requests from the LLD
- */
-static void
-nvmet_fc_handle_fcp_rqst_work(struct work_struct *work)
-{
-	struct nvmet_fc_fcp_iod *fod =
-		container_of(work, struct nvmet_fc_fcp_iod, work);
-	struct nvmet_fc_tgtport *tgtport = fod->tgtport;
-
-	nvmet_fc_handle_fcp_rqst(tgtport, fod);
-}
-
 /**
  * nvmet_fc_rcv_fcp_req - transport entry point called by an LLDD
  *                       upon the reception of a NVME FCP CMD IU.
@@ -2186,6 +2182,9 @@ nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *target_port,
 	struct nvme_fc_cmd_iu *cmdiu = cmdiubuf;
 	struct nvmet_fc_tgt_queue *queue;
 	struct nvmet_fc_fcp_iod *fod;
+	struct nvmet_fc_work_by_cpu *workcpu;
+	unsigned long flags;
+	bool running;
 
 	/* validate iu, so the connection id can be used to find the queue */
 	if ((cmdiubuf_len != sizeof(*cmdiu)) ||
@@ -2223,9 +2222,20 @@ nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *target_port,
 			((queue->qid - 1) % tgtport->ops->max_hw_queues) : 0;
 	memcpy(&fod->cmdiubuf, cmdiubuf, cmdiubuf_len);
 
-	if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR)
-		queue_work_on(queue->cpu, queue->work_q, &fod->work);
-	else
+	if (tgtport->ops->target_features & NVMET_FCTGTFEAT_CMD_IN_ISR) {
+		/* context switch for processing */
+
+		workcpu = nvmet_fc_workcpu(queue->cpu);
+
+		spin_lock_irqsave(&workcpu->clock, flags);
+		list_add_tail(&fod->work_list, &workcpu->fod_list);
+		running = workcpu->running;
+		workcpu->running = true;
+		spin_unlock_irqrestore(&workcpu->clock, flags);
+
+		if (!running)
+			schedule_work_on(workcpu->cpu, &workcpu->cpu_work);
+	} else
 		nvmet_fc_handle_fcp_rqst(tgtport, fod);
 
 	return 0;
@@ -2391,13 +2401,17 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 {
 	struct nvmet_fc_tgtport *tgtport = port->priv;
 	unsigned long flags;
+	bool matched = false;
 
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	if (tgtport->port == port) {
-		nvmet_fc_tgtport_put(tgtport);
+		matched = true;
 		tgtport->port = NULL;
 	}
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
+
+	if (matched)
+		nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
@@ -2410,9 +2424,99 @@ static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
 };
 
+static void
+nvmet_fc_do_work_on_cpu(struct work_struct *work)
+{
+	struct nvmet_fc_work_by_cpu *workcpu =
+		container_of(work, struct nvmet_fc_work_by_cpu, cpu_work);
+	struct nvmet_fc_fcp_iod *fod;
+	unsigned long flags;
+	int workcnt = 0;
+
+	spin_lock_irqsave(&workcpu->clock, flags);
+
+	fod = list_first_entry_or_null(&workcpu->fod_list,
+				struct nvmet_fc_fcp_iod, work_list);
+	for ( ; fod; ) {
+		list_del(&fod->work_list);
+
+		spin_unlock_irqrestore(&workcpu->clock, flags);
+
+		if (fod->started)
+			nvmet_fc_fod_op_done(fod);
+		else
+			nvmet_fc_handle_fcp_rqst(fod->tgtport, fod);
+
+		spin_lock_irqsave(&workcpu->clock, flags);
+
+		if (++workcnt >= NVMET_FC_MAX_WORK_BUDGET)
+			goto exit_reschedule;
+
+		fod = list_first_entry_or_null(&workcpu->fod_list,
+					struct nvmet_fc_fcp_iod, work_list);
+	}
+
+	workcpu->running = false;
+
+	spin_unlock_irqrestore(&workcpu->clock, flags);
+
+	return;
+
+exit_reschedule:
+	spin_unlock_irqrestore(&workcpu->clock, flags);
+	schedule_work_on(workcpu->cpu, &workcpu->cpu_work);
+}
+
+static int
+nvmet_fc_create_worklists(void)
+{
+	struct nvmet_fc_work_by_cpu *workcpu;
+	int i;
+
+	nvmet_fc_cpu_cnt = num_active_cpus();
+	for (i = 0; i < nvmet_fc_cpu_cnt; i++, workcpu++) {
+		workcpu = nvmet_fc_workcpu(i);
+
+		workcpu->cpu = i;
+		workcpu->running = false;
+		spin_lock_init(&workcpu->clock);
+		INIT_LIST_HEAD(&workcpu->fod_list);
+		INIT_WORK(&workcpu->cpu_work, nvmet_fc_do_work_on_cpu);
+	}
+
+	return 0;
+}
+
+static void
+nvmet_fc_delete_worklists(void)
+{
+	struct nvmet_fc_work_by_cpu *workcpu;
+	int i;
+
+	for (i = 0; i < nvmet_fc_cpu_cnt; i++, workcpu++) {
+		workcpu = nvmet_fc_workcpu(i);
+
+		/* sanity check - all work should be removed */
+		if (!list_empty(&workcpu->fod_list))
+			pr_warn("%s: cpu %d worklist not empty\n", __func__, i);
+	}
+}
+
 static int __init nvmet_fc_init_module(void)
 {
-	return nvmet_register_transport(&nvmet_fc_tgt_fcp_ops);
+	int ret;
+
+	ret = nvmet_fc_create_worklists();
+	if (ret)
+		goto fail;
+
+	ret = nvmet_register_transport(&nvmet_fc_tgt_fcp_ops);
+	if (!ret)
+		return 0;
+
+fail:
+	nvmet_fc_delete_worklists();
+	return -ENXIO;
 }
 
 static void __exit nvmet_fc_exit_module(void)
@@ -2423,6 +2527,8 @@ static void __exit nvmet_fc_exit_module(void)
 
 	nvmet_unregister_transport(&nvmet_fc_tgt_fcp_ops);
 
+	nvmet_fc_delete_worklists();
+
 	ida_destroy(&nvmet_fc_tgtport_cnt);
 }
 
-- 
2.11.0
