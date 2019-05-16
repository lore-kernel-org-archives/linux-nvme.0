From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 08:44:52 -0600
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
Message-ID: <20190516144452.GB23372@localhost.localdomain>

On Thu, May 16, 2019@12:03:54AM -0700, Hannes Reinecke wrote:
> On 5/16/19 8:46 AM, Christoph Hellwig wrote:
> > On Wed, May 15, 2019@03:33:51PM -0600, Keith Busch wrote:
> >> So here's a solution that no one will like: pull subsystem and controller
> >> instances from the same IDA so that there won't be any namespace block
> >> devices with a matching controller handle name. While this does nothing
> >> to clear up device relationships, this will force the user to think
> >> really hard about what they're doing and avoid such mistakes.
> > 
> > Hmm.  So we'll get:
> > 
> > /dev/nvme0
> >   - chardev subsys X ctl 1
> > 
> > /dev/nvme1n1
> > /dev/nvme1n2
> >   - namespaces for subsys X
> > 
> > /dev/nvme2
> >   - chardev subsys X ctl 2
> > 
> > /dev/nvme3
> >   - chardev subsys Y ctl 1
> > 
> > ...
> > 
> > This should work.  Not sure it really buys us so much, though.
> > 
> > Btw, I wonder if we should have udev rules for:
> > 
> > /dev/nvme-subsys-$NQN-ctrl1
> > /dev/nvme-subsys-$NQN-ctrl2
> > /dev/nvme-subsys-$NQN-ns1
> > /dev/nvme-subsys-$NQN-ns2
> > 
> > I have to admit that since udev/systemd moved to github I can't
> > be bother to send them patches, though as it would require signing
> > up for that crappy service.
> > 
> That rather calls for persistent device names, no?
> 
> proposal would be to create symlinks like
> 
> /dev/disk/by-id/nvme-subsys-$NQN-ns-$NS

Hm, the current by-id rules use the namespace's nguid or eui if it exists,
and serial + nsid if not. We can add susbsys too.

> to keep in line with the other symlinks in /dev/disk/by-id/
> The controller symlinks don't really fall into this category, though;
> we could create a 'nvme' subdirectory (much like MD does), and
> create symlinks in there.

Cool, I would also like to see persistent char dev names, but I wasn't
sure where they'd go. If we can make our own 'nvme' subdirectory, that'd
be great.
 
> And yes, I'm happy to draft up udev rules once we've come to a 
> conclusion here.

Thanks!
