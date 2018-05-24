From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 24 May 2018 15:15:39 -0600
Subject: [PATCHv3 9/9] nvme-pci: Don't wait for HMB completion on shutdown
In-Reply-To: <20180524204506.GA29048@lst.de>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-10-keith.busch@intel.com>
 <20180524204506.GA29048@lst.de>
Message-ID: <20180524211539.GM11037@localhost.localdomain>

On Thu, May 24, 2018@10:45:06PM +0200, Christoph Hellwig wrote:
> None of this is intimately related to the HMB code.  If we really have
> to we could handle this either in __nvme_submit_sync_cmd or all the
> way down in blk_execute_rq, 

Yeah, that's a better idea.

> but why doesn't the block layer timeout
> code kill the command once we've reached the timeout?

The shutdown_lock serializes resets, and we can't release a command until
the pci device is disabled under that lock. That requirement is mainly
for IO, as we can't assume a controller won't access transfer buffers
just because the command timed out.
 
> Also if we really need to reset the controller submitting any command
> just doesn't seem very helpful.  We might as well just skip trying
> to disable the HMB, as the controller needs to come up in a clean
> state anyway.

That's also fine with me.
