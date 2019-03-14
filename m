From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 14 Mar 2019 13:45:28 +0200
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
Message-ID: <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>


On 3/7/2019 3:56 AM, Sagi Grimberg wrote:
>
>>> net_dim.h lib exposes an implementation of the DIM algorithm for 
>>> dynamically-tuned interrupt
>>> moderation for networking interfaces.
>>>
>>> We need the same behavior for any block CQ. The main motivation is 
>>> two benefit from maximized
>>> completion rate and reduced interrupt overhead that DIM may provide.
>>
>> What is a "block CQ"?
>
> There is no such thing... Also, this has no difference
> if a block/file/whatever is using the rdma cq.
>
> The naming should really be something like rdma_dim as it accounts
> for completions and not bytes/packets.

Sagi,

I think that in the future we could use it in nvme since there is an 
option to set the interrupt coalescing in NVMe spec.

This might improve performance for NVMe driver.

We already see some bottlenecks in performance (maybe driver ones) while 
developing the NVMe SNAP feature in Bluefield (NVMe emulation using 
Smart NIC).

We're trying to get 2.5-2.7 MIOPs OOB from 1 controller and it's not 
trivial for today's driver.

So let's take this into consideration when we set the naming.


>
>
>> How does net_dim compare to lib/irq_poll?
>
> Its orthogonal, its basically adaptive interrupt moderation for
> RDMA devices. Its sort of below the irq_poll code. It basically
> configures interrupt moderation based on stats collected by
> the rdma driver.
>
>> Which approach results in the best performance and lowest latency?
>
> I guess it depends on what is the test case. This approach tries to
> apply some time or completion count limit to when the HW should fire
> an interrupt based on the load in an adaptive fashion.
>
> The scheme is to try and detect what are the load characteristics and
> come up with a moderation parameters that fit. For high interrupt rate
> (usually seen with small size high queue-depth workloads) it configures
> the device to aggregate some more before firing an interrupt - so less
> interrupts, better efficiency per interrupt (finds more completions).
> For low interrupt rate (low queue depth) the load is probably low to
> moderate and aggregating before firing an interrupt is just added
> latency for no benefit. So the algorithm tries to transition between a
> number of pre-defined levels according to the load it samples.
>
> This has been widely used by the network drivers for the past decade.
>
> Now, this algorithm while trying to adjust itself by learning the load,
> also adds entropy to the overall system performance and latency.
> So this is not a trivial trade-off for any workload.
>
> I took a stab at this once (came up with something very similar),
> and while for large queue-depth workloads I got up to 2x IOPs as the
> algorithm chose aggressive moderation parameters which improved the
> efficiency a lot, but when the workload varied the algorithm wasn't very
> successful detecting the load and the step direction (I used a variation
> of the same basic algorithm from mlx5 driver that net_dim is based on).
>
> Also, QD=1 resulted in higher latency as the algorithm was dangling
> between the two lowest levels. So I guess this needs to undergo a
> thorough performance evaluation for steady and varying workloads before
> we can consider this.
>
> Overall, I think its a great idea to add that to the rdma subsystem
> but we cannot make it the default and especially without being able
> to turn it off. So this needs to be opt in with a sysctl option.

We can add flag in create_cq command that will 
try_coalescing_is_possible instead of module parameter of course.

Storage ULPs can set it to True.

Also in the internal review Yamin added a table that summarize all the 
testing that were done using NVMeoF (I guess it somehow didn't get to 
this RFC).

I guess we can do the same for iSER to get more confidence and then set 
both to create modifiable cq (if HCA supports, of course).

Agreed ?

>
>
> Moreover, not every device support cq moderation so you need to check
> the device capabilities before you apply any of this.

for sure.
