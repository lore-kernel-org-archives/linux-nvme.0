Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43754CA6006
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2026 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kI6agDxL1eh8YPLkDIP44zBbj716g5bLAuc2cGCeaR4=; b=Qj9ayUhdQY2lFlmOjfJcEtF8oT
	1ki9YegM2YqwhiRYX1sD8fz1tW3SuO/WbQ2IkAIlVhln4bnFTGGlPZY2TA6hIC8Eko6727LMBOqlx
	rfrccGDAhMo9c9yCKpM7VgfPCKSrgftFfGAXg5v32Gu88jlFpTdIM/cvjpJ/97rrLRBXJ5kNxMgzV
	9hLQwURLEb35jFbP+WPM9r/W9RK8WkxbW6Qg5pdoI+/nOmjTWvOq7AbyMJtSUD7LCWrdVY4l/2+Uk
	belRTRsC2BtyJnEorYgmCvC9t6gFu81EAzQPEX7sP/5BmqU8W3Jvk6SVKlypk6J9eCMUF1OdIHIvB
	NcWI37Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE6Ee-00000000xHm-2Asm;
	Tue, 06 Oct 2026 14:33:40 +0000
Received: from mail-dl1-x1248.google.com ([2607:f8b0:4864:20::1248])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE6Eb-00000000xFW-0H9p
	for linux-nvme@lists.infradead.org;
	Tue, 06 Oct 2026 14:33:38 +0000
Received: by mail-dl1-x1248.google.com with SMTP id a92af1059eb24-1384427c3efso4293651c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791297215; x=1791902015; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kI6agDxL1eh8YPLkDIP44zBbj716g5bLAuc2cGCeaR4=;
        b=DUNpU1DxMIlK7wlHVy2lK/3en6V0GxqRgpJpLF7f4V8niVU/rNqNL0oaqbcjrmNTVM
         Vm7ucmPA4qJGKBusIuaKeZ16uhs7bm4Tm149W8C9disn1DDbg+0eb5ZP6TTTKim72Ob6
         yJmzKOaOs2YSR1jn2tv/o96zQW+Cm7JEOiFmS40m26Dpw6r68SZ9SQr95p4zx9HDIIzJ
         BQAYBpgwY2mwFPYtD8ERXeT15Ekw7TQPrc2a3ut2ae3neEicaSftcG1IWmlF5yc2Osbv
         C1dAdxWk3djMzU6dv4F1XD2Zowzen4XDiWTyFBEQAoJX9Nk+6RR4T47X7vMTslDYIrAc
         abDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297215; x=1791902015;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kI6agDxL1eh8YPLkDIP44zBbj716g5bLAuc2cGCeaR4=;
        b=ME3j2BDViv5hBT1NmWdKOezHef2X6FvbuAKx6CcAjEgoNnvcpHjQdBoryTHwHXxVaU
         7xmRwntN9OLYXD7rwxS8wTsBGTrvtojd6iT6/Hh4x/Pb7A5I4KNHWvhZhtYp6T7rRW+m
         2doxhRgX5Ej8cXpGkGEVt7jsUifJiHptfslLFexaCHi4fxbeQ8ZrLRWdUx4lh+rR/jyA
         hH23Yqe79CMMgMaRl8jtgA5EeOXODhVyTFKID1A2lomyuoeL26ZJTphduMKObysBuH8E
         K3oJ6yY+qApLHuaItCAW2BQ01kqc9xjvNbt4RP8Bp2QrDsRt6mIX5XgGN69XFIVCvonm
         a4hA==
X-Forwarded-Encrypted: i=1; AKwUvBxnyDS16zhh+vGiKB23xWuytucJzAiZ/wascC+A3wWjQZcSECpNYesVUeO9OF+6Ea72jDkJhRXD3Cxp@lists.infradead.org
X-Gm-Message-State: AFuF++kGhF1qvZAc+T6d1q44iQNGmVKHAggbuIGs6Qm+xoTrv0npJr/K
	ElJDItd/nHGMg8YuRjXNU1JZHaqM61m+s0/KctuhFuih9YObaaugj/AuvgUFmHHgzp02eJ62xsd
	obBcxwh653g==
