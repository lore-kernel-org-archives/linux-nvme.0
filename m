From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 13:09:53 -0700
Subject: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
In-Reply-To: <20151002171606.GA41011@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
Message-ID: <20151002200953.GB40695@linux.vnet.ibm.com>

We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).
 
The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).
 
In this particular case, and generally, we want to use the IOMMU's page
size for the default device page size, rather than the kernel's page
size.
 
This series consists of five patches:

1) add a generic dma_get_page_shift implementation that just returns
PAGE_SHIFT
2) override the generic implementation on Power to use the IOMMU table's
page shift if available
3) allow further specific overriding on power with machdep platform
overrides
4) use the machdep override on pseries, as the DDW code puts the TCE
shift in a special property and there is no IOMMU table available
5) leverage the new API in the NVMe driver
 
With these patches, a NVMe device survives our internal hardware
exerciser; the kernel BUGs within a few seconds without the patch.

 arch/powerpc/include/asm/dma-mapping.h   |  3 +++
 arch/powerpc/include/asm/machdep.h       |  3 ++-
 arch/powerpc/kernel/dma.c                | 11 +++++++++++
 arch/powerpc/platforms/pseries/iommu.c   | 36 ++++++++++++++++++++++++++++++++++++
 drivers/block/nvme-core.c                |  3 ++-
 include/asm-generic/dma-mapping-common.h |  7 +++++++
 6 files changed, 61 insertions(+), 2 deletions(-)

v1 -> v2:
  Based upon feedback from Christoph Hellwig, rather than using an
  arch-specific hack, expose the DMA page shift via a generic DMA API and
  override it on Power as needed.
