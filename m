From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 Mar 2017 19:10:30 -0400
Subject: [PATCH 1/1] nvme: don't ignore tagset allocation failures
In-Reply-To: <fb263c4e-0403-c39c-1c88-be47d846c2b6@grimberg.me>
References: <1490778212-11007-1-git-send-email-maxg@mellanox.com>
 <a7db55a8-d40a-81e9-332e-2bd0306687bc@grimberg.me>
 <20170329173241.GC20181@localhost.localdomain>
 <fb263c4e-0403-c39c-1c88-be47d846c2b6@grimberg.me>
Message-ID: <20170329231029.GE20181@localhost.localdomain>

On Wed, Mar 29, 2017@08:42:33PM +0300, Sagi Grimberg wrote:
> 
> > Not having a tagset doesn't mean we can't go live; it just means we can't
> > do IO, but the admin handle is still up for device management.
> 
> So don't queue ns scanning...

And what about the sysfs rescan or namespace notify async event? We have
to fence those off too, so doing it in one place sounds better than
three.
 
> > Also, nvme_queue_scan can be triggered from places outside nvme pci's control,
> > so I think Max's patch is an appropriate place to check.
> 
> How is that not racy?

The tagset can only be allocated while the controller is not "LIVE", so
that satisfies synchronizing this resource.
