From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Mon, 08 Apr 2019 13:04:03 +0300
Subject: your mail
In-Reply-To: <20190319152212.GC24176@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319152212.GC24176@localhost.localdomain>
Message-ID: <4a3d473c8f671d59c57ec26ff5ec0879ad38bf9a.camel@redhat.com>

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
> 
> I think you should send 6/9 "nvme/pci: init shadow doorbell after each
> reset" separately for immediate inclusion.
> 
> I like the idea in principle, but it will take me a little time to get
> through reviewing your implementation. I would have guessed we could
> have leveraged something from the existing nvme/target for the mediating
> controller register access and admin commands. Maybe even start with
> implementing an nvme passthrough namespace target type (we currently
> have block and file).


Hi!

Sorry to bother you, but any update?

I was somewhat sick for the last week, now finally back in shape to continue
working on this and other tasks I have.

I am studing now the nvme target code and the io_uring to evaluate the
difficultiy of using something similiar to talk to the block device instead of /
in addtion to the  direct connection I implemented.

I would be glad to hear more feedback on this project.

I will also soon post the few fixes separately as you suggested.

Best regards,
    Maxim Levitskky
