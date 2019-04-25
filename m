From: hare@suse.de (Hannes Reinecke)
Date: Thu, 25 Apr 2019 16:32:42 +0200
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <20190425004106.GA22683@ming.t460p>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
 <20190424221422.GA21351@ming.t460p> <20190425004106.GA22683@ming.t460p>
Message-ID: <c6a54cea-f2ce-3344-efb1-ba8f20bf9509@suse.de>

On 4/25/19 2:41 AM, Ming Lei wrote:
> On Thu, Apr 25, 2019@06:14:22AM +0800, Ming Lei wrote:
>> On Wed, Apr 24, 2019@10:20:46AM -0700, Sagi Grimberg wrote:
>>>
>>>> per-queue bioset is used originally for avoiding deadlock, are you
>>>> sure the static bioset is safe?
>>>
>>> Can you explain this? I didn't find any indication of that in the change
>>> log history...
>>>
>>> Originally introduced by Kent:
>>
>> bio split can be run from stacking drivers, for example, MD over NVMe,
>> if the global reserved mempool is consumed by MD bio splitting, then
>> no any progress can be made when splitting on bio submitted to NVMe.
>>
>> Kent may have more details...
> 
> I guess it might be fine to use one shared global bio_set for all
> lowest underlying queues, could be all queues except for loop, dm, md
> , drbd, bcache, ...
> 
But wasn't the overall idea of stacking drivers that we propagate the 
queue limits up to the uppermost drivers, so that we have to do a split 
only at the upper layers?
Furthermore, it's not every bio which needs to be split, only those 
which straddle some device limitations.
The only ones not being able to propagate the queue limits is MD, and 
that is already using a private bio_set here.

I've worked on a patchset to provide a separate bio set for each of the 
stacking drivers, but the interface I've been able to come up with is 
not very nice, and I really doubt it's worth it.

So I'd advocate to test with this patch first, and only provide 
individual biosets once we find it's an issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
