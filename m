From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 16:32:53 +0200
Subject: [PATCHv3 1/9] nvme: Sync request queues on reset
In-Reply-To: <20180525142233.GN11037@localhost.localdomain>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-2-keith.busch@intel.com>
 <20180525124209.GD23463@lst.de>
 <20180525142233.GN11037@localhost.localdomain>
Message-ID: <20180525143253.GA26539@lst.de>

On Fri, May 25, 2018@08:22:34AM -0600, Keith Busch wrote:
> On Fri, May 25, 2018@02:42:09PM +0200, Christoph Hellwig wrote:
> > On Thu, May 24, 2018@02:34:52PM -0600, Keith Busch wrote:
> > > This patch fixes races that occur with simultaneous controller
> > > resets
> > 
> > Wait..  How do we end up with simultaneous controller resets?  We
> > not only have the NVME_CTRL_RESETTING resetting state, but also
> > execute all resets from ctrl->reset_work, so they are implicitly
> > single threaded.
> 
> Right, the bring up is single threaded, but the NVMe Controller Level
> Reset (CC.EN 1 -> 0) can happen through a timeout. This patch is really
> just working with the way blk-mq's timeout handler claims requests
> and prevents the driver from completing them. The reset_work operates
> under the assumption that there are no outstanding commands after
> nvme_dev_disable, so this patch just ensures that's the case.

Ok, so we are talking about simultaneous nvme_dev_disable calls, which
makes more sense.

That being said I really like the idea that Jianchao floated about
always returning BLK_EH_RESET_TIMER and just letting the reset work
do the work.  I hope it actually works and doesn't have hidden
pitfalls..
