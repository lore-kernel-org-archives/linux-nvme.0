From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 14 Mar 2019 14:53:08 -0700
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
Message-ID: <1271ff04-c1c2-fe9d-c7e8-4898c690d242@grimberg.me>


>>> What is a "block CQ"?
>>
>> There is no such thing... Also, this has no difference
>> if a block/file/whatever is using the rdma cq.
>>
>> The naming should really be something like rdma_dim as it accounts
>> for completions and not bytes/packets.
> 
> Sagi,
> 
> I think that in the future we could use it in nvme since there is an 
> option to set the interrupt coalescing in NVMe spec.
> 
> This might improve performance for NVMe driver.

That would require changing the spec to make moderation config per-queue
and not controller-wide. This does not apply specifically to block so
naming it with blk does not make sense.

>> Overall, I think its a great idea to add that to the rdma subsystem
>> but we cannot make it the default and especially without being able
>> to turn it off. So this needs to be opt in with a sysctl option.
> 
> We can add flag in create_cq command that will 
> try_coalescing_is_possible instead of module parameter of course.
> 
> Storage ULPs can set it to True.

The point is that it can't be universally on.

> Also in the internal review Yamin added a table that summarize all the 
> testing that were done using NVMeoF (I guess it somehow didn't get to 
> this RFC).
> 
> I guess we can do the same for iSER to get more confidence and then set 
> both to create modifiable cq (if HCA supports, of course).
> 
> Agreed ?

Sure.