X-Received: from dlbou16.prod.google.com ([2002:a05:7022:1110:b0:14d:a680:6081])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2506:b0:156:3684:96d4
 with SMTP id a92af1059eb24-15eca26aa8amr1928661c88.25.1791297214392; Tue, 06
 Oct 2026 07:33:34 -0700 (PDT)
Date: Tue,  6 Oct 2026 14:33:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006143329.2415252-1-afranji@google.com>
Subject: [RFC PATCH] nvme-pci: defer batch completion to unbound workqueue for SWIOTLB
From: Ryan Afranji <afranji@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Petr Tesarik <ptesarik@suse.com>, 
	Luigi Rizzo <lrizzo@google.com>, linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_073337_138885_2611DF2F 
X-CRM114-Status: GOOD (  22.54  )
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

High-bandwidth NVMe read workloads when SWIOTLB bounce buffering is
forced enabled (e.g. all confidential VMs) can cause guest CPU
soft lockups.

The root cause is that each NVMe queue has a dedicated interrupt vector
pinned to a single vCPU. During I/O read completions, the interrupt
handler executes on that pinned vCPU and invokes
nvme_pci_complete_batch(), which unmaps requests via
nvme_pci_unmap_rq(). When SWIOTLB bounce buffering is active, DMA
unmapping performs CPU-heavy memory copies to transfer data from
shared/unencrypted bounce buffers to private guest memory. As read
throughput scales, this memory copying saturates 100% of the pinned
vCPU's execution time in hard IRQ context, starving other kernel threads
and watchdogs, leading to soft lockup stalls.

While increasing the number of NVMe queues and reducing queue depth in
the VMM mitigates the issue by distributing the SWIOTLB bounces across
more vCPUs, it is only a temporary workaround: expensive compute work
remains inside the hard IRQ handler, and next-generation storage or
faster host platforms will still saturate the assigned cores.

Address this by deferring completion batch processing out of the hard
IRQ handler into an unbound, high-priority workqueue (swiotlb_wq,
allocated with WQ_HIGHPRI | WQ_UNBOUND). Allocate a dedicated workqueue
for each NVMe I/O queue to limit workqueue lock contention.

Introduce a module parameter 'force_bounce_swiotlb_wq'. When enabled,
nvme_irq() packages the io_comp_batch into a work item and defers
nvme_pci_complete_batch() to the queue's swiotlb_wq. If the atomic
allocation of the deferred work item fails, it falls back to immediate
in-IRQ completion.

Deferring completion to an unbound workqueue provides two key benefits:
1. Work executes in worker thread context at lower priority, allowing
   watchdog and other kernel threads to run thus preventing soft
   lockups.
2. The unbound workqueue allows the kernel scheduler to distribute
   bounce-buffer copy work across any available vCPU rather than
   bottlenecking the single vCPU pinned to the NVMe interrupt.

Across 40 consecutive test runs under high-bandwidth workloads, baseline
in-IRQ completions frequently suffered soft lockups, whereas the
deferred workqueue implementation completely eliminated them.

The benchmark results in the tables below compare performance with this
feature enabled against the existing implementation ('+' indicates
performance improvement, '-' indicates regression):

  4 vCPUs (2 Queues)
  Metric                      p5        p50
  =========================================
  IOPS                    +7.59%     +4.05%
  Bandwidth               +1.53%     +1.18%
  Latency (clat p50)     -10.41%     -3.88%
  Latency (clat p90)      +1.74%     +5.51%
  Latency (clat p99.9)   +16.44%     +9.86%

  176 vCPUs (4 Queues)
  Metric                      p5        p50
  =========================================
  IOPS                   +90.32%    +93.32%
  Bandwidth               +9.57%    +10.68%
  Latency (clat p50)      -9.58%     -8.70%
  Latency (clat p90)      -9.91%     -7.51%
  Latency (clat p99.9)    -8.00%     +4.58%

Signed-off-by: Ryan Afranji <afranji@google.com>
---
 drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..a20d6bd12ef0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,6 +24,7 @@
 #include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
@@ -277,6 +278,11 @@ static bool noacpi;
 module_param(noacpi, bool, 0444);
 MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 
