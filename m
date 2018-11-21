From: hare@suse.de (Hannes Reinecke)
Date: Wed, 21 Nov 2018 12:09:06 +0100
Subject: [PATCH 2/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <8a583536-151e-6f68-f4f9-98d8c4b853dd@broadcom.com>
References: <20181115122927.40431-1-hare@suse.de>
 <20181115122927.40431-3-hare@suse.de> <20181120164235.GA3073@lst.de>
 <84110e63-463b-807d-55b9-1a03ea7b61ff@suse.de>
 <8a583536-151e-6f68-f4f9-98d8c4b853dd@broadcom.com>
Message-ID: <b3adb4fe-486f-481d-4dc9-13718d90e91d@suse.de>

On 11/20/18 9:41 PM, James Smart wrote:
> 
> 
> On 11/20/2018 12:30 PM, Hannes Reinecke wrote:
>>> So you never consider non-optimized paths here?
>>>
>> Yes, correct. Two reasons:
>> - We try to optimize for performance. Selecting a non-optimized path 
>> per definition doesn't provide that.
>> - The selection algorithm becomes overly complex, and will require an 
>> even more complex mechanism to figure out at which point the use of a 
>> non-optimized path become feasible.
> 
> so what do you do on an out-of-optimized-paths scenario ??? I would 
> assume the same logic should be applicable, only looking for 
> non-optimized.?? And if both optimized and non-optimized are 
> out-of-paths, then it should revert to the same logic, just inaccessible 
> paths.? I believe the last sentence is required for current devices(s) 
> out there to induce storage failover.
> 
The idea is to a round-robin load balancing for optimal paths, and fall 
back to single path once we run out of optimal paths.

As already explained, one could implement a round-robin algorithm for 
non-optimial paths, too, but the question then arises how to handle 
scenarios where we have both.
Clearly, in the optimal case we should be scheduling between optimal 
paths only.
But what happens when the optimal paths do down?
Shall we wait until all optimal paths are down, and only then switch 
over to the non-optimal ones?
But when doing that we might end up in a situation where we have only 
one optimal path, and several non-optimal ones.
And as the underlying reason was that several paths provide a better 
performance than a single one. there will be a cut-over point when 
several non-optimal paths might provide a better performance than a 
single optimal one.
But that would be pretty much implementation defined, and hard to quantify.

Hence I settled on the rather trivial algorithm with considering optimal 
paths only.

Cheers,

Hannes
