From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 19:31:31 +0100
Subject: [PATCH 5/8] nvme/pci: Remove last_sq_tail
In-Reply-To: <20190308174313.5134-5-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-5-keith.busch@intel.com>
Message-ID: <20190311183131.GE11448@lst.de>

On Fri, Mar 08, 2019@10:43:10AM -0700, Keith Busch wrote:
> We don't allocate enough tags to wrap the submission queue ring. Remove
> the checks for this condition and shrink struct nvme_queue.

Hmm, I don't see how this is related to wrapping, more about avoiding
SQ doorbell writes until we actually commit the current batch of I/O.

It originated from:

ommit 04f3eafda6e05adc56afed4d3ae6e24aaa429058
Author: Jens Axboe <axboe at kernel.dk>
Date:   Thu Nov 29 10:02:29 2018 -0700

    nvme: implement mq_ops->commit_rqs() hook
