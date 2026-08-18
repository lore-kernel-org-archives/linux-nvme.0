Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12A8C5DF74
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 03:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Subject:Date:From:Cc:To:Content-Type:Mime-Version:Message-Id:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L6P2M/Xg/WjQd6Uai0Az7H3wHn+LRg7hoUN1NOmvf9k=; b=qkuY5uJDJo2muvv9UHguOkv+gT
	sUI6uWDvFVnodGrDAIuvhGGBJh12+M9fEfhFPh2anoqptQTk2ZpzL/e/ifddVEbaTlB/7RazQ6M+3
	vTa2eNsiilPy8SzTnHyePrbvfyLN8zXsTPqy+2ttV/333i17unVWBKAoFzpXY1/1RZLFF5A4OH7Q7
	AdFXzrJGY8GITooqA7AKSUsa8QYl1hA8mJEm9v0mspN8ypOlfxFxjOfPByZsJkiVkelKdQM4tsvaM
	yGD1wXsnis4Cl/tJP5a8N1DMOTIxcz5K+SOCDfae1J1NJHOsUdBhWFDnA/rbbrMsdtQjB+R8wv6wC
	2YoYRQAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwAfX-00000007Co9-3NsV;
	Tue, 18 Aug 2026 03:39:19 +0000
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwAfU-00000007CnF-147O
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 03:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787024347; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=L6P2M/Xg/WjQd6Uai0Az7H3wHn+LRg7hoUN1NOmvf9k=;
 b=lMH8Itk24on23yC6gAY9NazZkMvb2elAzP9oediP2D7EM/DZYxxzth3O4BZs3lfBCHbauZ
 U0usv9Xwew8uA+vo0q1SQ7ENg2WZCxgCHuisdPGFOcywk31brBiVxACzEGRGJfoB2NFoNJ
 1KlE7/MAk8ti0sRwAEsAiuRw50uFl7jQuBGRmFx/tfy/jTFJj8k7WsbIRMH+LF7EZ0BTwR
 MiFUXlWWLFPZfgz7foP2il4g985J5kExWrGabdapWy+kQDWGAJNvVmjgo091DeKFOLkoUS
 zsqu/JEZ/FOGjQ6lB4fsQCbFlcWLiC1Fm4DFZLx0s3kbEa6ErV5T2UVGAW9vwg==
Message-Id: <20260818033846.53790-1-changfengnan@bytedance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, "Fengnan Chang" <changfengnan@bytedance.com>, 
	"Guzebing" <guzebing@bytedance.com>
From: "Fengnan Chang" <changfengnan@bytedance.com>
Date: Tue, 18 Aug 2026 11:38:46 +0800
X-Lms-Return-Path: <lba+26a83d3d9+93e9e6+lists.infradead.org+changfengnan@bytedance.com>
Subject: [PATCH] nvme-pci: add adaptive interrupt polling
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_203916_453710_7E2214EE 
X-CRM114-Status: GOOD (  28.06  )
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

In high-IOPS scenarios, relying on interrupts to handle I/O operations
can limit performance. This issue becomes particularly pronounced in
multi-disk environments, where performance is constrained by the CPU's
interrupt-handling capacity.

Add an opt-in adaptive policy for eligible non-threaded MSI-X I/O
queues. The idea behind this approach is: let each I/O queue switch
itself between interrupt and poll mode based on its own recent
completion rate.

In IRQ mode, sample at least 8192 completions and start a
polling attempt when the average completion interval is at most 10 us.
During the trial, hrtimer-driven irq_poll drains the CQ. Progress may
trail the IRQ baseline by 20 us within a window, but a full 8192-CQE
poll window must be strictly faster.

Keep successful polling for at most 64 windows before refreshing the
IRQ baseline. Allow two retries; after the third failed trial, count
64 windows worth of IRQ completions before resampling.

The default-off module parameter initializes new controllers. A
per-controller sysfs attribute changes the policy after freezing
namespace request queues and draining outstanding I/O. Threaded
interrupts are not supported.

