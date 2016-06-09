From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Jun 2016 16:09:09 +0200
Subject: [PATCH 0/2] check the number of hw queues mapped to sw queues
In-Reply-To: <1465415292-9416-1-git-send-email-mlin@kernel.org>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
Message-ID: <20160609140909.GA30293@lst.de>

On Wed, Jun 08, 2016@03:48:10PM -0400, Ming Lin wrote:
> It adds check code to blk_mq_update_queue_map().
> But it seems too aggresive because it's not an error that some hw queues
> were not mapped to sw queues.
> 
> So this series just add a new function blk_mq_hctx_mapped() to check
> how many hw queues were mapped. And the driver(for example, nvme-rdma)
> that cares about it will do the check.

I think it would be better to have this number available a structure
field.  Any reason not to update nr_hw_queues in the tag set
with the actual number of queues?
