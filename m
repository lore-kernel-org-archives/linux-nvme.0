From: haggaie@mellanox.com (Haggai Eran)
Date: Sun, 8 Jan 2017 10:55:28 +0200
Subject: phys_addr_t instead of dma_addr_t for nvme_dev->cmb_dma_addr
In-Reply-To: <20170105183933.GA4724@localhost.localdomain>
References: <1d5efe82-0654-3217-ffde-fb6ad499170a@mellanox.com>
 <1ce2030c-d31f-0ad4-02db-410abfc87c06@mellanox.com>
 <20170105183933.GA4724@localhost.localdomain>
Message-ID: <0846672a-484d-ab80-aa1c-751042405f29@mellanox.com>

On 1/5/2017 8:39 PM, Jon Derrick wrote:
>> Perhaps I'm mistaken, but shouldn't the code use pcibios_resource_to_bus()
>> in this case to convert the resource to bus addresses? I see cmb_dma_addr 
>> is later passed directly to the device as the sq_dma_addr.
>>
> That gets us a region from a window within a larger region, but to me it
> looks to me like resource_contains() would fail to match if the CMB
> region went beyond the window.
I thought that the CMB must fit in its BAR, and therefore in the window that 
contains it. Isn't it so?

> There's another option - pci_bus_addr_t/pci_bus_region takes the largest
> of phys_addr_t's width and dma_addr_t's width. So in the cases where
> those two types might differ it should still be able to hold a valid
> physical address, which is what both the resource API and Create-SQes
> expect.
I don't think the issue is just the width of the types. What happens on 
architectures where phy_addr_t addresses are translated before going to 
the PCIe bus?

Regards,
Haggai
