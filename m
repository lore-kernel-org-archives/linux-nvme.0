From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 08:21:35 +0200
Subject: [PATCH 5/6] nvme: track subsystems
In-Reply-To: <c6be6cd6-bb33-e3a7-484a-0070eff55949@grimberg.me>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-6-hch@lst.de>
 <c6be6cd6-bb33-e3a7-484a-0070eff55949@grimberg.me>
Message-ID: <20170616062135.GC6592@lst.de>

On Thu, Jun 15, 2017@08:04:53PM +0300, Sagi Grimberg wrote:
>> +static struct nvme_subsystem *__nvme_find_subsystem(const char *subsysnqn)
>
> __nvme_find_get_subsystem?

Sure.

>> +	if (!subsys)
>> +		return -ENOMEM;
>> +	INIT_LIST_HEAD(&subsys->ctrls);
>> +	kref_init(&subsys->ref);
>> +	nvme_init_subnqn(subsys, ctrl, id);
>> +	mutex_init(&subsys->lock);
>
> Nit: might be nicer to allocate the subsys only if its new (in the
> else case) instead of freeing if you found a match. Maybe
> nvme_init_subsysnqn should receive the subsysnqn buffer (on stack
> here) which would be copied to the subsys->subnqn if new.

That means another huge stack buffer, and it means we'll have to do
a kmalloc under the global lock.  Not the end of the world, but given
that most subsystems have a single controller anyway probably not worth
optimizing for.
