From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 21 May 2019 17:45:42 +0800
Subject: [PATCH 5.0 66/95] nvme: cancel request synchronously
In-Reply-To: <d0cd612d-1bce-50ca-1186-de67054b33c1@mellanox.com>
References: <20190509181309.180685671@linuxfoundation.org>
 <20190509181314.082604502@linuxfoundation.org>
 <d0cd612d-1bce-50ca-1186-de67054b33c1@mellanox.com>
Message-ID: <20190521094535.GA28632@ming.t460p>

On Tue, May 21, 2019@11:36:26AM +0300, Max Gurtovoy wrote:
> On 5/9/2019 9:42 PM, Greg Kroah-Hartman wrote:
> > [ Upstream commit eb3afb75b57c28599af0dfa03a99579d410749e9 ]
> > 
> > nvme_cancel_request() is used in error handler, and it is always
> > reliable to cancel request synchronously, and avoids possible race
> > in which request may be completed after real hw queue is destroyed.
> 
> Ming,
> 
> If the completion is async in the block layer, can't a "good" request (not a
> canceled one..) complete after real HW queue is destroyed ?

In theory, it can't.

1) in case of error recovery

It is driver's responsibility to sync normal completion and handling
error. NVMe PCI calls nvme_dev_disable() to shutdown controller, and
there won't be good request any more after nvme_dev_disable() returns.
I am not very familiar with NVMe RDMA code, but nvme_rdma_stop_io_queues()
is supposed to do that for avoiding race with normal completion. Otherwise,
it isn't enough by simply canceling in-flight requests.

2) in case of device removal
blk_cleanup_queue() drains all in-queue requests, so there can't be
such issue.


Thanks,
Ming
