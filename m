From: hare@suse.com (Hannes Reinecke)
Date: Thu, 22 Nov 2018 14:52:56 +0100
Subject: [PATCH 2/2] nvme-multipath: round-robin I/O policy
In-Reply-To: <8a583536-151e-6f68-f4f9-98d8c4b853dd@broadcom.com>
References: <20181115122927.40431-1-hare@suse.de>
 <20181115122927.40431-3-hare@suse.de> <20181120164235.GA3073@lst.de>
 <84110e63-463b-807d-55b9-1a03ea7b61ff@suse.de>
 <8a583536-151e-6f68-f4f9-98d8c4b853dd@broadcom.com>
Message-ID: <4bd45bde-d709-5aa4-d454-f936b2baeefd@suse.com>

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
Errm.

I believe you are referring to this bit of the spec:
 > If no controllers are reporting ANA Optimized state or ANA
 > Non-Optimized state, then a transition may be occurring such
 > that a controller reporting the Inaccessible state may become
 > accessible and the host should retry the command on the controller
 > reporting Inaccessible state for at least ANATT seconds

But from my interpretation this is only valid if the target is _already_ 
transitioning (... a transitioning may be occuring ...), and is not 
intended to _induce_ a transtion.
And if you happen refer to the slightly 'odd' E-Series behaviour, we're 
already in discussion with them to get that fixed up :-)

But in general, an explicit failover with sending I/O to the 
inaccessible path is _NOT_ something we assume, not what the spec intended.
That really brings back horrible memories from the old AVT mechanism in 
RDAC, which never really worked and only caused issued during booting.
If some poor soul really had implemented it we should point him to the 
error of his ways ...

But still, yes, we could follow with a second round of trying the 
non-optimized path, but this would happen only if we ran out of 
optimized paths.

As you're not the first requesting that, I'll be including that with my 
next version.

Cheers,

Hannes
