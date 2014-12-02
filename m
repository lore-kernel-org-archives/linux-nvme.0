From: daniel.stodden@gmail.com (Daniel Stodden)
Date: Mon, 01 Dec 2014 16:36:11 -0800
Subject: NVMe driver within hypervisors
In-Reply-To: <alpine.LNX.2.00.1412012345220.4225@localhost.lm.intel.com>
References: <53cea8aa3891427498928f77e6b9dc46@hioexcmbx06-prd.hq.netapp.com>
 <alpine.LNX.2.00.1412011504440.4225@localhost.lm.intel.com>
 <1417473163.6910.10.camel@espiritosanto.int.convergent.io>
 <alpine.LNX.2.00.1412012345220.4225@localhost.lm.intel.com>
Message-ID: <1417480571.6910.34.camel@espiritosanto.int.convergent.io>

On Tue, 2014-12-02@00:08 +0000, Keith Busch wrote:
> On Mon, 1 Dec 2014, Daniel Stodden wrote:
> > On Mon, 2014-12-01@15:07 +0000, Keith Busch wrote:
> >> Correct me if I'm wrong, but doesn't Xen derive device driver support
> >> from its "dom-0"? Just use an nvme-capable Linux guest there and you've
> >> enabled Xen to support nvme, yeah?
> >
> > Correct. Backends in dom0 eventually translate guest I/O to bios issued
> > to a kernel blockdev. Such as an NVMe one, typically implemented by a
> > normal Linux driver.
> 
> I get asked about Xen support a lot, but my experience is limited so I've
> only been guessing when I say it ought to work just fine. No one ever
> takes it to the next level as far as I know. I'm not sure what people
> are waiting for (a commercial offering perhaps?), so I'll give it a shot.
[..]
> Looks like Xen and NVMe have worked for years! Hardly worth a mention
> on nvmexpress.org, though; they don't announce for a particular linux
> distro, so I don't see why xen would get special treatment.

I used to help maintain a fair bit of the block I/O backend code in
XenServer. The backend landscape changed a bit since then.

But for locally attached storage, no backend I'm currently aware of
wouldn't eventually map back to a normal kernel block device driver.

In practice, there may be ways in which a direct map
(guest->blkfront->blkback->nvme) can work out sub-optimally (LBA size,
partition offsets, type of guest), but nothing special I'd expect to
apply here.

And certainly there's a much larger variety on how to map guest I/O
(say, guest->blkfront->blktap->vhd->ext3/4->nvme). 

But they'll all root on standard kernel facilities, and should work
fine. Maxing out throughput may be a different question. But MQ support
may already help with that, and rather be Xen-work to fully utilize.

Daniel
