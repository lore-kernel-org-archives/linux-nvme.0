From: hch@lst.de (Christoph Hellwig)
Date: Thu, 14 Jun 2018 16:59:42 +0200
Subject: Requirement to get BAR pci_bus_address in user space
In-Reply-To: <20180614085015.3f39b367@w520.home>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
 <20180614102001.GA20836@lst.de>
 <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
 <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
 <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
 <20180614085015.3f39b367@w520.home>
Message-ID: <20180614145942.GA4885@lst.de>

On Thu, Jun 14, 2018@08:50:15AM -0600, Alex Williamson wrote:
> I don't understand the CQ vs CMB, but I think I gather that there's some
> sort of buffer that's allocated from within the devices MMIO BAR and
> some programming of the device needs to reference that buffer.
> Wouldn't you therefore use the vfio type1 IOMMU MAP_DMA ioctl to map
> the BAR into the IOVA address space and you can then use the IOVA +
> offset into the BAR for the device to reference the buffer?  It seems
> this is the same way we'd setup a peer-to-peer mapping, but we're using
> it for the device to reference itself effectively.  Thanks,

That's exactly what I meant..
