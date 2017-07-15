From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 15 Jul 2017 01:51:41 -0700
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <20170714170846.GA24365@localhost.localdomain>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
 <20170710190818.GA13671@localhost.localdomain>
 <64da8c4d-2d69-22fa-06a0-aa4f11903e39@pse-consulting.de>
 <20170711194523.GD4604@localhost.localdomain>
 <458f2115-4a07-e23c-2f1f-a90a95668f74@pse-consulting.de>
 <20170712195012.GA8388@localhost.localdomain>
 <5ac79312-b9e3-7cbb-8a82-382fb99705b5@pse-consulting.de>
 <20170713134754.GD8388@localhost.localdomain>
 <39459fb9-ea2c-0718-10a1-a7e96b9ec21f@pse-consulting.de>
 <20170714170846.GA24365@localhost.localdomain>
Message-ID: <20170715085141.GC25753@infradead.org>

On Fri, Jul 14, 2017@01:08:47PM -0400, Keith Busch wrote:
> > So LVM2 backed by md raid1 isn't compatible with newer hardware... Any
> > suggestions?
> 
> It's not that LVM2 or RAID isn't compatible. Either the IOMMU isn't
> compatible if can use different page offsets for DMA addresses than the
> physical aaddresses, or the driver for it is broken. The DMA addresses
> in this mapped SGL look completely broken, at least, since the last 4
> entries are all the same address. That'll corrupt data.

Given that this is a Xen system I wonder if swiotlb-xen is involved
here, which does some odd chunking of dma translations?

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
