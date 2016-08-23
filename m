From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Aug 2016 10:41:57 -0400
Subject: NVME PCI driver question
In-Reply-To: <0aa9297eed8d4090a5e24c611e47d7c7@CWMAIL-AP-F14.dji.com>
References: <0aa9297eed8d4090a5e24c611e47d7c7@CWMAIL-AP-F14.dji.com>
Message-ID: <20160823144157.GF28276@localhost.localdomain>

On Tue, Aug 23, 2016@09:03:07AM +0000, First Light wrote:
> Dear maintainers of NVME driver
> I have a question about NVME driver.
> In drivers/nvme/host/pci.c, function: nvme_dev_map calls pci_enable_msix, what if  a device just supports MSI but doesn't support MSIX? in such logic, if   pci_enable_msix failed,

It sounds like you're not using the most recent version of the driver.

The function you're referring sets up early initialisation and would
use MSI-x if INTx was not available. This version of the driver would
also poll for completions if INTx wasn't working.

The nvme_setup_io_queues function would redo all the interrupt setup
once the driver knew how many vectors it needed to allocate. This
routine would fallback to MSI if MSI-x was not supported, so you should
be fine.

> I'm using synopsys pcie driver which doesn't support MSIX, but I also want to use it to connect a SSD, what should I do to make it work?

I assume you mean synopsys pcie "drive" rather than driver. It should
work just fine.
