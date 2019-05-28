From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 May 2019 12:46:23 -0700
Subject: [PATCH 1/2] nvme-rdma: fix queue mapping when queue count is
 limited
In-Reply-To: <35bf4975-a67b-8851-09e1-217969c6fb2e@mellanox.com>
References: <20190524041004.23200-1-sagi@grimberg.me>
 <35bf4975-a67b-8851-09e1-217969c6fb2e@mellanox.com>
Message-ID: <47b75bf8-366d-91fb-7527-e357396c57a5@grimberg.me>


>> When the controller supports less queues than requested, we
>> should make sure that queue mapping does the right thing and
>> not assume that all queues are available. This fixes a crash
>> when the controller supports less queues than requested.
>>
>> The rules are:
>> 1. if no write/poll queues are requested, we assign the available queues
>> ??? to the default queue map. The default and read queue maps share the
>> ??? existing queues.
>> 2. if write queues are requested:
>> ?? - first make sure that read queue map gets the requested
>> ???? nr_io_queues count
>> ?? - then grant the default queue map the minimum between the requested
>> ???? nr_write_queues and the remaining queues. If there are no available
>> ???? queues to dedicate to the default queue map, fallback to (1) and
>> ???? share all the queues in the existing queue map.
>> 3. if poll queues are requested:
>> ?? - map the remaining queues to the poll queue map.
>>
>> Also, provide a log indication on how we constructed the different
>> queue maps.
>>
>> One side-affect change is that we remove the rdma device number of
>> completion vectors device limitation when setting the queue count.
> 
> Why creating more rw queues than completion vectors ?

If the user is asking for num_online_cpus read and num_online_cpus write
it will never be able to. You are saying that each one should be limited
to the number of completion vectors?

I can do that.

>> @@ -681,6 +658,34 @@ static int nvme_rdma_alloc_io_queues(struct 
>> nvme_rdma_ctrl *ctrl)
>> ????? dev_info(ctrl->ctrl.device,
>> ????????? "creating %d I/O queues.\n", nr_io_queues);
>> +??? if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
> I would use local variables for write/poll/default queues and not 
> ctrl->opts pointer.
> 
> opts->nr_write_queues is not limited to num_online_cpu and can be 1000 
> (and you might steal poll queues).

This is just a question of weather write queues were requested, the
actual number is taken from ctrl->io_queues[HCTX_TYPE_DEFAULT]. So
it cannot "steal" any queues.

> Maybe we should limit it in nvmf_parse_options ?

I would avoid changing what the user passed in.

>> @@ -1763,17 +1768,24 @@ static void nvme_rdma_complete_rq(struct 
>> request *rq)
>> ? static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
>> ? {
>> ????? struct nvme_rdma_ctrl *ctrl = set->driver_data;
>> +??? struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
>> -??? set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
>> -??? set->map[HCTX_TYPE_DEFAULT].nr_queues =
>> -??????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> -??? set->map[HCTX_TYPE_READ].nr_queues = 
>> ctrl->io_queues[HCTX_TYPE_READ];
>> -??? if (ctrl->ctrl.opts->nr_write_queues) {
>> +??? if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
>> ????????? /* separate read/write queues */
>> +??????? set->map[HCTX_TYPE_DEFAULT].nr_queues =
>> +??????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> +??????? set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
>> +??????? set->map[HCTX_TYPE_READ].nr_queues =
>> +??????????? ctrl->io_queues[HCTX_TYPE_READ];
>> ????????? set->map[HCTX_TYPE_READ].queue_offset =
>> -??????????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> +??????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> ????? } else {
>> -??????? /* mixed read/write queues */
>> +??????? /* shared read/write queues */
>> +??????? set->map[HCTX_TYPE_DEFAULT].nr_queues =
>> +??????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> +??????? set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
>> +??????? set->map[HCTX_TYPE_READ].nr_queues =
>> +??????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> ????????? set->map[HCTX_TYPE_READ].queue_offset = 0;
> 
> why we should set the READ map in case of shared queues ?

The READ map is always set regardless of which case, its just
set differently.

> In that case we should rename TYPE_DEFAULT to TYPE_WRITE..

This is the shared queues case. This means that both default
and read queue maps relate to the same queues.

>> @@ -1781,16 +1793,22 @@ static int nvme_rdma_map_queues(struct 
>> blk_mq_tag_set *set)
>> ????? blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
>> ????????????? ctrl->device->dev, 0);
>> -??? if (ctrl->ctrl.opts->nr_poll_queues) {
>> +??? if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
>> +??????? /* map dedicated poll queues only if we have queues left */
>> ????????? set->map[HCTX_TYPE_POLL].nr_queues =
>> ????????????????? ctrl->io_queues[HCTX_TYPE_POLL];
>> ????????? set->map[HCTX_TYPE_POLL].queue_offset =
>> -??????????????? ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> -??????? if (ctrl->ctrl.opts->nr_write_queues)
>> -??????????? set->map[HCTX_TYPE_POLL].queue_offset +=
>> -??????????????? ctrl->io_queues[HCTX_TYPE_READ];
>> +??????????? ctrl->io_queues[HCTX_TYPE_DEFAULT] +
>> +??????????? ctrl->io_queues[HCTX_TYPE_READ];
> 
> I would use set->map[TYPE].nr_queues (the real offset).

Its exactly the same value, whats the difference?
