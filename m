From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:11:19 -0800
Subject: [PATCH 4/5] nvme-tcp: support separate queue maps for read and
 write
In-Reply-To: <20181211134135.GD20614@lst.de>
References: <20181211104936.25333-1-sagi@grimberg.me>
 <20181211104936.25333-5-sagi@grimberg.me> <20181211134135.GD20614@lst.de>
Message-ID: <0b392933-9cdd-bfba-ea14-cdabc31a1dcb@grimberg.me>


>> +static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
>> +{
>> +	struct nvme_tcp_ctrl *ctrl = set->driver_data;
>> +	struct blk_mq_queue_map *map;
>> +
>> +	if (ctrl->ctrl.opts->nr_write_queues) {
>> +		/* separate read/write queues */
>> +		map = &set->map[HCTX_TYPE_DEFAULT];
>> +		map->queue_offset = 0;
>> +		map->nr_queues = ctrl->ctrl.opts->nr_write_queues;
>> +		blk_mq_map_queues(map);
> 
> Shouldn't this use nr_io_queues?

The intent is that HCTX_TYPE_READ will always use nr_io_queues and
HCTX_TYPE_DEFAULT will use nr_write_queues.. I'll document that
in the change log.

> Also I find the reused local map variable a little odd and not helpful
> for readability.  What about something like:
> 
> static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
> {
> 	struct nvme_tcp_ctrl *ctrl = set->driver_data;
> 
> 	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> 	set->map[HCTX_TYPE_DEFAULT].nr_queues = ctrl->ctrl.opts->nr_io_queues;
> 	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> 
> 	if (ctrl->ctrl.opts->nr_write_queues) {
> 		/* separate read/write queues */
> 		set->map[HCTX_TYPE_READ].queue_offset =
> 				ctrl->ctrl.opts->nr_io_queues;
> 		set->map[HCTX_TYPE_READ].nr_queues =
> 				ctrl->ctrl.opts->nr_write_queues;
> 	} else {
> 		/* mixed read/write queues */
> 		set->map[HCTX_TYPE_READ].queue_offset = 0;
> 		set->map[HCTX_TYPE_READ].nr_queues =
> 				ctrl->ctrl.opts->nr_io_queues;
> 	}
> 	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> 	return 0;
> }

That's better.. I'll update the patch with a change according to my
note above..
