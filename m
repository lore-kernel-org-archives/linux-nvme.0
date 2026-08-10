Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578AEC5AD55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RuMvWveapRdAvgMsP6qbMmUrLveWZij17c5B9TAvCvk=; b=GjBG4nCh4mHg31qa3qJEqstJdO
	StWObWWpYeQ+Khrjf3cG99SQGm+1LQI8umIYwPr3I/w/3yUw6wmoPr4MXl3YvXUQsowLIsKHGnHQv
	X1vufvPI1Di3A7hsWj8lhFx15gFopBL7cVAD69K4b0hoyJUb2uNwm57txiB4NZKOwwJ3IXEhUC+4O
	mMtDgPUlHCHspcpTpyoPn3PGEdJ7U/05dy67x2finhiY40ID+VgnKo2Xfz2RhSkBxyt2CWktICxAz
	XiFBMCmtu+kZwhteyAX/y5g30E4N79hwHwdhS160lvjdovQUbKTyjpNfcy4cScibpT8LpSAga4LMF
	SWatA8zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtX1U-0000000Cs6p-0hkP;
	Mon, 10 Aug 2026 20:55:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtX1T-0000000Cs6j-0AHy
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 20:55:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D027600AA;
	Mon, 10 Aug 2026 20:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858BC1F000E9;
	Mon, 10 Aug 2026 20:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786395301;
	bh=RuMvWveapRdAvgMsP6qbMmUrLveWZij17c5B9TAvCvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TK06uKx505TpywTyKXrbDHvPRglPt4aUzEsarwFHf5fbMgXlFFa9K6mdixTrhQLFp
	 HjJP7DAT2rtcSYQK8LwK9GBHkLPN8G0LjM/xZxF24+pug53sqj/oDdY1Y4lREnN0b2
	 WkAkKKhStIyqI+8F0869z30pp2UUnn27EZ1pUaNPPqn+CDsfShhxSwaYDPc3qjQD8D
	 le5GQdu4rRj6F4QEbQ6p9MofvNRpLV0OwJEE5G9zGHZ8O3BHLjUugjcs4TfOa+uYsk
	 3HNDVkKQccPpQoxDuP5Md+oX+wMsau7Hs2YzZFytT3uInlSNpZ3JtKHauO2Ic/ESMI
	 p6Mm8vB3oYCzA==
Date: Mon, 10 Aug 2026 14:55:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
Message-ID: <ano6o6i4Yr2JfMgu@kbusch-mbp>
References: <20260806031058.40176-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806031058.40176-1-changfengnan@bytedance.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2026 at 11:10:58AM +0800, Fengnan Chang wrote:
> The idea behind this approach is: Let each I/O queue switch itself between
> interrupt and poll mode based on its own recent completion rate.
> 
> This version is still in the testing phase, and there are still some issues
> with the code implementation.  I releasing it now to see if the approach
> is generally acceptable.  If the approach looks good, I´ll continue to
> refine it and conduct more extensive testing.  The main implementation
> logic is in `nvme_adaptive_sample` and `nvme_adaptive_irq_poll`; you should
> focus on reviewing the implementation of these two functions.

Can we subscribe to the dynamic interrupt moderation (dim) library? I
know it's generally used in conjuction with a hardware interrupt
coalescing feature, but we can just do pure software with it too. The
library provides a hill climb to adapt the policy at run time.

This is a quick PoC I put together. I haven't tested on fast devices, so
I'm not sure if I've dialed in the profiles, but it's start of what I
had in mind.

---
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c9..9fad1c7b1f678 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -6,6 +6,7 @@ config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
 	select NVME_CORE