Link: https://lore.kernel.org/linux-nvme/d9210bcdf73fbe1ac8b6ec132865609a3ed68688.ff265e95.1296.491e.89f9.8ae888a03346@bytedance.com/T/#mea881a7898c85b73992f568864001913cb456d59
Link: https://lore.kernel.org/linux-nvme/20260806031058.40176-1-changfengnan@bytedance.com/T/#u
Signed-off-by: Guzebing <guzebing@bytedance.com>
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 Documentation/ABI/testing/sysfs-nvme |  15 +
 drivers/nvme/host/Kconfig            |   1 +
 drivers/nvme/host/pci.c              | 507 +++++++++++++++++++++++++--
 3 files changed, 497 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testing/sysfs-nvme
index 499d5f843cd43..695da343f65ef 100644
--- a/Documentation/ABI/testing/sysfs-nvme
+++ b/Documentation/ABI/testing/sysfs-nvme
@@ -11,3 +11,18 @@ Description:
 		(REPLACETLSPSK) with the target. After a reauthentication
 		the value returned by tls_configured_key will be the new
 		serial.
+
+What:		/sys/class/nvme/nvmeX/adaptive_irq_polling
+Date:		August 2026
+KernelVersion:	7.2
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		Set the adaptive IRQ polling policy (0 or 1) for eligible I/O queues of one
+		PCI NVMe controller.  Reading returns the policy, not whether a queue
+		is currently polling.  Changing it freezes the namespace request
+		queues and waits for outstanding namespace I/O.  Writes fail with
+		EBUSY unless the controller is live.
+
+		Eligible queues use non-threaded MSI-X with a dedicated vector.  The
+		attribute is unavailable with threaded interrupts.  The module
+		parameter supplies only the initial policy for new controllers.
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c9..22164b901da85 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -5,6 +5,7 @@ config NVME_CORE
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
+	select IRQ_POLL
 	select NVME_CORE
 	help
 	  The NVM Express driver is for solid state drives directly
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b537..b24c462d5aff2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -10,9 +10,12 @@
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
 #include <linux/dmi.h>
+#include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq_poll.h>
+#include <linux/ktime.h>
 #include <linux/kstrtox.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
