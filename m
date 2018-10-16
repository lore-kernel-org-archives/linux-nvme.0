From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Oct 2018 18:04:46 -0700
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me>
Message-ID: <c14b6091-781d-580e-833f-d2c6db54a5d2@grimberg.me>


>> Can we please make forward progress on this?
>>
>> Christoph, Sagi:? it seems you think /proc/irq/$IRP/smp_affinity
>> shouldn't be allowed if drivers support managed affinity. Is that 
>> correct?
>>
>> Perhaps that can be codified and be a way forward?? IE: Somehow allow
>> the admin to choose either "managed by the driver/ulps" or "managed by
>> the system admin directly"?
>>
>> Or just use Sagi's patch.? Perhaps a WARN_ONCE() if the affinity looks
>> wonked when set via procfs?? Just thinking out loud...
> 
> I think we should take my patch. While ideally we'd like to have
> perfect linear irq based queue mapping, people apparently really like
> to modify devices irq affinity. With this, at least some of the queues
> are assigned according to the device affinity. Its not ideal, but at
> least better than blindly falling to default mapping.
> 
> Christoph?
> 
> If there is strong resistance to the patch we should at least start
> by falling to the default mapping unconditionally.

Ping?

Would you prefer we fallback to the naive mapping if the device is not
using manged affinity?
