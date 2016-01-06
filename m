From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Wed, 6 Jan 2016 21:24:54 +0000
Subject: [PATCH 0/3] NVMe: Introduce CMB allocation scheme
In-Reply-To: <20160106201308.GB21311@localhost.localdomain>
References: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>
 <20160106201308.GB21311@localhost.localdomain>
Message-ID: <36F6EBABA23FEF4391AF72944D228901EB6D16C8@BBYEXM01.pmc-sierra.internal>

> >
> > This patchset changes the CMB allocation scheme. Instead of reserving
> > the entire range for SQes and automatically placing the SQes in the
> > CMB, this set creates sysfs knobs to manage it. This allows partial
> > usage of the CMB for SQes, so that the remainder can be mmapped or
> > used for other NVMe-defined CMB usages.
> 
> Thanks, Jon.
> 
> In general, I like the control and visibility this provides. With this, I think we're
> on the verge of warranting a new drivers/nvme/host/sysfs.c file to keep all
> the nvme sysfs management in one place.

I would like to +1 this idea. Seems like there is enough sysfs stuff now to warrant its own file.

> 
> I don't think anyone is in a rush to see this in the 4.5 merge window, so I'll
> load this on a CMB capable machine and provide a more thorough review in
> the next week or so.

I will do the same and hope to get you some feedback in the next week or so. Thanks for doing this!

> 
> > Jon Derrick (3):
> >   NVMe: Introduce sysfs entries for submission queues in CMB
> >   NVMe: Generate resource tree for CMB
> >   NVMe: Create CMB resource sysfs file
> >
> >  drivers/nvme/host/core.c | 161
> ++++++++++++++++++++++++++++++++++-
> >  drivers/nvme/host/nvme.h |  21 +++++
> >  drivers/nvme/host/pci.c  | 212
> > ++++++++++++++++++++++++++++++-----------------
> >  3 files changed, 313 insertions(+), 81 deletions(-)
> >
> > --
> > 2.1.4
> >
