From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 23 May 2018 08:35:40 -0600
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180523003446.GC31196@ming.t460p>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522161704.GA20000@lst.de> <20180523003446.GC31196@ming.t460p>
Message-ID: <20180523143539.GA10882@localhost.localdomain>

On Wed, May 23, 2018@08:34:48AM +0800, Ming Lei wrote:
> Let's consider the normal NVMe timeout code path:
> 
> 1) one request is timed out;
> 
> 2) controller is shutdown, this timed-out request is requeued from
> nvme_cancel_request(), but can't dispatch because queues are quiesced
> 
> 3) reset is done from another context, and this request is dispatched
> again, and completed exactly before returning EH_HANDLED to blk-mq, but
> its state isn't updated to COMPLETE yet.
> 
> 4) then double completions are done from both normal completion and timeout
> path.

We're definitely fixing this, but I must admit that's an impressive
cognitive traversal across 5 thread contexts to arrive at that race. :)
