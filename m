From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Jul 2017 09:34:16 +0300
Subject: [PATCH 6/8] mtip32xx: quiesce request queues to make sure no
 submissions are inflight
In-Reply-To: <20170704223251.GB3732@ming.t460p>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-7-git-send-email-sagi@grimberg.me>
 <20170704223251.GB3732@ming.t460p>
Message-ID: <fd1a48c9-5912-69a6-7ade-32b07e21403b@grimberg.me>

>> @@ -3995,7 +3995,7 @@ static int mtip_block_remove(struct driver_data *dd)
>>   						dd->disk->disk_name);
>>   
>>   	blk_freeze_queue_start(dd->queue);
>> -	blk_mq_stop_hw_queues(dd->queue);
>> +	blk_mq_quiesce_queue(dd->queue);
>>   	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
> 
> We still need to unquiesce queue for avoiding hanging blk_freeze_queue()
> in blk_cleanup_queue() since any new request queued during quiescing
> can't be dispatched to driver/device.

Yes, already added it in v2.

> There are other blk_mq_tagset_busy_iter() in mtip_service_thread(),
> which looks need quiesce too.

Wasn't sure about those two... I agree it looks like quiescing is
needed, will add in v2.

> This case is even worse, because both
> mtip_abort_cmd() and mtip_queue_cmd() do not check if the req is
> started.

Its easy enough to add.
