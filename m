Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC09C44501
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 08:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVdUwqXGNcKNU73AUvhZYp1dhNe5TwtMbkr0MkBFB3Y=; b=AjwEB2cLfmxquOU+qFdFxK4bkR
	KssAmdtYlIiMOBdaKj4NtSSaJynXjw/oHK81fh+DtjIPihTt87Y9HWqC1XL+AKEscAdUR/qOBaMHx
	nkhjZpzwOxOWlBoY/BL4eLB6THd1XxRZyZSgcpbhjSgfbg01YfsxaBypM0j5kWHDBhPZ/rmRU8nDI
	RiS61DITuOTW0GHg5NT8t+OXYbGXeeGkpXFlicvE8zGcQty+8guJdc+anqihKv2qfrhyLRHgbRHG8
	ajxV17DBdAhYzceTjgTGdV/s9LrBZiKraucbFaQXux80DQQ2gwRnc8msCN9f25Tty4HwOs6Y2ggI5
	jMGkC4Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjufI-0000000E6tD-1eKK;
	Wed, 15 Jul 2026 08:08:24 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjufF-0000000E6rL-41a6
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 08:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784102902; x=1815638902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rcCpjudhWupUhS/aicPi5XjIzEOquuOUVyAMkovNLY0=;
  b=MYTdzA+ttTtbsfuWFIYUh5g1GILfhKimkdGBtkAAdHn7A09FXoDqJG0H
   bzHHzCH7056wOBbiDm40pJNScLD1PvLwrX5283ERZIfZmXeIUHqFjA5fd
   haS9KOQBIOYPGFDU0hJZrLijkfhzCaNMUy9J6QhJjPEIUqtSvpg0nkwsd
   X4B+xxB6fyh1PWeyoVJvXsgajnyUnLwKow+CzEAVTD20vNul9sTkAhQMb
   og6EvFtBeaQZJPUMW0vmm3PQf7XH8B1WAU9p0Uk2f/pEkJvSeeoLa6Iqt
   jm1N/C7XexleF0AQc8uBrTJTdzH10lHU8NsjCV4EPdzE5jFaNRX5Mi4IP
   Q==;
X-CSE-ConnectionGUID: 5OQFvzgnRLCcG8baMURmwg==
X-CSE-MsgGUID: pq8Ch2lWSCSPJTny8Bf5gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84849409"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84849409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 01:08:22 -0700
X-CSE-ConnectionGUID: 5iCMHNkBQy6lpDil6/2VEQ==
X-CSE-MsgGUID: aa5ukBskT0yV6BSJqXst/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="254984205"
Received: from sh14l02shfs0402.sh.intel.com ([10.239.12.240])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 01:08:19 -0700
From: Jun Zeng <jun1.zeng@intel.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@intel.com,
	gang.cao@intel.com,
	jun.i.jin@intel.com,
	yong.hu@intel.com,
	Jun Zeng <jun1.zeng@intel.com>,
	Liang Fang <liang.a.fang@intel.com>
Subject: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Date: Wed, 15 Jul 2026 15:57:03 +0800
Message-ID: <20260715075703.15578-2-jun1.zeng@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715075703.15578-1-jun1.zeng@intel.com>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_010822_041504_5D96C6B6 
X-CRM114-Status: GOOD (  27.46  )
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

Add adaptive interrupt coalescing to improve IOPS for high-throughput
workloads. Monitor IO pressure periodically and enable/disable coalescing
automatically based on IOPS, queue depth, and inflight IO thresholds.
This feature is enabled by default, can be controlled through debugfs
variable during runtime.

This significantly improves 4k random read IOPS on multi-disk Gen5 NVMe
configurations without affecting latency-sensitive workloads (i.e.,
double the total IOPS with 16 NVMe disks).

Co-developed-by: Liang Fang <liang.a.fang@intel.com>
Signed-off-by: Liang Fang <liang.a.fang@intel.com>
Signed-off-by: Jun Zeng <jun1.zeng@intel.com>
---
 drivers/nvme/host/pci.c | 540 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 539 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb..68e010af1e0d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
+#include <linux/debugfs.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -19,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nodemask.h>
+#include <linux/notifier.h>
 #include <linux/once.h>
 #include <linux/pci.h>
 #include <linux/suspend.h>
