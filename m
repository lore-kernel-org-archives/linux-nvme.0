From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 14 Dec 2018 11:49:45 -0800
Subject: [PATCH] nvme-pci: only set nr_maps to 2 if poll queues are
 supported
In-Reply-To: <dad8c698-cac2-8523-de9f-bfee87ff166b@kernel.dk>
References: <20181214162019.14847-1-hch@lst.de>
 <9d2fa9e4-927e-655b-5db3-32d8f0a17db7@grimberg.me>
 <e6ff4bc1-2fbe-9aef-a384-ee19b4788460@kernel.dk>
 <a136f3b0-0be4-ef22-d224-3ca3ae22cf54@grimberg.me>
 <dad8c698-cac2-8523-de9f-bfee87ff166b@kernel.dk>
Message-ID: <9b53a38c-7a03-e52c-61db-85b0b6494b35@grimberg.me>


>>> since the core doesn't have any notion of how many queues are used for
>>> what. We only support polling if you have explicit poll queues now,
>>> hence the above is wrong if nvme says nr_maps is 3 and it doesn't have
>>> any poll queues.
>>
>> Yea, but its not broken because the map shares the default queue map
>> right? Just wanted to understand if something is broken rather than just
>> wrong.
> 
> It's broken since we say we support polling by setting the QUEUE_FLAG_POLL
> flag, but we do not. It's not broken in terms of maps on the nvme side.
> As you mention, the map sharing means it's perfectly legit to not have
> special queues for each map. Polling is just special since we absolutely
> do require special poll queues without interrupts. It's not like reads
> vs writes, where we can share and nobody cares.

Yea... I fixed that for rdma as well..
