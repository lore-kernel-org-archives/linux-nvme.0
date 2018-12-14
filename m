From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 14 Dec 2018 10:59:51 -0800
Subject: [PATCH v3 6/6] nvme-rdma: implement polling queue map
In-Reply-To: <20181214154632.GC24417@lst.de>
References: <20181213213410.9841-1-sagi@grimberg.me>
 <20181213213410.9841-7-sagi@grimberg.me> <20181214154632.GC24417@lst.de>
Message-ID: <1ae85cf5-4b54-c1f2-7337-16184f7ba5d4@grimberg.me>


>> +static bool nvme_rdma_poller_queue(struct nvme_rdma_queue *queue)
> 
> Can we please make this poll_queue?  or at least polled_queue?
> poller sounds odd..

Changed to nvme_rdma_poll_queue..

> 
>> -		set->nr_maps = 2 /* default + read */;
>> +		set->nr_maps = HCTX_MAX_TYPES;
>>   	}
>>   
>>   	ret = blk_mq_alloc_tag_set(set);
>> @@ -864,6 +881,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>>   			ret = PTR_ERR(ctrl->ctrl.connect_q);
>>   			goto out_free_tag_set;
>>   		}
>> +
>> +		if (ctrl->ctrl.opts->nr_poll_queues)
>> +			blk_queue_flag_set(QUEUE_FLAG_POLL,
>> +				ctrl->ctrl.connect_q);
> 
> The block core is supposed to detect we can poll based on nr_maps > 2,
> and then set QUEUE_FLAG_POLL automatically.  Although I got the details
> wrong for PCI as well, but I just sent a fix..

I'll lose that, but I didn't understand what you got wrong for pci?
(didn't understand the fix either)

>> +static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
>> +{
>> +	struct nvme_rdma_queue *queue = hctx->driver_data;
>> +	struct ib_cq *cq = queue->ib_cq;
>> +
>> +	return ib_process_cq_direct(cq, -1);
> 
> I think we can skip the cq local variable here.

Lost..

> Otherwise this looks really nice and simple, thanks for looking into it!
> 
> Do you have any performance number, especially with Jens' ringbuffer
> code?

Well, I can get from my local vm on my laptop on top of soft-roce 7K
iops :) (compared tp 5.5K without polling, but not something to
conclude from)

I don't have any numbers to show for right now...

As I said in the cover letter, we want a way to tell ib_poll_cq_direct
to not count send completions (where we end our sqe), right now we are
probably screwing up poll_success stat...
