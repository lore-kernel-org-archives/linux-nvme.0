From: shan.hai@oracle.com (Shan Hai)
Date: Wed, 12 Oct 2016 15:35:04 +0800
Subject: [PATCH 0/1] Fix cpu hotplug failure when multiple nvme devices are
 installed
Message-ID: <1476257705-9836-1-git-send-email-shan.hai@oracle.com>


The cpu hotplug operation would fail on a large NUMA system installed
with multiple nvme devices with the below message:


CPU 2 disable failed: CPU has 189 vectors assigned and there are
only 0 available.

The root cause is that the large number of nvme queue IRQs deplete
the IRQ vector space of the remaining online cpus when the IRQs are
migrated.

This patch provides a solution to this problem by setting a limit
to the number of nvme I/O queues to reduce the nvme queue IRQs to
an acceptable number.

Thanks
Shan Hai
