From: hch@lst.de (Christoph Hellwig)
Date: Sun, 23 Apr 2017 09:47:10 +0200
Subject: [PATCH] nvme: change cq_vector to a bool and set to true after
 request_irq
In-Reply-To: <1492817055-33601-1-git-send-email-sandeep@purestorage.com>
References: <1492817055-33601-1-git-send-email-sandeep@purestorage.com>
Message-ID: <20170423074710.GB20750@lst.de>

nvmeq_irq went away in a commit in the PCI tree, so merging this now
would create a bit of a merge problem.  Either we can live with the
conflict or delay the patch until the first round of merges for -rc1
are done..

> +	bool cq_vector;

I think the field is badly misnamed now.  Something like a flags
field with an NVME_PCI_Q_IS_ALIVE flag might be more suitable now?
