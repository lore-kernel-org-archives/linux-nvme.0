From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Apr 2017 09:18:24 +0200
Subject: [PATCH] nvme: change cq_vector to a bool and set to true after
 request_irq
In-Reply-To: <7814D156-5C3D-47A3-B73F-07EED4719920@purestorage.com>
References: <1492817055-33601-1-git-send-email-sandeep@purestorage.com>
 <20170423074710.GB20750@lst.de>
 <7814D156-5C3D-47A3-B73F-07EED4719920@purestorage.com>
Message-ID: <20170425071824.GA26885@lst.de>

On Mon, Apr 24, 2017@01:25:39PM -0700, Sandeep Mann wrote:
> 
> > nvmeq_irq went away in a commit in the PCI tree, so merging this now
> > would create a bit of a merge problem.  Either we can live with the
> > conflict or delay the patch until the first round of merges for -rc1
> > are done..
> 
> I am not sure if I need to anything here, would you like me provide a diff on top of the PCI tree?

Yes, feel free to work based on that.  I think we'll have to wait
until both the PCI and block/nvme trees are merged in mainline to apply
it, though.  And then it will be even more work to backport it to stable,
sorry.
