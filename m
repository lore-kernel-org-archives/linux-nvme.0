From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 30 Aug 2018 13:11:18 -0600
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
In-Reply-To: <20180830185352.3369-8-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
Message-ID: <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>

On 8/30/18 12:53 PM, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory.
> 
> When a request is submitted we check if PCI P2PDMA memory is assigned
> to the first page in the bio. If it is, we ensure the queue it's
> submitted to supports it, and enforce REQ_NOMERGE.

I think this belongs in the caller - both the validity check, and
passing in NOMERGE for this type of request. I don't want to impose
this overhead on everything, for a pretty niche case.

-- 
Jens Axboe
