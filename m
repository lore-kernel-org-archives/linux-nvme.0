From: yaminf@mellanox.com (Yamin Friedman)
Date: Thu, 21 Mar 2019 05:53:01 +0000
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <78352f3a-7788-e4c3-8d53-7c0b7a63921b@grimberg.me>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <78352f3a-7788-e4c3-8d53-7c0b7a63921b@grimberg.me>
Message-ID: <9c10b248-cfbf-f02b-4fcf-1b325f6a7912@mellanox.com>


On 3/18/2019 11:32 PM, Sagi Grimberg wrote:
>
>> I agree that blk is not the most successful name, we were trying to find
>> something that would work for general storage applications. I think
>> rdma_dim would work as it is completion based but then when we want to
>> use it for nvme it will probably require code duplication.
>
> Lets worry about reuse NVMe when it is actually applicable.
>
>>> Also in the internal review Yamin added a table that summarize all the
>>> testing that were done using NVMeoF (I guess it somehow didn't get to
>>> this RFC).
>>>
>>> I guess we can do the same for iSER to get more confidence and then
>>> set both to create modifiable cq (if HCA supports, of course).
>>>
>>> Agreed ?
>>>
>> I think that adding a flag in create_cq will be less clean as it will
>> require more work for anyone writing applications that should not have
>> to consider this feature.
>>
>> Based on the results I saw during testing I would set it to work by
>> default as I could not find a use case where it significantly reduces
>> performance and in many cases it is a large improvement. It should be
>> more of an opt out situation.
>
> By detailed performance results I meant:
> 1. Full latency histogram for QD=1 both for single queue and multi-queue
> (including max, 99.99% and 99.999% percentiles)
> 2. latency vs. IOPs graph/table for both single queue and multi-queue
> 3. At least some measurement/analysis of how well the algorithm is
> ?? adapting to workload change dynamically and how quickly.
> 4. Test also with real NVMe devices.
>
> Also, we need to separate the host side moderation and the target
> side moderation to understand if/how they effect each other.
>
> Its very easy to show that for high stress workloads you can get an
> improvement as obviously there is a clear win for interrupt moderation,
> however, if this was the only metric that is interesting, we wouldn't
> need it to be adaptive.
>
> As I said before, this adds entropy to the equation which in certain use
> cases can make more harm than good, and we need to quantify where is the
> impact and understand how important they are compared to the extremely
> niche use-case of a single host pushing 2M-8M IOPs.


I ran extensive tests between two hosts using FIO and NVMeoF with and 
without DIM on each side separately and together. I am attaching the 
results of the tests. The main point I would like to make is that when 
used on both sides especially we see improvements across the board in 
both IOPS and latency.

>
>> Performance improvement (ConnectX-5 100GbE, x86) running FIO 
>> benchmark over
>> ? ??? NVMf between two equal end-hosts with 56 cores across a 
>> Mellanox switch
>> ? ??? using null_blk device:
>>
>> ? ??? IO READS before:
>> ? ??? blk size | BW????? | IOPS | 99th percentile latency
>> ? ??? 512B???? | 3.2GiB? | 6.6M | 1549? usec
>> ? ??? 4k?????? | 7.2GiB? | 1.8M | 7177? usec
>> ? ??? 64k????? | 10.7GiB | 176k | 82314 usec
>
> I've seen this before, why are we not getting 100Gb/s for 4k with CX5?
> I recall we used to get it with CX4.

It depends on the host server and whether or not it causes backpressure 
on the PCI because of the amount of interrupts.

>
>> ? ??? IO READS after:
>> ? ??? blk size | BW????? | IOPS | 99th percentile latency
>> ? ??? 512B???? | 4.2GiB? | 8.6M | 1729?? usec
>> ? ??? 4k?????? | 10.5GiB | 2.7M | 5669?? usec
>> ? ??? 64k????? | 10.7GiB | 176k | 102000 usec
>>
>> ? ??? IO WRITES before:
>> ? ??? blk size | BW????? | IOPS | 99th percentile latency
>> ? ??? 512B???? | 3GiB??? | 6.2M | 2573? usec
>> ? ??? 4k?????? | 7.2GiB? | 1.8M | 5342? usec
>> ? ??? 64k????? | 10.7GiB | 176k | 62129 usec
>>
>> ? ??? IO WRITES after:
>> ? ??? blk size | BW????? | IOPS? | 99th percentile latency
>> ? ??? 512B???? | 4.2GiB? | 8.6M? | 938?? usec
>> ? ??? 4k?????? | 10.2GiB | 2.68M | 2769? usec
>> ? ??? 64k????? | 10.6GiB | 173k? | 87557 usec
>
> The fact that the 64k 99% latency is substantially higher (20+
> milliseconds) without any BW benefit, while its not a very interesting
> measurement, gives me an indication that a more detailed analysis needs
> to be made here to understand where are the trade-offs.
>
>> It doesn't really make a difference to me how the option is implemented
>> but I think it makes more sense to have it dealt with by us such as in a
>> module parameter and not something like a flag that has a larger radius
>> of effect.
>
> I was suggesting a sysctl global parameter for global behavior and of
> someone wants to override it it can add a CQ flag (which follows the
> common net params exactly).
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: comp_DIM_to_no_DIM.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190321/11839723/attachment-0003.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: comp_initiator_DIM_to_no_DIM.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190321/11839723/attachment-0004.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: comp_target_DIM_to_no_DIM.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190321/11839723/attachment-0005.txt>
