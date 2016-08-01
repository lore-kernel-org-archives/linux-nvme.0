From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 17:48:40 +0200
Subject: [PATCH 3/5] nvme-rdma: Make sure to shutdown the controller if
 we can
In-Reply-To: <63b33585-3fd2-a497-94a1-34dc9484da99@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-4-git-send-email-sagi@grimberg.me>
 <20160801110446.GD16141@lst.de>
 <63b33585-3fd2-a497-94a1-34dc9484da99@grimberg.me>
Message-ID: <20160801154840.GB22771@lst.de>

On Mon, Aug 01, 2016@02:17:37PM +0300, Sagi Grimberg wrote:
>>> -	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
>>> +	if (test_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[0].flags))
>>>  		nvme_shutdown_ctrl(&ctrl->ctrl);
>>>
>>>  	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
>>
>> Maybe the right way to handle this is to unconditionally call
>> nvme_shutdown_ctrl and make sure we return an early error
>> on the register write?
>
> As I wrote on patch 2/5 reply, I'd like to avoid depending on
> queue_rq to fail early peeking at the ctrl state. This dependency
> can grow in the future and I think we should at least try not to
> go there...

I don't want ->queue_rq to peek at controller state.  What I had
in mind was copying the PCIe behavior of failing early in the
timeout handler if we are in the reset handler, which will
mean blk_execute_rq will return ASAP with an error.
