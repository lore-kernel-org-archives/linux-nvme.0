From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 5 Jun 2019 01:02:16 +0300
Subject: [Suspected-Phishing]Re: [PATCH] Revert "nvme-rdma: remove
 redundant reference between ib_device and tagset"
In-Reply-To: <20190604191131.GC28398@lst.de>
References: <20190603231159.17034-1-sagi@grimberg.me>
 <b98d3c8f-85ee-06f2-b47a-a3e04261c0d1@grimberg.me>
 <F4E18075-01AA-443B-BF43-23A4BA80C10C@intel.com>
 <d2a20c0f-092d-28ca-3365-1fb5df2cb816@mellanox.com>
 <b4a79dfe-ffc8-0571-9f54-cf5b98c21500@mellanox.com>
 <20190604191131.GC28398@lst.de>
Message-ID: <73b729a8-b3ee-a54a-64a1-2bd2e615e23f@mellanox.com>


On 6/4/2019 10:11 PM, Christoph Hellwig wrote:
> So this basically means we can't keep dma mappings around, which
> is a bit unfortunate.  Can you also write a real changelog explaining
> the reasoning behind it, which isn't quite obvious to me?

Sure I'll explain it when I'll send a final patch. This one was quick 
and dirty one. I put this in our nightly regression and I'll run more 
manual tests tomorrow as well.

This was Sagi's idea actually to dma map and unmap during the actual 
queue_rq and complete_rq to instead of taking a refcount by the 
rdma_ctrl of the rdma_device.

We need this reference since currently we do the dma_unmap during 
exit_request callback and the ibdev might be already freed (disconnect 
during reconnect scenario for example) and we get the trace and crash.

My idea for an alternative fix was taking a ctrl refcount on the device 
and add a blk_iter for remapping the requests. But I guess Sagi's idea 
is simpler.

Another thing that came into my mind during writing the fix is how we 
deal with the scenario that the target ctrl queues depth was changed 
during re-connection ? As we don't destroy the tagset in re-connection, 
we might need to add blk layer helper for that.


>
> Nitpicks below:
>
>> +static void nvme_rdma_unmap_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
>> +			       size_t capsule_size, enum dma_data_direction dir)
>>   {
>>   	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
>> +}
>> +
>> +static int nvme_rdma_map_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
>> +			    size_t capsule_size, enum dma_data_direction dir)
>> +{
>> +	qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
>> +	return ib_dma_mapping_error(ibdev, qe->dma);
>> +}
>> +
>> +static void nvme_rdma_free_qe(struct nvme_rdma_qe *qe)
>> +{
>>   	kfree(qe->data);
>>   }
> All these helpers are pretty pointless now, and we might as well just
> open code them.
>
>> +static void nvme_rdma_free_mapped_qe(struct ib_device *ibdev,
>> +				     struct nvme_rdma_qe *qe,
>> +				     size_t capsule_size,
>> +				     enum dma_data_direction dir)
> Can you use normal two tabs indents for your new functions?
>
>>   
>>   	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
>>   
>> -	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
>> -			sizeof(struct nvme_command), DMA_TO_DEVICE);
>> +	error = nvme_rdma_alloc_mapped_qe(ctrl->device->dev,
>> +					  &ctrl->async_event_sqe,
>> +					  sizeof(struct nvme_command),
>> +					  DMA_TO_DEVICE);
> So.. If keeping SQEs mapped is not fine, why is keeping the AEN SQE
> around fine?

we alloc_map and free_unmap it for each re-connection/error_recovery so 
we're good here. Also for post_recv ring.

For the SQEs we can't hold it since we don't destroy the tagset in 
error_recovery.


>
>> +		if (err == -ENOMEM || err == -EAGAIN)
>> +			ret = BLK_STS_RESOURCE;
>> +		else
>> +			ret = BLK_STS_IOERR;
>> +		goto unmap_qe;
>>   	}
>>   
>>   	sqe->cqe.done = nvme_rdma_send_done;
>> @@ -1735,14 +1781,20 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   			req->mr ? &req->reg_wr.wr : NULL);
>>   	if (unlikely(err)) {
>>   		nvme_rdma_unmap_data(queue, rq);
>> -		goto err;
>> +		if (err == -ENOMEM || err == -EAGAIN)
>> +			ret = BLK_STS_RESOURCE;
>> +		else
>> +			ret = BLK_STS_IOERR;
>> +		goto unmap_qe;
> It would be nice to keep the status mapping in a single place behind
> the goto label.

Yup I'll do it as it was before.

(Was too quick implementation...)

>> +out:
>> +	return ret;
> No real need for the label here, you could just return directly.
Yup.
