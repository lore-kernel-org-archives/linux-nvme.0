From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 21 Jun 2016 17:28:30 -0500
Subject: [PATCH v3 0/6] Introduce pci_(request|release)_(mem|io)_regions
In-Reply-To: <cover.1465200424.git.jthumshirn@suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
Message-ID: <20160621222830.GF7603@localhost>

On Tue, Jun 07, 2016@09:44:00AM +0200, Johannes Thumshirn wrote:
> The first patch in this series introduces the following 4 helper functions to
> the PCI core:
> 
> * pci_request_mem_regions()
> * pci_request_io_regions()
> * pci_release_mem_regions()
> * pci_release_io_regions()
> 
> which encapsulate the request and release of a PCI device's memory or I/O
> bars.
> 
> The subsequent patches convert the drivers, which use the
> pci_request_selected_regions(pdev, 
> 	pci_select_bars(pdev, IORESOURCE_MEM), name); 
> and similar pattern to use the new interface.
> 
> This was suggested by Christoph Hellwig in
> http://lists.infradead.org/pipermail/linux-nvme/2016-May/004570.html and
> tested on kernel v4.6 with NVMe.

I applied all six of these to pci/resources for v4.8, thanks, Johannes.

> Johannes Thumshirn (6):
>   PCI: Add helpers to request/release memory and I/O regions
>   NVMe: Use pci_(request|release)_mem_regions
>   lpfc: Use pci_(request|release)_mem_regions
>   GenWQE: Use pci_(request|release)_mem_regions
>   ethernet/intel: Use pci_(request|release)_mem_regions
>   alx: Use pci_(request|release)_mem_regions
> 
>  drivers/misc/genwqe/card_base.c               | 13 +++++--------
>  drivers/net/ethernet/atheros/alx/main.c       | 12 +++++-------
>  drivers/net/ethernet/intel/e1000e/netdev.c    |  6 ++----
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 11 +++--------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  9 +++------
>  drivers/net/ethernet/intel/igb/igb_main.c     | 10 +++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  9 +++------
>  drivers/nvme/host/pci.c                       | 10 +++-------
>  drivers/scsi/lpfc/lpfc_init.c                 | 15 ++++----------
>  include/linux/pci.h                           | 28 +++++++++++++++++++++++++++