@@ -334,6 +336,20 @@ struct nvme_dev {
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
+
+	/* adaptive interrupt coalescing support: */
+	bool in_coalescing;
+	bool need_reset_coalesce;
+	bool irq_coalesce_supported;
+	bool coalesce_work_stop;
+	u32 coalesce_set_streak;
+	u32 coalesce_clear_streak;
+	unsigned long *active_q_bitmap;
+	u64 prev_coal_check_time;
+	struct delayed_work coalesce_work;
+	struct notifier_block coalesce_notifier;
+	bool coalesce_notifier_registered;
+
 	struct nvme_descriptor_pools descriptor_pools[];
 };
 
@@ -391,6 +407,10 @@ struct nvme_queue {
 	__le32 *dbbuf_sq_ei;
 	__le32 *dbbuf_cq_ei;
 	struct completion delete_done;
+	/* to count complete io number of this queue */
+	atomic_long_t io_cnt;
+	/* Previous io_cnt for delta calculation */
+	unsigned long prev_io_cnt;
 };
 
 /* bits for iod->flags */
@@ -1402,6 +1422,397 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	return ret;
 }
 
+/* definition and logic for adaptive interrupt coalescing */
+#define NVME_ADAPTIVE_COALESCING_ENABLE		0x0001
+#define NVME_ADAPTIVE_COALESCING_DISABLE	0x0002
+#define COAL_CHECK_INTERVAL_MS			100
+#define COAL_CHECK_IO_DELTA_THRESH		45000 /* 45k io num, in 100 ms */
+#define COAL_CHECK_STREAK_THRESH		5
+#define COAL_CHECK_AVG_INFLT_IO_THRESH		32
+#define COAL_CHECK_INFLT_IO_THRESH		256
+#define COAL_ACTIVE_Q_SAMPLE_INTERVAL		512
+#define COALESCE_SET_VALUE			0x10a
+#define COALESCE_CLEAR_VALUE			0x000
+
+static BLOCKING_NOTIFIER_HEAD(nvme_adaptive_coalesce_notifier_list);
+
+/* enable adaptive interrupt coalescing by default */
+static int adaptive_coalescing_disabled;
+static u32 high_io_delta = COAL_CHECK_IO_DELTA_THRESH;
+static u32 avg_qd_threshold = COAL_CHECK_AVG_INFLT_IO_THRESH;
+static u32 total_inflight_io_threshold = COAL_CHECK_INFLT_IO_THRESH;
+
+static int nvme_set_irq_coalesce(struct nvme_ctrl *ctrl, u32 v)
+{
+	return nvme_set_features(ctrl, NVME_FEAT_IRQ_COALESCE, v, NULL, 0, NULL);
+}
+
+static int nvme_get_irq_coalesce(struct nvme_ctrl *ctrl, u32 *v)
+{
+	return nvme_get_features(ctrl, NVME_FEAT_IRQ_COALESCE, 0, NULL, 0, v);
+}
+
+static bool nvme_check_irq_coalesce_supported(struct nvme_ctrl *ctrl)
+{
+	u32 value;
+
+	if (nvme_get_irq_coalesce(ctrl, &value)) {
+		dev_info(ctrl->device, "interrupt coalescing not supported\n");
+		return false;
+	}
+	return true;
+}
+
+static int disable_adaptive_coalescing_show(void *data, u64 *val)
+{
+	*val = adaptive_coalescing_disabled;
+	return 0;
+}
+
+static int disable_adaptive_coalescing_store(void *data, u64 val)
+{
+	int old_val, new_val;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	new_val = (int)val;
+	old_val = xchg(&adaptive_coalescing_disabled, new_val);
+
+	/* If old_val == new_val, no change needed */
+	if (old_val == new_val)
+		return 0;
+
+	if (new_val)
+		blocking_notifier_call_chain(&nvme_adaptive_coalesce_notifier_list,
+					     NVME_ADAPTIVE_COALESCING_DISABLE, NULL);
+	else
+		blocking_notifier_call_chain(&nvme_adaptive_coalesce_notifier_list,
+					     NVME_ADAPTIVE_COALESCING_ENABLE, NULL);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(disable_adaptive_coalescing_fops,
+			 disable_adaptive_coalescing_show,
+			 disable_adaptive_coalescing_store,
+			 "%llu\n");
+
+static int nvme_coalesce_work_cpu(struct nvme_dev *dev)
+{
+	int node = dev_to_node(dev->dev);
+	int cpu;
+
+	if (node != NUMA_NO_NODE && node_online(node)) {
+		cpu = cpumask_last(cpumask_of_node(node));
+		if (cpu < nr_cpu_ids && cpu_online(cpu))
+			return cpu;
+	}
+
+	cpu = cpumask_last(cpu_online_mask);
+	if (cpu < nr_cpu_ids && cpu_online(cpu))
+		return cpu;
+
+	return WORK_CPU_UNBOUND;
+}
+
+/*
+ * Check if coalescing should be enabled based on IO pressure.
+ * Returns true if high IO pressure is detected.
+ */
+static bool nvme_should_enable_coalesce(u64 io_delta, u64 time_interval,
+					u32 avg_inflight_io, u32 busy_queues)
+{
+	/* Check if IOPS exceeds threshold (adjusted for actual time interval) */
+	if (io_delta * COAL_CHECK_INTERVAL_MS * NSEC_PER_MSEC <=
+	    high_io_delta * time_interval)
+		return false;
+
+	/*
+	 * Enable coalescing when average number of inflight IOs on active queues
+	 * is larger enough to indicate a throughput-oriented workload.
+	 */
+	if (avg_inflight_io > avg_qd_threshold)
+		return true;
+
+	/*
+	 * Even when each active queue is relatively shallow, still enable
+	 * coalescing if the aggregate inflight IO across busy queues is high.
+	 */
+	return busy_queues * avg_inflight_io > total_inflight_io_threshold;
+}
+
+/* Update coalesce streak counters based on current IO pressure */
+static void nvme_update_coalesce_streak(struct nvme_dev *dev, bool should_enable)
+{
+	if (should_enable) {
+		dev->coalesce_set_streak++;
+		dev->coalesce_clear_streak = 0;
+	} else {
+		dev->coalesce_clear_streak++;
+		dev->coalesce_set_streak = 0;
+	}
+}
+
+/* Apply coalesce state change if streak threshold is reached */
+static void nvme_apply_coalesce_change(struct nvme_dev *dev)
+{
+	if (!dev->in_coalescing) {
+		if (dev->coalesce_set_streak <= COAL_CHECK_STREAK_THRESH)
+			return;
+
+		if (nvme_set_irq_coalesce(&dev->ctrl, COALESCE_SET_VALUE)) {
+			dev_warn_ratelimited(dev->ctrl.device,
+					     "set irq coalesce with value:%d failed.\n",
+					     COALESCE_SET_VALUE);
+			return;
+		}
+
+		dev->in_coalescing = true;
+		dev->coalesce_set_streak = 0;
+		dev->coalesce_clear_streak = 0;
+		return;
+	}
+
+	if (dev->coalesce_clear_streak <= COAL_CHECK_STREAK_THRESH)
+		return;
+
+	if (nvme_set_irq_coalesce(&dev->ctrl, COALESCE_CLEAR_VALUE)) {
+		dev_warn_ratelimited(dev->ctrl.device,
+				     "clear irq coalesce with value:%d failed.\n",
+				     COALESCE_CLEAR_VALUE);
+		return;
+	}
+
+	dev->in_coalescing = false;
+	dev->coalesce_set_streak = 0;
+	dev->coalesce_clear_streak = 0;
+}
+
+/* Collect IO statistics from all queues */
+static void nvme_collect_io_stats(struct nvme_dev *dev, u64 *io_delta,
+				  u32 *avg_inflight_io, u32 *busy_queues)
+{
+	struct nvme_queue *nvmeq;
+	u64 total_inflight_io = 0;
+	unsigned int i;
+	u32 queues_counted = 0;
+
+	*io_delta = 0;
+
+	/*
+	 * Count active queues during iteration rather than using bitmap_weight()
+	 * upfront. The bitmap can be modified concurrently by nvme_mark_queue_active()
+	 * from other CPUs, so we count the actual queues processed to ensure the
+	 * divisor matches the accumulated total_inflight_io.
+	 */
+	for_each_set_bit(i, dev->active_q_bitmap, dev->nr_allocated_queues) {
+		u32 sq_tail;
+		u32 cq_head;
+		u32 q_depth;
+
+		nvmeq = &dev->queues[i];
+		/*
+		 * Read cq_head before sq_tail in source order for a conservative
+		 * estimate. If we read sq_tail first and completions happen between
+		 * reads, cq_head could advance past the observed sq_tail, causing
+		 * the inflight calculation to produce an artificially high value.
+		 *
+		 * Note: READ_ONCE() only prevents compiler reordering; weakly ordered
+		 * architectures may still reorder at hardware level. This is acceptable
+		 * for approximate statistics - occasional inflated values don't affect
+		 * adaptive coalescing decisions significantly.
+		 */
+		cq_head = READ_ONCE(nvmeq->cq_head);
+		sq_tail = READ_ONCE(nvmeq->sq_tail);
+		q_depth = READ_ONCE(nvmeq->q_depth);
+		/* Skip uninitialized queue to avoid divide-by-zero */
+		if (!q_depth)
+			continue;
+		/* Use unsigned arithmetic to handle ring buffer wrap correctly */
+		total_inflight_io += (sq_tail + q_depth - cq_head) % q_depth;
+		queues_counted++;
+	}
+
+	*busy_queues = queues_counted;
+	if (queues_counted)
+		*avg_inflight_io = div_u64(total_inflight_io, queues_counted);
+	else
+		*avg_inflight_io = 0;
+
+	/*
+	 * Calculate io_delta and advance each queue's baseline every cycle,
+	 * including cycles where no queue crossed an active sampling boundary.
+	 * This keeps the completion delta aligned with the measurement interval.
+	 *
+	 * We must calculate delta in native word size first (unsigned long)
+	 * before accumulating to 64-bit. On 32-bit platforms, if a queue's
+	 * 32-bit counter wraps from 0xFFFFFFFF to 0, calculating delta in
+	 * 32-bit unsigned arithmetic handles wrap correctly (e.g., 5 - 0xFFFFFFF0
+	 * = 21). Accumulating absolute 64-bit values would cause huge errors.
+	 */
+	for (i = dev->nr_allocated_queues - 1; i > 0; i--) {
+		unsigned long curr_cnt, queue_delta;
+
+		nvmeq = &dev->queues[i];
+		curr_cnt = atomic_long_read(&nvmeq->io_cnt);
+		/* Unsigned subtraction handles wrap correctly */
+		queue_delta = curr_cnt - nvmeq->prev_io_cnt;
+		nvmeq->prev_io_cnt = curr_cnt;
+		*io_delta += queue_delta;
+	}
+
+	/*
+	 * Use atomic clear_bit to avoid mixing atomic and non-atomic ops
+	 * on the same memory, which could lose updates and trigger KCSAN.
+	 */
+	for (i = 0; i < dev->nr_allocated_queues; i++)
+		clear_bit(i, dev->active_q_bitmap);
+}
+
+static void nvme_adjust_coalesce(struct nvme_dev *dev)
+{
+	u64 now = ktime_get_ns();
+	u64 time_interval;
+	u64 io_delta;
+	u32 avg_inflight_io;
+	u32 busy_queues;
+	bool should_enable;
+
+	if (READ_ONCE(adaptive_coalescing_disabled)) {
+		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_LIVE)
+			return;
+
+		/* Force clear coalescing when disabled */
+		dev->coalesce_set_streak = 0;
+		dev->coalesce_clear_streak += COAL_CHECK_STREAK_THRESH + 1;
+		dev_info(dev->ctrl.device, "clearing coalesce due to disable\n");
+		nvme_apply_coalesce_change(dev);
+		return;
+	}
+
+	/* If ctrlr state no LIVE, then skip this round */
+	if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_LIVE)
+		return;
+
+	/*
+	 * Pairs with smp_wmb() in nvme_reset_work() to ensure we see
+	 * need_reset_coalesce=true if we see state=LIVE after reset.
+	 */
+	smp_rmb();
+
+	/* Check if controller been reset - coalescing config may be lost */
+	if (dev->need_reset_coalesce) {
+		unsigned int j;
+
+		/*
+		 * Use atomic clear_bit to avoid data race with concurrent
+		 * set_bit() from nvme_mark_queue_active() on other CPUs.
+		 */
+		for (j = 0; j < dev->nr_allocated_queues; j++)
+			clear_bit(j, dev->active_q_bitmap);
+
+		/*
+		 * Sync each queue's prev_io_cnt to current io_cnt, because queues
+		 * may not be reallocated and io_cnt retains lifetime values.
+		 * Otherwise io_delta would be erroneously huge on next cycle.
+		 */
+		for (j = dev->nr_allocated_queues - 1; j > 0; j--)
+			dev->queues[j].prev_io_cnt = atomic_long_read(&dev->queues[j].io_cnt);
+
+		/*
+		 * Clear hardware coalescing state to ensure software and hardware
+		 * states are synchronized after controller reset.
+		 */
+		if (dev->in_coalescing)
+			nvme_set_irq_coalesce(&dev->ctrl, COALESCE_CLEAR_VALUE);
+
+		dev->in_coalescing = false;
+		dev->coalesce_set_streak = 0;
+		dev->coalesce_clear_streak = 0;
+		dev->need_reset_coalesce = false;
+		dev->prev_coal_check_time = now;
+		return;
+	}
+
+	nvme_collect_io_stats(dev, &io_delta, &avg_inflight_io, &busy_queues);
+	time_interval = now - dev->prev_coal_check_time;
+	dev->prev_coal_check_time = now;
+
+	should_enable = nvme_should_enable_coalesce(io_delta, time_interval,
+						    avg_inflight_io, busy_queues);
+	nvme_update_coalesce_streak(dev, should_enable);
+	nvme_apply_coalesce_change(dev);
+}
+
+static void nvme_adjust_coalesce_work(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, coalesce_work.work);
+	/*
+	 * Schedule the delayed work on the last CPU of the NUMA node the disk
+	 * belongs to.
+	 */
+	int cpu = nvme_coalesce_work_cpu(dev);
+
+	/* Check stop flag before doing any work or rescheduling */
+	if (READ_ONCE(dev->coalesce_work_stop))
+		return;
+
+	if (READ_ONCE(adaptive_coalescing_disabled) && !dev->in_coalescing)
+		return;
+
+	nvme_adjust_coalesce(dev);
+
+	/* Check again before rescheduling to avoid use-after-free */
+	if (!READ_ONCE(dev->coalesce_work_stop))
+		schedule_delayed_work_on(cpu, &dev->coalesce_work,
+					 msecs_to_jiffies(COAL_CHECK_INTERVAL_MS));
+}
+
+static void nvme_mark_queue_active(struct nvme_queue *nvmeq, u16 sq_tail)
+{
+	if (READ_ONCE(adaptive_coalescing_disabled))
+		return;
+
+	/* ignore admin op */
+	if (nvmeq->qid == 0)
+		return;
+
+	/*
+	 * Sample at COAL_ACTIVE_Q_SAMPLE_INTERVAL boundaries and whenever the
+	 * submission queue wraps. This ensures queues shallower than the sample
+	 * interval can still be recognized as active.
+	 */
+	if ((sq_tail & (COAL_ACTIVE_Q_SAMPLE_INTERVAL - 1)) == 0)
+		set_bit(nvmeq->qid, nvmeq->dev->active_q_bitmap);
+}
+
+static int nvme_pci_coalescing_notify(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct nvme_dev *dev =
+		container_of(nb, struct nvme_dev, coalesce_notifier);
+	/*
+	 * Schedule the delayed work on the last CPU of the NUMA node the disk
+	 * belongs to.
+	 */
+	int cpu = nvme_coalesce_work_cpu(dev);
+
+	switch (action) {
+	case NVME_ADAPTIVE_COALESCING_ENABLE:
+		/* Use cached value to avoid blocking admin command in notifier */
+		if (dev->irq_coalesce_supported)
+			schedule_delayed_work_on(cpu, &dev->coalesce_work,
+						 msecs_to_jiffies(COAL_CHECK_INTERVAL_MS));
+		break;
+	case NVME_ADAPTIVE_COALESCING_DISABLE:
+		/* no need to do things now, the coalesce_work will exit automatically */
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
@@ -1424,8 +1835,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ret = nvme_prep_rq(req);
 	if (unlikely(ret))
 		return ret;
+
 	spin_lock(&nvmeq->sq_lock);
 	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	nvme_mark_queue_active(nvmeq, nvmeq->sq_tail);
 	nvme_write_sq_db(nvmeq, bd->last);
 	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
@@ -1443,6 +1856,7 @@ static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+		nvme_mark_queue_active(nvmeq, nvmeq->sq_tail);
 	}
 	nvme_write_sq_db(nvmeq, true);
 	spin_unlock(&nvmeq->sq_lock);
@@ -1555,6 +1969,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
+	atomic_long_inc(&nvmeq->io_cnt);
+
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
 	    !blk_mq_add_to_batch(req, iob,
@@ -2124,6 +2540,8 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->qid = qid;
+	atomic_long_set(&nvmeq->io_cnt, 0);
+	nvmeq->prev_io_cnt = 0;
 	dev->ctrl.queue_count++;
 
 	return 0;
@@ -3342,8 +3760,18 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
+	/* Signal work to stop before canceling to prevent rearming */
+	WRITE_ONCE(dev->coalesce_work_stop, true);
+	if (dev->coalesce_notifier_registered) {
+		blocking_notifier_chain_unregister(
+			&nvme_adaptive_coalesce_notifier_list,
+			&dev->coalesce_notifier);
+		dev->coalesce_notifier_registered = false;
+	}
+	cancel_delayed_work_sync(&dev->coalesce_work);
 	nvme_free_tagset(dev);
 	put_device(dev->dev);
+	bitmap_free(dev->active_q_bitmap);
 	kfree(dev->queues);
 	kfree(dev);
 }
@@ -3429,6 +3857,18 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_free_tagset(dev);
 	}
 
