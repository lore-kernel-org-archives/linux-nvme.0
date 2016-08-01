From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 17:47:17 +0200
Subject: [PATCH 2/5] nvme-rdma: Free the I/O tags when we delete the
 controller
In-Reply-To: <c2c194b0-d0a1-11af-cae9-a4ce8ea8fdde@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-3-git-send-email-sagi@grimberg.me>
 <20160801110308.GC16141@lst.de>
 <c2c194b0-d0a1-11af-cae9-a4ce8ea8fdde@grimberg.me>
Message-ID: <20160801154717.GA22771@lst.de>

On Mon, Aug 01, 2016@02:15:59PM +0300, Sagi Grimberg wrote:
>> or in a second step we should probably always call shutdown_ctrl
>> but skip the actual shutdown if the ctrl state doesn't require it.
>
> What do you mean "if the ctrl state doesn't require it"?
> Up until today we managed to avoid checking the ctrl state
> in queue_rq and I'd like to keep it that way. I'd be much
> happier if we don't depend on queue_rq to fail early under
> some assumptions, it might be a slippery slope...

In this case I actually thought about checking the state in
the new __nvme_rdma_remove_ctrl.  If called from
nvme_rdma_del_ctrl_work the state will be NVME_CTRL_DELETING,
so we can check that to see if we want to do a controlled
shutdown using nvme_rdma_shutdown_ctrl instead of having
to overwrite ->remove_work.
