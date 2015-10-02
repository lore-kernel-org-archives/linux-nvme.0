From: nacc@linux.vnet.ibm.com (Nishanth Aravamudan)
Date: Fri, 2 Oct 2015 10:16:06 -0700
Subject: [PATCH 0/2] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151002171606.GA41011@linux.vnet.ibm.com>

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

This series consists of two patches, one of which exposes the IOMMU's
page shift on Power (currently only the page size is exposed, and it
seems unnecessary to ilog2 that value in the driver). The second patch
leverages this value on Power in the NVMe driver.

With these patches, a NVMe device survives our internal hardware
exerciser; the kernel BUGs within a few seconds without the patch.
