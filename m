Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA028C55ABA
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 03:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Cc:Subject:From
	:Content-Type:Message-Id:Date:Content-Transfer-Encoding:To:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TTmCYAkcC8H3ZWOG0oEfkJZ2Kr2iYpJHR2d7gHY67SM=; b=G6JtgJC31EFP1xw7rlrgB73BXu
	3Y8uqyLREq70P7jdBmnX8c0AjsBgDowtvCw/cIF46uCWKFiVF92jc4EAZHtnBgUzg15xkpCYsBPj+
	0GE8qVhHC11VM9Hiamoezy2/qRAZaf+MXKHrZH1LQ+NSpojG8zba6QicG2BoP5VHJXdoqcY5LOaa7
	/bMYFQdn2W2eLYk+HHssqtevvmBRRwmJNiX67c+owZHu3oD+ypQcE0EWjQEvL6XXHp+qmCtBUKv6v
	M7KL3AQisaGPshh9YGoYxtSAaQvO+L7QkV5AzvFpT+e0kYENgzj36gAN+FV0gc6u/WxCBCZFTxFPK
	/JIth5iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wroWB-00000004rLV-12AF;
	Thu, 06 Aug 2026 03:11:39 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wroW8-00000004rL7-3IHG
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 03:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785985889; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TTmCYAkcC8H3ZWOG0oEfkJZ2Kr2iYpJHR2d7gHY67SM=;
 b=gjTt+VI+dUC3S+22r4xWsnHzoz1fSrG1IugaiGE2E3stuNI+C7/2TQ6H21rh9WjB0ejMpo
 yVN2s6tfaMs7Vo4m+x3jbzz2nFVbvZZP4C5KKS7daohM7MVsiajIl4ETL1bgaN1aSSJbzO
 Gn+Jr199pgRthntfeVdMKcV4/LmsNMIwEPj8Ak0kABF1Un0akJbb8DPWafjLZ8+oSkk5sh
 ski/5SLL/7d3bIGGEPKZVtzFX9Zvsn3HxF2OUHoILYZWtMo6DQEn1pklPdOoETCmTug2Uo
 jO22EUkpIP+H8L1cgGV4KsTCpcF5DIYDXdUCJjtLeVv1qhubKwfX4ff69yHZFw==
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Date: Thu,  6 Aug 2026 11:10:58 +0800
Message-Id: <20260806031058.40176-1-changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a73fb5f+03eea0+lists.infradead.org+changfengnan@bytedance.com>
From: "Fengnan Chang" <changfengnan@bytedance.com>
Subject: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
Cc: <linux-kernel@vger.kernel.org>, 
	"Fengnan Chang" <changfengnan@bytedance.com>, 
	"Guzebing" <guzebing@bytedance.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_201136_953265_2F8FB668 
X-CRM114-Status: GOOD (  38.10  )
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

The idea behind this approach is: Let each I/O queue switch itself between
interrupt and poll mode based on its own recent completion rate.

This version is still in the testing phase, and there are still some issues
with the code implementation.  I releasing it now to see if the approach
is generally acceptable.  If the approach looks good, I=E2=80=99ll continue=
 to
refine it and conduct more extensive testing.  The main implementation
logic is in `nvme_adaptive_sample` and `nvme_adaptive_irq_poll`; you should
focus on reviewing the implementation of these two functions.

Compared to the previous version, this represents a much smaller
performance regression while offering greater benefits.

In high-IOPS scenarios, relying on interrupts to handle I/O operations
can limit performance. This issue becomes particularly pronounced in
multi-disk environments, where performance is constrained by the CPU's
interrupt-handling capacity.

Each Solidigm SB5PH27X038T device used for testing can deliver about 3.2M
4 KiB random-read IOPS.  Four of them should be good for about 12.8M IOPS,
but interrupt-driven completion tops out at 5.59M, only about 44% of that.

Polling gets rid of that cost, but polling every queue all the time burns
CPU and hurts the sparse or bursty queues that interrupts handle just fine.
So instead of a global switch, let each queue make the call on its own,
from how fast it has been completing lately, and re-check often enough that
the decision tracks the workload rather than a fixed tunable.

