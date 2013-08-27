From: xuehua@gmail.com (Xuehua Chen)
Date: Tue, 27 Aug 2013 15:13:41 -0700
Subject: A question regarding to MSIX interrupts for NVME
In-Reply-To: <alpine.LRH.2.03.1308271512000.1857@AMR>
References: <CAOu78O0uf0XarS8=RwfwzZ1zy93gxKNk5uK64+4nzWzBvze4_g@mail.gmail.com>
 <alpine.LRH.2.03.1308271512000.1857@AMR>
Message-ID: <CAOu78O0eW5E2kE+_D87obRz3c-qM=DABdy84S4JtY6ETTYScHQ@mail.gmail.com>

Hi, Keith,

Thank you very much for your response.

On Tue, Aug 27, 2013@2:31 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, 27 Aug 2013, Xuehua Chen wrote:
>>
>> It seems to me that admin queue is sharing vector 0 with IOCQ 1 now.
>> Is there any good reason
>> that admin queue should not have its own vector? It seems to me this
>> could makes interrupt
>> coalescing of nvme a bit strange due to the following reason.
>>
>> In NVMe 1.1 spec, 5.12.1.9 Interrupt Vector Configuration, it is mentioned
>> that
>>
>> ?By default, coalescing settings are enabled for each interrupt
>> vector. Interrupt coalescing is not supported for
>> the Admin Completion Queue.?
>>
>> If a user want to enable coalescing for IOCQ 1, this will enable the
>> coalescing for admin queue
>> well since the interrupt vector are shared and violate the spec. So
>> this somehow makes IOCQ 1
>> different from other IOCQs.
>
>
> If your device enables coalescing on the admin queue when the host
> enables it for IOQ 1's interrupt vector, I think your device violates
> the spec rather than the host.

This seems to makes hw kind of harder to implement. This is part of the reason
why I ask the question here:) We have a vector sometimes coalescing and
sometimes not, which seems a bit strange. I am not sure I understand the spec
well enough. If will be good that the spec is a bit more elaborated on
this special
corner case.

>
>
>> Also does the spec don?t s support interrupt for ACQ because it want
>> ACQ be processed as soon
>> as possible? In the current implementation, admin queue commands could
>> be delayed when there
>> are lots of entries in IOCQ1 being processed. Maybe a separate vector
>> for admin queue could be
>> better for such a situation?
>
>
> The admin queue does not get the kind of activity an IO queue does,
> so sharing the interrupt with an IO queue seems like a good way to
> reduce resource requirements without a performance loss. You can also
> find yourself in a situation where you have no choice but to share the
> interrupt vector.

Let's say there are a bunch of cq entries posted to IOCQ1, quickly followed a
new admin cq entry, will the admin cq entry be processed right away or wait
until the some existing iocqs are processed? I do not have concern with
io performance here, just the response of admin command. Since admin
queue does not support coalescing, I assume it needs to be processed asap.
I think iocq sharing interrupts is fine. Just think admin cq better not share
interrupt with any IOCQs. An alternative could be using a separate vector for
admin queue with affinity hint to all cpus online for example.

Thanks a lot!

Best regards,

Xuehua
