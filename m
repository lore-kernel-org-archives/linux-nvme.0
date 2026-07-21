Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4F4C4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Date:From:Cc:References:Content-Type:Mime-Version:
	Subject:Message-Id:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTCbANU7vWSxa3JLMt4cJo5Ee8ItV8WdLM/GlzKZh/M=; b=qEhXFDKTv1J9Kdi2mXoODF6X53
	zsFQx5JQXesl8cW4lW8OtdnRNsnhFtwbSv0icccxxSBROf+tKGIaVChjvxwHb5Y17L/9wWBxE+lh1
	y202u8ePnCKv1lu3lljJQJueV6rAlp5cqSZShrAjOd1YVi3acWy3TJ1ZyNWTGtnJhVifS6o+gKZzC
	IxZU0k1UNDl/lmE96Z4A8o1Zz9aHHKnbeevicY7rTeSOwNHlgWTXNeDDT5QYYbEcMHf3SxrWjZmrW
	128J6Cf1zlrzWWu0r4aZIBevdCRXl++Dt/0GHFly8y0iPj7fyjq29o0sRzXeR7p5QPF6VeSZ387Df
	UhFP7y7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm5zy-00000008quP-2XV0;
	Tue, 21 Jul 2026 08:38:46 +0000
Received: from va-2-114.ptr.blmpb.com ([209.127.231.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm5zs-00000008qsw-12dM
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 08:38:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784623112; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=yTCbANU7vWSxa3JLMt4cJo5Ee8ItV8WdLM/GlzKZh/M=;
 b=RgbiHC1CdaNi9FDQ7mvcrDgLxthEd4Uxral6RRqO5I62I5fZWY6pondgoK5nBuXG0OlNu2
 StqThx+s/QdVY7Hk4hob8OirjEN1Maxbg64gjc6gdjDLtBQZlu72jhOok3VT5j9El7ixFG
 OLa3gt/8xLfM6vUuQEZrnw42pqGJHbP6RWm+s9BYLHY5/S7Un2bnM+uDP5c1we5EVSmI5d
 2ZeRJ2imrrTDoIK5ibPr2L5gEJKSdLERcvPoYN7JVNUfO9Z/uyJ8Req5cQem1QsNdkdT22
 kKtybuFz90oNMawp0xNi13T2GCU8Q1sJlU8G3qSWdAQReN8Cdr7BUh+KOwgVFg==
To: <hch@lst.de>
Message-Id: <20260721083739.69676-1-changfengnan@bytedance.com>
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Mime-Version: 1.0
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
References: <20260715075703.15578-1-jun1.zeng@intel.com> <20260715075703.15578-2-jun1.zeng@intel.com> <allEmTmXCFosxIOr@kbusch-mbp> <20260720150539.GB17986@lst.de>
X-Lms-Return-Path: <lba+26a5f3006+7ba1aa+lists.infradead.org+changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Cc: <andriy.shevchenko@intel.com>, <axboe@kernel.dk>, <gang.cao@intel.com>, 
	<jun.i.jin@intel.com>, <jun1.zeng@intel.com>, <kbusch@kernel.org>, 
	<liang.a.fang@intel.com>, <linux-kernel@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <tglx@kernel.org>, 
	<yong.hu@intel.com>, <guzebing@bytedance.com>, 
	"Fengnan Chang" <changfengnan@bytedance.com>
From: "Fengnan Chang" <changfengnan@bytedance.com>
Date: Tue, 21 Jul 2026 16:37:39 +0800
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260720150539.GB17986@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_013840_443785_7006F3ED 
X-CRM114-Status: GOOD (  25.72  )
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

Hi all,

I'd like to add some information. A few months ago, when I was
testing Zeng's solution, I encountered some issues, primarily that
enabling or disabling interrupt aggregation on certain disks could
cause I/O latency of several tens of milliseconds. 

Inspired by the design of network NAPI, I came up with a similar idea
and implemented a patch, which performed well in testing.
If you're interested in this approach, I can continue to improve it.
The reason I didn't move forward with this approach is that our
initial goal was to solve the issues encountered with QEMU, but
disabling interrupts causes problems in VFIO+QEMU environments, and
this approach only works in physical machine scenarios. 

The patch estimates how busy a queue is from the submission queue tail
and the SQ head reported in completion entries.  When the number of
pending commands crosses a high watermark, the hard IRQ handles the
current completions, masks the queue's interrupt and wakes the IRQ
thread.  The IRQ thread then polls for more completions.  It switches
back to interrupts when the pending count falls below a low watermark,
or when a bounded number of polling loops is reached.  Using separate
high and low watermarks avoids switching back and forth too often.

This is only enabled when the controller has separate MSI-X vectors, so
masking one queue does not block completions from other queues.

I tested it with four Solidigm NVMe devices using 4K random reads.  fio
used regular io_uring, without hipri or SQ polling.  These are the
median results from three runs on a 7.2-rc1 based kernel:

                         baseline    patched
  IOPS                   7.61M       11.41M  (+50%)
  mean latency           267 us      177 us  (-34%)
  hard IRQs per I/O      0.52        0.21    (-60%)

Without the patch, three of the four devices were limited to about
1.49M IOPS each.  With the patch, all four devices reached around
2.8M-2.9M IOPS.

The patch is included below. 

Thanks,
Fengnan

From 1c84b5afc906e780e1dbd2ee186251f9de2716b5 Mon Sep 17 00:00:00 2001
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Tue, 21 Jul 2026 12:31:46 +0800
Subject: [PATCH] nvme-pci: adaptively poll busy queues from threaded
 interrupts

On systems with multiple fast NVMe devices, hard IRQ completion
processing can become CPU-bound and cap 4K random-read throughput
before the devices are saturated.

Add adaptive polling for busy interrupt-driven queues. Track the SQ head
reported by completions while the CQE is still owned by the host. After
the hard IRQ reaps pending CQEs, wake the IRQ thread and mask the queue
interrupt when the number of SQ entries not yet consumed reaches a high
watermark. Poll in the IRQ thread until the queue drops below a low
watermark or a bounded loop count is reached, then reenable the
interrupt.

Only enable adaptive polling when the controller has independent
vectors, as masking a shared single vector could suppress unrelated
queues. Expose the enable switch, watermarks, loop bound, and sleep
interval as module parameters.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 drivers/nvme/host/pci.c | 212 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 198 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b537..be3a3ea0196f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -79,8 +80,136 @@ struct quirk_entry {
 	u32 disabled_quirks;
 };
 
-static int use_threaded_interrupts;
-module_param(use_threaded_interrupts, int, 0444);
+static int use_adaptive_polling;
+module_param(use_adaptive_polling, int, 0444);
+MODULE_PARM_DESC(use_adaptive_polling,
+		 "use adaptive completion polling on busy interrupt queues");
+
+static unsigned int adaptive_poll_start_pending = 10;
+static unsigned int adaptive_poll_stop_pending = 3;
+static unsigned int adaptive_poll_max_loops = 100;
+static unsigned int adaptive_poll_sleep_min_us = 20;
+static unsigned int adaptive_poll_sleep_max_us = 30;
+
+static int nvme_adaptive_poll_start_pending_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int pending;
+	int ret;
+
+	ret = kstrtouint(val, 10, &pending);
+	if (ret)
+		return ret;
+	if (!pending || pending < READ_ONCE(adaptive_poll_stop_pending))
+		return -EINVAL;
+
+	WRITE_ONCE(*(unsigned int *)kp->arg, pending);
+	return 0;
+}
+
+static const struct kernel_param_ops nvme_adaptive_poll_start_pending_ops = {
+	.set = nvme_adaptive_poll_start_pending_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(adaptive_poll_start_pending, &nvme_adaptive_poll_start_pending_ops,
+		&adaptive_poll_start_pending, 0644);
+MODULE_PARM_DESC(adaptive_poll_start_pending, "SQ pending high watermark for adaptive polling");
+
+static int nvme_adaptive_poll_stop_pending_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int pending;
+	int ret;
+
+	ret = kstrtouint(val, 10, &pending);
+	if (ret)
+		return ret;
+	if (!pending || pending > READ_ONCE(adaptive_poll_start_pending))
+		return -EINVAL;
+
+	WRITE_ONCE(*(unsigned int *)kp->arg, pending);
+	return 0;
+}
+
+static const struct kernel_param_ops nvme_adaptive_poll_stop_pending_ops = {
+	.set = nvme_adaptive_poll_stop_pending_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(adaptive_poll_stop_pending, &nvme_adaptive_poll_stop_pending_ops,
+		&adaptive_poll_stop_pending, 0644);
+MODULE_PARM_DESC(adaptive_poll_stop_pending, "SQ pending low watermark for adaptive polling");
+
+static int nvme_adaptive_poll_max_loops_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int loops;
+	int ret;
+
+	ret = kstrtouint(val, 10, &loops);
+	if (ret)
+		return ret;
+	if (!loops)
+		return -EINVAL;
+
+	WRITE_ONCE(*(unsigned int *)kp->arg, loops);
+	return 0;
+}
+
+static const struct kernel_param_ops nvme_adaptive_poll_max_loops_ops = {
+	.set = nvme_adaptive_poll_max_loops_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(adaptive_poll_max_loops, &nvme_adaptive_poll_max_loops_ops,
+		&adaptive_poll_max_loops, 0644);
+MODULE_PARM_DESC(adaptive_poll_max_loops, "Maximum adaptive polling loops");
+
+static int nvme_adaptive_poll_sleep_min_us_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int usecs;
+	int ret;
+
+	ret = kstrtouint(val, 10, &usecs);
+	if (ret)
+		return ret;
+	if (!usecs || usecs > READ_ONCE(adaptive_poll_sleep_max_us))
+		return -EINVAL;
+
+	WRITE_ONCE(*(unsigned int *)kp->arg, usecs);
+	return 0;
+}
+
+static const struct kernel_param_ops nvme_adaptive_poll_sleep_min_us_ops = {
+	.set = nvme_adaptive_poll_sleep_min_us_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(adaptive_poll_sleep_min_us, &nvme_adaptive_poll_sleep_min_us_ops,
+		&adaptive_poll_sleep_min_us, 0644);
+MODULE_PARM_DESC(adaptive_poll_sleep_min_us, "Minimum adaptive polling delay in microseconds");
+
+static int nvme_adaptive_poll_sleep_max_us_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int usecs;
+	int ret;
+
+	ret = kstrtouint(val, 10, &usecs);
+	if (ret)
+		return ret;
+	if (!usecs || usecs < READ_ONCE(adaptive_poll_sleep_min_us))
+		return -EINVAL;
+
+	WRITE_ONCE(*(unsigned int *)kp->arg, usecs);
+	return 0;
+}
+
+static const struct kernel_param_ops nvme_adaptive_poll_sleep_max_us_ops = {
+	.set = nvme_adaptive_poll_sleep_max_us_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(adaptive_poll_sleep_max_us, &nvme_adaptive_poll_sleep_max_us_ops,
+		&adaptive_poll_sleep_max_us, 0644);
+MODULE_PARM_DESC(adaptive_poll_sleep_max_us, "Maximum adaptive polling delay in microseconds");
 
 static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
@@ -377,6 +506,7 @@ struct nvme_queue {
 	u16 cq_vector;
 	u16 sq_tail;
 	u16 last_sq_tail;
+	u16 sq_head;
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
@@ -1607,7 +1737,7 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 }
 
 static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
-			        struct io_comp_batch *iob)
+				struct io_comp_batch *iob, u16 *sq_head)
 {
 	bool found = false;
 
@@ -1618,6 +1748,8 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
+		if (sq_head)
+			*sq_head = le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].sq_head);
 		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
