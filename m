From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 21 May 2019 20:49:09 +0800
Subject: [PATCH 5.0 66/95] nvme: cancel request synchronously
In-Reply-To: <23729cbc-3a3f-fe16-be14-71053253c53b@mellanox.com>
References: <20190509181309.180685671@linuxfoundation.org>
 <20190509181314.082604502@linuxfoundation.org>
 <d0cd612d-1bce-50ca-1186-de67054b33c1@mellanox.com>
 <20190521094535.GA28632@ming.t460p>
 <7a4863ba-ece9-e3fa-8396-21736d54e1fe@mellanox.com>
 <20190521104121.GA31530@ming.t460p>
 <23729cbc-3a3f-fe16-be14-71053253c53b@mellanox.com>
Message-ID: <20190521124908.GA655@ming.t460p>

On Tue, May 21, 2019@02:50:22PM +0300, Max Gurtovoy wrote:
> 
> On 5/21/2019 1:41 PM, Ming Lei wrote:
> > On Tue, May 21, 2019@01:21:39PM +0300, Max Gurtovoy wrote:
> > > On 5/21/2019 12:45 PM, Ming Lei wrote:
> > > > On Tue, May 21, 2019@11:36:26AM +0300, Max Gurtovoy wrote:
> > > > > On 5/9/2019 9:42 PM, Greg Kroah-Hartman wrote:
> > > > > > [ Upstream commit eb3afb75b57c28599af0dfa03a99579d410749e9 ]
> > > > > > 
> > > > > > nvme_cancel_request() is used in error handler, and it is always
> > > > > > reliable to cancel request synchronously, and avoids possible race
> > > > > > in which request may be completed after real hw queue is destroyed.
> > > > > Ming,
> > > > > 
> > > > > If the completion is async in the block layer, can't a "good" request (not a
> > > > > canceled one..) complete after real HW queue is destroyed ?
> > > > In theory, it can't.
> > > > 
> > > > 1) in case of error recovery
> > > > 
> > > > It is driver's responsibility to sync normal completion and handling
> > > > error. NVMe PCI calls nvme_dev_disable() to shutdown controller, and
> > > > there won't be good request any more after nvme_dev_disable() returns.
> > > > I am not very familiar with NVMe RDMA code, but nvme_rdma_stop_io_queues()
> > > > is supposed to do that for avoiding race with normal completion. Otherwise,
> > > > it isn't enough by simply canceling in-flight requests.
> > > Indeed nvme_rdma_stop_io_queues will guaranty that we won't get anything
> > > from the wire/HCA anymore.
> > > 
> > > 
> > > But what happens to IO's that were completed before
> > > "nvme_rdma_stop_io_queues" in async way:
> > > 
> > > 1. nvme_end_request --> blk_mq_complete_request (async)
> > > 
> > > 2. error recovery starts (queues are stopped)
> > > 
> > > 3. block layer calls ops->complete(rq) on rq from step #1
> > > 
> > > if the blk_mq_quiesce_queue + blk_mq_unquiesce_queue don't sync the requests
> > > from #1, i think it might be problematic..
> > You are right, we might have to wait until there isn't any in-flight request
> > which is marked as transient MQ_RQ_COMPLETE before destroying hw queue.
> 
> is there an API in the block layer to guaranty that ?

So far there isn't yet.

And it can be built easily against blk_mq_tagset_busy_iter(), then called
in delay-spin style for checking if there is any request marked as
MQ_RQ_COMPLETE.


Thanks,
Ming
