From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 2 May 2018 09:29:53 -0600
Subject: [PATCH] nvme/pci: Use async_schedule for initial reset work
In-Reply-To: <alpine.LRH.2.02.1805011928470.17838@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180427211708.5604-1-keith.busch@intel.com>
 <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com>
 <20180430194533.GC5938@localhost.localdomain>
 <alpine.LRH.2.02.1805011928470.17838@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180502152953.GH5938@localhost.localdomain>

On Tue, May 01, 2018@07:33:10PM -0400, Mikulas Patocka wrote:
> On Mon, 30 Apr 2018, Keith Busch wrote:
> 
> > On Sat, Apr 28, 2018@05:11:18PM +0800, Ming Lei wrote:
> > > Looks fine,
> > > 
> > > Reviewed-by: Ming Lei <ming.lei at redhat.com>
> > 
> > Thanks, Ming.
> > 
> > Mikulas, would you be able to test this and confirm it works for you?
> > This appears successful in my testing, but want to hear from the source
> > if possible.
> > 
> > Thanks,
> > Keith
> 
> The patch is not correct - scan_work is still called from a workqueue and 
> if it's too slow, the nvme device is not found when mounting root.
> 
> You can add msleep(10000) at the beginning of nvme_scan_work to test for 
> the race condition on your system.
> 
> Here I submit the corrected patch - I added 
> flush_work(&dev->ctrl.scan_work) to nvme_async_probe

Roger that. Will incorporate your adjustment and add your
Tested-by. Thanks for the confirmation.