+	/*
+	 * Set need_reset_coalesce before changing to LIVE state to avoid
+	 * race with nvme_adjust_coalesce_work() which could run with stale
+	 * bitmap and prev_io_cnt values causing erroneous IOPS calculation.
+	 */
+	dev->need_reset_coalesce = true;
+	/*
+	 * Ensure need_reset_coalesce is visible before the LIVE state change.
+	 * Pairs with smp_rmb() in nvme_adjust_coalesce().
+	 */
+	smp_wmb();
+
 	/*
 	 * If only admin queue live, keep it to do further investigation or
 	 * recovery.
@@ -3436,6 +3876,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller live state\n");
+		dev->need_reset_coalesce = false;
 		result = -ENODEV;
 		goto out;
 	}
@@ -3650,8 +4091,18 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
+	INIT_DELAYED_WORK(&dev->coalesce_work, nvme_adjust_coalesce_work);
+	dev->coalesce_notifier.notifier_call = nvme_pci_coalescing_notify;
+	dev->coalesce_notifier_registered = false;
 	mutex_init(&dev->shutdown_lock);
 
+	dev->in_coalescing = false;
+	dev->need_reset_coalesce = false;
+	dev->coalesce_work_stop = false;
+	dev->coalesce_set_streak = 0;
+	dev->coalesce_clear_streak = 0;
+	dev->prev_coal_check_time = ktime_get_ns();
+
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 	dev->nr_allocated_queues = nvme_max_io_queues(dev) + 1;
@@ -3660,6 +4111,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	if (!dev->queues)
 		goto out_free_dev;
 
+	dev->active_q_bitmap = bitmap_zalloc_node(dev->nr_allocated_queues, GFP_KERNEL, node);
+	if (!dev->active_q_bitmap) {
+		ret = -ENOMEM;
+		goto out_free_queues;
+	}
+
 	dev->dev = get_device(&pdev->dev);
 
 	quirks |= check_vendor_combination_bug(pdev);
@@ -3679,6 +4136,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		quirks |= qentry->enabled_quirks;
 		quirks &= ~qentry->disabled_quirks;
 	}
+
 	ret = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			     quirks);
 	if (ret)
@@ -3704,6 +4162,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 
 out_put_device:
 	put_device(dev->dev);
+	kfree(dev->active_q_bitmap);
+out_free_queues:
 	kfree(dev->queues);
 out_free_dev:
 	kfree(dev);
@@ -3790,14 +4250,39 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_disable;
 	}
 
+	result = blocking_notifier_chain_register(
+			&nvme_adaptive_coalesce_notifier_list,
+			&dev->coalesce_notifier);
+	if (result)
+		goto out_disable;
+	dev->coalesce_notifier_registered = true;
+
 	pci_set_drvdata(pdev, dev);
 
 	nvme_start_ctrl(&dev->ctrl);
 	nvme_put_ctrl(&dev->ctrl);
 	flush_work(&dev->ctrl.scan_work);
+	/* Cache irq coalesce support to avoid admin cmd in notifier callback */
+	dev->irq_coalesce_supported = nvme_check_irq_coalesce_supported(&dev->ctrl);
+	if (dev->irq_coalesce_supported && !adaptive_coalescing_disabled) {
+		/*
+		 * Schedule the delayed work on the last CPU of the
+		 * NUMA node this NVMe disk belongs to.
+		 */
+		schedule_delayed_work_on(nvme_coalesce_work_cpu(dev),
+					 &dev->coalesce_work,
+					 msecs_to_jiffies(COAL_CHECK_INTERVAL_MS));
+	}
 	return 0;
 
 out_disable:
