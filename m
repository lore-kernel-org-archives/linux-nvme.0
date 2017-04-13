From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 13 Apr 2017 18:26:31 -0500
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1491974532.7236.43.camel@kernel.crashing.org>
 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
 <1492034124.7236.77.camel@kernel.crashing.org>
 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
Message-ID: <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>

On Thu, Apr 13, 2017@03:22:06PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 12/04/17 03:55 PM, Benjamin Herrenschmidt wrote:
> > Look at pcibios_resource_to_bus() and pcibios_bus_to_resource(). They
> > will perform the conversion between the struct resource content (CPU
> > physical address) and the actual PCI bus side address.
> 
> Ah, thanks for the tip! On my system, this translation returns the same
> address so it was not necessary. And, yes, that means this would have to
> find its way into the dma mapping routine somehow. This means we'll
> eventually need a way to look-up the p2pmem device from the struct page.
> Which means we will likely need a new flag bit in the struct page or
> something. The big difficulty I see is testing. Do you know what
> architectures or in what circumstances are these translations used?

Any caller of pci_add_resource_offset() uses CPU addresses different from
the PCI bus addresses (unless the offset is zero, of course).  All ACPI
platforms also support this translation (see "translation_offset"), though
in most x86 systems the offset is zero.  I'm aware of one x86 system that
was tested with a non-zero offset but I don't think it was shipped that
way.

Bjorn
