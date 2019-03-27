From: kbusch@kernel.org (Keith Busch)
Date: Tue, 26 Mar 2019 20:33:54 -0600
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
 <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
 <20190327021521.GA7389@localhost.localdomain>
 <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
Message-ID: <20190327023354.GB7389@localhost.localdomain>

On Wed, Mar 27, 2019@10:27:57AM +0800, jianchao.wang wrote:
> As the comment above, the stable request maybe something that has been freed due to following case,
> 1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
> 2. a removed io scheduler's sched request
> and this freed request could be allocated by others which may change the field of request->state.

You're not explaing how that request->state is changed. I understand the
request can be reallocated, but what is changing its state?