@@ -82,6 +85,16 @@ struct quirk_entry {
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
+static bool use_adaptive_irq_polling;
+module_param(use_adaptive_irq_polling, bool, 0444);
+MODULE_PARM_DESC(use_adaptive_irq_polling,
+		 "default adaptive polling policy for eligible I/O queues");
+
+#define NVME_ADAPTIVE_POLL_PERIOD_NS	(10U * NSEC_PER_USEC)
+#define NVME_ADAPTIVE_EPISODE_CQES	8192U
+#define NVME_ADAPTIVE_REEVAL_CQES	(64U * NVME_ADAPTIVE_EPISODE_CQES)
+#define NVME_ADAPTIVE_POLL_RETRIES	2U
+
 static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
@@ -307,6 +320,7 @@ struct nvme_dev {
 	void __iomem *bar;
 	unsigned long bar_mapped_size;
 	struct mutex shutdown_lock;
+	bool adaptive_irq_polling;
 	bool subsystem;
 	u64 cmb_size;
 	bool cmb_use_sqes;
@@ -358,6 +372,18 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
+struct nvme_adaptive_poll {
+	struct hrtimer timer;		/* fires the next poll drain */
+	struct irq_poll iopoll;		/* softirq context for the drain */
+	struct nvme_queue *nvmeq;
+	u64 start_ns;			/* when the current sample/episode started */
+	u32 retry_completions;		/* completions until retry or IRQ rebaseline */
+	u32 interval_ns;		/* sampled average gap between completions */
+	u32 completions;		/* completions seen so far this sample/episode */
+	int irq;
+	u8 poll_failures;		/* consecutive rejected polling trials */
+};
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -367,7 +393,8 @@ struct nvme_queue {
 	struct nvme_descriptor_pools descriptor_pools;
 	spinlock_t sq_lock;
 	void *sq_cmds;
-	 /* only used for poll queues: */
+	struct nvme_adaptive_poll *adaptive;
+	/* Used for both poll queues and adaptive interrupt polling. */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	struct nvme_completion *cqes;
 	dma_addr_t sq_dma_addr;
@@ -386,6 +413,9 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+#define NVMEQ_ADAPTIVE_POLLING	4
+#define NVMEQ_ADAPTIVE_ENABLED	5
+#define NVMEQ_ADAPTIVE_STALE_IRQ	6
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
@@ -1606,13 +1636,12 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
-			        struct io_comp_batch *iob)
+static inline unsigned int nvme_poll_cq(struct nvme_queue *nvmeq,
+					struct io_comp_batch *iob)
 {
-	bool found = false;
+	unsigned int found = 0;
 
 	while (nvme_cqe_pending(nvmeq)) {
-		found = true;
 		/*
 		 * load-load control dependency between phase and the rest of
 		 * the cqe requires a full read memory barrier
@@ -1620,6 +1649,7 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 		dma_rmb();
 		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
+		found++;
 	}
 
 	if (found)
@@ -1627,17 +1657,22 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 	return found;
 }
 
-static irqreturn_t nvme_irq(int irq, void *data)
+/* Keep the normal completion loop branch-free. */
+static unsigned int nvme_poll_cq_bounded(struct nvme_queue *nvmeq,
+					 struct io_comp_batch *iob,
+					 unsigned int limit)
 {
-	struct nvme_queue *nvmeq = data;
-	DEFINE_IO_COMP_BATCH(iob);
+	unsigned int found = 0;
 
-	if (nvme_poll_cq(nvmeq, &iob)) {
-		if (!rq_list_empty(&iob.req_list))
-			nvme_pci_complete_batch(&iob);
-		return IRQ_HANDLED;
+	while (found < limit && nvme_cqe_pending(nvmeq)) {
+		dma_rmb();
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
+		nvme_update_cq_head(nvmeq);
+		found++;
 	}
-	return IRQ_NONE;
+	if (found)
+		nvme_ring_cq_doorbell(nvmeq);
+	return found;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
@@ -1649,6 +1684,235 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
+/* Reset adaptive state to an uninitialised IRQ baseline. */
+static void nvme_adaptive_state_reset(struct nvme_adaptive_poll *adaptive)
+{
+	adaptive->start_ns = 0;
+	adaptive->retry_completions = 0;
+	adaptive->interval_ns = 0;
+	adaptive->completions = 0;
+	adaptive->poll_failures = 0;
+}
+
+/*
+ * Restore IRQ mode.  The first two failed trials rebaseline immediately;
+ * the third backs off for 64 windows.
+ */
+static void nvme_adaptive_poll_end(struct nvme_queue *nvmeq, bool backoff)
+{
+	struct nvme_adaptive_poll *adaptive = nvmeq->adaptive;
+	u8 poll_failures = adaptive->poll_failures;
+
+	nvme_adaptive_state_reset(adaptive);
+	if (backoff) {
+		if (poll_failures < NVME_ADAPTIVE_POLL_RETRIES)
+			adaptive->poll_failures = poll_failures + 1;
+		else
+			adaptive->retry_completions =
+				NVME_ADAPTIVE_REEVAL_CQES;
+	}
+	clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+	set_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags);
+	enable_irq(adaptive->irq);
+}
+
+static void nvme_adaptive_poll_window_start(struct nvme_adaptive_poll *adaptive,
+					    u64 now)
+{
+	adaptive->start_ns = now;
+	adaptive->completions = 0;
+}
+
+static void nvme_adaptive_arm(struct nvme_adaptive_poll *adaptive, u64 now)
+{
+	hrtimer_start(&adaptive->timer,
+		      ns_to_ktime(now + NVME_ADAPTIVE_POLL_PERIOD_NS),
+		      HRTIMER_MODE_ABS_PINNED_HARD);
+}
+
+static enum hrtimer_restart nvme_adaptive_poll_timer(struct hrtimer *timer)
+{
+	struct nvme_adaptive_poll *adaptive = container_of(timer,
+					struct nvme_adaptive_poll, timer);
+	struct nvme_queue *nvmeq = adaptive->nvmeq;
+
+	if (test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))
+		irq_poll_sched(&adaptive->iopoll);
+	return HRTIMER_NORESTART;
+}
+
+/*
+ * Drain CQEs from IRQ_POLL_SOFTIRQ and compare completion progress with the
+ * IRQ baseline.  Re-arm while within the allowed lag; leave poll mode on lag
+ * or teardown, and start another window only after a faster full window.
+ */
+static int nvme_adaptive_irq_poll(struct irq_poll *iop, int budget)
+{
+	struct nvme_adaptive_poll *adaptive = container_of(iop,
+					struct nvme_adaptive_poll, iopoll);
+	struct nvme_queue *nvmeq = adaptive->nvmeq;
+	unsigned int completions, limit;
+	unsigned long flags;
+	u64 deadline, elapsed, now;
+	DEFINE_IO_COMP_BATCH(iob);
+
+	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
+	if (unlikely(!test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))) {
+		completions = 0;
+		irq_poll_complete(iop);
+		goto out;
+	}
+	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags)) {
+		completions = 0;
+		irq_poll_complete(iop);
+		nvme_adaptive_poll_end(nvmeq, false);
+		goto out;
+	}
+
+	limit = min_t(unsigned int,
+		      budget,
+		      NVME_ADAPTIVE_EPISODE_CQES - adaptive->completions);
+	completions = nvme_poll_cq_bounded(nvmeq, &iob, limit);
+	adaptive->completions += completions;
+
+	if (completions >= budget &&
+	    adaptive->completions < NVME_ADAPTIVE_EPISODE_CQES)
+		goto out;
+	irq_poll_complete(iop);
+
+	/*
+	 * Before the window fills, allow progress to trail the IRQ baseline by
+	 * two poll periods.  At the boundary, require a strictly shorter time.
+	 * interval_ns is rounded down, so equal or slower never passes.
+	 */
+	now = ktime_get_ns();
+	elapsed = now - adaptive->start_ns;
+	deadline = (u64)adaptive->completions * adaptive->interval_ns;
+	if (adaptive->completions < NVME_ADAPTIVE_EPISODE_CQES) {
+		if (elapsed > deadline +
+		    2U * NVME_ADAPTIVE_POLL_PERIOD_NS)
+			nvme_adaptive_poll_end(nvmeq, true);
+		else
+			nvme_adaptive_arm(adaptive, now);
+		goto out;
+	}
+	if (elapsed >= deadline) {
+		nvme_adaptive_poll_end(nvmeq, true);
+		goto out;
+	}
+
+	adaptive->poll_failures = 0;
+	/* Bound polling to 64 successful windows before an IRQ rebaseline. */
+	adaptive->retry_completions -= NVME_ADAPTIVE_EPISODE_CQES;
+	if (!adaptive->retry_completions) {
+		nvme_adaptive_poll_end(nvmeq, false);
+		goto out;
+	}
+	nvme_adaptive_poll_window_start(adaptive, now);
+	nvme_adaptive_arm(adaptive, now);
+out:
+	spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
+	if (!rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+	return completions;
+}
+
+/*
+ * Count down an IRQ backoff or sample at least one completion window.
+ * A polling attempt is permitted when the average interval is no
+ * greater than the poll period.
+ */
+static void nvme_adaptive_sample(struct nvme_queue *nvmeq,
+				 unsigned int completions)
+{
+	struct nvme_adaptive_poll *adaptive = nvmeq->adaptive;
+	u64 delta, interval, now;
+
+	if (adaptive->retry_completions) {
+		adaptive->retry_completions -= min(completions,
+						   adaptive->retry_completions);
+		return;
+	}
+	if (!adaptive->start_ns) {
+		adaptive->start_ns = ktime_get_ns();
+		return;
+	}
+	adaptive->completions += completions;
+	if (adaptive->completions < NVME_ADAPTIVE_EPISODE_CQES)
+		return;
+
+	now = ktime_get_ns();
+	delta = now - adaptive->start_ns;
+	/* Admission only; a full poll window decides whether polling wins. */
+	interval = div64_u64(delta, adaptive->completions);
+	if (!interval || interval > NVME_ADAPTIVE_POLL_PERIOD_NS ||
+	    !test_bit(NVMEQ_ENABLED, &nvmeq->flags)) {
+		nvme_adaptive_poll_window_start(adaptive, now);
+		return;
+	}
+
+	adaptive->interval_ns = interval;
+	adaptive->retry_completions = NVME_ADAPTIVE_REEVAL_CQES;
+	nvme_adaptive_poll_window_start(adaptive, now);
+	set_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+	disable_irq_nosync(adaptive->irq);
+	nvme_adaptive_arm(adaptive, now);
+}
+
+static irqreturn_t nvme_irq(int irq, void *data);
+
+static noinline irqreturn_t nvme_irq_adaptive_enabled(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	unsigned int completions;
+	unsigned long flags;
+	DEFINE_IO_COMP_BATCH(iob);
+
+	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
+	if (unlikely(test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))) {
+		spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
+		return IRQ_HANDLED;
+	}
+	completions = nvme_poll_cq(nvmeq, &iob);
+	if (completions)
+		nvme_adaptive_sample(nvmeq, completions);
+	spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
+	if (!completions)
+		return test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ,
+					  &nvmeq->flags) ? IRQ_HANDLED : IRQ_NONE;
+	if (!rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nvme_irq_adaptive(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	irqreturn_t ret;
+
+	if (!test_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags)) {
+		ret = nvme_irq(irq, data);
+		if (ret == IRQ_NONE &&
+		    test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags))
+			return IRQ_HANDLED;
+		return ret;
+	}
+	return nvme_irq_adaptive_enabled(irq, data);
+}
+
+static irqreturn_t nvme_irq(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	DEFINE_IO_COMP_BATCH(iob);
+
+	if (nvme_poll_cq(nvmeq, &iob)) {
+		if (!rq_list_empty(&iob.req_list))
+			nvme_pci_complete_batch(&iob);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
 /*
  * Poll for completions for any interrupt driven queue
  * Can be called from any context.
@@ -1656,30 +1920,36 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
+	unsigned long flags;
 	int irq;
 
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
 	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
 	disable_irq(irq);
-	spin_lock(&nvmeq->cq_poll_lock);
+	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
 	nvme_poll_cq(nvmeq, NULL);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
 	enable_irq(irq);
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
+	unsigned long flags;
 	bool found;
 
 	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
 	    !nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock(&nvmeq->cq_poll_lock);
+	/*
+	 * cq_poll_lock is also taken from hardirq by the adaptive handler.
+	 * Disable IRQs here so lockdep sees a consistent lock class.
+	 */
+	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
 	found = nvme_poll_cq(nvmeq, iob);
-	spin_unlock(&nvmeq->cq_poll_lock);
+	spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
 
 	return found;
 }
@@ -2017,8 +2287,7 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (!nvmeq->sq_cmds)
-		return;
-
+		goto free_adaptive;
 	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
 		pci_free_p2pmem(to_pci_dev(nvmeq->dev->dev),
 				nvmeq->sq_cmds, SQ_SIZE(nvmeq));
@@ -2026,6 +2295,9 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 		dma_free_coherent(nvmeq->dev->dev, SQ_SIZE(nvmeq),
 				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	}
+free_adaptive:
+	kfree(nvmeq->adaptive);
+	nvmeq->adaptive = NULL;
 }
 
 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
