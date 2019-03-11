From: kbusch@kernel.org (Keith Busch)
Date: Mon, 11 Mar 2019 13:21:52 -0600
Subject: [PATCH 5/8] nvme/pci: Remove last_sq_tail
In-Reply-To: <20190311183131.GE11448@lst.de>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-5-keith.busch@intel.com>
 <20190311183131.GE11448@lst.de>
Message-ID: <20190311192152.GD10411@localhost.localdomain>

On Mon, Mar 11, 2019@07:31:31PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 08, 2019@10:43:10AM -0700, Keith Busch wrote:
> > We don't allocate enough tags to wrap the submission queue ring. Remove
> > the checks for this condition and shrink struct nvme_queue.
> 
> Hmm, I don't see how this is related to wrapping, more about avoiding
> SQ doorbell writes until we actually commit the current batch of I/O.
> 
> It originated from:
> 
> ommit 04f3eafda6e05adc56afed4d3ae6e24aaa429058
> Author: Jens Axboe <axboe at kernel.dk>
> Date:   Thu Nov 29 10:02:29 2018 -0700
> 
>     nvme: implement mq_ops->commit_rqs() hook

Right, the batched doorblell writes is the commit, and this comment
explains the wrap detection requirement that it brought with it:

  "Write sq tail if we are asked to, or if the next command would wrap."

Batched DB writes would need this if we could wrap, and the wrap detection
has to compare the previously wrtten sq tail the next entry. We just don't
have enough tags to do that, so it's not necessary to check.

I should have changed that comment in this patch, though.
