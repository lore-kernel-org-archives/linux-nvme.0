From: kbusch@kernel.org (Keith Busch)
Date: Tue, 26 Mar 2019 17:57:27 -0600
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
Message-ID: <20190326235726.GC4328@localhost.localdomain>

On Mon, Mar 25, 2019@08:05:53PM -0700, jianchao.wang wrote:
> What if there used to be a io scheduler and leave some stale requests of sched tags ?
> Or the nr_hw_queues was decreased and leave the hctx->fq->flush_rq ?

Requests internally queued in scheduler or block layer are not eligible
for the nvme driver's iterator callback. We only use it to reclaim
dispatched requests that the target can't return, which only applies to
requests that must have a valid rq->tag value from hctx->tags.
 
> The stable request could be some tings freed and used
> by others and the state field happen to be overwritten to non-zero...

I am not sure I follow what this means. At least for nvme, every queue
sharing the same tagset is quiesced and frozen, there should be no
request state in flux at the time we iterate.