@@ -2038,9 +2310,96 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 	}
 }
 
+static int nvme_adaptive_suspend(struct nvme_queue *nvmeq)
+{
+	struct nvme_adaptive_poll *adaptive = nvmeq->adaptive;
+	unsigned long flags;
+	int irq;
+
+	if (!adaptive || adaptive->irq < 0)
+		return -1;
+	irq = adaptive->irq;
+	synchronize_irq(irq);
+	irq_poll_disable(&adaptive->iopoll);
+	/* irq_poll_complete() can run before the poll callback returns. */
+	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
+	if (test_and_clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags)) {
+		set_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags);
+		enable_irq(irq);
+	}
+	spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
+	hrtimer_cancel(&adaptive->timer);
+	return irq;
+}
+
+static void nvme_adaptive_set_queue(struct nvme_queue *nvmeq, bool enable)
+{
+	struct nvme_adaptive_poll *adaptive = nvmeq->adaptive;
+	unsigned long flags;
+
+	if (nvme_adaptive_suspend(nvmeq) < 0) {
+		clear_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
+		return;
+	}
+
+	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
+	nvme_adaptive_state_reset(adaptive);
+	if (enable)
+		set_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
+	else
+		clear_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
+	spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
+	irq_poll_enable(&adaptive->iopoll);
+}
+
+/*
+ * Freeze namespace I/O before switching completion mode.  scan_lock keeps
+ * the namespace set stable; shutdown_lock prevents concurrent reset.
+ */
+static int nvme_adaptive_switch(struct nvme_dev *dev, bool enable)
+{
+	int qid, ret = 0;
+
+	mutex_lock(&dev->ctrl.scan_lock);
+	if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_LIVE) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (enable == READ_ONCE(dev->adaptive_irq_polling))
+		goto out_unlock;
+
+	nvme_start_freeze(&dev->ctrl);
+	nvme_wait_freeze(&dev->ctrl);
+
+	mutex_lock(&dev->shutdown_lock);
+	if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_LIVE) {
+		ret = -EBUSY;
+	} else {
+		for (qid = 1; qid < dev->ctrl.queue_count; qid++)
+			nvme_adaptive_set_queue(&dev->queues[qid], enable);
+		WRITE_ONCE(dev->adaptive_irq_polling, enable);
+	}
+	mutex_unlock(&dev->shutdown_lock);
+
+	nvme_unfreeze(&dev->ctrl);
+out_unlock:
+	mutex_unlock(&dev->ctrl.scan_lock);
+	return ret;
+}
+
+static void nvme_adaptive_suspend_done(struct nvme_queue *nvmeq, int irq)
+{
+	if (irq < 0)
+		return;
+	nvmeq->adaptive->irq = -1;
+	irq_poll_enable(&nvmeq->adaptive->iopoll);
+}
+
 static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int irq;
 
 	if (!test_and_clear_bit(NVMEQ_ENABLED, &nvmeq->flags))
 		return;
