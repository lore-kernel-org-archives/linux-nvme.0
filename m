From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Wed,  6 Jul 2016 18:03:30 -0300
Subject: [PATCH 0/3] dma, nvme,
 powerpc: introduce and implement DMA_ATTR_NO_WARN
Message-ID: <1467839013-22481-1-git-send-email-mauricfo@linux.vnet.ibm.com>

This patchset introduces dma_attr DMA_ATTR_NO_WARN (just like __GFP_NOWARN),
which tells the DMA-mapping subsystem to supress allocation failure reports.

On some architectures allocation failures are reported with error messages
to the system logs.  Although this can help to identify and debug problems,
drivers which handle failures (eg, retry later) have no problems with them,
and can actually flood the system logs with error messages that aren't any
problem at all, depending on the implementation of the retry mechanism.

So, this provides a way for drivers to avoid those error messages on calls
where allocation failures are not a problem, and shouldn't bother the logs.

 - Patch 1/3 introduces and documents the new dma_attr.

 - Patch 2/3 implements it on the nvme driver (which might repeatedly trip
             on allocation failures due to high load, flooding system logs
             with error messages at least on powerpc: "iommu_alloc failed")

 - Patch 3/3 implements support for it on powerpc arch (where this problem
             was observed.  It's possible to extend support for more archs
             if the patchset is welcome).

Mauricio Faria de Oliveira (3):
  dma: introduce DMA_ATTR_NO_WARN
  nvme: implement DMA_ATTR_NO_WARN
  powerpc: implement DMA_ATTR_NO_WARN

 Documentation/DMA-attributes.txt | 17 +++++++++++++++++
 arch/powerpc/kernel/iommu.c      |  4 ++--
 drivers/nvme/host/pci.c          | 10 ++++++++--
 include/linux/dma-attrs.h        |  1 +
 4 files changed, 28 insertions(+), 4 deletions(-)

-- 
1.8.3.1
