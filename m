From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Wed, 20 Mar 2019 18:30:29 +0200
Subject: your mail
In-Reply-To: <20190319152212.GC24176@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319152212.GC24176@localhost.localdomain>
Message-ID: <5a56e110b062de9d448c51cf0774c5e614133873.camel@redhat.com>

On Tue, 2019-03-19@09:22 -0600, Keith Busch wrote:
> On Tue, Mar 19, 2019@04:41:07PM +0200, Maxim Levitsky wrote:
> >   -> Share the NVMe device between host and guest. 
> >      Even in fully virtualized configurations,
> >      some partitions of nvme device could be used by guests as block
> > devices 
> >      while others passed through with nvme-mdev to achieve balance between
> >      all features of full IO stack emulation and performance.
> >   
> >   -> NVME-MDEV is a bit faster due to the fact that in-kernel driver 
> >      can send interrupts to the guest directly without a context 
> >      switch that can be expensive due to meltdown mitigation.
> > 
> >   -> Is able to utilize interrupts to get reasonable performance. 
> >      This is only implemented
> >      as a proof of concept and not included in the patches, 
> >      but interrupt driven mode shows reasonable performance
> >      
> >   -> This is a framework that later can be used to support NVMe devices 
> >      with more of the IO virtualization built-in 
> >      (IOMMU with PASID support coupled with device that supports it)
> 

> Would be very interested to see the PASID support. You wouldn't even
> need to mediate the IO doorbells or translations if assigning entire
> namespaces, and should be much faster than the shadow doorbells.

I fully agree with that.
Note that to enable PASID support two things have to happen in this vendor.

1. Mature support for IOMMU with PASID support. On Intel side I know that they
only have a spec released and currently the kernel bits to support it are
placed.
I still don't know when a product actually supporting this spec is going to be
released. For other vendors (ARM/AMD/) I haven't done yet a research on state of
PASID based IOMMU support on their platforms.

2. NVMe spec has to be extended to support PASID. At minimum, we need an ability
to assign an PASID to a sq/cq queue pair and ability to relocate the doorbells,
such as each guest would get its own (hardware backed) MMIO page with its own
doorbells. Plus of course the hardware vendors have to embrace the spec. I guess
these two things will happen in collaborative manner.


> 
> I think you should send 6/9 "nvme/pci: init shadow doorbell after each
> reset" separately for immediate inclusion.
I'll do this soon. 

Also '5/9 nvme/pci: add known admin effects to augment admin effects log page'
can be considered for immediate inclusion as well, as it works around a flaw
in the NVMe controller badly done admin side effects page with no side effects
(pun intended) for spec compliant controllers (I think so). 

This can be fixed with a quirk if you prefer though.

> 
> I like the idea in principle, but it will take me a little time to get
> through reviewing your implementation. I would have guessed we could
> have leveraged something from the existing nvme/target for the mediating
> controller register access and admin commands. Maybe even start with
> implementing an nvme passthrough namespace target type (we currently
> have block and file).

I fully agree with you on that I could have used some of the nvme/target code,
and I am planning to do so eventually.

For that I would need to make my driver, to be one of the target drivers, and I
would need to add another target back end, like you said to allow my target
driver to talk directly to the nvme hardware bypassing the block layer.

Or instead I can use the block backend, 
(but note that currently the block back-end doesn't support polling which is
critical for the performance).

Switch to the target code might though have some (probably minor) performance
impact, as it would probably lengthen the critical code path a bit (I might need
for instance to translate the PRP lists I am getting from the virtual controller
to a scattergather list and back).

This is why I did this the way I did, but now knowing that probably I can afford
to loose a bit of performance, I can look at doing that.

Best regards,
Thanks in advance for the review,
	Maxim Levitsky

PS:

For reference currently the IO path looks more or less like that:

My IO thread notices a doorbell write, reads a command from a submission queue,
translates it (without even looking at the data pointer) and sends it to the
nvme pci driver together with pointer to data iterator'.

The nvme pci driver calls the data iterator N times, which makes the iterator
translate and fetch the DMA addresses where the data is already mapped on the
its pci nvme device (the mdev driver maps all the guest memory to the nvme pci
device).
The nvme pci driver uses these addresses it receives, to create a prp list,
which it puts into the data pointer.

The nvme pci driver also allocates an free command id, from a list, puts it into
the command ID and sends the command to the real hardware.

Later the IO thread calls to the nvme pci driver to poll the queue. When
completions arrive, the nvme pci driver returns them back to the IO thread.

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
