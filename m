From: haggaie@mellanox.com (Haggai Eran)
Date: Thu, 5 Jan 2017 13:02:45 +0200
Subject: phys_addr_t instead of dma_addr_t for nvme_dev->cmb_dma_addr
In-Reply-To: <1d5efe82-0654-3217-ffde-fb6ad499170a@mellanox.com>
References: <1d5efe82-0654-3217-ffde-fb6ad499170a@mellanox.com>
Message-ID: <1ce2030c-d31f-0ad4-02db-410abfc87c06@mellanox.com>

On 1/5/2017 12:20 PM, Max Gurtovoy wrote:
> dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
> cmb = ioremap_wc(dma_addr, size);
> if (!cmb)
>     return NULL;
> 
> dev->cmb_dma_addr = dma_addr;
> dev->cmb_size = size;
> 
> in nvme_map_cmb func. pci_resource_start should return resource_size_t (phys_addr_t) and not dma_addr_t. I don't have the HW to check this code and propose a fix but it's seems buggy for me. In case we need dma address we should map it.

Perhaps I'm mistaken, but shouldn't the code use pcibios_resource_to_bus()
in this case to convert the resource to bus addresses? I see cmb_dma_addr 
is later passed directly to the device as the sq_dma_addr.

Haggai