@@ -2051,8 +2410,11 @@ static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		nvme_quiesce_admin_queue(&nvmeq->dev->ctrl);
-	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
-		pci_free_irq(to_pci_dev(dev->dev), nvmeq->cq_vector, nvmeq);
+	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags)) {
+		irq = nvme_adaptive_suspend(nvmeq);
+		pci_free_irq(pdev, nvmeq->cq_vector, nvmeq);
+		nvme_adaptive_suspend_done(nvmeq, irq);
+	}
 }
 
 static void nvme_suspend_io_queues(struct nvme_dev *dev)
@@ -2071,12 +2433,13 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
  */
 static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 {
+	unsigned long flags;
 	int i;
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
-		spin_lock(&dev->queues[i].cq_poll_lock);
+		spin_lock_irqsave(&dev->queues[i].cq_poll_lock, flags);
 		nvme_poll_cq(&dev->queues[i], NULL);
-		spin_unlock(&dev->queues[i].cq_poll_lock);
+		spin_unlock_irqrestore(&dev->queues[i].cq_poll_lock, flags);
 	}
 }
 
@@ -2166,18 +2529,78 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	return -ENOMEM;
 }
 
+/*
+ * Allocate or re-arm adaptive state after reset.  The caller has established
+ * MSI-X eligibility; return false if vector lookup or allocation fails.
+ */
+static bool nvme_adaptive_init(struct nvme_queue *nvmeq)
+{
+	struct nvme_adaptive_poll *adaptive = nvmeq->adaptive;
+	int irq = pci_irq_vector(to_pci_dev(nvmeq->dev->dev),
+				 nvmeq->cq_vector);
+
+	if (irq < 0)
+		return false;
+	if (!adaptive) {
+		adaptive = kzalloc_node(sizeof(*adaptive), GFP_KERNEL,
+					dev_to_node(nvmeq->dev->dev));
+		if (!adaptive)
+			return false;
+		adaptive->nvmeq = nvmeq;
+		hrtimer_setup(&adaptive->timer, nvme_adaptive_poll_timer,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+		irq_poll_init(&adaptive->iopoll, 64, nvme_adaptive_irq_poll);
+		adaptive->irq = irq;
+		WRITE_ONCE(nvmeq->adaptive, adaptive);
+		return true;
+	}
+	adaptive->irq = irq;
+	return true;
+}
+
 static int queue_request_irq(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
+	bool adaptive_queue;
+	int ret;
 
 	if (use_threaded_interrupts) {
+		clear_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
 				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	}
+	/* Install the adaptive-capable handler only on eligible queues. */
+	adaptive_queue = nvmeq->qid && nvmeq->dev->num_vecs > 1 &&
+		pdev->msix_enabled;
+	if (adaptive_queue)
+		adaptive_queue = nvme_adaptive_init(nvmeq);
+	if (adaptive_queue && READ_ONCE(nvmeq->dev->adaptive_irq_polling))
+		set_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
+	else
+		clear_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
+	ret = pci_request_irq(pdev, nvmeq->cq_vector,
+			      adaptive_queue ? nvme_irq_adaptive : nvme_irq,
+			      NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+	if (!adaptive_queue || ret) {
+		clear_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
+		if (ret && nvmeq->adaptive)
+			nvmeq->adaptive->irq = -1;
+	}
+	return ret;
+}
+
+static void nvme_adaptive_reset(struct nvme_queue *nvmeq)
+{
+	struct nvme_adaptive_poll *adaptive = nvmeq->adaptive;
+
+	clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+	clear_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags);
+	clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags);
+	if (!adaptive)
+		return;
+	nvme_adaptive_state_reset(adaptive);
+	adaptive->irq = -1;
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -2188,6 +2611,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
+	nvme_adaptive_reset(nvmeq);
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
 	nvme_dbbuf_init(dev, nvmeq, qid);
@@ -2808,6 +3232,33 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(hmb);
 
+static ssize_t adaptive_irq_polling_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%d\n", READ_ONCE(ndev->adaptive_irq_polling));
+}
+
+static ssize_t adaptive_irq_polling_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+	ret = nvme_adaptive_switch(ndev, enable);
+	if (ret)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(adaptive_irq_polling);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
@@ -2823,6 +3274,8 @@ static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 	}
 	if (a == &dev_attr_hmb.attr && !ctrl->hmpre)
 		return 0;
+	if (a == &dev_attr_adaptive_irq_polling.attr && use_threaded_interrupts)
+		return 0;
 
 	return a->mode;
 }
@@ -2832,6 +3285,7 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_adaptive_irq_polling.attr,
 	NULL,
 };
 
@@ -3685,6 +4139,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
+	dev->adaptive_irq_polling = use_adaptive_irq_polling;
 
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
-- 
2.39.5 (Apple Git-154)

