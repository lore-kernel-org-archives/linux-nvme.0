From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 11 Jan 2017 08:36:26 -0700
Subject: phys_addr_t instead of dma_addr_t for nvme_dev->cmb_dma_addr
In-Reply-To: <1484122522.26936.9.camel@mellanox.com>
References: <1d5efe82-0654-3217-ffde-fb6ad499170a@mellanox.com>
 <1ce2030c-d31f-0ad4-02db-410abfc87c06@mellanox.com>
 <20170105183933.GA4724@localhost.localdomain>
 <0846672a-484d-ab80-aa1c-751042405f29@mellanox.com>
 <20170109215422.GA5286@localhost.localdomain>
 <1484122522.26936.9.camel@mellanox.com>
Message-ID: <20170111153626.GA5485@localhost.localdomain>

On Wed, Jan 11, 2017@08:15:23AM +0000, Haggai Eran wrote:
> On Mon, 2017-01-09@14:54 -0700, Jon Derrick wrote:
> > On Sun, Jan 08, 2017@10:55:28AM +0200, Haggai Eran wrote:
> > > 
> > > On 1/5/2017 8:39 PM, Jon Derrick wrote:
> > > > 
> > > > > 
> > > > > Perhaps I'm mistaken, but shouldn't the code use
> > > > > pcibios_resource_to_bus()
> > > > > in this case to convert the resource to bus addresses? I see
> > > > > cmb_dma_addr?
> > > > > is later passed directly to the device as the sq_dma_addr.
> > > > > 
> > > > That gets us a region from a window within a larger region, but
> > > > to me it
> > > > looks to me like resource_contains() would fail to match if the
> > > > CMB
> > > > region went beyond the window.
> > > I thought that the CMB must fit in its BAR, and therefore in the
> > > window that?
> > > contains it. Isn't it so?
> > > 
> > The spec is unclear if it's the host's responsibility to stay within
> > the
> > BAR, or the device's to reduce CMBLOC and CMBSZ to fit:
> > 
> > "If the Offset + Size exceeds the length of
> > the indicated BAR, the size available to the host is limited by the
> > length of the BAR."
> 
> If the BAR is smaller than (offset + size) then any address that is
> outside the BAR must be treated by the device as if it is not in the
> CMB (otherwise some other devices / host memory will simply be
> inaccessible by the NVMe device).?
> > 
> > I think this would only happen if we're behind a bridge with a
> > smaller
> > window than BAR.
> 
> I'm pretty sure that the bridge window must contain the underlying
> device BARs. If it can't contain them, they can be simply left
> disabled.
> 
Oh good. I wasn't aware of those restrictions. That should make
pcibus_resource_to_bus a possibility.

> The situation can still happen in case the NVMe device exposes a
> smaller BAR than the CMB, or if it supports the resizeable BAR PCIe
> capability and the BIOS resized it to a smaller size (although I
> haven't heard of any device or BIOS that supports that).?
> 
> > 
> > 
> > > 
> > > > 
> > > > There's another option - pci_bus_addr_t/pci_bus_region takes the
> > > > largest
> > > > of phys_addr_t's width and dma_addr_t's width. So in the cases
> > > > where
> > > > those two types might differ it should still be able to hold a
> > > > valid
> > > > physical address, which is what both the resource API and Create-
> > > > SQes
> > > > expect.
> > > I don't think the issue is just the width of the types. What
> > > happens on?
> > > architectures where phy_addr_t addresses are translated before
> > > going to?
> > > the PCIe bus?
> > If we have a DMA translation, we get the host side addresses from the
> > ioremapping and I believe the device is still expecting the
> > untranslated
> > addresses, since it needs to DMA over the fabric. Do archs exists
> > that
> > don't fit this model?
> I'm not talking about DMA translation. I'm talking about MMIO
> translation. From what I understand this can happen on POWER systems.
> The physical addresses for MMIO that are used by the CPU are different
> from the ones that are used on the PCIe bus.
> 
I hadn't considered those but the address given in the Create SQes
command still should be in the range of the addresses in the device's
BARs. I'm guessing we'll may have to go through the IOMMU subsystem to
untranslate those.

> Regards,
> Haggai
