From: xuehua@gmail.com (Xuehua Chen)
Date: Wed, 28 Aug 2013 09:58:35 -0700
Subject: A question regarding to MSIX interrupts for NVME
In-Reply-To: <CAOu78O3RxF3XDN5Wm0-AAwKLeESVzVxZdrXMnm6CnaCGrFTmLg@mail.gmail.com>
References: <CAOu78O0uf0XarS8=RwfwzZ1zy93gxKNk5uK64+4nzWzBvze4_g@mail.gmail.com>
 <alpine.LRH.2.03.1308271512000.1857@AMR>
 <CAOu78O0eW5E2kE+_D87obRz3c-qM=DABdy84S4JtY6ETTYScHQ@mail.gmail.com>
 <alpine.LRH.2.03.1308271616480.1857@AMR>
 <CAOu78O3RxF3XDN5Wm0-AAwKLeESVzVxZdrXMnm6CnaCGrFTmLg@mail.gmail.com>
Message-ID: <CAOu78O0dPM-7b8RVFPb2X1pddtb4s_kVUNHL_faOdx1PRQ0gkw@mail.gmail.com>

Hi, All,

Previous thoughts on short response and timing is just guess and may
not be solid. Here are some thoughts on how device and driver could
fit for the spec well.

"By default, coalescing settings are enabled for each interrupt
vector. Interrupt coalescing is not supported for the Admin Completion
Queue."

Approach 1:
1. Device enables coalescing settings each interrupt vector by default at reset.
2. When configuring admin queue, device disabled coalescing for the
vector 0 which is assigned to ACQs.
3. Assigning other vectors to IOCQs. Interrupt vector can be shared
between IOCQs.

Aproach 2.
1. Device enables coalescing settings for each interrupt vector by
default at reset.
2. When configuring admin queue, device disabled coalescing for the
vector 0 which is assigned to ACQs.
3. IOCQs can share interrupt with ACQ. But when user try to enable
coalescing for the vector associated with ACQ,
    return error.

Approach 3
1. Device enables coalescing settings for each interrupt vector by
default at reset and also for vector 0, no interrupt coalescing for
ACQ.
2. IOCQs can share interrupt with ACQ. And user can enable coalescing
for the vector associated with ACQ.

It seems approach 3 can be most flexible. But it comes with a couple
of questions.
1. It is wired that when we say the interrupt coalescing is enabled
for vector 0 while in the mean time ACQ use the vector and interrupt
coalescing is disabled for it. Is this what the spec really wanted?
2. HW implementation is more complex and will this approach really
have much advantage than approach 1?

If approach 3 is not the spec actually means, then which one is
better, approach 1 or approach 2. It seems that this is a trade-off
between one extra interrupt vector and the capability of enabling
interrupt coalescing for some IOCQs. Will approach 1 cause noticeable
performance loss?  One extra interrupt is too much?

Thanks a lot!

Best regards,

Xuehua


On Tue, Aug 27, 2013@6:04 PM, Xuehua Chen <xuehua@gmail.com> wrote:
> On Tue, Aug 27, 2013@3:35 PM, Keith Busch <keith.busch@intel.com> wrote:
>> On Tue, 27 Aug 2013, Xuehua Chen wrote:
>>>>
>>>> The admin queue does not get the kind of activity an IO queue does,
>>>> so sharing the interrupt with an IO queue seems like a good way to
>>>> reduce resource requirements without a performance loss. You can also
>>>> find yourself in a situation where you have no choice but to share the
>>>> interrupt vector.
>>>
>>>
>>> Let's say there are a bunch of cq entries posted to IOCQ1, quickly
>>> followed a
>>> new admin cq entry, will the admin cq entry be processed right away or
>>> wait
>>> until the some existing iocqs are processed? I do not have concern with
>>> io performance here, just the response of admin command. Since admin
>>> queue does not support coalescing, I assume it needs to be processed asap.
>>> I think iocq sharing interrupts is fine. Just think admin cq better not
>>> share
>>> interrupt with any IOCQs. An alternative could be using a separate vector
>>> for
>>> admin queue with affinity hint to all cpus online for example.
>>
>>
>> I hadn't thought much about it, but I always assumed coalescing isn't an
>> option for the admin command because you wouldn't expect a workload on
>> there that even comes close to realizing the benefits of coalescing.
>>
>> If the device raises an interrupt for completions on the IOQ or Admin
>> Queue (or both), the driver's interrupt routine will be called twice:
>> once for each queue. The interrupt service routine will process all the
>> completed requests for the first queue it is called with, then it will
>> do so for the other queue. Are you saying that draining the completions
>> from the IO queue takes an unexceptable amount of time if there is a
>> completion on the admin queue? That doesn't seem likely.
>>
>
> If it is not for quick response time, I don't understand why the spec
> specifically mention that
> "interrupt coalescing is not supported for the admin completion
> queue". Because I don't see
> that enabling interrupt coalescing for ACQ will cause problem most of
> the time as well. Please
> correct me if this is not right. And if yes, then the spec just made
> hw implementation more
> complicated. HW need to implement differently for this vector than for
> any other vector shared by
> pure IOCQs. So I tend to think this statement could be for the
> consideration of short response
> time.
>
> I don't have any timing data here. But NVME spec can support IOCQ with
> 2**16 entries,
> maybe very intensive IO could cause some non-negligible delay for
> admin commands on some
> fast platforms? Also for weighted round robin with urgent priority
> class arbitration, ASQ has highest
> priority than all other SQs. This also seems to me that occasionally
> AQ need very short response
> time.
>
> Thanks,
>
> Best regards,
>
> Xuehua
