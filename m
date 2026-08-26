Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D130BC61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:Cc:
	References:Content-Transfer-Encoding:Message-Id:To:Mime-Version:From:Date:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LfY+t+OzhVpgMOFox7Y98et2LGNcBNB/IvOCh21ucLc=; b=GmQoJYRx/agr9wH4tWOTK5uYZq
	LjOF0fyX/LyRstSQpjZ4/1LcmtSlSbNhhTFfCOQT2xpmUVRzl4ulp9sVyvcDYcbqq7sOZ67QxB+Da
	17MFDTp+a/mkS2hT8dK2P+K6M/cQg/vFNLMuu7JjKBeur/etCe48yo+w2U+KfVx1EKhtchD0Lekd7
	FCFv6TLT/4+a4rQue22q4LeUygGXDNoccSVSbQqtlrlZvAt1KJBUyrlMAn7HdudgQ5Pk4JffBKW2s
	YDKxtUwJoVt9p4mfdB6bVOwJ8GG5NahalA6lOvqrPJ+6B+uufQf/mM3Ryc74bN9sumu66cBXbhr9D
	+EwQ321Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz6xD-00000001xUV-0yvl;
	Wed, 26 Aug 2026 06:17:43 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz6x9-00000001xU7-3Ds3
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 06:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787725049; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=LfY+t+OzhVpgMOFox7Y98et2LGNcBNB/IvOCh21ucLc=;
 b=kKSd6/ebTpXZXqQu8Rirgjk2RPXllMyTbPBa862ULCxE7m3YkvmBg8Y4ucNLVo3Y1N4vk+
 IHWAE1U8QIBMo30VRmU1VhvUt44qAq41vKBwKyf9Ado+Rb6X+PW0GwRAAnNiGQXjjTbRtt
 4GjOBEwL2HFfvVoRKsJSTqP3j0s9xjZy5x08XyQzjW3H3U8h3xdRF7C9AZ+kzeeNzeB8jv
 s8T6PrZMk2QLcVosdcfGU6ENPzFsyAU7caSFL5WoaI2IbrgisSlAPnW7DfKYZOM82/QXGe
 jf4Af4vEZ9elYNri6Hlx3mP99bzok3IzUXvCcmUK3Fn7E6GhGw5UUxclmXNKZQ==
Subject: [PATCH v2 2/2] nvme-pci: add adaptive interrupt polling
Date: Wed, 26 Aug 2026 14:15:46 +0800
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
From: "Fengnan Chang" <changfengnan@bytedance.com>
Mime-Version: 1.0
To: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, <anuj1072538@gmail.com>
Message-Id: <20260826061546.56006-3-changfengnan@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <20260826061546.56006-1-changfengnan@bytedance.com>
Cc: <guzebing@bytedance.com>, "Fengnan Chang" <changfengnan@bytedance.com>
In-Reply-To: <20260826061546.56006-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Lms-Return-Path: <lba+26a8e84f7+08dc46+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_231739_961210_D41EDC8E 
X-CRM114-Status: GOOD (  31.37  )
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

At high IOPS, interrupt handling can limit throughput, especially when
multiple drives contend for CPU time.

Add an opt-in adaptive policy for I/O queues that use a dedicated MSI-X
vector and do not use threaded interrupts. Each queue independently
switches between interrupt and poll mode based on its recent completion
rate.

In interrupt mode, wait for at least 8192 completions. If they arrive
no more than 10 us apart on average, try polling. While polling, an
hrtimer runs irq_poll to drain the completion queue. Before a window
is full, polling may fall 20 us behind the interrupt-mode pace. After
8192 completions, polling must be strictly faster than interrupt mode.

If a try fails, go back to interrupt mode and measure again. After
three failures in a row, stay in interrupt mode for 64 windows of
completions before measuring again. If polling works, keep it for at
most 64 windows, then go back to interrupt mode and measure again.

