From: hare@suse.de (Hannes Reinecke)
Date: Thu, 18 Apr 2019 17:02:10 +0200
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <20190418143429.GA19175@ming.t460p>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
Message-ID: <28f8343f-3159-9ca2-f98f-a37ecce31fd5@suse.de>

On 4/18/19 4:34 PM, Ming Lei wrote:
> Hi Hannes,
> 
> On Thu, Apr 18, 2019@04:06:32PM +0200, Hannes Reinecke wrote:
>> When calling blk_queue_split() it will be using the per-queue
>> bioset to allocate the split bio from. However, blk_steal_bios()
>> might move the bio to another queue, _and_ the original queue
>> might be removed completely (nvme is especially prone to do so).
> 
> Could you explain a bit how the original queue is removed in case
> that blk_steal_bios() is involved?
> 
It's not blk_steal_bios() which removes the queue. What happens is:

- bio returns with error
- blk_steal_bios() moves bio over to a different queue
- nvme_reset_ctrl() is called
- Error detection finds that the original device is gone
- nvme calls nvme_remove_ns()
- nvme_remove_ns() removes the original request queue alongside the 
bio_set from which the bvecs have been allocated from.
- 'stolen' bio is completed
- 'stolen' bio calls bio_endio()
- bio_endio() calls mempool_free() on the bvecs, referencing the mempool 
from the original queue
- crash

>> That leaves the bvecs of the split bio with a missing / destroyed
>> mempool, and a really fun crash in bio_endio().
> 
> per-queue bioset is used originally for avoiding deadlock, are you
> sure the static bioset is safe?
> 
If that turns out be be an issue we could be having a per 'ns_head' 
bio_set for allocating the split bio from.
But the main point is that we cannot use the bioset from the request 
queue as the queue (and the bioset) might be removed during the lifetime 
of the bio.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
