From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 5 Jan 2017 12:20:19 +0200
Subject: phys_addr_t instead of dma_addr_t for nvme_dev->cmb_dma_addr
Message-ID: <1d5efe82-0654-3217-ffde-fb6ad499170a@mellanox.com>

hi Guys,
we have noticed that in drivers/nvme/host/pci.c we have the following lines:

"
dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
cmb = ioremap_wc(dma_addr, size);
if (!cmb)
     return NULL;

dev->cmb_dma_addr = dma_addr;
dev->cmb_size = size;

"

in nvme_map_cmb func. pci_resource_start should return resource_size_t 
(phys_addr_t) and not dma_addr_t. I don't have the HW to check this code 
and propose a fix but it's seems buggy for me. In case we need dma 
address we should map it.

thanks,
Max.
