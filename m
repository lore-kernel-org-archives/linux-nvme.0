From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Oct 2017 11:15:38 -0600
Subject: [PATCH 5/6] nvme: Export subsystems to /sys/class/nvme-subsys
In-Reply-To: <20171002165632.GA12157@lst.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-6-git-send-email-hare@suse.de>
 <20171002161808.GD11048@lst.de>
 <20171002165317.GT8463@localhost.localdomain>
 <20171002165632.GA12157@lst.de>
Message-ID: <20171002171538.GU8463@localhost.localdomain>

On Mon, Oct 02, 2017@06:56:32PM +0200, Christoph Hellwig wrote:
> 
> > BTW, I just notice nvme_init_subsystem needs call nvme_put_subsystem in
> > the invalid duplicate subnqn case.
> 
> We call __nvme_free_subsystem in that case, which should do the job.

We're calling __nvme_free_subsystem on the one that was allocated, not
the one that was found. The 'found' will have an additional reference
taken on it that isn't tracked.
