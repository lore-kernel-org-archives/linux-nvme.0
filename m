From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 3 Oct 2018 14:05:16 -0500
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
Message-ID: <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>



On 8/24/2018 9:17 PM, Sagi Grimberg wrote:
> 
>>> nvme-rdma attempts to map queues based on irq vector affinity.
>>> However, for some devices, completion vector irq affinity is
>>> configurable by the user which can break the existing assumption
>>> that irq vectors are optimally arranged over the host cpu cores.
>>
>> IFF affinity is configurable we should never use this code,
>> as it breaks the model entirely.? ib_get_vector_affinity should
>> never return a valid mask if affinity is configurable.
> 
> I agree that the model intended initially doesn't fit. But it seems
> that some users like to write into their nic's
> /proc/irq/$IRP/smp_affinity and get mad at us for not letting them with
> using managed affinity.
> 
> So instead of falling back to the block mapping function we try
> to do a little better first:
> 1. map according to the device vector affinity
> 2. map vectors that end up without a mapping to cpus that belong
> ?? to the same numa-node
> 3. map all the rest of the unmapped cpus like the block layer
> ?? would do.
> 
> We could have device drivers that don't use managed affinity to never
> return a valid mask but that would never allow affinity based mapping
> which is optimal at least for users that do not mangle with device
> irq affinity (which is probably the majority of users).
> 
> Thoughts?

Can we please make forward progress on this?

Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
shouldn't be allowed if drivers support managed affinity. Is that correct?

Perhaps that can be codified and be a way forward?  IE: Somehow allow
the admin to choose either "managed by the driver/ulps" or "managed by
the system admin directly"?

Or just use Sagi's patch.  Perhaps a WARN_ONCE() if the affinity looks
wonked when set via procfs?  Just thinking out loud...

But as it stands, things are just plain borked if an rdma driver
supports ib_get_vector_affinity() yet the admin changes the affinity via
/proc...

Thanks,

Steve.
