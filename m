From: hare@suse.de (Hannes Reinecke)
Date: Thu, 13 Dec 2018 15:19:17 +0100
Subject: [PATCH v2 0/5] implement nvmf read/write queue maps
In-Reply-To: <90ebfdb6-8890-ad7d-a302-c6e3e5d8a97b@kernel.dk>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
 <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
 <ce273a86-ae5c-0d82-d3d5-a43367f9ba53@suse.de>
 <90ebfdb6-8890-ad7d-a302-c6e3e5d8a97b@kernel.dk>
Message-ID: <de2a5569-c4cd-f6a5-780a-d4c6fcd3d62d@suse.de>

On 12/13/18 3:02 PM, Jens Axboe wrote:
> On 12/13/18 5:04 AM, Hannes Reinecke wrote:
>> On 12/12/18 6:58 PM, Sagi Grimberg wrote:
>>>
>>>> Sagi,
>>>>
>>>> What other wins are there for this split ?
>>>>
>>>> I'm considering whether its worthwhile for fc as well, but the hol
>>>> issue doesn't exist with fc. What else is being resolved ?
>>>
>>> I've pondered it myself, which is why I didn't add it to fc as well
>>> (would have been easy enough I think). I guess that with this the
>>> user can limit writes compared to read by assigning less queues as
>>> jens suggested in his patches...
>>>
>> Weelll ... isn't that what blkcg is for?
>> I do understand if one would want to implement something like this if
>> there's a real benefit from the _hardware_ side, but if there isn't we
>> should try to keep it in the upper layers where it belongs.
> 
> The point is that nvme round robins queues, if you have 1 write queue
> for N read queues, then you would get better read servicing as writes
> can't flood more than one queue.
> 
> Obviously this isn't a replacement for any kind of real throttling,
> but it's cheap and easy to do.
> 
> The multiple queue maps are more useful for the polled IO, and for
> future prioritized IO in general. But it is also handy for not
> oversubscribing the write side.
> 
But how can you tell?
It's not that the hardware tells us "Oh, incidentally, I'm far slower 
writing than reading, please use only so many queues for writing.".
So any number we pick would be pretty heuristic to start with.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