+	if (dev->coalesce_notifier_registered) {
+		blocking_notifier_chain_unregister(
+			&nvme_adaptive_coalesce_notifier_list,
+			&dev->coalesce_notifier);
+		dev->coalesce_notifier_registered = false;
+	}
+	cancel_delayed_work_sync(&dev->coalesce_work);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
 	nvme_free_host_mem(dev);
@@ -3853,14 +4338,42 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	/*
+	 * Set DELETING state first to fail pending admin commands quickly,
+	 * preventing 60-second timeout stalls during abrupt removal.
+	 */
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+
+	/*
+	 * Signal work to stop and unregister notifier early to prevent
+	 * use-after-free: work could rearm itself, or debugfs write could
+	 * trigger notifier callback which submits admin commands after
+	 * admin queue is destroyed.
+	 */
+	WRITE_ONCE(dev->coalesce_work_stop, true);
+	if (dev->coalesce_notifier_registered) {
+		blocking_notifier_chain_unregister(
+			&nvme_adaptive_coalesce_notifier_list,
+			&dev->coalesce_notifier);
+		dev->coalesce_notifier_registered = false;
+	}
 	pci_set_drvdata(pdev, NULL);
 
+	/*
+	 * Disable device BEFORE cancel_delayed_work_sync() to abort any
+	 * pending admin commands. This prevents 60-second timeout stalls
+	 * during surprise removal: if coalesce_work is blocked waiting
+	 * for nvme_set_irq_coalesce() admin command on unresponsive
+	 * hardware, nvme_dev_disable() will abort it immediately.
+	 */
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
 	}
 
