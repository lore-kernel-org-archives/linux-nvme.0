From: mlin@kernel.org (Ming Lin)
Date: Mon, 16 Nov 2015 00:08:58 -0800
Subject: [RFC] generic NVMe target and NVMe loop driver
In-Reply-To: <1447659004.23230.102.camel@haakon3.risingtidesystems.com>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1447659004.23230.102.camel@haakon3.risingtidesystems.com>
Message-ID: <1447661338.10221.8.camel@hasee>

On Sun, 2015-11-15@23:30 -0800, Nicholas A. Bellinger wrote:
> On Sat, 2015-11-07@18:00 +0100, Christoph Hellwig wrote:
> > This series continues the NVMe host drive split and also starts adding a
> > consume for it.  The consumer is mostly interesting for developers at this
> > point as it's simply a 'loopback' NVMe device that ties the split NVMe
> > driver fronted into the new generic NVMe target subsystem.
> 
> Very excited to see this code posted.  8-)
> 
> > This was developed for our NVMe over Fabrics prototype, but will also be useful for
> > other work like Ming's virtio-nvme or event an implementation traditional
> > PCIe NVMe using vhost.
> > 
> 
> Wrt to vhost-nvme, the WIP code (Dr. Hannes + Dave CC'ed) I'm currently
> hacking on is here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/nab/target-pending.git/log/?h=vhost-nvme-wip
> 
> Note it's still a week or two away (using rts-megasas as a reference)
> from actually functioning across a modest number of queue resources, but
> should at least give interested folks an idea of how things look so far.

Hi Nic,

FYI,

I have done the vhost-nvme patches(based on our previous discussion) on
top of NVMe target.

I'll post kernel & qemu patches early this week.

But the tests I have done so far didn't show competitive performance
compared with vhost-scsi. Maybe because the mmio thing is slow.

I'm going to do anther implementation with virtio-nvme/vhost-nvme.
With nvme-split, now virtio-nvme seems make sense.

I have ported virtio-nvme last month.
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-split/virtio 

Thanks,
Ming

> 
> > The biggest gap at this point is aborts and resets, which are still under
> > heavy development.  Once those are done and I've finished the configfs
> > layout the code will hopefully be ready for inclusion in Linux 4.5.
> > 
> > I've also written a python based shell to ease configuration of the target
> > subsystem which I'll hopefully be able to release soon.
> > 
> 
> ;)
> 
> > As this depends on a lot of pending NVMe patch a git tree is also
> > available:
> > 
> > 	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-loop.2
> > 
> 
> So on vhost-nvme configfs side, my initial code will be using
> target_core_fabric_configfs.c to process incoming nvme-hi frames
> into existing backend struct se_device.
> 
> That said, I'm planning to rebase atop your WIP tree in the short-term
> for the common nvme opcode + command set decoding bits, that both
> vhost-nvme and nvme-fabrics code are going to require.
> 
> --nab
