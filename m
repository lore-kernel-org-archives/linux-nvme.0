From: keith.busch@gmail.com (Keith Busch)
Date: Fri, 14 Jun 2019 13:36:07 -0600
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
References: <20190610074456.2761-1-drake@endlessm.com>
 <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>
 <CAD8Lp45djPU_Ur8uCO2Y5Sbek_5N9QKkxLXdKNVcvkr6rFPLUQ@mail.gmail.com>
 <CAOSXXT7H6HxY-za66Tr9ybRQyHsTdwwAgk9O2F=xK42MT8HsuA@mail.gmail.com>
 <20190613085402.GC13442@lst.de>
 <CAD8Lp47Vu=w+Lj77_vL05JYV1WMog9WX3FHGE+TseFrhcLoTuA@mail.gmail.com>
Message-ID: <CAOSXXT4Ba_6xRUyaQBxpq+zdG9_itXDhFJ5EFZPv3CQuJZKHzg@mail.gmail.com>

On Thu, Jun 13, 2019@8:26 PM Daniel Drake <drake@endlessm.com> wrote:
> On Thu, Jun 13, 2019@4:54 PM Christoph Hellwig <hch@lst.de> wrote:
> >  b) reset handling, including the PCI device removal as the last
> >     escalation step
>
> Apparently can't be supported, but it's not clear that this actually
> matters for a home PC...
>
> https://marc.info/?l=linux-ide&m=147733119300691&w=2
> "The driver seems to already comprehend instances where the
> device does not support nvme_reset_subsystem() requests."
>
> https://marc.info/?l=linux-ide&m=147734288604783&w=2
> "Talking with Keith, subsystem-resets are a feature of enterprise-class
> NVMe devices.  I think those features are out of scope for the class
> of devices that will find themselves in a platform with this
> configuration, same for hot-plug."

NVMe Subsystem resets are not the same thing as conventional PCI
resets. We still have use for the latter in client space.

Even if you wish to forgo the standard features and management
capabilities, you're still having to deal with legacy IRQ, which has
IOPs at a fraction of the hardware's true capabilities when using MSI.
I do not believe that is what users want out of their purchased
hardware, so your best option is still to set to AHCI mode for Linux
for this reason alone, and vendors should be providing this option in
BIOS.
