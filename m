From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 7 Sep 2018 09:55:25 -0600
Subject: Devices expected?
In-Reply-To: <DE927C68B458BE418D582EC97927A9288003FD37@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9288003E585@ORSMSX113.amr.corp.intel.com>
 <20180906210508.GA31480@localhost.localdomain>
 <DE927C68B458BE418D582EC97927A9288003FD37@ORSMSX113.amr.corp.intel.com>
Message-ID: <20180907155524.GA857@localhost.localdomain>

On Fri, Sep 07, 2018@03:40:45PM +0000, Gruher, Joseph R wrote:
> > > In general, my question is whether this is expected behavior?  If a
> > > bug, is it fixed in a newer kernel?  We are trying to track some disk
> > > stats and the unexpected (at least from our perspective) behavior in
> > > /proc/diskstats is causing us some confusion.  Thanks!
> > 
> > With the exception of the 'lsblk' error message, I think all your results are
> > expected when CONFIG_NVME_MUTLIPATH=y.
> 
> Thanks Keith.  I just pulled the Ubuntu mainline kernel package, rather than building my own, so I guess they have NVMeoF multipathing on by default.

If you do not want to use this feature, you may disable it with kernel
parameter "nvme_core.multipath=0" if modifying the kernel or its config
is not desirable.

> Does nvme2c1n1 represent one path for the nvme2n1 device to use?  If I connected a second path I would see something like nvme2c2n1 pop up as well?

Yes, that is what that those names represent.

In your example, the '2' in nvme2 is the subsystem instance, which
is just a unique number software assigned to the subsystem. The '1'
in nvme2c1 is the controller id that identify controller reports, so it
may not necessarily start at 1 or increase sequentially.