The module parameter is off by default and only sets the initial
mode for new controllers. A per-controller sysfs file can change
the mode later. The change freezes the namespace queues and waits
for in-flight I/O to finish. Queues that use threaded, MSI, or
legacy interrupts keep the regular interrupt handler.

Measured with 4 KiB random reads on Solidigm SB5PH27X076T, adaptive
polling on versus off:
                                     QD32      QD64      QD128
one device, one job                 -0.08%    +31.56%   +30.95%
fifteen devices, eight jobs/device  +188.03%  +236.46%  +231.38%

The fifteen-device aggregate with eight jobs per device increases
from 13.48M / 13.47M / 13.47M IOPS to 38.83M / 45.31M / 44.64M IOPS.

Link: https://lore.kernel.org/linux-nvme/d9210bcdf73fbe1ac8b6ec132865609a3ed68688.ff265e95.1296.491e.89f9.8ae888a03346@bytedance.com/T/#mea881a7898c85b73992f568864001913cb456d59
Link: https://lore.kernel.org/linux-nvme/20260806031058.40176-1-changfengnan@bytedance.com/T/#u
Signed-off-by: Guzebing <guzebing@bytedance.com>
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 Documentation/ABI/testing/sysfs-nvme |  17 +
 drivers/nvme/host/Kconfig            |   1 +
 drivers/nvme/host/pci.c              | 517 ++++++++++++++++++++++++++-
 3 files changed, 521 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testing/sysfs-nvme
index 499d5f843cd43..eb9df624a8a07 100644
--- a/Documentation/ABI/testing/sysfs-nvme
+++ b/Documentation/ABI/testing/sysfs-nvme
@@ -11,3 +11,20 @@ Description:
 		(REPLACETLSPSK) with the target. After a reauthentication
 		the value returned by tls_configured_key will be the new
 		serial.
