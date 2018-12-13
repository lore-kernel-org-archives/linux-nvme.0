From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 13 Dec 2018 07:02:15 -0700
Subject: [PATCH v2 0/5] implement nvmf read/write queue maps
In-Reply-To: <ce273a86-ae5c-0d82-d3d5-a43367f9ba53@suse.de>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
 <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
 <ce273a86-ae5c-0d82-d3d5-a43367f9ba53@suse.de>
Message-ID: <90ebfdb6-8890-ad7d-a302-c6e3e5d8a97b@kernel.dk>

On 12/13/18 5:04 AM, Hannes Reinecke wrote:
> On 12/12/18 6:58 PM, Sagi Grimberg wrote:
>>
>>> Sagi,
>>>
>>> What other wins are there for this split ?
>>>
>>> I'm considering whether its worthwhile for fc as well, but the hol 
>>> issue doesn't exist with fc. What else is being resolved ?
>>
>> I've pondered it myself, which is why I didn't add it to fc as well
>> (would have been easy enough I think). I guess that with this the
>> user can limit writes compared to read by assigning less queues as
>> jens suggested in his patches...
>  >
> Weelll ... isn't that what blkcg is for?
> I do understand if one would want to implement something like this if 
> there's a real benefit from the _hardware_ side, but if there isn't we 
> should try to keep it in the upper layers where it belongs.

The point is that nvme round robins queues, if you have 1 write queue
for N read queues, then you would get better read servicing as writes
can't flood more than one queue.

Obviously this isn't a replacement for any kind of real throttling,
but it's cheap and easy to do.

The multiple queue maps are more useful for the polled IO, and for
future prioritized IO in general. But it is also handy for not
oversubscribing the write side.

-- 
Jens Axboe
