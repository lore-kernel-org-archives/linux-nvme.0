From: hare@suse.de (Hannes Reinecke)
Date: Wed, 21 Nov 2018 12:24:24 +0100
Subject: [PATCH 2/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <20181121082846.GB29231@lst.de>
References: <20181115122927.40431-1-hare@suse.de>
 <20181115122927.40431-3-hare@suse.de> <20181120164235.GA3073@lst.de>
 <84110e63-463b-807d-55b9-1a03ea7b61ff@suse.de>
 <20181121082846.GB29231@lst.de>
Message-ID: <394063d6-73c7-3953-881d-4304e496d1df@suse.de>

On 11/21/18 9:28 AM, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018@09:30:32PM +0100, Hannes Reinecke wrote:
>>> So you never consider non-optimized paths here?
>>>
>> Yes, correct. Two reasons:
>> - We try to optimize for performance. Selecting a non-optimized path per
>> definition doesn't provide that.
>> - The selection algorithm becomes overly complex, and will require an even
>> more complex mechanism to figure out at which point the use of a
>> non-optimized path become feasible.
> 
> We can still have a system where we don't see any optimized path at all,
> so you will need some kind of fallback.
> 
Well, the fallback is to use the original implementation, ie use a 
single path only.
And as already outlined in another mail, taking both optimized and 
non-optimized paths into account would increase the complexity of the 
algorithm massively.
Hence I'd prefer to have the simple implementation in for now, and 
improve upon it or add other algorithms if and when the need arises.

>>> Can you move the __nvme_find_path call for the first path into
>>> your round robing helper so that we can make this whole thing
>>> a little cleaner?  E.g.
>>>
>>> 	if (head->subsys->iopolicy == NVME_IOPOLICY_RR)
>>> 		return nvme_round_robin_path(head, node);
>>>    	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
>>> 		ns = __nvme_find_path(head, node);
>>> 	return ns;
>>> Actually this order was by design.
>> By ordering it _after_ __nvme_find_path() we guarantee that the first round
>> found an optimal path, and so we can continue selecting the next optimal
>> path.
>> So this ordering would break the assumptions I did when implementing it.
>> But I'll have a look to see if that can't be lifted.
> 
> You can keep the __nvme_find_path for round robin, I just want it moved
> into the round robin helper, so that the main function stays nice and tidy.
> 
Ah, that's what you mean.
Sure, no problem at all.

Cheers,

Hannes
