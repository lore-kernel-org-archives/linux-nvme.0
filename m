From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 19:24:25 +0300
Subject: [PATCH rfc 25/30] nvme: move control plane handling to nvme core
In-Reply-To: <20170619125505.GS29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-26-git-send-email-sagi@grimberg.me>
 <20170619125505.GS29061@lst.de>
Message-ID: <ff56bb79-1d57-b565-72a3-cd1e72b468b3@grimberg.me>

>> +static void nvme_free_io_queues(struct nvme_ctrl *ctrl)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < ctrl->queue_count; i++)
>> +		ctrl->ops->free_hw_queue(ctrl, i);
>> +}
>> +
>> +void nvme_stop_io_queues(struct nvme_ctrl *ctrl)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < ctrl->queue_count; i++)
>> +		ctrl->ops->stop_hw_queue(ctrl, i);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_stop_io_queues);
> 
> At leasr for PCIe this is going to work very differently, so I'm not
> sure this part make so much sense in the core.  Maybe in Fabrics?
> Or at least make the callouts operate on all I/O queues, which would
> suite PCIe a lot more.

Yea, I spent some time thinking on the async nature of queue
removal for pci... I started from ->stop/free_io_queues callouts
but hated the fact that we need to iterate exactly the same way
in every driver...

We could have an optional stop/free_io_queues that the core
will call instead if implemented?

>> +	error = ctrl->ops->start_hw_queue(ctrl, 0);
>> +	if (error)
>> +		goto out_cleanup_connect_queue;
>> +
>> +	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
>> +	if (error) {
>> +		dev_err(ctrl->device,
>> +			"prop_get NVME_REG_CAP failed\n");
>> +		goto out_cleanup_connect_queue;
>> +	}
>> +
>> +	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
>> +
>> +	error = nvme_enable_ctrl(ctrl, ctrl->cap);
>> +	if (error)
>> +		goto out_cleanup_connect_queue;
> 
> I'm not sure this ordering is going to work for PCIe..

This one is easy to reverse...
