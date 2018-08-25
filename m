From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 Aug 2018 19:17:38 -0700
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <20180822131130.GC28149@lst.de>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
Message-ID: <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>


>> nvme-rdma attempts to map queues based on irq vector affinity.
>> However, for some devices, completion vector irq affinity is
>> configurable by the user which can break the existing assumption
>> that irq vectors are optimally arranged over the host cpu cores.
> 
> IFF affinity is configurable we should never use this code,
> as it breaks the model entirely.  ib_get_vector_affinity should
> never return a valid mask if affinity is configurable.

I agree that the model intended initially doesn't fit. But it seems
that some users like to write into their nic's
/proc/irq/$IRP/smp_affinity and get mad at us for not letting them with
using managed affinity.

So instead of falling back to the block mapping function we try
to do a little better first:
1. map according to the device vector affinity
2. map vectors that end up without a mapping to cpus that belong
    to the same numa-node
3. map all the rest of the unmapped cpus like the block layer
    would do.

We could have device drivers that don't use managed affinity to never
return a valid mask but that would never allow affinity based mapping
which is optimal at least for users that do not mangle with device
irq affinity (which is probably the majority of users).

Thoughts?