Each queue runs a small loop with three stages.  First it samples its
completion rate while still on interrupts.  Only if that rate is high
enough to fill a small batch inside a bounded latency window does it mask
its own IRQ and start draining the CQ from a high-resolution timer, with
each wait sized to collect roughly one batch.  It keeps polling as long as
it keeps up with that rate; the moment it stalls or slows down it turns the
IRQ back on and backs off, waiting longer the further behind it fell.
A queue that doesn't benefit drops back quickly and only gets retried once
in a while, so polling stays on the queues that are actually
interrupt-bound and everything else keeps running on the untouched IRQ
path.

Measured with 4 KiB random reads on Solidigm SB5PH27X038T, adaptive on
versus off:

                                   QD32      QD64      QD128
  one device, one job             +18.44%   +24.35%   +26.38%
  four devices, eight jobs        +83.76%   +99.02%   +96.26%

The four-device eight-job aggregate goes from 5.59M IOPS (44% of the 12.8M
ceiling) to 10.89M IOPS (85%).  Tail latency improves too: QD64 p99 drops
from 1073 us to 498 us (-54%) and p99.9 from 1909 us to 741 us (-61%).
Interrupts per I/O drop from about 0.91 to 0.08 (~12x fewer) in the
four-device case, and from 0.96 to 0.03 (~33x fewer) on a single high-QD
queue.

Link:https://lore.kernel.org/linux-nvme/d9210bcdf73fbe1ac8b6ec132865609a3ed=
68688.ff265e95.1296.491e.89f9.8ae888a03346@bytedance.com/T/#mea881a7898c85b=
73992f568864001913cb456d59
Signed-off-by: Guzebing <guzebing@bytedance.com>
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/pci.c   | 468 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 452 insertions(+), 17 deletions(-)

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
index 69932d640b537..18559dd16b752 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -10,9 +10,13 @@
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
 #include <linux/dmi.h>
+#include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq_poll.h>
+#include <linux/jump_label.h>
+#include <linux/ktime.h>
 #include <linux/kstrtox.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
@@ -82,6 +86,57 @@ struct quirk_entry {
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
=20
+static DEFINE_STATIC_KEY_FALSE(nvme_adaptive_irq_polling_key);
+static bool use_adaptive_irq_polling;
+
+static int nvme_adaptive_irq_polling_set(const char *val,
+					 const struct kernel_param *kp)
+{
+	int ret =3D param_set_bool(val, kp);
+
+	if (ret)
+		return ret;
+	if (use_adaptive_irq_polling)
+		static_branch_enable(&nvme_adaptive_irq_polling_key);
+	else
+		static_branch_disable(&nvme_adaptive_irq_polling_key);
+	return 0;
+}
+
+static const struct kernel_param_ops nvme_adaptive_irq_polling_ops =3D {
+	.set =3D nvme_adaptive_irq_polling_set,
+	.get =3D param_get_bool,
+};
+
+module_param_cb(use_adaptive_irq_polling, &nvme_adaptive_irq_polling_ops,
+		&use_adaptive_irq_polling, 0644);
+MODULE_PARM_DESC(use_adaptive_irq_polling,
+		 "enable adaptive polling on non-threaded MSI-X I/O queues");
+
+/*
+ * Adaptive IRQ polling flips a busy interrupt-driven queue over to a
+ * timer-based poll path and back, based only on how fast that queue is
+ * completing.  Each queue goes through three stages:
+ *
+ *  1. Sample (still in IRQ mode): count completions over
+ *     NVME_ADAPTIVE_SAMPLE_CQES interrupts and work out the average gap
+ *     between them.  If the queue is too slow to fill a batch within
+ *     NVME_ADAPTIVE_MAX_DELAY_NS, or already fast enough to batch on its =
own,
+ *     leave it alone on the normal IRQ path.
+ *  2. Poll: mask the queue's IRQ and drain the CQ from an hrtimer, arming
+ *     each wait for NVME_ADAPTIVE_TARGET_BATCH gaps (but never less than =
2 us
+ *     or more than NVME_ADAPTIVE_MAX_DELAY_NS).  Keep polling as long as =
the
+ *     queue keeps up, up to NVME_ADAPTIVE_EPISODE_CQES completions.
+ *  3. Back off: once a queue falls behind, go back to IRQ mode and skip t=
he
+ *     next deficit * NVME_ADAPTIVE_BACKOFF_MULT completions before sampli=
ng
+ *     it again.  Queues that don't benefit get retried only now and then.
+ */
+#define NVME_ADAPTIVE_TARGET_BATCH	5U
+#define NVME_ADAPTIVE_SAMPLE_CQES	256U
+#define NVME_ADAPTIVE_MAX_DELAY_NS	(10U * NSEC_PER_USEC)
+#define NVME_ADAPTIVE_EPISODE_CQES	(32U * NVME_ADAPTIVE_SAMPLE_CQES)
+#define NVME_ADAPTIVE_BACKOFF_MULT	20U
+
 static bool use_cmb_sqes =3D true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQe=
s");
@@ -358,6 +413,25 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme=
_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
=20
+/*
+ * Per-queue adaptive polling state.  This sits outside struct nvme_queue =
on
+ * purpose, so the completion path's layout doesn't change when the featur=
e is
+ * built in but not used.  @lock covers every field below; it's separate f=
rom
+ * the legacy polling lock because the two paths never touch the same queu=
e at
+ * the same time.
+ */
+struct nvme_adaptive_poll {
+	struct hrtimer timer;		/* fires the next poll drain */
+	struct irq_poll iopoll;		/* softirq context for the drain */
+	struct nvme_queue *nvmeq;
+	spinlock_t lock;
+	u64 start_ns;			/* when the current sample/episode started */
+	u64 retry_completions;		/* IRQ completions to skip before sampling again =
*/
+	u32 interval_ns;		/* average gap between completions, last sample */
+	u32 completions;		/* completions seen so far this sample/episode */
+	int irq;
+};
+
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
@@ -367,7 +441,8 @@ struct nvme_queue {
 	struct nvme_descriptor_pools descriptor_pools;
 	spinlock_t sq_lock;
 	void *sq_cmds;
-	 /* only used for poll queues: */
+	struct nvme_adaptive_poll *adaptive;
+	/* Only used for poll queues. */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	struct nvme_completion *cqes;
 	dma_addr_t sq_dma_addr;
@@ -386,6 +461,8 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+#define NVMEQ_ADAPTIVE_POLLING	4
+#define NVMEQ_ADAPTIVE_STALE_IRQ	5
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
@@ -1606,13 +1683,12 @@ static inline void nvme_update_cq_head(struct nvme_=
queue *nvmeq)
 	}
 }
