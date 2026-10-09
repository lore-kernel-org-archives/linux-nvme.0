Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B37CA6015
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 05:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EZHcU/fJ75D/YFV+/52EKTOe0fXHRks66pGLOM+iPCY=; b=XEg8EDHV4zpJWJFotX4wiMkAvO
	cwKMjt2V/qr4vVZO6XO1ywPDlRAFDKPc3HUMzyBJYaj7xTgWjb5nlbCCeb8i8xVMaUQorrR8Gin3b
	+sN7rMVUPnDNTUM2vuVp0+2J5/KWgSiaxlTDNPZFuhoGx8JnT9/6eYSCs1CWcIP0DKJM2XJF4AShf
	jQLo1UXfBdlPBJM9Dlrc3GzVqeA9b8YzTOLsRQWqO9VeSrW0leAameMhzj1awxlCbf1YyWfG5Xaop
	YrZBriCGZYD7pIGowtiPQUBN0jzp8JVFEV54HDdrUoFLYxNj5AVn9d0xKes6+oU+b+333U3puWBVR
	GCxMndNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF2o3-00000005VMe-0WAE;
	Fri, 09 Oct 2026 05:06:07 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF2o0-00000005VLR-3Oxq
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 05:06:06 +0000
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1561420B7166;
	Thu,  8 Oct 2026 22:05:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1561420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791522362;
	bh=EZHcU/fJ75D/YFV+/52EKTOe0fXHRks66pGLOM+iPCY=;
	h=From:To:Cc:Subject:Date:From;
	b=api2nSQvkXes0vTfLg8ltk+65TUyn+gYl+AKbhcr7+VC2/zdTpYLVLuL4KJZUNhWg
	 1fb48ktyspoGOlV+iTWyo2lRKhQWjSZxarROwXNlGD3strzkxf571jrckizgqp9HIT
	 NkGL4E/SOlFQgUz6QMuXH1mDieFosT0CCqV9nBSM=
From: Naman Jain <namjain@linux.microsoft.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
Date: Fri,  9 Oct 2026 05:05:53 +0000
Message-ID: <20261009050556.2817978-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_220604_892989_77D46339 
X-CRM114-Status: GOOD (  17.27  )
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

Hi,

On systems with several fast NVMe controllers, completion interrupts can
keep returning to the same CPUs faster than scheduled work can run. Each
handler may drain only a small number of completions, but the combined
interrupt stream can still prevent scheduler and watchdog progress.

This series keeps the existing hardirq completion path for normal I/O.
For an I/O queue with a dedicated MSI-X vector, if an interrupt arrives
with a completion pending while need_resched() is set, mask that vector
and hand the queue to irq_poll. The poller drains bounded batches and
returns the queue to interrupt mode as soon as it catches up.

The completion-path transitions are:

                         +-----------------+
                         | normal IRQ mode |
                         +-----------------+
                                  |
                   CQE pending and need_resched()
                                  |
                                  v
                     mask vector, schedule irq_poll
                                  |
                                  v
                +--------------------------------+
          +---->| drain up to one poll budget    |
          |     +--------------------------------+
          |              |                 |
          |         full budget        short batch
          |              |                 |
          |              v                 v
          |     remain on poll list   irq_poll_complete()
          |              |           mark handoff allowance
          |     generic irq_poll      clear poll ownership
          |     invokes next pass     enable vector
          |              |                 |
          +--------------+                 v
                                  +-----------------+
                                  | normal IRQ mode |
                                  +-----------------+

A full-budget return deliberately stays on the irq_poll list. The generic
irq_poll core invokes another bounded pass. Eventually a pass consumes
less than its budget, takes the short-batch path, and restores interrupt
mode.

An MSI-X message may have been latched while the vector was masked, but
not every MSI-X hierarchy can report pending state. The handoff allowance
therefore does not claim that an interrupt is known to be stale. It lets
exactly one empty interrupt after unmasking return IRQ_HANDLED. If a new
completion is present, the normal completion path handles it.

The core idea is simple: when a hardirq sees need_resched(), it masks the
interrupt and offloads completion processing to irq_poll. The interrupt is
unmasked once the CQ catches up. Everything else handles queue and
controller state changes while irq_poll is active, because its asynchronous
callback can outlive the hardirq that scheduled it.

The lifecycle transitions are:

  normal IRQ mode / irq_poll
              |
              | set PAUSED, join IRQ and irq_poll, mask vector
              v
          +--------+
          | paused |---- temporary ----> resume after controller is ready
          +--------+                      clear PAUSED, restore IRQ mode
              |
              | permanent stop
              | clear INIT, balance owned mask, synchronize replay
              v
        free registered IRQ

