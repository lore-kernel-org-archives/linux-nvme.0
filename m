From: keith.busch@intel.com (Keith Busch)
Date: Tue, 6 Feb 2018 08:13:35 -0700
Subject: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown
 and reset case
In-Reply-To: <d218f5f5-45f7-6036-00a5-48769101080f@oracle.com>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180202182413.GH24417@localhost.localdomain>
 <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
 <20180205151314.GP24417@localhost.localdomain>
 <d218f5f5-45f7-6036-00a5-48769101080f@oracle.com>
Message-ID: <20180206151335.GE31110@localhost.localdomain>

On Tue, Feb 06, 2018@09:46:36AM +0800, jianchao.wang wrote:
> Hi Keith
> 
> Thanks for your kindly response.
> 
> On 02/05/2018 11:13 PM, Keith Busch wrote:
> >  but how many requests are you letting enter to their demise by
> > freezing on the wrong side of the reset?
> 
> There are only two difference with this patch from the original one.
> 1. Don't freeze the queue for the reset case. At the moment, the outstanding requests will be requeued back to blk-mq queues.
>    The new entered requests during reset will also stay in blk-mq queues. All this requests will not enter into nvme driver layer
>    due to quiescent request_queues. And they will be issued after the reset is completed successfully.
> 2. Drain the request queue before nvme_dev_disable. This is nearly same with the previous rule which will also unquiesce the queue
>    and let the requests be able to be drained. The only difference is this patch will invoke wait_freeze in nvme_dev_disable instead
>    of nvme_reset_work.
> 
> We don't sacrifice any request. This patch do the same thing with the previous one and make things clearer.

No, what you're proposing is quite different.

By "enter", I'm referring to blk_queue_enter. Once a request enters
into an hctx, it can not be backed out to re-enter a new hctx if the
original one is invalidated.

Prior to a reset, all requests that have entered the queue are committed
to that hctx, and we can't do anything about that. The only thing we can
do is prevent new requests from entering until we're sure that hctx is
valid on the other side of the reset.
