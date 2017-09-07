From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 7 Sep 2017 13:47:08 +0300
Subject: [PATCH 2/3] nvmet-rdma: use SRQ per completion vector
In-Reply-To: <b02ac628-3960-7874-90bf-0a96e8938ea7@grimberg.me>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
 <1504609157-3004-3-git-send-email-maxg@mellanox.com>
 <b02ac628-3960-7874-90bf-0a96e8938ea7@grimberg.me>
Message-ID: <688ba6a5-c8bc-78ee-3933-8dc755f44b11@mellanox.com>



On 9/6/2017 5:50 PM, Sagi Grimberg wrote:
> 
>> In order to save resource allocation and utilize the completion
>> locality in a better way, allocate Shared Receive Queues (SRQs) per
>> completion vector (and not per device).
> 
> Something is backwards here, srq per vector is not saving resources
> compared to srq per-device, maybe compared to normal receive queues
> (if we have enough initiators).

I meant compared to the normal MQ state.
Also I added a module param that one can control the amount of resource 
allocations.

> 
> And what do you mean by "utilize the completion locality in a better
> way"? How is using srq affecting a completion queue locality?

I meant that for each completion that arrives on CPU N the "local" SRQ_N 
will be the one that will post_recv (and lock the srq spin_lock) the buffer.
In SRQ per device we'll get completions from all CPU's and a single SRQ 
will be "working" on all the CPU's.

maybe we can rephrase it.

> 
>> Assosiate each created QP/CQ
> 
> associate

:)

> 
>> with an appropriate SRQ according to the queue index. This association
>> will reduce the lock contention in the fast path
> 
> It reduces lock contention compared to srq-per-device, not normal
> receive queues.

of course.

> 
> 
>> and increase the locality in memory buffers.
> 
> How does it increase locality in memory buffers?

We are sharing buffers between many connections (compared to normal MQ). 
lets say that many initiatores are running traffic. In that case the 
shared buffers will be "hot" much more than the case that each resource 
will be used by 1 consumer. I assume the MM unit can recognize this 
situation.