=20
-static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
-			        struct io_comp_batch *iob)
+static inline unsigned int nvme_poll_cq(struct nvme_queue *nvmeq,
+					struct io_comp_batch *iob)
 {
-	bool found =3D false;
+	unsigned int found =3D 0;
=20
 	while (nvme_cqe_pending(nvmeq)) {
-		found =3D true;
 		/*
 		 * load-load control dependency between phase and the rest of
 		 * the cqe requires a full read memory barrier
@@ -1620,6 +1696,7 @@ static inline bool nvme_poll_cq(struct nvme_queue *nv=
meq,
 		dma_rmb();
 		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
+		found++;
 	}
=20
 	if (found)
@@ -1627,6 +1704,258 @@ static inline bool nvme_poll_cq(struct nvme_queue *=
nvmeq,
 	return found;
 }
=20
+/* Keep the normal completion loop branch-free. */
+static unsigned int nvme_poll_cq_bounded(struct nvme_queue *nvmeq,
+					 struct io_comp_batch *iob,
+					 unsigned int limit)
+{
+	unsigned int found =3D 0;
+
+	while (found < limit && nvme_cqe_pending(nvmeq)) {
+		dma_rmb();
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
+		nvme_update_cq_head(nvmeq);
+		found++;
+	}
+	if (found)
+		nvme_ring_cq_doorbell(nvmeq);
+	return found;
+}
+
+static irqreturn_t nvme_irq_check(int irq, void *data)
+{
+	struct nvme_queue *nvmeq =3D data;
+
+	if (nvme_cqe_pending(nvmeq))
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
+}
+
+static bool nvme_adaptive_enabled(struct nvme_queue *nvmeq)
+{
+	return READ_ONCE(use_adaptive_irq_polling) &&
+		test_bit(NVMEQ_ENABLED, &nvmeq->flags);
+}
+
+/*
+ * Stop polling and turn the queue's IRQ back on.  @elapsed is how long th=
e
+ * episode ran after it started falling behind, or 0 if it ended cleanly.
+ * The bigger @elapsed is, the more completions we missed, and the longer =
we
+ * wait before sampling this queue again, so a queue that polling doesn't
+ * help is left alone most of the time.
+ */
+static void nvme_adaptive_poll_end(struct nvme_queue *nvmeq, u64 elapsed)
+{
+	struct nvme_adaptive_poll *adaptive =3D nvmeq->adaptive;
+	u64 deficit =3D 0;
+
+	if (elapsed) {
+		deficit =3D div64_u64(elapsed - 1, adaptive->interval_ns) + 1;
+		deficit -=3D min_t(u64, deficit, adaptive->completions);
+	}
+	adaptive->retry_completions =3D
+		deficit > U64_MAX / NVME_ADAPTIVE_BACKOFF_MULT ? U64_MAX :
+		deficit * NVME_ADAPTIVE_BACKOFF_MULT;
+	adaptive->start_ns =3D 0;
+	adaptive->completions =3D 0;
+	set_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags);
+	clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+	enable_irq(adaptive->irq);
+}
+
+/*
+ * Set the poll timer to fire one batch from now: how long the sampled
+ * rate needs to produce NVME_ADAPTIVE_TARGET_BATCH completions.
+ */
+static void nvme_adaptive_arm(struct nvme_adaptive_poll *adaptive, u64 now=
)
+{
+	u64 delay =3D clamp_t(u64,
+		(u64)adaptive->interval_ns * NVME_ADAPTIVE_TARGET_BATCH,
+		2U * NSEC_PER_USEC, NVME_ADAPTIVE_MAX_DELAY_NS);
+
+	hrtimer_start(&adaptive->timer,
+		      ns_to_ktime(now + delay), HRTIMER_MODE_ABS_PINNED_HARD);
+}
+
+static enum hrtimer_restart nvme_adaptive_poll_timer(struct hrtimer *timer=
)
+{
+	struct nvme_adaptive_poll *adaptive =3D container_of(timer,
+					struct nvme_adaptive_poll, timer);
+	struct nvme_queue *nvmeq =3D adaptive->nvmeq;
+
+	if (test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))
+		irq_poll_sched(&adaptive->iopoll);
+	return HRTIMER_NORESTART;
+}
+
+/*
+ * The poll drain, run from softirq when the timer fires.  Reap some CQEs,=
 then
+ * pick one of three things: stop if we hit the episode cap, wait again if=
 the
+ * queue is keeping up, or go back to IRQ mode if it went idle or slowed d=
own.
+ */
+static int nvme_adaptive_irq_poll(struct irq_poll *iop, int budget)
+{
+	struct nvme_adaptive_poll *adaptive =3D container_of(iop,
+					struct nvme_adaptive_poll, iopoll);
+	struct nvme_queue *nvmeq =3D adaptive->nvmeq;
+	unsigned int completions, limit;
+	unsigned long flags;
+	bool on_schedule;
+	u64 elapsed, now;
+	DEFINE_IO_COMP_BATCH(iob);
+
+	spin_lock_irqsave(&adaptive->lock, flags);
+	if (unlikely(!test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))) {
+		completions =3D 0;
+		irq_poll_complete(iop);
+		goto out;
+	}
+
+	limit =3D min_t(unsigned int,
+		      budget - !nvme_adaptive_enabled(nvmeq),
+		      NVME_ADAPTIVE_EPISODE_CQES - adaptive->completions);
+	completions =3D nvme_poll_cq_bounded(nvmeq, &iob, limit);
+	adaptive->completions +=3D completions;
+	if (!rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+
+	if (completions >=3D budget)
+		goto out;
+	irq_poll_complete(iop);
+
+	if (!nvme_adaptive_enabled(nvmeq)) {
+		nvme_adaptive_poll_end(nvmeq, 0);
+		goto out;
+	}
+
+	/*
+	 * Only keep polling if the queue is still hitting the sampled rate.
+	 * MAX_DELAY leaves room for one empty wait, so a queue that's still
+	 * completing keeps polling; one that stalled or slowed down goes back
+	 * to IRQ mode and backs off.
+	 */
+	now =3D ktime_get_ns();
+	elapsed =3D now - adaptive->start_ns;
+	on_schedule =3D elapsed <=3D (u64)adaptive->completions *
+		adaptive->interval_ns + NVME_ADAPTIVE_MAX_DELAY_NS;
+	if (adaptive->completions >=3D NVME_ADAPTIVE_EPISODE_CQES)
+		nvme_adaptive_poll_end(nvmeq, on_schedule ? 0 : elapsed);
+	else if (on_schedule)
+		nvme_adaptive_arm(adaptive, now);
+	else
+		nvme_adaptive_poll_end(nvmeq, elapsed);
+out:
+	spin_unlock_irqrestore(&adaptive->lock, flags);
+	return completions;
+}
+
+/*
+ * Called from the IRQ handler after a reap that found something.  If we'r=
e
+ * still in backoff, just count it down.  Otherwise time how long
+ * NVME_ADAPTIVE_SAMPLE_CQES completions take to get the average gap betwe=
en
+ * them.  If that looks worth polling (see the filter below) mask the IRQ =
and
+ * switch to poll mode; if not, leave the queue on interrupts.
+ */
+static void nvme_adaptive_sample(struct nvme_queue *nvmeq,
+				 unsigned int completions)
+{
+	struct nvme_adaptive_poll *adaptive =3D nvmeq->adaptive;
+	unsigned int sample;
+	unsigned long flags;
+	u64 delta, interval, now;
+
+	if (adaptive->retry_completions) {
+		if (adaptive->retry_completions !=3D U64_MAX)
+			adaptive->retry_completions -=3D min_t(u64, completions,
+							 adaptive->retry_completions);
+		return;
+	}
+	if (!adaptive->start_ns) {
+		adaptive->start_ns =3D ktime_get_ns();
+		return;
+	}
+	adaptive->completions +=3D completions;
+	if (adaptive->completions < NVME_ADAPTIVE_SAMPLE_CQES)
+		return;
+
+	now =3D ktime_get_ns();
+	delta =3D now - adaptive->start_ns;
+	sample =3D adaptive->completions;
+	adaptive->start_ns =3D now;
+	adaptive->completions =3D 0;
+	if (!delta || delta > (u64)NVME_ADAPTIVE_SAMPLE_CQES *
+			       NVME_ADAPTIVE_MAX_DELAY_NS)
+		return;
+	/*
+	 * Is this rate worth polling?  The 100/99 factor trims 1% off the gap so
+	 * a queue sitting right on the threshold isn't pulled in.  Skip it if
+	 * it's too slow to fill a batch within MAX_DELAY, and also skip it if
+	 * it's already fast enough to batch by itself.  The hardware's own
+	 * coalescing already handles that case, so leave it on interrupts.
+	 */
+	interval =3D div64_u64(delta * 100, sample * 99);
+	if (!interval || interval > NVME_ADAPTIVE_MAX_DELAY_NS ||
+	    (delta > NSEC_PER_MSEC &&
+	     interval <=3D NVME_ADAPTIVE_MAX_DELAY_NS /
+			 NVME_ADAPTIVE_TARGET_BATCH))
+		return;
+
+	spin_lock_irqsave(&adaptive->lock, flags);
+	if (nvme_adaptive_enabled(nvmeq)) {
+		adaptive->interval_ns =3D interval;
+		set_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+		disable_irq_nosync(adaptive->irq);
+		nvme_adaptive_arm(adaptive, now);
+	}
+
+	spin_unlock_irqrestore(&adaptive->lock, flags);
+}
+
+static irqreturn_t nvme_irq(int irq, void *data);
+
+/*
+ * IRQ handler for queues that may switch to adaptive polling.  It reaps t=
he CQ
+ * like the normal handler, then feeds the count to the sampler, which may=
 flip
+ * the queue into poll mode.  An empty CQ right after an IRQ we masked our=
selves
+ * (NVMEQ_ADAPTIVE_STALE_IRQ) is still ours to ack.
+ */
+static noinline irqreturn_t nvme_irq_adaptive_enabled(int irq, void *data)
+{
+	struct nvme_queue *nvmeq =3D data;
+	unsigned int completions;
+	DEFINE_IO_COMP_BATCH(iob);
+
+	completions =3D nvme_poll_cq(nvmeq, &iob);
+	if (!completions)
+		return test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ,
+					  &nvmeq->flags) ? IRQ_HANDLED : IRQ_NONE;
+	if (!rq_list_empty(&iob.req_list))
+		nvme_pci_complete_batch(&iob);
+	nvme_adaptive_sample(nvmeq, completions);
+	return IRQ_HANDLED;
+}
+
+static __always_inline bool nvme_adaptive_armed(void)
+{
+	return static_branch_unlikely(&nvme_adaptive_irq_polling_key) &&
+		READ_ONCE(use_adaptive_irq_polling);
+}
+
+static irqreturn_t nvme_irq_adaptive(int irq, void *data)
+{
+	struct nvme_queue *nvmeq =3D data;
+	irqreturn_t ret;
+
+	if (nvme_adaptive_armed())
+		return nvme_irq_adaptive_enabled(irq, data);
+
+	ret =3D nvme_irq(irq, data);
+	if (ret =3D=3D IRQ_NONE &&
+	    test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags))
+		return IRQ_HANDLED;
+	return ret;
+}
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq =3D data;
@@ -1640,13 +1969,20 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return IRQ_NONE;
 }
