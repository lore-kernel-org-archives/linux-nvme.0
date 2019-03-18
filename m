From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 18 Mar 2019 13:08:28 +0200
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
Message-ID: <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>


On 3/18/2019 11:24 AM, Yamin Friedman wrote:
> On 3/14/2019 1:45 PM, Max Gurtovoy wrote:
>> On 3/7/2019 3:56 AM, Sagi Grimberg wrote:
>>>>> net_dim.h lib exposes an implementation of the DIM algorithm for
>>>>> dynamically-tuned interrupt
>>>>> moderation for networking interfaces.
>>>>>
>>>>> We need the same behavior for any block CQ. The main motivation is
>>>>> two benefit from maximized
>>>>> completion rate and reduced interrupt overhead that DIM may provide.
>>>> What is a "block CQ"?
>>> There is no such thing... Also, this has no difference
>>> if a block/file/whatever is using the rdma cq.
>>>
>>> The naming should really be something like rdma_dim as it accounts
>>> for completions and not bytes/packets.
>> Sagi,
>>
>> I think that in the future we could use it in nvme since there is an
>> option to set the interrupt coalescing in NVMe spec.
>>
>> This might improve performance for NVMe driver.
>>
>> We already see some bottlenecks in performance (maybe driver ones)
>> while developing the NVMe SNAP feature in Bluefield (NVMe emulation
>> using Smart NIC).
>>
>> We're trying to get 2.5-2.7 MIOPs OOB from 1 controller and it's not
>> trivial for today's driver.
>>
>> So let's take this into consideration when we set the naming.
>>
>>
> I agree that blk is not the most successful name, we were trying to find
> something that would work for general storage applications. I think
> rdma_dim would work as it is completion based but then when we want to
> use it for nvme it will probably require code duplication.

agreed for rdma_dim.

Yamin/Idan,

let's discuss internally regarding Sagi's proposal for 
moderation/coalescing per NVMe queue (and not per controller).

maybe need to update specification.


>
>>>
>>>> How does net_dim compare to lib/irq_poll?
>>> Its orthogonal, its basically adaptive interrupt moderation for
>>> RDMA devices. Its sort of below the irq_poll code. It basically
>>> configures interrupt moderation based on stats collected by
>>> the rdma driver.
>>>
>>>> Which approach results in the best performance and lowest latency?
>>> I guess it depends on what is the test case. This approach tries to
>>> apply some time or completion count limit to when the HW should fire
>>> an interrupt based on the load in an adaptive fashion.
>>>
>>> The scheme is to try and detect what are the load characteristics and
>>> come up with a moderation parameters that fit. For high interrupt rate
>>> (usually seen with small size high queue-depth workloads) it configures
>>> the device to aggregate some more before firing an interrupt - so less
>>> interrupts, better efficiency per interrupt (finds more completions).
>>> For low interrupt rate (low queue depth) the load is probably low to
>>> moderate and aggregating before firing an interrupt is just added
>>> latency for no benefit. So the algorithm tries to transition between a
>>> number of pre-defined levels according to the load it samples.
>>>
>>> This has been widely used by the network drivers for the past decade.
>>>
>>> Now, this algorithm while trying to adjust itself by learning the load,
>>> also adds entropy to the overall system performance and latency.
>>> So this is not a trivial trade-off for any workload.
>>>
>>> I took a stab at this once (came up with something very similar),
>>> and while for large queue-depth workloads I got up to 2x IOPs as the
>>> algorithm chose aggressive moderation parameters which improved the
>>> efficiency a lot, but when the workload varied the algorithm wasn't very
>>> successful detecting the load and the step direction (I used a variation
>>> of the same basic algorithm from mlx5 driver that net_dim is based on).
>>>
>>> Also, QD=1 resulted in higher latency as the algorithm was dangling
>>> between the two lowest levels. So I guess this needs to undergo a
>>> thorough performance evaluation for steady and varying workloads before
>>> we can consider this.
>>>
>>> Overall, I think its a great idea to add that to the rdma subsystem
>>> but we cannot make it the default and especially without being able
>>> to turn it off. So this needs to be opt in with a sysctl option.
>> We can add flag in create_cq command that will
>> try_coalescing_is_possible instead of module parameter of course.
>>
>> Storage ULPs can set it to True.
>>
>> Also in the internal review Yamin added a table that summarize all the
>> testing that were done using NVMeoF (I guess it somehow didn't get to
>> this RFC).
>>
>> I guess we can do the same for iSER to get more confidence and then
>> set both to create modifiable cq (if HCA supports, of course).
>>
>> Agreed ?
>>
> I think that adding a flag in create_cq will be less clean as it will
> require more work for anyone writing applications that should not have
> to consider this feature.


As we discussed, let's check with RDMA maintainers if it's better to 
extend alloc_cq API or create alloc_cq_dim API function.

Sagi/Christoph,

how about adding a module param per ULP ? as we use register_always 
today, create a use_dimm module param for iSER/NVMe-RDMA ?

>
> Based on the results I saw during testing I would set it to work by
> default as I could not find a use case where it significantly reduces
> performance and in many cases it is a large improvement. It should be
> more of an opt out situation.
>
> Performance improvement (ConnectX-5 100GbE, x86) running FIO benchmark over
>   ??? NVMf between two equal end-hosts with 56 cores across a Mellanox switch
>   ??? using null_blk device:
>
>   ??? IO READS before:
>   ??? blk size | BW????? | IOPS | 99th percentile latency
>   ??? 512B???? | 3.2GiB? | 6.6M | 1549? usec
>   ??? 4k?????? | 7.2GiB? | 1.8M | 7177? usec
>   ??? 64k????? | 10.7GiB | 176k | 82314 usec
>
>   ??? IO READS after:
>   ??? blk size | BW????? | IOPS | 99th percentile latency
>   ??? 512B???? | 4.2GiB? | 8.6M | 1729?? usec
>   ??? 4k?????? | 10.5GiB | 2.7M | 5669?? usec
>   ??? 64k????? | 10.7GiB | 176k | 102000 usec
>
>   ??? IO WRITES before:
>   ??? blk size | BW????? | IOPS | 99th percentile latency
>   ??? 512B???? | 3GiB??? | 6.2M | 2573? usec
>   ??? 4k?????? | 7.2GiB? | 1.8M | 5342? usec
>   ??? 64k????? | 10.7GiB | 176k | 62129 usec
>
>   ??? IO WRITES after:
>   ??? blk size | BW????? | IOPS? | 99th percentile latency
>   ??? 512B???? | 4.2GiB? | 8.6M? | 938?? usec
>   ??? 4k?????? | 10.2GiB | 2.68M | 2769? usec
>   ??? 64k????? | 10.6GiB | 173k? | 87557 usec
>
> It doesn't really make a difference to me how the option is implemented
> but I think it makes more sense to have it dealt with by us such as in a
> module parameter and not something like a flag that has a larger radius
> of effect.
>
>>>
>>> Moreover, not every device support cq moderation so you need to check
>>> the device capabilities before you apply any of this.
>> for sure.
>>
>>
