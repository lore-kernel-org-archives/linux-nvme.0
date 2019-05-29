From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 May 2019 15:41:41 -0700
Subject: [PATCH v2 1/2] nvme-rdma: fix queue mapping when queue count is
 limited
In-Reply-To: <43f3aeb8-d8a7-a9b4-7623-7f6e0a2bdc2b@mellanox.com>
References: <20190529054905.16279-1-sagi@grimberg.me>
 <83c239a0-69bd-9fa4-b7af-4cb01d20cc2c@mellanox.com>
 <c5fa88e8-f046-2d3b-7851-afbc1446fcbf@grimberg.me>
 <43f3aeb8-d8a7-a9b4-7623-7f6e0a2bdc2b@mellanox.com>
Message-ID: <22d82019-67cc-3cca-6920-d2accd7ed2b0@grimberg.me>


> I see. It will work (in case I understand the idea).
> 
> I guess that set->map[HCTX_TYPE_READ].queue_offset is always == 
> set->map[HCTX_TYPE_DEFAULT].nr_queues in case of separate queues.

Yes.

> I really don't understand the answer I got in V1, that we need to set 
> the READ map always (also in the shared case). In the documentation it 
> says that DEFAULT refers to queues that are not set explicitly. maybe 
> it's because the nr_maps that we ask during tagset creation.

Exactly.

> BTW,
> 
> does this feature really improve performance ? what is the scenario ?

It could. It pretty much gives dedicated queues for reads that are
usually more latency sensitive than writes.

Also, I have a patch that I plan to propose that ties priority queue
arbitration to this. This way we can hint the controller the priority
of poll queues over read queues over default queues.

> I thing that a user might configure the queues in a wrong way that will 
> cause perf degradation.

The default case remains intact. The user can always theoretically get
it wrong, but this is why its not the default.

> This patch fixes the reported bug,
> 
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

Thanks Max. We'll queue it up.
