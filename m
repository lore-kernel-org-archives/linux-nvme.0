From: hch@lst.de (Christoph Hellwig)
Date: Tue, 11 Dec 2018 14:42:20 +0100
Subject: [PATCH 5/5] nvme-rdma: support read/write queue separation
In-Reply-To: <20181211104936.25333-6-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
 <20181211104936.25333-6-sagi@grimberg.me>
Message-ID: <20181211134220.GE20614@lst.de>

This probably wants a little explanation..

>  	struct nvme_rdma_ctrl *ctrl = set->driver_data;
> +	struct blk_mq_queue_map *map;
> +	int offset = 0;
> +
> +	if (ctrl->ctrl.opts->nr_write_queues) {
> +		/* separate read/write queues */
> +		map = &set->map[HCTX_TYPE_DEFAULT];
> +		map->queue_offset = offset;
> +		map->nr_queues = ctrl->ctrl.opts->nr_write_queues;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
> +		offset += map->nr_queues;
> +
> +		map = &set->map[HCTX_TYPE_READ];
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		map->queue_offset = offset;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, offset);
> +		offset += map->nr_queues;
>  
> +	} else {
> +		/* mixed read/write queues */
> +		map = &set->map[HCTX_TYPE_DEFAULT];
> +		map->queue_offset = 0;
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
> +
> +		map = &set->map[HCTX_TYPE_READ];
> +		map->queue_offset = 0;
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
> +	}

Same comment and suggested style as for the TCP one.
