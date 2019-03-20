From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Wed, 20 Mar 2019 18:44:59 +0200
Subject: your mail
In-Reply-To: <SN6PR04MB4527810F605C8ADE388E958286400@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319152212.GC24176@localhost.localdomain>
 <SN6PR04MB4527810F605C8ADE388E958286400@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <964d501e1141b2e58665b89dd82a8b65d8db2b53.camel@redhat.com>

On Tue, 2019-03-19@23:49 +0000, Chaitanya Kulkarni wrote:
> Hi Keith,
> On 03/19/2019 08:21 AM, Keith Busch wrote:
> > On Tue, Mar 19, 2019@04:41:07PM +0200, Maxim Levitsky wrote:
> > >    -> Share the NVMe device between host and guest.
> > >       Even in fully virtualized configurations,
> > >       some partitions of nvme device could be used by guests as block
> > > devices
> > >       while others passed through with nvme-mdev to achieve balance
> > > between
> > >       all features of full IO stack emulation and performance.
> > > 
> > >    -> NVME-MDEV is a bit faster due to the fact that in-kernel driver
> > >       can send interrupts to the guest directly without a context
> > >       switch that can be expensive due to meltdown mitigation.
> > > 
> > >    -> Is able to utilize interrupts to get reasonable performance.
> > >       This is only implemented
> > >       as a proof of concept and not included in the patches,
> > >       but interrupt driven mode shows reasonable performance
> > > 
> > >    -> This is a framework that later can be used to support NVMe devices
> > >       with more of the IO virtualization built-in
> > >       (IOMMU with PASID support coupled with device that supports it)
> > 
> > Would be very interested to see the PASID support. You wouldn't even
> > need to mediate the IO doorbells or translations if assigning entire
> > namespaces, and should be much faster than the shadow doorbells.
> > 
> > I think you should send 6/9 "nvme/pci: init shadow doorbell after each
> > reset" separately for immediate inclusion.
> > 
> > I like the idea in principle, but it will take me a little time to get
> > through reviewing your implementation. I would have guessed we could
> > have leveraged something from the existing nvme/target for the mediating
> > controller register access and admin commands. Maybe even start with
> > implementing an nvme passthrough namespace target type (we currently
> > have block and file).
> 
> I have the code for the NVMeOf target passthru-ctrl, I think we can use 
> that as it is if you are looking for the passthru for NVMeOF.
> 
> I'll post patch-series based on the latest code base soon.

I am very intersing in this code. 
Could you explain how your NVMeOF target passthrough works? 
Which components of the NVME stack does it involve?

Best regards,
	Maxim Levitsky

> > 
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme
> > 
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