@@ -1631,8 +1763,11 @@ static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
 	DEFINE_IO_COMP_BATCH(iob);
+	u16 sq_head;
+
+	if (nvme_poll_cq(nvmeq, &iob, &sq_head)) {
+		WRITE_ONCE(nvmeq->sq_head, sq_head);
 
-	if (nvme_poll_cq(nvmeq, &iob)) {
 		if (!rq_list_empty(&iob.req_list))
 			nvme_pci_complete_batch(&iob);
 		return IRQ_HANDLED;
@@ -1640,13 +1775,56 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static irqreturn_t nvme_irq_check(int irq, void *data)
+static unsigned int nvme_sq_pending(struct nvme_queue *nvmeq)
+{
+	int pending = READ_ONCE(nvmeq->sq_tail) - READ_ONCE(nvmeq->sq_head);
+
+	if (pending < 0)
+		pending += nvmeq->q_depth;
+	return pending;
+}
+
+static bool nvme_adaptive_poll_should_start(struct nvme_queue *nvmeq)
+{
+	return nvme_sq_pending(nvmeq) >= READ_ONCE(adaptive_poll_start_pending);
+}
+
+static bool nvme_adaptive_poll_should_stop(struct nvme_queue *nvmeq)
+{
+	return nvme_sq_pending(nvmeq) < READ_ONCE(adaptive_poll_stop_pending);
+}
+
+static irqreturn_t nvme_adaptive_poll(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
+	unsigned int loops = 0;
+	unsigned int max_loops = READ_ONCE(adaptive_poll_max_loops);
+	unsigned int sleep_min = READ_ONCE(adaptive_poll_sleep_min_us);
+	unsigned int sleep_max = READ_ONCE(adaptive_poll_sleep_max_us);
 
-	if (nvme_cqe_pending(nvmeq))
-		return IRQ_WAKE_THREAD;
-	return IRQ_NONE;
+	do {
+		if (nvme_cqe_pending(nvmeq))
+			nvme_irq(irq, data);
+		if (nvme_adaptive_poll_should_stop(nvmeq))
+			break;
+		usleep_range(sleep_min, sleep_max);
+	} while (++loops < max_loops);
+
+	enable_irq(irq);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nvme_irq_adaptive_poll(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	irqreturn_t ret;
+
+	ret = nvme_irq(irq, data);
+	if (!nvme_adaptive_poll_should_start(nvmeq))
+		return ret;
+
+	disable_irq_nosync(irq);
+	return IRQ_WAKE_THREAD;
 }
 
 /*
@@ -1663,7 +1841,7 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
 	disable_irq(irq);
 	spin_lock(&nvmeq->cq_poll_lock);
-	nvme_poll_cq(nvmeq, NULL);
+	nvme_poll_cq(nvmeq, NULL, NULL);
 	spin_unlock(&nvmeq->cq_poll_lock);
 	enable_irq(irq);
 }
@@ -1678,7 +1856,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_poll_cq(nvmeq, iob);
+	found = nvme_poll_cq(nvmeq, iob, NULL);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
@@ -2075,7 +2253,7 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
 		spin_lock(&dev->queues[i].cq_poll_lock);
-		nvme_poll_cq(&dev->queues[i], NULL);
+		nvme_poll_cq(&dev->queues[i], NULL, NULL);
 		spin_unlock(&dev->queues[i].cq_poll_lock);
 	}
 }
@@ -2171,9 +2349,14 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
 
-	if (use_threaded_interrupts) {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+	/*
+	 * Adaptive polling masks the entire vector, so don't use it when
+	 * multiple queues share the single available vector.
+	 */
+	if (use_adaptive_polling && nvmeq->dev->num_vecs > 1) {
+		return pci_request_irq(pdev, nvmeq->cq_vector,
+				nvme_irq_adaptive_poll, nvme_adaptive_poll, nvmeq,
+				"nvme%dq%d", nr, nvmeq->qid);
 	} else {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
 				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
@@ -2186,6 +2369,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 
 	nvmeq->sq_tail = 0;
 	nvmeq->last_sq_tail = 0;
+	nvmeq->sq_head = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];

