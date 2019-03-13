From: bharat@chelsio.com (Potnuri Bharat Teja)
Date: Wed, 13 Mar 2019 19:38:18 +0530
Subject: [PATCH rdma-next] RDMA/addr: create addr_wq with WQ_MEM_RECLAIM
 flag
In-Reply-To: <9726d34d-8ab8-a00d-57b1-639495e0426b@opengridcomputing.com>
References: <5f5a1e4e90f3625cea57ffa79fc0e5bcb7efe09d.1548963371.git.swise@opengridcomputing.com>
 <20190205223952.GA23332@ziepe.ca>
 <ee2c28c2-d131-8b4e-1bc2-b4c76931344a@opengridcomputing.com>
 <9726d34d-8ab8-a00d-57b1-639495e0426b@opengridcomputing.com>
Message-ID: <20190313140817.GA24035@chelsio.com>

On Thursday, February 02/07/19, 2019@03:49:47 +0530, Steve Wise wrote:
> 
> On 2/6/2019 3:52 PM, Steve Wise wrote:
> > On 2/5/2019 4:39 PM, Jason Gunthorpe wrote:
> >> On Thu, Jan 31, 2019@11:30:42AM -0800, Steve Wise wrote:
> >>> While running NVMe/oF wire unplug tests, we hit this warning in
> >>> kernel/workqueue.c:check_flush_dependency():
> >>>
> >>> WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
> >>> 		      (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM),
> >>> 	  "workqueue: WQ_MEM_RECLAIM %s:%pf is flushing !WQ_MEM_RECLAIM %s:%pf",
> >>> 	  worker->current_pwq->wq->name, worker->current_func,
> >>> 	  target_wq->name, target_func);
> >>>
> >>> Which I think means we're flushing a workq that doesn't have
> >>> WQ_MEM_RECLAIM set, from workqueue context that does have it set.
> >>>
> >>> Looking at rdma_addr_cancel() which is doing the flushing, it flushes
> >>> the addr_wq which doesn't have MEM_RECLAIM set.  Yet rdma_addr_cancel()
> >>> is being called by the nvme host connection timeout/reconnect workqueue
> >>> thread that does have WQ_MEM_RECLAIM set.
> >> Since we haven't learned anything more, I think you should look to
> >> remove either the WQ_MEM_RECLAIM or the rdma_addr_cancel() from the
> >> nvme side.
> > The nvme code is just calling rdma_destroy_id(), which in turn calls
> > rdma_addr_cancel(),? so I'll have to remove WQ_MEM_RECLAIM from the
> > workqueue.
> >
> > I'll post this patch then.
> 
> 
> What a mess.? If I remove RECLAIM for nvme_wq, then I'll regress this
> change, I think:
> 
> c669ccdc50c2 ("nvme: queue ns scanning and async request from nvme_wq")
> 
Hi All,
I see this issue with some basic tests. Looks like the discussion ended here.
Please suggest where this ideally needs to be fixed so that I can try fixing it.

Thanks,
Bharat
