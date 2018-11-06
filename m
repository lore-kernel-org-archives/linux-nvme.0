From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 6 Nov 2018 13:10:27 +0200
Subject: [PATCH] nvme-rdma: Don't fail the controller if only part of the
 queues fail to connect
In-Reply-To: <fa4ec36d-29e5-3cbd-742e-33c617d0f82e@broadcom.com>
References: <1541349434-31640-1-git-send-email-israelr@mellanox.com>
 <fa4ec36d-29e5-3cbd-742e-33c617d0f82e@broadcom.com>
Message-ID: <67c9a957-1b61-2632-396c-3c410f6729fa@mellanox.com>


On 11/5/2018 9:34 PM, James Smart wrote:
> On 11/4/2018 8:37 AM, Israel Rukshin wrote:
>> From: Sagi Grimberg <sagi at grimberg.me>
>>
>> blk-mq tells us to skip unmapped queues but we fail the controller 
>> altogether.
>>
>> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
>> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
>> ---
>> ? drivers/nvme/host/rdma.c | 19 ++++++++++++++++---
>> ? 1 file changed, 16 insertions(+), 3 deletions(-)
>>
>
> This sounds odd.?? Why aren't you concerned that io queues are not 
> connecting ?? Are there any log messages hinting at the failures ? any 
> way someone looking at the controller knows how many queues were 
> actually created ? ? I would assume any failure is significant and 
> should be visible, and it's worthwhile knowing whether this is a 
> consistent failure or a random failure. and what the failure was.

This may happen (well it happened in the past, and fixed in the block 
layer) in case there are offline cpu's or some other reason that some 
queue is unmapped.

I prefer not to relay on the block layer to ensure us 100% mapping and 
prefer be safe in our ULP.

>
> As far as continuing on in spite of failure - ok, but the target has 
> already been told, via SET FEATURES, to prepare (thus may allocate 
> resources) for X number of io queues, so minimally its a condition 
> where the target may be severely wasting resources which may affect 
> it's scale out ability.? I assume the transport should should be 
> resetting the controller and self-tuning the max queue count so that 
> it is reduced to what is being used.? Granted, this assumes the error 
> was consistent and for the same reason.? If it was an inconsistent 
> error, its ok to continue without resetting, but the transport should 
> be very verbose about the state it's in and why.

You can create IO queues (connect to IO queues in case of fabric) 
according to your desire. I don't think it's by the spec to create all 
queues that the target/drive support. For scale out we have suggested 
other solutions (set max_queues according to target resources, SRQ per 
core, etc...).



>
> It appears the patch doesn't save the connected queue count, which 
> means the blk-mq nr_hw_queues is not in sync with the new count. What 
> happens on those cpu's that select a hctx that is on a queue that 
> isn't connected ??? I assume the Q_LIVE bit has the queue_rq routine 
> continually bouncing them until they fail ?
>
we only allow failures if we get EXDEV rc. Usually in case of transport 
error, non of the queues will be able to connect. Here we protect 
against "in-house" recoverable error such as offline cpu's or others.

I guess Sagi can comment, it was originally proposed by him.


> Note: For now, where queues are only seen for cpu affinity, the choice 
> to "not use it" may not be a big deal. But in the future, queues may 
> be related to specific activities/features and this choice can't be so 
> arbitrary.

In the future, we'll update the code to suite new features.


>
> -- james
>
>
