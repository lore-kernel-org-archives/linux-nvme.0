From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:36:49 -0800
Subject: [PATCH RFC 2/4] rdma: introduce ib_change_cq_ctx
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Message-ID: <20181211233652.9705-3-sagi@grimberg.me>

Allow cq consumers to modify the cq polling context online. The
consumer might want to allocate the cq with softirq/workqueue polling
context for async (setup time) I/O, and when completed, switch the
polling context to direct polling and get all the interrupts out
of the way.

One example is nvme-rdma driver that hooks into the block layer
infrastructure for a polling queue map for latency sensitive I/O.
Every nvmf queue starts with a connect message that is the slow path
at setup time, and there is no need for polling (it is actually
hurtful). Instead, allocate the polling queue cq with IB_POLL_SOFTIRQ
and switch it to IB_POLL_DIRECT where it makes sense.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/infiniband/core/cq.c | 102 ++++++++++++++++++++++++-----------
 include/rdma/ib_verbs.h      |   1 +
 2 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index b1e5365ddafa..c820eb954edc 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL(ib_process_cq_direct);
 
 static void ib_cq_completion_direct(struct ib_cq *cq, void *private)
 {
-	WARN_ONCE(1, "got unsolicited completion for CQ 0x%p\n", cq);
+	pr_debug("got unsolicited completion for CQ 0x%p\n", cq);
 }
 
 static int ib_poll_handler(struct irq_poll *iop, int budget)
@@ -120,6 +120,33 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 	queue_work(cq->comp_wq, &cq->work);
 }
 
+static int __ib_cq_set_ctx(struct ib_cq *cq)
+{
+	switch (cq->poll_ctx) {
+	case IB_POLL_DIRECT:
+		cq->comp_handler = ib_cq_completion_direct;
+		break;
+	case IB_POLL_SOFTIRQ:
+		cq->comp_handler = ib_cq_completion_softirq;
+
+		irq_poll_init(&cq->iop, IB_POLL_BUDGET_IRQ, ib_poll_handler);
+		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
+		break;
+	case IB_POLL_WORKQUEUE:
+	case IB_POLL_UNBOUND_WORKQUEUE:
+		cq->comp_handler = ib_cq_completion_workqueue;
+		INIT_WORK(&cq->work, ib_cq_poll_work);
+		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
+		cq->comp_wq = (cq->poll_ctx == IB_POLL_WORKQUEUE) ?
+				ib_comp_wq : ib_comp_unbound_wq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * __ib_alloc_cq - allocate a completion queue
  * @dev:		device to allocate the CQ for
@@ -164,28 +191,9 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 	rdma_restrack_set_task(&cq->res, caller);
 	rdma_restrack_add(&cq->res);
 
-	switch (cq->poll_ctx) {
-	case IB_POLL_DIRECT:
-		cq->comp_handler = ib_cq_completion_direct;
-		break;
-	case IB_POLL_SOFTIRQ:
-		cq->comp_handler = ib_cq_completion_softirq;
-
-		irq_poll_init(&cq->iop, IB_POLL_BUDGET_IRQ, ib_poll_handler);
-		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
-		break;
-	case IB_POLL_WORKQUEUE:
-	case IB_POLL_UNBOUND_WORKQUEUE:
-		cq->comp_handler = ib_cq_completion_workqueue;
-		INIT_WORK(&cq->work, ib_cq_poll_work);
-		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
-		cq->comp_wq = (cq->poll_ctx == IB_POLL_WORKQUEUE) ?
-				ib_comp_wq : ib_comp_unbound_wq;
-		break;
-	default:
-		ret = -EINVAL;
+	ret = __ib_cq_set_ctx(cq);
+	if (ret)
 		goto out_free_wc;
-	}
 
 	return cq;
 
@@ -198,17 +206,8 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 }
 EXPORT_SYMBOL(__ib_alloc_cq);
 
-/**
- * ib_free_cq - free a completion queue
- * @cq:		completion queue to free.
- */
-void ib_free_cq(struct ib_cq *cq)
+static void __ib_cq_clear_ctx(struct ib_cq *cq)
 {
-	int ret;
-
-	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
-		return;
-
 	switch (cq->poll_ctx) {
 	case IB_POLL_DIRECT:
 		break;
@@ -222,6 +221,20 @@ void ib_free_cq(struct ib_cq *cq)
 	default:
 		WARN_ON_ONCE(1);
 	}
+}
+
+/**
+ * ib_free_cq - free a completion queue
+ * @cq:		completion queue to free.
+ */
+void ib_free_cq(struct ib_cq *cq)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
+		return;
+
+	__ib_cq_clear_ctx(cq);
 
 	kfree(cq->wc);
 	rdma_restrack_del(&cq->res);
@@ -229,3 +242,28 @@ void ib_free_cq(struct ib_cq *cq)
 	WARN_ON_ONCE(ret);
 }
 EXPORT_SYMBOL(ib_free_cq);
+
+/**
+ * ib_change_cq_ctx - change completion queue polling context dynamically
+ * @cq:			the completion queue
+ * @poll_ctx:		new context to poll the CQ from
+ *
+ * The caller must make sure that there is no inflight I/O when calling
+ * this (otherwise its just asking for trouble). If the cq polling context
+ * change fails, the old polling context is restored.
+ */
+int ib_change_cq_ctx(struct ib_cq *cq, enum ib_poll_context poll_ctx)
+{
+	enum ib_poll_context old_ctx = cq->poll_ctx;
+	int ret;
+
+	__ib_cq_clear_ctx(cq);
+	cq->poll_ctx = poll_ctx;
+	ret = __ib_cq_set_ctx(cq);
+	if (ret) {
+		cq->poll_ctx = old_ctx;
+		__ib_cq_set_ctx(cq);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(ib_change_cq_ctx);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9c0c2132a2d6..c9d03d3a3cd4 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3464,6 +3464,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 
 void ib_free_cq(struct ib_cq *cq);
 int ib_process_cq_direct(struct ib_cq *cq, int budget);
+int ib_change_cq_ctx(struct ib_cq *cq, enum ib_poll_context poll_ctx);
 
 /**
  * ib_create_cq - Creates a CQ on the specified device.
-- 
2.17.1
