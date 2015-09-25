From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 25 Sep 2015 08:12:33 -0700
Subject: [PATCH] Move nvme driver source into subdirectory and move pci
 specifics from core into separate file
In-Reply-To: <20150925000251.GA25904@infradead.org>
References: <1443130050.6973.125.camel@linux.intel.com>
 <20150925000251.GA25904@infradead.org>
Message-ID: <1443193953.3304.18.camel@linux.intel.com>

On Thu, 2015-09-24@17:02 -0700, Christoph Hellwig wrote:
> Hi J,
> 
> thanks for starting this important work, but I think we need to do
> this in smaller steps.  

Yes, we debated if this should be one big patch or break it up into
smaller patches.


> This large patch does a few things at the same
> time:
> 
>  - move files to a new directory
>  - split data structures
>  - split files
>  - introduces a new internal API
> 
> Which need to be split over a few patches.  I'd suggest we start with
> the easiest and most important parts first and then iterate through 
> the
> rest.
> 
> My suggestion would be:
> 
>  a) move files to a new directory.  My suggestion for that would be
>     driver/nvme/host/ as I have a software NVMe controller
>     implementation under development which I'd like to also add under
>     a different subdirectory of drivers/nvme.

Would that directory be slightly confusing name as the split
implementation in this patch can still be used as the NVMe PCIe driver
for SSD devices inside a given computer (laptop, PC, etc)?  I have no
issue with the name, just posing a question.

>  b) start splitting struct nvme_dev into a generic struct nvme_ctrl
>     and a PCI-specific nvme_pci_ctrl

OK, we can start looking at this.  JayS and Phil who are cc'ed in this
email are two important people that did the heavy lifting of this
patch.

> 
> Based on that we can start thinking about an API and move the PCI 
> code
> to it's own file.  Note that most of your operations should not be
> needed.  

I can see that.  However we started with the split we had just out of
the concern for backwards compatibility and worry of breaking something
with the initial split.  There was the thought we can optimize some of
the operations and remove them on future patches on operations that we
know are safe to remove.

> With my ongoing work we now have the nvme_submit*cmd* APIs
> that give a nice separatation for anything related to NVMe commans,
> so we'd just need abstractions for the BAR access.