+	select DIMLIB
 	help
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8438c904ec496..ff0c8d74fae08 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,8 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
+#include <linux/delay.h>
+#include <linux/dim.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -82,6 +84,45 @@ struct quirk_entry {
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
+static unsigned int irq_poll_thresh = 7;
+module_param(irq_poll_thresh, uint, 0644);
+MODULE_PARM_DESC(irq_poll_thresh,
+	"outstanding depth after which a queue switches to threaded polling");
+
+static unsigned int irq_poll_spin = 7;
+module_param(irq_poll_spin, uint, 0644);
+MODULE_PARM_DESC(irq_poll_spin,
+	"poll iterations to spin (cpu_relax) before sleeping in the poll loop (zero based)");
+
+static unsigned int irq_poll_sleep_us = 20;
+static unsigned int irq_poll_idle_us = 80;
+static unsigned int irq_poll_idle_rounds = DIV_ROUND_UP(80, 20);
+
+static int irq_poll_us_set(const char *val, const struct kernel_param *kp)
+{
+	int ret = param_set_uint(val, kp);
+
+	if (ret)
+		return ret;
+
+	irq_poll_idle_rounds = irq_poll_sleep_us ?
+		DIV_ROUND_UP(irq_poll_idle_us, irq_poll_sleep_us) : 1;
+	return 0;
+}
+
+static const struct kernel_param_ops irq_poll_us_ops = {
+	.set = irq_poll_us_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(irq_poll_sleep_us, &irq_poll_us_ops, &irq_poll_sleep_us, 0644);
+MODULE_PARM_DESC(irq_poll_sleep_us,
+	"microseconds to sleep between poll bursts (<=10 busy-delays, does not yield)");
+
+module_param_cb(irq_poll_idle_us, &irq_poll_us_ops, &irq_poll_idle_us, 0644);
+MODULE_PARM_DESC(irq_poll_idle_us,
+	"microseconds to wait for stragglers before handing a queue back to the IRQ path");
+
 static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
@@ -381,11 +422,21 @@ struct nvme_queue {
 	u16 qid;
 	u8 cq_phase;
 	u8 sqes;
+	/* Adaptive polling knobs, seeded from the irq_poll_* module params. */
+	unsigned int poll_thresh;
+	unsigned int poll_sleep_us;
+	unsigned int poll_idle_rounds;
+	unsigned int poll_budget;
+	/* Adaptive interrupt moderation (DIM) sampling state. */
+	struct dim dim;
+	u16 dim_events;			/* cumulative interrupts (BIT_GAP-safe) */
+	u32 dim_comps;			/* cumulative completions */
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+#define NVMEQ_POLLING		4
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
@@ -1606,13 +1657,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
-			        struct io_comp_batch *iob)
+static inline int __nvme_poll_cq(struct nvme_queue *nvmeq,
+				  struct io_comp_batch *iob, int budget)
 {
-	bool found = false;
+	int found = 0;
 
 	while (nvme_cqe_pending(nvmeq)) {
-		found = true;
+		found++;
 		/*
 		 * load-load control dependency between phase and the rest of
 		 * the cqe requires a full read memory barrier
@@ -1620,6 +1671,8 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 		dma_rmb();
 		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
+		if (budget && found == budget)
+			break;
 	}
 
 	if (found)
@@ -1627,26 +1680,253 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 	return found;
 }
 
+/* budget == 0 means reap the whole queue. */
+static int nvme_poll_cq(struct nvme_queue *nvmeq, int budget)
+{
+	DEFINE_IO_COMP_BATCH(iob);
+	int found = __nvme_poll_cq(nvmeq, &iob, budget);
+
+	if (found && !rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+	return found;
+}
+
+static inline unsigned int nvmeq_outstanding(struct nvme_queue *nvmeq)
+{
+	u16 sq_tail = READ_ONCE(nvmeq->last_sq_tail);
+	u16 cq_head = nvmeq->cq_head;
+
+	if (sq_tail >= cq_head)
+		return sq_tail - cq_head;
+	return nvmeq->q_depth - cq_head + sq_tail;
+}
+
+static inline bool nvmeq_cq_continue(struct nvme_queue *nvmeq)
+{
+	return nvmeq_outstanding(nvmeq) > nvmeq->poll_thresh;
+}
+
+static inline bool nvmeq_cq_idle(struct nvme_queue *nvmeq)
+{
+	return nvmeq->cq_head == READ_ONCE(nvmeq->last_sq_tail);
+}
+
+/*
+ * Interrupt-moderation profiles, ordered from least moderation (index 0: enter
+ * polling late, short sleep, brief linger -> lowest latency, most interrupts)
+ * to most moderation (enter early, long sleep, long linger -> fewest
+ * interrupts).  The hill-climb walks this table to keep completions-per-
+ * interrupt high, which is what bounds the interrupt rate.
+ */
+static const struct nvme_poll_prof {
+	u16 thresh;
+	u16 sleep_us;
+	u16 idle_rounds;
+	u16 budget;		/* hard-IRQ initial poll cap; 0 == reap all */
+} nvme_poll_prof[] = {
+	{ 31,  0,  1,  0 },	/* drain inline: lowest latency, most interrupts */
+	{ 15, 10,  2, 16 },
+	{  7, 20,  4,  8 },	/* start profile; matches irq_poll_* defaults */
+	{  3, 40,  8,  4 },
+	{  1, 80, 16,  2 },	/* reap a little, hand the bulk to the thread */
+};
+
+#define NVME_DIM_START_PROFILE 2
+
+static void nvme_apply_profile(struct nvme_queue *nvmeq)
+{
+	const struct nvme_poll_prof *p = &nvme_poll_prof[nvmeq->dim.profile_ix];
+
+	nvmeq->poll_thresh = p->thresh;
+	nvmeq->poll_sleep_us = p->sleep_us;
+	nvmeq->poll_idle_rounds = p->idle_rounds;
+	nvmeq->poll_budget = p->budget;
+}
+
+/* Mirror of rdma_dim_step() bounded to our profile table. */
+static int nvme_dim_step(struct dim *dim)
+{
+	if (dim->tune_state == DIM_GOING_RIGHT) {
+		if (dim->profile_ix == ARRAY_SIZE(nvme_poll_prof) - 1)
+			return DIM_ON_EDGE;
+		dim->profile_ix++;
+		dim->steps_right++;
+	}
+	if (dim->tune_state == DIM_GOING_LEFT) {
+		if (dim->profile_ix == 0)
+			return DIM_ON_EDGE;
+		dim->profile_ix--;
+		dim->steps_left++;
+	}
+	return DIM_STEPPED;
+}
+
+/* Mirror of rdma_dim_stats_compare(): completion rate first, then batching. */
+static int nvme_dim_stats_compare(struct dim_stats *curr, struct dim_stats *prev)
+{
+	if (!prev->cpms)
+		return DIM_STATS_SAME;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpms, prev->cpms))
+		return curr->cpms > prev->cpms ? DIM_STATS_BETTER :
+						 DIM_STATS_WORSE;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
+		return curr->cpe_ratio > prev->cpe_ratio ? DIM_STATS_BETTER :
+							   DIM_STATS_WORSE;
+
+	return DIM_STATS_SAME;
+}
+
+/* Mirror of rdma_dim_decision(); returns true if the profile changed. */
+static bool nvme_dim_decision(struct dim_stats *curr, struct dim *dim)
+{
+	int prev_ix = dim->profile_ix;
+	int stats_res;
+
+	stats_res = nvme_dim_stats_compare(curr, &dim->prev_stats);
+	switch (stats_res) {
+	case DIM_STATS_SAME:
+		if (curr->cpe_ratio <= 50 * prev_ix)
+			dim->profile_ix = 0;
+		break;
+	case DIM_STATS_WORSE:
+		dim_turn(dim);
+		fallthrough;
+	case DIM_STATS_BETTER:
+		if (nvme_dim_step(dim) == DIM_ON_EDGE)
+			dim_turn(dim);
+		break;
+	}
+
+	dim->prev_stats = *curr;
+	return dim->profile_ix != prev_ix;
+}
+
+/*
+ * Sample the completion/interrupt counters and, once per DIM_NEVENTS
+ * interrupts, compute the load stats.  Called only from the interrupt owner
+ * (never concurrently with the poll thread), so the counters have a single
+ * writer.  ktime_get() is taken only at a window boundary, not per interrupt.
+ *
+ * On each completed window the hill-climb picks a profile and, if it changed,
+ * applies it to nvmeq->poll_*.
+ */
+static void nvme_dim(struct nvme_queue *nvmeq)
+{
+	struct dim *dim = &nvmeq->dim;
+	struct dim_sample end;
+	struct dim_stats stats;
+
+	if (dim->state == DIM_START_MEASURE) {
+		dim_update_sample_with_comps(nvmeq->dim_events, 0, 0,
+					     nvmeq->dim_comps, &dim->start_sample);
+		dim->state = DIM_MEASURE_IN_PROGRESS;
+		return;
+	}
+
+	/* Cheap gate: only recompute once a full window of events accrues. */
+	if ((u16)(nvmeq->dim_events - dim->start_sample.event_ctr) < DIM_NEVENTS)
+		return;
+
+	dim_update_sample_with_comps(nvmeq->dim_events, 0, 0, nvmeq->dim_comps,
+				     &end);
+	if (dim_calc_stats(&dim->start_sample, &end, &stats)) {
+		if (nvme_dim_decision(&stats, dim))
+			nvme_apply_profile(nvmeq);
+		trace_nvme_dim(nvmeq->qid, stats.cpms, stats.epms,
+			       stats.cpe_ratio, dim->profile_ix);
+	}
+	dim->start_sample = end;
+}
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	DEFINE_IO_COMP_BATCH(iob);
+	struct nvme_dev *dev = nvmeq->dev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	irqreturn_t ret = IRQ_NONE;
+	unsigned int idle = 0;
 
-	if (nvme_poll_cq(nvmeq, &iob)) {
-		if (!rq_list_empty(&iob.req_list))
-			nvme_pci_complete_batch(&iob);
-		return IRQ_HANDLED;
+	for (;;) {
+		bool worked = false;
+		unsigned int i;
+
+		for (i = 0; i <= irq_poll_spin; i++) {
+			int n = nvme_poll_cq(nvmeq, 0);
+
+			if (n) {
+				nvmeq->dim_comps += n;
+				ret = IRQ_HANDLED;
+				worked = true;
+				idle = 0;
+			}
+
+			if (nvmeq_cq_idle(nvmeq))
+				goto done;
+			else if (need_resched())
+				cond_resched();
+			else
+				cpu_relax();
+		}
+
+		if (worked || ++idle < nvmeq->poll_idle_rounds) {
+			fsleep(nvmeq->poll_sleep_us);
+			continue;
+		}
+done:
+		clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+		if (!nvme_cqe_pending(nvmeq) ||
+		    test_and_set_bit(NVMEQ_POLLING, &nvmeq->flags))
+			break;
+
+		if (need_resched())
+			cond_resched();
+		else
+			cpu_relax();
+		idle = 0;
 	}
-	return IRQ_NONE;
+
+	if (pdev->msi_enabled)
+		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMC);
+	return ret;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
+	int found;
+
+	nvmeq->dim_events++;
 
-	if (nvme_cqe_pending(nvmeq))
+	if (test_and_set_bit(NVMEQ_POLLING, &nvmeq->flags))
+		return IRQ_HANDLED;
+
+	found = nvme_poll_cq(nvmeq, nvmeq->poll_budget);
+	nvmeq->dim_comps += found;
+	nvme_dim(nvmeq);
+
+	if (!found) {
+		clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+		return IRQ_NONE;
+	}
+
+	/*
+	 * Hand off to the poll thread when the queue is still deep, or when the
+	 * budgeted initial poll left CQEs behind: their interrupt is already
+	 * spent, so releasing here would strand them.
+	 */
+	if (nvme_cqe_pending(nvmeq) || nvmeq_cq_continue(nvmeq)) {
+		struct nvme_dev *dev = nvmeq->dev;
+		struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+		if (pdev->msi_enabled)
+			writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMS);
 		return IRQ_WAKE_THREAD;
-	return IRQ_NONE;
+	}
+
+	clear_bit(NVMEQ_POLLING, &nvmeq->flags);
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1663,7 +1943,7 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
 	disable_irq(irq);
 	spin_lock(&nvmeq->cq_poll_lock);
-	nvme_poll_cq(nvmeq, NULL);
+	__nvme_poll_cq(nvmeq, NULL, 0);
 	spin_unlock(&nvmeq->cq_poll_lock);
 	enable_irq(irq);
 }