+static bool force_bounce_swiotlb_wq;
+module_param(force_bounce_swiotlb_wq, bool, 0644);
+MODULE_PARM_DESC(force_bounce_swiotlb_wq,
+		 "Defer NVMe completion batch to swiotlb_wq");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -395,6 +401,7 @@ struct nvme_queue {
 	__le32 *dbbuf_sq_ei;
 	__le32 *dbbuf_cq_ei;
 	struct completion delete_done;
+	struct workqueue_struct *swiotlb_wq;
 };
 
 /* bits for iod->flags */
@@ -1541,6 +1548,35 @@ static void nvme_pci_complete_batch(struct io_comp_batch *iob)
 	nvme_complete_batch(iob, nvme_pci_unmap_rq);
 }
 
+struct nvme_pci_complete_batch_work {
+	struct work_struct work;
+	struct io_comp_batch iob;
+};
+
+static void nvme_pci_complete_batch_work_fn(struct work_struct *work)
+{
+	struct nvme_pci_complete_batch_work *w =
+		container_of(work, struct nvme_pci_complete_batch_work, work);
+
+	nvme_pci_complete_batch(&w->iob);
+	kfree(w);
+}
+
+static void nvme_pci_complete_batch_deferred(struct nvme_queue *nvmeq,
+					     struct io_comp_batch iob)
+{
+	struct nvme_pci_complete_batch_work *w;
+
+	w = kmalloc_obj(*w, GFP_ATOMIC);
+	if (w) {
+		INIT_WORK(&w->work, nvme_pci_complete_batch_work_fn);
+		w->iob = iob;
+		queue_work(nvmeq->swiotlb_wq, &w->work);
+	} else {
+		nvme_pci_complete_batch(&iob);
+	}
+}
+
 /* We read the CQE phase first to check if the rest of the entry is valid */
 static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 {
@@ -1644,8 +1680,12 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	DEFINE_IO_COMP_BATCH(iob);
 
 	if (nvme_poll_cq(nvmeq, &iob)) {
-		if (!rq_list_empty(&iob.req_list))
-			nvme_pci_complete_batch(&iob);
+		if (!rq_list_empty(&iob.req_list)) {
+			if (force_bounce_swiotlb_wq && nvmeq->swiotlb_wq)
+				nvme_pci_complete_batch_deferred(nvmeq, iob);
+			else
+				nvme_pci_complete_batch(&iob);
+		}
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -2026,6 +2066,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 static void nvme_free_queue(struct nvme_queue *nvmeq)
 	__context_unsafe(/* frees queue which is no longer in use */)
 {
+	if (nvmeq->swiotlb_wq) {
+		destroy_workqueue(nvmeq->swiotlb_wq);
+		nvmeq->swiotlb_wq = NULL;
+	}
 	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (!nvmeq->sq_cmds)
@@ -2065,6 +2109,8 @@ static void nvme_suspend_queue(struct nvme_dev *dev, unsigned int qid)
 		nvme_quiesce_admin_queue(&nvmeq->dev->ctrl);
 	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
 		pci_free_irq(to_pci_dev(dev->dev), nvmeq->cq_vector, nvmeq);
+	if (nvmeq->swiotlb_wq)
+		flush_workqueue(nvmeq->swiotlb_wq);
 }
 
 static void nvme_suspend_io_queues(struct nvme_dev *dev)
@@ -2158,9 +2204,15 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	if (nvme_alloc_sq_cmds(dev, nvmeq, qid))
+	nvmeq->swiotlb_wq = alloc_workqueue("nvme%dq%d-swiotlb-wq",
+					    WQ_HIGHPRI | WQ_UNBOUND, 0,
+					    dev->ctrl.instance, qid);
+	if (!nvmeq->swiotlb_wq)
 		goto free_cqdma;
 
+	if (nvme_alloc_sq_cmds(dev, nvmeq, qid))
+		goto free_wq;
+
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->sq_lock);
 	spin_lock_init(&nvmeq->cq_poll_lock);
@@ -2172,6 +2224,9 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 
 	return 0;
 
+ free_wq:
+	destroy_workqueue(nvmeq->swiotlb_wq);
+	nvmeq->swiotlb_wq = NULL;
  free_cqdma:
 	dma_free_coherent(dev->dev, CQ_SIZE(nvmeq), (void *)nvmeq->cqes,
 			  nvmeq->cq_dma_addr);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


