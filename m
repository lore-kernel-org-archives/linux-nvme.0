From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 May 2019 13:27:54 -0700
Subject: [PATCH v2 1/2] nvme-rdma: fix queue mapping when queue count is
 limited
In-Reply-To: <c5fa88e8-f046-2d3b-7851-afbc1446fcbf@grimberg.me>
References: <20190529054905.16279-1-sagi@grimberg.me>
 <83c239a0-69bd-9fa4-b7af-4cb01d20cc2c@mellanox.com>
 <c5fa88e8-f046-2d3b-7851-afbc1446fcbf@grimberg.me>
Message-ID: <bb65e190-527a-e660-3cda-8fc340b57ef7@grimberg.me>


>>> @@ -1781,16 +1798,22 @@ static int nvme_rdma_map_queues(struct 
>>> blk_mq_tag_set *set)
>>> ????? blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
>>> ????????????? ctrl->device->dev, 0);
>>> -??? if (ctrl->ctrl.opts->nr_poll_queues) {
>>> +??? if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
>>> +??????? /* map dedicated poll queues only if we have queues left */
>>> ????????? set->map[HCTX_TYPE_POLL].nr_queues =
>>> ????????????????? ctrl->io_queues[HCTX_TYPE_POLL];
>>> ????????? set->map[HCTX_TYPE_POLL].queue_offset =
>>> -??????????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>>> -??????? if (ctrl->ctrl.opts->nr_write_queues)
>>> -??????????? set->map[HCTX_TYPE_POLL].queue_offset +=
>>> -??????????????? ctrl->io_queues[HCTX_TYPE_READ];
>>> +??????????? ctrl->io_queues[HCTX_TYPE_DEFAULT] +
>>> +??????????? ctrl->io_queues[HCTX_TYPE_READ];
>>
>> in case of shared queues? ctrl->io_queues[HCTX_TYPE_READ] != 
>> set->map[HCTX_TYPE_READ].nr_queues.
>>
>> Shouldn't we jump over (the queue_offset) the set->map values ?
> 
> This is exactly why we shouldn't. In the shared case, we only have
> HCTX_TYPE_DEFAULT and HCTX_TYPE_READ is zero so this case jumps
> exactly how much it needs to.

btw, I want a review tag from you Max before taking this in.
