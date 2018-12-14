From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Dec 2018 12:36:02 -0700
Subject: [PATCH] nvme-pci: only set nr_maps to 2 if poll queues are
 supported
In-Reply-To: <a136f3b0-0be4-ef22-d224-3ca3ae22cf54@grimberg.me>
References: <20181214162019.14847-1-hch@lst.de>
 <9d2fa9e4-927e-655b-5db3-32d8f0a17db7@grimberg.me>
 <e6ff4bc1-2fbe-9aef-a384-ee19b4788460@kernel.dk>
 <a136f3b0-0be4-ef22-d224-3ca3ae22cf54@grimberg.me>
Message-ID: <dad8c698-cac2-8523-de9f-bfee87ff166b@kernel.dk>

On 12/14/18 12:01 PM, Sagi Grimberg wrote:
> 
>>>> The block layer now enables polling support on a queue if nr_maps
>>>> includes the poll map, so we should only set that if we actually
>>>> support poll queues.
>>>>
>>>> Fixes:  6544d229bf ("block: enable polling by default if a poll map is initalized")
>>>
>>> What does it fix? is there a bug when setting 3 queue maps?
>>
>> After the recent changes, blk_mq_init_allocated_queue() does this:
>>
>> if (set->nr_maps > HCTX_TYPE_POLL)
>> 	blk_queue_flag_set(QUEUE_FLAG_POLL, q);
>>
>> since the core doesn't have any notion of how many queues are used for
>> what. We only support polling if you have explicit poll queues now,
>> hence the above is wrong if nvme says nr_maps is 3 and it doesn't have
>> any poll queues.
> 
> Yea, but its not broken because the map shares the default queue map
> right? Just wanted to understand if something is broken rather than just
> wrong.

It's broken since we say we support polling by setting the QUEUE_FLAG_POLL
flag, but we do not. It's not broken in terms of maps on the nvme side.
As you mention, the map sharing means it's perfectly legit to not have
special queues for each map. Polling is just special since we absolutely
do require special poll queues without interrupts. It's not like reads
vs writes, where we can share and nobody cares.

-- 
Jens Axboe
