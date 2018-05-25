From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 25 May 2018 08:45:37 -0600
Subject: [PATCHv3 1/9] nvme: Sync request queues on reset
In-Reply-To: <20180525143253.GA26539@lst.de>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-2-keith.busch@intel.com>
 <20180525124209.GD23463@lst.de>
 <20180525142233.GN11037@localhost.localdomain>
 <20180525143253.GA26539@lst.de>
Message-ID: <20180525144536.GQ11037@localhost.localdomain>

On Fri, May 25, 2018@04:32:53PM +0200, Christoph Hellwig wrote:
> Ok, so we are talking about simultaneous nvme_dev_disable calls, which
> makes more sense.
> 
> That being said I really like the idea that Jianchao floated about
> always returning BLK_EH_RESET_TIMER and just letting the reset work
> do the work.  I hope it actually works and doesn't have hidden
> pitfalls..

There are some pitfalls there. The reset_work won't queue if we're in the
DELETING state, for example, and we do still need something to disable
the controller if an admin command issued within reset_work times out. We
do the nvme_dev_disable inline with the timeout for those reasons.
