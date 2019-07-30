From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 30 Jul 2019 08:45:26 +0800
Subject: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
Message-ID: <20190730004525.GB28708@ming.t460p>

On Wed, Jul 24, 2019@11:48:38AM +0800, Ming Lei wrote:
> Hi,
> 
> blk-mq may schedule to call queue's complete function on remote CPU via
> IPI, but never provide any way to synchronize the request's complete
> fn.
> 
> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> re-allocated. If the completed request's complete fn is run finally after the
> hardware queue's resource is released, kernel crash will be triggered.
> 
> Fixes this issue by waitting until completed req's complete fn is run.
> 
> V2:
> 	- fix one build warning
> 	- fix commit log
> 	- apply the wait on nvme-fc code too
> 
> Thanks,
> Ming
> 
> Ming Lei (5):
>   blk-mq: introduce blk_mq_request_completed()
>   blk-mq: introduce blk_mq_tagset_wait_completed_request()
>   nvme: don't abort completed request in nvme_cancel_request
>   nvme: wait until all completed request's complete fn is called
>   blk-mq: remove blk_mq_complete_request_sync
> 
>  block/blk-mq-tag.c         | 32 ++++++++++++++++++++++++++++++++
>  block/blk-mq.c             | 13 ++++++-------
>  drivers/nvme/host/core.c   |  6 +++++-
>  drivers/nvme/host/fc.c     |  2 ++
>  drivers/nvme/host/pci.c    |  2 ++
>  drivers/nvme/host/rdma.c   |  8 ++++++--
>  drivers/nvme/host/tcp.c    |  8 ++++++--
>  drivers/nvme/target/loop.c |  2 ++
>  include/linux/blk-mq.h     |  3 ++-
>  9 files changed, 63 insertions(+), 13 deletions(-)
> 
> Cc: Max Gurtovoy <maxg at mellanox.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at lst.de>

Hello Jens, Chritoph and Guys,

Ping on this fix.

Thanks,
Ming
