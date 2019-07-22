From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:45 -0600
Subject: [PATCH 00/14] PCI/P2PDMA: Support transactions that hit the host
 bridge
Message-ID: <20190722230859.5436-1-logang@deltatee.com>

As discussed on the list previously, in order to fully support the
whitelist Christian added with the IOMMU, we must ensure that we
map any buffer going through the IOMMU with an aprropriate dma_map
call. This patchset accomplishes this by cleaning up the output of
upstream_bridge_distance() to better indicate the mapping requirements,
caching these requirements in an xarray, then looking them up at map
time and applying the appropriate mapping method.

After this patchset, it's possible to use the NVMe-of P2P support to
transfer between devices without a switch on the whitelisted root
complexes. A couple Intel device I have tested this on have also
been added to the white list.

Most of the changes are contained within the p2pdma.c, but there are
a few minor touches to other subsystems, mostly to add support
to call an unmap function.

The final patch in this series demonstrates a possible
pci_p2pdma_map_resource() function that I expect Christian will need
but does not have any users at this time so I don't intend for it to be
considered for merging.

This patchset is based on 5.3-rc1 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem/ p2pdma_rc_map_v1

--

Logan Gunthorpe (14):
  PCI/P2PDMA: Add constants for not-supported result
    upstream_bridge_distance()
  PCI/P2PDMA: Factor out __upstream_bridge_distance()
  PCI/P2PDMA: Apply host bridge white list for ACS
  PCI/P2PDMA: Cache the result of upstream_bridge_distance()
  PCI/P2PDMA: Factor out host_bridge_whitelist()
  PCI/P2PDMA: Add whitelist support for Intel Host Bridges
  PCI/P2PDMA: Add the provider's pci_dev to the dev_pgmap struct
  PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
  PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
  PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
  PCI/P2PDMA: dma_map P2PDMA map requests that traverse the host bridge
  PCI/P2PDMA: No longer require no-mmu for host bridge whitelist
  PCI/P2PDMA: Update documentation for pci_p2pdma_distance_many()
  PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()

 drivers/infiniband/core/rw.c |   6 +-
 drivers/nvme/host/pci.c      |  10 +-
 drivers/pci/p2pdma.c         | 400 +++++++++++++++++++++++++++--------
 include/linux/memremap.h     |   1 +
 include/linux/pci-p2pdma.h   |  28 ++-
 5 files changed, 341 insertions(+), 104 deletions(-)

--
2.20.1
