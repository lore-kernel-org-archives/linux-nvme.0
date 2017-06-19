From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 10:59:22 +0300
Subject: [PATCH rfc 02/30] nvme-rdma: Don't alloc/free the tagset on reset
In-Reply-To: <20170619071851.GB13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-3-git-send-email-sagi@grimberg.me>
 <20170619071851.GB13168@lst.de>
Message-ID: <4b612cf9-f8ba-f2fa-8f93-c2c46468daf4@grimberg.me>



On 19/06/17 10:18, Christoph Hellwig wrote:
>> +static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remove)
>>   {
>> +	nvme_rdma_stop_queue(&ctrl->queues[0]);
>> +	if (remove) {
>> +		blk_cleanup_queue(ctrl->ctrl.admin_connect_q);
>> +		blk_cleanup_queue(ctrl->ctrl.admin_q);
>> +		blk_mq_free_tag_set(&ctrl->admin_tag_set);
>> +		nvme_rdma_dev_put(ctrl->device);
>> +	}
>> +
>>   	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
>>   			sizeof(struct nvme_command), DMA_TO_DEVICE);
>> +	nvme_rdma_free_queue(&ctrl->queues[0]);
> 
> I don't like the calling convention.  We only have have two callers
> anyway.  So I'd much rather only keep the code inside the if above
> in the new nvme_rdma_destroy_admin_queue that is only called at shutdown
> time, and opencode the calls to nvme_rdma_stop_queue, nvme_rdma_free_qe
> and nvme_rdma_free_queue in the callers.

We can do that, but this tries to eliminate duplicate code as
much as possible. It's not like the convention is unprecedented...

>> -static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
>> +static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)
> 
> PCIe is just checking for a non-null admin_q.

Which I don't like very much :)

> But I think we should
> jsut split this into two functions, one for the shared code at the end
> and one just for the first-time setup, with the nvme_rdma_init_queue
> call open coded.

We can split, but I less like the idea of open-coding
nvme_rdma_init_queue at the call-sites.

>>   	error = nvmf_connect_admin_queue(&ctrl->ctrl);
>> @@ -1596,6 +1601,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
>>   
>>   	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
>>   
>> +	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
>> +
> 
> Where does this come from?

Spilled in I guess...