+	/* Now safe to sync - any pending admin commands are aborted */
+	cancel_delayed_work_sync(&dev->coalesce_work);
+
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
@@ -4273,14 +4786,37 @@ static struct pci_driver nvme_driver = {
 	.err_handler	= &nvme_err_handler,
 };
 
+static struct dentry *nvme_dbg_root;
+
 static int __init nvme_init(void)
 {
+	int ret;
+
+	/*
+	 * debugfs is not essential for driver functionality.
+	 * Don't check return values - debugfs API handles errors gracefully.
+	 */
+	nvme_dbg_root = debugfs_create_dir("nvme_pci", NULL);
+	debugfs_create_file("disable_adaptive_interrupt_coalescing",
+			    0644, nvme_dbg_root, NULL,
+			    &disable_adaptive_coalescing_fops);
+	debugfs_create_u32("high_io_delta", 0644, nvme_dbg_root,
+			   &high_io_delta);
+	debugfs_create_u32("avg_qd_threshold", 0644, nvme_dbg_root,
+			   &avg_qd_threshold);
+	debugfs_create_u32("total_inflight_io_threshold", 0644,
+			   nvme_dbg_root, &total_inflight_io_threshold);
+
 	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 
-	return pci_register_driver(&nvme_driver);
+	ret = pci_register_driver(&nvme_driver);
+	if (ret)
+		debugfs_remove_recursive(nvme_dbg_root);
+
+	return ret;
 }
 
 static void __exit nvme_exit(void)
@@ -4288,6 +4824,8 @@ static void __exit nvme_exit(void)
 	kfree(nvme_pci_quirk_list);
 	pci_unregister_driver(&nvme_driver);
 	flush_workqueue(nvme_wq);
+
+	debugfs_remove_recursive(nvme_dbg_root);
 }
 
 MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
-- 
2.43.0


