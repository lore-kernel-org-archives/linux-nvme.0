From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 16 Feb 2019 18:13:06 +0100
Subject: [patch v6 0/7] genirq/affinity: Overhaul the multiple interrupt sets
 support
Message-ID: <20190216171306.403545970@linutronix.de>

This is the final update to the series with a few corner cases fixes
vs. V5 which can be found here:

   https://lkml.kernel.org/r/20190214204755.819014197 at linutronix.de

The series applies against:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

and is also available from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.irq

Changes vs. V5:

  - Change the invocation for the driver callback so it is invoked even
    when there are no interrupts left to spread out. That ensures that the
    driver can adjust to the situation (in case of NVME a single interrupt)

  - Make sure the callback is invoked in the legacy irq fallback case so
    the driver is not in a stale state from a failed MSI[X} allocation
    attempt.

  - Fix the adjustment logic in the NVME driver as pointed out by Ming and
    Marc, plus another corner case I found during testing.

  - Simplify the unmanaged set support

Thanks,

	tglx

8<-------------
 drivers/nvme/host/pci.c         |  117 +++++++++++++---------------------------
 drivers/pci/msi.c               |   39 +++++--------
 drivers/scsi/be2iscsi/be_main.c |    2 
 include/linux/interrupt.h       |   35 ++++++++---
 include/linux/pci.h             |    4 -
 kernel/irq/affinity.c           |  116 ++++++++++++++++++++++++---------------
 6 files changed, 153 insertions(+), 160 deletions(-)