+
+What:		/sys/class/nvme/nvmeX/adaptive_irq_polling
+Date:		August 2026
+KernelVersion:	7.3
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		Set the adaptive IRQ polling policy (0 or 1) for eligible
+		I/O queues of one PCI NVMe controller. Reading returns the
+		policy, not whether a queue is currently polling. Changing it
+		freezes the namespace request queues and waits for outstanding
+		namespace I/O. Writes fail with EBUSY unless the controller is
+		live.
+
+		Eligible queues use non-threaded MSI-X with a dedicated vector.
+		The attribute is unavailable with threaded interrupts. The
+		module parameter supplies only the initial policy for new
+		controllers.
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
index 620d0430601e3..f7f30eb196633 100644
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
@@ -82,6 +85,37 @@ struct quirk_entry {
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
 
+static bool use_adaptive_irq_polling;
+module_param(use_adaptive_irq_polling, bool, 0444);
+MODULE_PARM_DESC(use_adaptive_irq_polling,
+		 "default adaptive polling policy for eligible I/O queues");
+
+/*
+ * The constants below balance how quickly a queue reacts to load changes
+ * against how stable its measured completion rate is.
+ *
+ * The 10 us poll period plays two roles.  As an admission threshold it gates
+ * entry to poll mode: 10 us per completion maps to 100k completions/s, and
+ * below that rate interrupts already keep up, so only busier queues qualify.
+ * As a poll interval it targets ~10 us between polls once polling is active --
+ * a goal, not a hard bound, since scheduling delay can stretch it -- which is
+ * tolerable for Gen5/Gen6 random reads.
+ *
+ * The large 8192-CQE window makes the rate estimate robust: averaging over many
+ * CQEs absorbs short bursts and stalls, so jitter does not trip a false
+ * fallback to interrupt mode, at the cost of a slower reaction to genuine rate
+ * changes.
+ *
+ * The 64-window budget serves two roles depending on mode: in poll mode it bounds
+ * a single polling run before rebaselining via IRQ; in IRQ mode it is the backoff
+ * endured after repeated rejections.  The first two rejections rebaseline
+ * immediately; only the third arms that backoff.
+ */
+#define NVME_ADAPTIVE_POLL_PERIOD_NS	(10U * NSEC_PER_USEC)
+#define NVME_ADAPTIVE_WINDOW_CQES	8192U
+#define NVME_ADAPTIVE_REEVAL_CQES	(64U * NVME_ADAPTIVE_WINDOW_CQES)
+#define NVME_ADAPTIVE_POLL_RETRIES	2U
+
 static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
@@ -307,6 +341,7 @@ struct nvme_dev {
 	void __iomem *bar;
 	unsigned long bar_mapped_size;
 	struct mutex shutdown_lock;
+	bool adaptive_irq_polling;
 	bool subsystem;
 	u64 cmb_size;
 	bool cmb_use_sqes;
@@ -358,6 +393,28 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
+struct nvme_adaptive_poll {
+	/* Fires the next poll drain. */
+	struct hrtimer timer;
+	/* Softirq context for the drain. */
+	struct irq_poll iopoll;
+	struct nvme_queue *nvmeq;
+	/* When the current sample or episode started. */
+	u64 start_ns;
+	/*
+	 * Dual-purpose completion countdown: an IRQ-mode backoff before the
+	 * next sample, or the remaining budget of a successful polling episode.
+	 */
+	u32 retry_completions;
+	/* Sampled average gap between completions. */
+	u32 interval_ns;
+	/* Completions seen so far in this sample or episode. */
+	u32 completions;
+	int irq;
+	/* Consecutive rejected polling trials. */
+	u8 poll_failures;
+};
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -367,7 +424,8 @@ struct nvme_queue {
 	struct nvme_descriptor_pools descriptor_pools;
 	spinlock_t sq_lock;
 	void *sq_cmds;
-	 /* only used for poll queues: */
+	struct nvme_adaptive_poll *adaptive;
+	/* Used for poll queues and adaptive interrupt polling. */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	struct nvme_completion *cqes;
 	dma_addr_t sq_dma_addr;
@@ -386,6 +444,12 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+/* currently in poll mode with this queue's IRQ disabled */
+#define NVMEQ_ADAPTIVE_POLLING	4
+/* adaptive policy selected for this queue; picks the interrupt handler */
+#define NVMEQ_ADAPTIVE_ENABLED	5
+/* swallow one stale IRQ latched while switching back from poll mode */
+#define NVMEQ_ADAPTIVE_STALE_IRQ	6
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
@@ -1627,6 +1691,28 @@ static inline unsigned int nvme_poll_cq(struct nvme_queue *nvmeq,
 	return found;
 }
 
+/*
+ * Honor the irq_poll budget without adding a limit check to the unbounded
+ * completion path used by the regular interrupt handler.
+ */
+static unsigned int nvme_poll_cq_bounded(struct nvme_queue *nvmeq,
+					 struct io_comp_batch *iob,
+					 unsigned int limit)
+{
+	unsigned int found = 0;
+
+	while (found < limit && nvme_cqe_pending(nvmeq)) {
+		dma_rmb();
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
+		nvme_update_cq_head(nvmeq);
+		found++;
+	}
+
+	if (found)
+		nvme_ring_cq_doorbell(nvmeq);
+	return found;
+}
+
 static irqreturn_t nvme_irq_complete_batch(struct io_comp_batch *iob,
 					   unsigned int completions)
 {
@@ -1654,6 +1740,218 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
+/* Reset adaptive state to an uninitialized IRQ baseline. */
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
+ * Restore IRQ mode.  Back off for 64 windows after the third consecutive
+ * rejection; otherwise rebaseline immediately.
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
+	struct nvme_adaptive_poll *adaptive =
+		container_of(timer, struct nvme_adaptive_poll, timer);
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
+	struct nvme_adaptive_poll *adaptive =
+		container_of(iop, struct nvme_adaptive_poll, iopoll);
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
+	limit = min_t(unsigned int, budget,
+		      NVME_ADAPTIVE_WINDOW_CQES - adaptive->completions);
+	completions = nvme_poll_cq_bounded(nvmeq, &iob, limit);
+	adaptive->completions += completions;
+
+	if (completions >= budget &&
+	    adaptive->completions < NVME_ADAPTIVE_WINDOW_CQES)
+		goto out;
+	if (completions < budget)
+		irq_poll_complete(iop);
+
+	/*
+	 * Before the window fills, allow progress to trail the IRQ baseline by
+	 * two poll periods.  At the boundary, require a strictly shorter time.
+	 * interval_ns is rounded down, so equal or slower never passes.
+	 */
+	now = ktime_get_ns();
+	elapsed = now - adaptive->start_ns;
+	deadline = (u64)adaptive->completions * adaptive->interval_ns;
+	if (adaptive->completions < NVME_ADAPTIVE_WINDOW_CQES) {
+		if (elapsed > deadline + 2U * NVME_ADAPTIVE_POLL_PERIOD_NS)
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
+	/*
+	 * Here retry_completions is the polling-episode budget: spend one
+	 * window and rebaseline via IRQ once the 64-window episode is used up.
+	 */
+	adaptive->retry_completions -= NVME_ADAPTIVE_WINDOW_CQES;
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
+		/* Here retry_completions is the IRQ backoff before resampling. */
+		adaptive->retry_completions -= min(completions,
+						   adaptive->retry_completions);
+		return;
+	}
+	if (!adaptive->start_ns) {
+		adaptive->start_ns = ktime_get_ns();
+		return;
+	}
+	adaptive->completions += completions;
+	if (adaptive->completions < NVME_ADAPTIVE_WINDOW_CQES)
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
+	return nvme_irq_complete_batch(&iob, completions);
+}
+
+static irqreturn_t nvme_irq_adaptive(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	irqreturn_t ret;
+
+	if (test_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags))
+		ret = nvme_irq_adaptive_enabled(irq, data);
+	else
+		ret = nvme_irq(irq, data);
+	if (ret == IRQ_NONE &&
+	    test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags))
+		return IRQ_HANDLED;
+	return ret;
+}
+
 /*
  * Poll for completions for any interrupt driven queue
  * Can be called from any context.
@@ -1661,30 +1959,36 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
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
@@ -2022,8 +2326,7 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (!nvmeq->sq_cmds)
-		return;
-
+		goto free_adaptive;
 	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
 		pci_free_p2pmem(to_pci_dev(nvmeq->dev->dev),
 				nvmeq->sq_cmds, SQ_SIZE(nvmeq));
@@ -2031,6 +2334,9 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 		dma_free_coherent(nvmeq->dev->dev, SQ_SIZE(nvmeq),
 				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	}
+free_adaptive:
+	kfree(nvmeq->adaptive);
+	nvmeq->adaptive = NULL;
 }
 
 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
@@ -2043,9 +2349,96 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
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
@@ -2056,8 +2449,11 @@ static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
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
@@ -2076,12 +2472,13 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
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
 
@@ -2171,18 +2568,78 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
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
@@ -2193,6 +2650,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
+	nvme_adaptive_reset(nvmeq);
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
 	nvme_dbbuf_init(dev, nvmeq, qid);
@@ -2813,6 +3271,33 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
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
@@ -2828,6 +3313,8 @@ static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 	}
 	if (a == &dev_attr_hmb.attr && !ctrl->hmpre)
 		return 0;
+	if (a == &dev_attr_adaptive_irq_polling.attr && use_threaded_interrupts)
+		return 0;
 
 	return a->mode;
 }
@@ -2837,6 +3324,7 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_adaptive_irq_polling.attr,
 	NULL,
 };
 
@@ -3690,6 +4178,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
+	dev->adaptive_irq_polling = use_adaptive_irq_polling;
 
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
-- 
2.39.5 (Apple Git-154)