INIT means the queue has an initialized irq_poll instance and a dedicated
MSI-X vector. IRQ_POLL owns completion processing, while MASKED records the
matching disable_irq_nosync(). PAUSED blocks IRQ handling and new admission.
HANDOFF allows one empty interrupt after unmasking. A temporary pause keeps
MASKED set for resume; permanent stop keeps PAUSED set through IRQ removal.

Admin, shared, legacy, and threaded interrupt paths are unchanged. Explicit
polling never enters irq_poll; it only disables bottom halves while holding
the shared CQ polling lock. The series adds no timer, rate sampler,
workqueue, sysfs knob, module parameter, or IRQ thread.

Why not use nvme.use_threaded_interrupts=1 instead?

Threaded mode installs nvme_irq_check() as the primary handler and
nvme_irq() as the IRQ thread. When the primary handler finds a pending
completion, it returns IRQ_WAKE_THREAD, so completion queue draining runs
through a schedulable task rather than the normal hardirq fast path.

That remains a useful opt-in mode and this series does not change it. On
the affected VM it prevented the lockup, but it also reduced peak
throughput. This series has a narrower goal: retain direct hardirq
completion while the CPU is keeping up, and use bounded irq_poll work
only after the scheduler has already asserted need_resched().

The distinction is not that irq_poll is always faster than an IRQ thread.
It is that the normal path is left alone, while the fallback creates a
scheduling boundary only after a reschedule request is observed.

need_resched() is used here as a best-effort pressure signal, not as an
interrupt-flood detector or an elapsed-time guarantee. It is transient,
and irq_poll may execute one bounded callback before the scheduler runs.
The narrower claim is that, once an NVMe hardirq observes an already
pending reschedule request, it stops unbounded CQ draining in hardirq.

Previous NVMe attempts made the fallback the normal high-load path. An
all-irq_poll RFC in 2016 reported an 8-10% single-core IOPS loss and a
measurable low-queue-depth latency cost. A hardirq-first, threaded
overflow series in 2019 fixed the Azure lockup, but Azure testing
reported a substantial throughput loss.

Relevant discussions from the past around this problem:

  https://lore.kernel.org/linux-nvme/1475660534-16681-1-git-send-email-sagi@grimberg.me/
  https://lore.kernel.org/lkml/1566281669-48212-1-git-send-email-longli@linuxonhyperv.com/
  https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/

The first patch selects IRQ_POLL. The second makes existing task-context
CQ polling safe against the new softirq user. The third adds the NVMe
queue handoff and lifecycle handling.

The RFC starts with a per-queue weight of 256, matching the existing
global irq_poll budget. This is a starting point, not a claim that 256 is
the optimal NVMe value.

Testing included:

  - full x86_64 kernel build and strict checkpatch
  - four-controller QEMU fio, full-disable S3, controller reset, and
    post-reset I/O
  - QEMU lockdep, prove-locking, and atomic-context validation
  - ARM64 Hyper-V VM with four 14-queue NVMe data controllers
  - natural irq_poll activation with threaded interrupts disabled
  - matching default-hardirq, IRQ-poll fallback, and threaded-IRQ comparison
  - four controller resets followed by successful reads

Read-only 4 KiB random-read results follow. "Default hardirq" uses the
unpatched base. The other modes use the same kernel built from this series:
"IRQ-poll fallback" uses the default nvme.use_threaded_interrupts=0, while
"threaded IRQs" uses nvme.use_threaded_interrupts=1. Low-load values are
medians of two 30-second runs. High-load fallback and threaded values are
medians of two and three 90-second runs respectively; the default-hardirq
run locked up before it could complete.

                              default       IRQ-poll      threaded
                              hardirq       fallback      IRQs
  1 disk, QD1
    IOPS                      24.42K        24.96K        21.24K
    mean completion latency  38.94 us      38.17 us      44.60 us
    p99 completion latency   90.6 us       90.1 us       94.2 us
    p99.9 completion latency 94.7 us       94.7 us      103.9 us

  4 disks, 128 jobs, QD256
    status                    lockup (26s)  pass           pass
    IOPS                      N/A           4.986M         3.165M
    bandwidth                 N/A          19.0 GiB/s     12.1 GiB/s
    mean completion latency   N/A           6.544 ms      10.332 ms
    p99 completion latency    N/A          14.483 ms      22.151 ms
    p99.9 completion latency  N/A          22.544 ms      24.773 ms

IRQ-poll fallback prevents hardirq starvation while avoiding the 15-37%
IOPS loss and higher latency observed with threaded interrupts, by
activating only under scheduler pressure.

Naman Jain (3):
  nvme-pci: select IRQ_POLL
  nvme-pci: make completion queue polling softirq-safe
  nvme-pci: defer completions when rescheduling is needed

 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/pci.c   | 295 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 283 insertions(+), 13 deletions(-)

base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
-- 
2.43.0