=20
-static irqreturn_t nvme_irq_check(int irq, void *data)
+static unsigned long nvme_adaptive_lock(struct nvme_queue *nvmeq)
 {
-	struct nvme_queue *nvmeq =3D data;
+	unsigned long flags =3D 0;
=20
-	if (nvme_cqe_pending(nvmeq))
-		return IRQ_WAKE_THREAD;
-	return IRQ_NONE;
+	if (nvmeq->adaptive)
+		spin_lock_irqsave(&nvmeq->adaptive->lock, flags);
+	return flags;
+}
+
+static void nvme_adaptive_unlock(struct nvme_queue *nvmeq,
+				 unsigned long flags)
+{
+	if (nvmeq->adaptive)
+		spin_unlock_irqrestore(&nvmeq->adaptive->lock, flags);
 }
=20
 /*
@@ -1656,15 +1992,18 @@ static irqreturn_t nvme_irq_check(int irq, void *da=
ta)
 static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev =3D to_pci_dev(nvmeq->dev->dev);
+	unsigned long flags;
 	int irq;
=20
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
=20
 	irq =3D pci_irq_vector(pdev, nvmeq->cq_vector);
 	disable_irq(irq);
+	flags =3D nvme_adaptive_lock(nvmeq);
 	spin_lock(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
 	spin_unlock(&nvmeq->cq_poll_lock);
+	nvme_adaptive_unlock(nvmeq, flags);
 	enable_irq(irq);
 }
=20
@@ -2017,8 +2356,7 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (!nvmeq->sq_cmds)
-		return;
-
+		goto free_adaptive;
 	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
 		pci_free_p2pmem(to_pci_dev(nvmeq->dev->dev),
 				nvmeq->sq_cmds, SQ_SIZE(nvmeq));
@@ -2026,6 +2364,9 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 		dma_free_coherent(nvmeq->dev->dev, SQ_SIZE(nvmeq),
 				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	}
+free_adaptive:
+	kfree(nvmeq->adaptive);
+	nvmeq->adaptive =3D NULL;
 }
=20
 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
@@ -2038,9 +2379,42 @@ static void nvme_free_queues(struct nvme_dev *dev, i=
nt lowest)
 	}
 }
=20
+static int nvme_adaptive_suspend(struct nvme_queue *nvmeq)
+{
+	struct nvme_adaptive_poll *adaptive =3D nvmeq->adaptive;
+	unsigned long flags;
+	int irq;
+
+	if (!adaptive || adaptive->irq < 0)
+		return -1;
+	irq =3D adaptive->irq;
+	synchronize_irq(irq);
+	irq_poll_disable(&adaptive->iopoll);
+	spin_lock_irqsave(&adaptive->lock, flags);
+	spin_unlock_irqrestore(&adaptive->lock, flags);
+	hrtimer_cancel(&adaptive->timer);
+	spin_lock_irqsave(&adaptive->lock, flags);
+	if (test_and_clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags)) {
+		set_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags);
+		enable_irq(irq);
+	}
+	spin_unlock_irqrestore(&adaptive->lock, flags);
+	return irq;
+}
+
+static void nvme_adaptive_suspend_done(struct nvme_queue *nvmeq, int irq)
+{
+	if (irq < 0)
+		return;
+	nvmeq->adaptive->irq =3D -1;
+	irq_poll_enable(&nvmeq->adaptive->iopoll);
+}
+
 static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
 {
 	struct nvme_queue *nvmeq =3D &dev->queues[qid];
+	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
+	int irq;
=20
 	if (!test_and_clear_bit(NVMEQ_ENABLED, &nvmeq->flags))
 		return;
@@ -2051,8 +2425,11 @@ static void nvme_suspend_queue(struct nvme_dev *dev,=
 unsigned int qid)
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		nvme_quiesce_admin_queue(&nvmeq->dev->ctrl);
-	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
-		pci_free_irq(to_pci_dev(dev->dev), nvmeq->cq_vector, nvmeq);
+	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags)) {
+		irq =3D nvme_adaptive_suspend(nvmeq);
+		pci_free_irq(pdev, nvmeq->cq_vector, nvmeq);
+		nvme_adaptive_suspend_done(nvmeq, irq);
+	}
 }
=20
 static void nvme_suspend_io_queues(struct nvme_dev *dev)
@@ -2166,18 +2543,74 @@ static int nvme_alloc_queue(struct nvme_dev *dev, i=
nt qid, int depth)
 	return -ENOMEM;
 }
=20
+static bool nvme_adaptive_init(struct nvme_queue *nvmeq)
+{
+	struct nvme_adaptive_poll *adaptive =3D nvmeq->adaptive;
+	int irq =3D pci_irq_vector(to_pci_dev(nvmeq->dev->dev),
+				 nvmeq->cq_vector);
+
+	if (irq < 0)
+		return false;
+	if (!adaptive) {
+		adaptive =3D kzalloc_node(sizeof(*adaptive), GFP_KERNEL,
+					dev_to_node(nvmeq->dev->dev));
+		if (!adaptive)
+			return false;
+		adaptive->nvmeq =3D nvmeq;
+		spin_lock_init(&adaptive->lock);
+		hrtimer_setup(&adaptive->timer, nvme_adaptive_poll_timer,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+		irq_poll_init(&adaptive->iopoll, 64, nvme_adaptive_irq_poll);
+		adaptive->irq =3D irq;
+		WRITE_ONCE(nvmeq->adaptive, adaptive);
+		return true;
+	}
+	adaptive->irq =3D irq;
+	return true;
+}
+
 static int queue_request_irq(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev =3D to_pci_dev(nvmeq->dev->dev);
 	int nr =3D nvmeq->dev->ctrl.instance;
+	bool adaptive_queue;
+	int ret;
=20
 	if (use_threaded_interrupts) {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
 				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	}
+	/*
+	 * Decide once, at setup, whether this queue can ever poll adaptively.
+	 * nvme_irq_adaptive() is only installed when the adaptive state is
+	 * allocated and armed here, so its fast path never has to re-check
+	 * these static queue properties on every completion IRQ.
+	 */
+	adaptive_queue =3D nvmeq->qid && nvmeq->dev->num_vecs > 1 &&
+		pdev->msix_enabled &&
+		nvmeq->q_depth >=3D NVME_ADAPTIVE_TARGET_BATCH;
+	if (adaptive_queue)
+		adaptive_queue =3D nvme_adaptive_init(nvmeq);
+	ret =3D pci_request_irq(pdev, nvmeq->cq_vector,
+			      adaptive_queue ? nvme_irq_adaptive : nvme_irq,
+			      NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+	if (ret && nvmeq->adaptive)
+		nvmeq->adaptive->irq =3D -1;
+	return ret;
+}
+
+static void nvme_adaptive_reset(struct nvme_queue *nvmeq)
+{
+	struct nvme_adaptive_poll *adaptive =3D nvmeq->adaptive;
+
+	clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+	clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags);
+	if (!adaptive)
+		return;
+	adaptive->start_ns =3D 0;
+	adaptive->completions =3D 0;
+	adaptive->retry_completions =3D 0;
+	adaptive->irq =3D -1;
 }
=20
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -2188,6 +2621,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq,=
 u16 qid)
 	nvmeq->last_sq_tail =3D 0;
 	nvmeq->cq_head =3D 0;
 	nvmeq->cq_phase =3D 1;
+	nvme_adaptive_reset(nvmeq);
 	nvmeq->q_db =3D &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
 	nvme_dbbuf_init(dev, nvmeq, qid);
--=20
2.39.5 (Apple Git-154)