@@ -1671,14 +1951,14 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
-	bool found;
+	int found;
 
 	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
 	    !nvme_cqe_pending(nvmeq))
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_poll_cq(nvmeq, iob);
+	found = __nvme_poll_cq(nvmeq, iob, 0);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
@@ -2075,7 +2355,7 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
 		spin_lock(&dev->queues[i].cq_poll_lock);
-		nvme_poll_cq(&dev->queues[i], NULL);
+		__nvme_poll_cq(&dev->queues[i], NULL, 0);
 		spin_unlock(&dev->queues[i].cq_poll_lock);
 	}
 }
@@ -2171,13 +2451,8 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
 
-	if (use_threaded_interrupts) {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	}
+	return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
+			nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -2188,6 +2463,17 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
+	nvmeq->poll_thresh = irq_poll_thresh;
+	nvmeq->poll_sleep_us = irq_poll_sleep_us;
+	nvmeq->poll_idle_rounds = irq_poll_idle_rounds;
+	nvmeq->poll_budget = nvme_poll_prof[NVME_DIM_START_PROFILE].budget;
+	memset(&nvmeq->dim, 0, sizeof(nvmeq->dim));
+	nvmeq->dim.priv = nvmeq;
+	nvmeq->dim.profile_ix = NVME_DIM_START_PROFILE;
+	nvmeq->dim.tune_state = DIM_GOING_RIGHT;
+	nvmeq->dim_events = 0;
+	nvmeq->dim_comps = 0;
+	clear_bit(NVMEQ_POLLING, &nvmeq->flags);
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
 	nvme_dbbuf_init(dev, nvmeq, qid);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index ad25ad1e40412..4bdd5abc60880 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -498,3 +498,4 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 }
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_dim);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 4fb5922ffdac5..b7099b3026079 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -161,6 +161,29 @@ TRACE_EVENT(nvme_sq,
 	)
 );
 
+TRACE_EVENT(nvme_dim,
+	TP_PROTO(u16 qid, int cpms, int epms, int cpe_ratio, u8 profile),
+	TP_ARGS(qid, cpms, epms, cpe_ratio, profile),
+	TP_STRUCT__entry(
+		__field(u16, qid)
+		__field(int, cpms)
+		__field(int, epms)
+		__field(int, cpe_ratio)
+		__field(u8, profile)
+	),
+	TP_fast_assign(
+		__entry->qid = qid;
+		__entry->cpms = cpms;
+		__entry->epms = epms;
+		__entry->cpe_ratio = cpe_ratio;
+		__entry->profile = profile;
+	),
+	TP_printk("qid=%u cpms=%d epms=%d cpe_ratio=%d profile=%u",
+		__entry->qid, __entry->cpms, __entry->epms,
+		__entry->cpe_ratio, __entry->profile
+	)
+);
+
 #endif /* _TRACE_NVME_H */
 
 #undef TRACE_INCLUDE_PATH
--

