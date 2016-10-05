From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Oct 2016 12:42:08 +0300
Subject: [PATCH rfc 0/6] convert nvme pci to use irq-poll service
Message-ID: <1475660534-16681-1-git-send-email-sagi@grimberg.me>

Currently we have a couple of problems with our completion processing scheme:

1. We abuse the polling context by doing it from hard-irq (which is
why the threaded interrupts mode was introduced). We can possibly
stay there for too long causing us to hard-lockup (can be triggered
easily by running heavy randread workloads on systems with lots of
cpu cores).

2. We lack fairness between completion queues that share the same
MSI/MSIX assignment (completion queues that belong to different
devices). We need to drain a completion queue completely before
we can process another completion queue.

irq-poll service solves both by correctly budgeting the completion
processing contexts and keeping per-cpu queues of completion queues.
By using it we can reduce the number of overall nvme interrupts in
the system which is a bonus.

I ran some tests with this and it seemed to work pretty well with
my low-end nvme devices. One phenomenon I've encountered was that
for single core long queue-depth'ed randread workload I saw around
~8-10% iops decrease. However when running multi-core IO I didn't
see any noticeable performance degradation. non-polling Canonical
randread latency doesn't seem to be affected as well. And also
polling mode IO is not affected as expected.

So in addition for review and feedback, this is a call for testing
and benchmarking as this touches the critical data path.

Sagi Grimberg (6):
  nvme-pci: Split __nvme_process_cq to poll and handle
  nvme-pci: Add budget to __nvme_process_cq
  nvme-pci: Use irq-poll for completion processing
  nvme: don't consume cq in queue_rq
  nvme-pci: open-code polling logic in nvme_poll
  nvme-pci: Get rid of threaded interrupts

 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/pci.c   | 179 ++++++++++++++++++++++++++--------------------
 2 files changed, 101 insertions(+), 79 deletions(-)

-- 
2.7.4
