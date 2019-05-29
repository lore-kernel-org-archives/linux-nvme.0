From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 30 May 2019 01:22:47 +0300
Subject: [PATCH v2 1/2] nvme-rdma: fix queue mapping when queue count is
 limited
In-Reply-To: <c5fa88e8-f046-2d3b-7851-afbc1446fcbf@grimberg.me>
References: <20190529054905.16279-1-sagi@grimberg.me>
 <83c239a0-69bd-9fa4-b7af-4cb01d20cc2c@mellanox.com>
 <c5fa88e8-f046-2d3b-7851-afbc1446fcbf@grimberg.me>
Message-ID: <43f3aeb8-d8a7-a9b4-7623-7f6e0a2bdc2b@mellanox.com>


On 5/29/2019 8:58 PM, Sagi Grimberg wrote:
>
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

I see. It will work (in case I understand the idea).

I guess that set->map[HCTX_TYPE_READ].queue_offset is always == 
set->map[HCTX_TYPE_DEFAULT].nr_queues in case of separate queues.

I really don't understand the answer I got in V1, that we need to set 
the READ map always (also in the shared case). In the documentation it 
says that DEFAULT refers to queues that are not set explicitly. maybe 
it's because the nr_maps that we ask during tagset creation.

BTW,

does this feature really improve performance ? what is the scenario ?

I thing that a user might configure the queues in a wrong way that will 
cause perf degradation.


This patch fixes the reported bug,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
