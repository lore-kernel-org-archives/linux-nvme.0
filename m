From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 5 Jan 2017 11:39:34 -0700
Subject: phys_addr_t instead of dma_addr_t for nvme_dev->cmb_dma_addr
In-Reply-To: <1ce2030c-d31f-0ad4-02db-410abfc87c06@mellanox.com>
References: <1d5efe82-0654-3217-ffde-fb6ad499170a@mellanox.com>
 <1ce2030c-d31f-0ad4-02db-410abfc87c06@mellanox.com>
Message-ID: <20170105183933.GA4724@localhost.localdomain>

On Thu, Jan 05, 2017@01:02:45PM +0200, Haggai Eran wrote:
> On 1/5/2017 12:20 PM, Max Gurtovoy wrote:
> > dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
> > cmb = ioremap_wc(dma_addr, size);
> > if (!cmb)
> >     return NULL;
> > 
> > dev->cmb_dma_addr = dma_addr;
> > dev->cmb_size = size;
> > 
> > in nvme_map_cmb func. pci_resource_start should return resource_size_t (phys_addr_t) and not dma_addr_t. I don't have the HW to check this code and propose a fix but it's seems buggy for me. In case we need dma address we should map it.
Good catch. It does look wrong to pass a dma_addr_t to ioremap_wc and
Create-SQes's PRP1.

> 
> Perhaps I'm mistaken, but shouldn't the code use pcibios_resource_to_bus()
> in this case to convert the resource to bus addresses? I see cmb_dma_addr 
> is later passed directly to the device as the sq_dma_addr.
> 
That gets us a region from a window within a larger region, but to me it
looks to me like resource_contains() would fail to match if the CMB
region went beyond the window.

There's another option - pci_bus_addr_t/pci_bus_region takes the largest
of phys_addr_t's width and dma_addr_t's width. So in the cases where
those two types might differ it should still be able to hold a valid
physical address, which is what both the resource API and Create-SQes
expect.

But I'd rather see full integration into the pci resource tree so that
it is aware of the CMB window. It isn't currently because the offset is
given in an nvme register. I'd like to see the resource tree aware of
all of this, and made a poor attempt to do that and sysfs integration at
the same time. But I think Haggai's genalloc modifications and
integration into the resource tree would mesh really well :)

I'll follow up with a patch shortly that I think fixes a few basic
issues expressed here.

Cheers
