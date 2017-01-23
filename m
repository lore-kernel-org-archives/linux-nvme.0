From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Jan 2017 19:30:50 +0100
Subject: [PATCH 1/6] irq/affinity: Assign all online CPUs to vectors
In-Reply-To: <1483569671-1462-2-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-2-git-send-email-keith.busch@intel.com>
Message-ID: <20170123183050.GA23791@lst.de>

On Wed, Jan 04, 2017@05:41:06PM -0500, Keith Busch wrote:
> This patch makes sure all online CPUs are assigned to vectors in
> cases where the nodes don't have the same number of online CPUs.
> The calculation for how many vectors needs to be assigned should account
> for the number of CPUs for a particular node on each round of assignment
> in order to ensure all online CPUs are assigned a vector when they don't
> evenly divide, and calculate extras accordingly.
> 
> Since we attempt to divide evently among the nodes, this may still result
> in unused vectors if some nodes have fewer CPUs than nodes previosuly
> set up, but at least every online CPU will be assigned to something.

This looks fine:

I think we still should switch to something like all present or possible
cpus for MSI-X vector and blk-mq queue assignment, though reduce
the needs for this:

Reviewed-by: Christoph Hellwig <hch at lst.de>
