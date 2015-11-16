From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Mon, 16 Nov 2015 00:29:35 -0800
Subject: [RFC] generic NVMe target and NVMe loop driver
In-Reply-To: <1447661338.10221.8.camel@hasee>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1447659004.23230.102.camel@haakon3.risingtidesystems.com>
 <1447661338.10221.8.camel@hasee>
Message-ID: <1447662575.23230.105.camel@haakon3.risingtidesystems.com>

On Mon, 2015-11-16@00:08 -0800, Ming Lin wrote:
> On Sun, 2015-11-15@23:30 -0800, Nicholas A. Bellinger wrote:
> > On Sat, 2015-11-07@18:00 +0100, Christoph Hellwig wrote:
> > > This series continues the NVMe host drive split and also starts adding a
> > > consume for it.  The consumer is mostly interesting for developers at this
> > > point as it's simply a 'loopback' NVMe device that ties the split NVMe
> > > driver fronted into the new generic NVMe target subsystem.
> > 
> > Very excited to see this code posted.  8-)
> > 
> > > This was developed for our NVMe over Fabrics prototype, but will also be useful for
> > > other work like Ming's virtio-nvme or event an implementation traditional
> > > PCIe NVMe using vhost.
> > > 
> > 
> > Wrt to vhost-nvme, the WIP code (Dr. Hannes + Dave CC'ed) I'm currently
> > hacking on is here:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/nab/target-pending.git/log/?h=vhost-nvme-wip
> > 
> > Note it's still a week or two away (using rts-megasas as a reference)
> > from actually functioning across a modest number of queue resources, but
> > should at least give interested folks an idea of how things look so far.
> 
> Hi Nic,
> 
> FYI,
> 
> I have done the vhost-nvme patches(based on our previous discussion) on
> top of NVMe target.
> 
> I'll post kernel & qemu patches early this week.
> 

Great.  Looking forward to seeing the prototype code.

> But the tests I have done so far didn't show competitive performance
> compared with vhost-scsi. Maybe because the mmio thing is slow.
> 

Anything interesting hot-spots that show up in perf output..?

> I'm going to do anther implementation with virtio-nvme/vhost-nvme.
> With nvme-split, now virtio-nvme seems make sense.
> 
> I have ported virtio-nvme last month.
> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-split/virtio 

Cool.  :)
