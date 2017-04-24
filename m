From: sandeep@purestorage.com (Sandeep Mann)
Date: Mon, 24 Apr 2017 13:25:39 -0700
Subject: [PATCH] nvme: change cq_vector to a bool and set to true after
 request_irq
In-Reply-To: <20170423074710.GB20750@lst.de>
References: <1492817055-33601-1-git-send-email-sandeep@purestorage.com>
 <20170423074710.GB20750@lst.de>
Message-ID: <7814D156-5C3D-47A3-B73F-07EED4719920@purestorage.com>


> nvmeq_irq went away in a commit in the PCI tree, so merging this now
> would create a bit of a merge problem.  Either we can live with the
> conflict or delay the patch until the first round of merges for -rc1
> are done..

I am not sure if I need to anything here, would you like me provide a diff on top of the PCI tree?

>> +	bool cq_vector;
> 
> I think the field is badly misnamed now.  Something like a flags
> field with an NVME_PCI_Q_IS_ALIVE flag might be more suitable now?

I will make this change, thanks.

Sandeep
