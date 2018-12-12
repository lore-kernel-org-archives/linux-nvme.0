From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:19:22 -0800
Subject: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181212071140.GD28461@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de>
Message-ID: <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>


> [adding Jens]
> 
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1547,6 +1547,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>>   	if (ns->head->disk) {
>>   		nvme_update_disk_info(ns->head->disk, ns, id);
>>   		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
>> +		/* XXX: multipath device does not support polling for now... */
>> +		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);
> 
> I'd drop the XXX.  But I think we actually have a block layer problem
> here.  Currently stacking devices will just pass through REQ_HIPRI,
> despite none of them supporting any polling for it.

Yea... forgot there are other stack devices...

> So we need to make sure in the block layer or I/O submitter that
> REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
> also help if we rename it to REQ_POLL to make this more obvious.

It used to check for it, but was changed to look at nr_maps instead...
So I think this is a regression...
