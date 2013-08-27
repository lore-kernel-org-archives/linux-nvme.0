From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Aug 2013 16:35:29 -0600 (MDT)
Subject: A question regarding to MSIX interrupts for NVME
In-Reply-To: <CAOu78O0eW5E2kE+_D87obRz3c-qM=DABdy84S4JtY6ETTYScHQ@mail.gmail.com>
References: <CAOu78O0uf0XarS8=RwfwzZ1zy93gxKNk5uK64+4nzWzBvze4_g@mail.gmail.com>
 <alpine.LRH.2.03.1308271512000.1857@AMR>
 <CAOu78O0eW5E2kE+_D87obRz3c-qM=DABdy84S4JtY6ETTYScHQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1308271616480.1857@AMR>

On Tue, 27 Aug 2013, Xuehua Chen wrote:
>> The admin queue does not get the kind of activity an IO queue does,
>> so sharing the interrupt with an IO queue seems like a good way to
>> reduce resource requirements without a performance loss. You can also
>> find yourself in a situation where you have no choice but to share the
>> interrupt vector.
>
> Let's say there are a bunch of cq entries posted to IOCQ1, quickly followed a
> new admin cq entry, will the admin cq entry be processed right away or wait
> until the some existing iocqs are processed? I do not have concern with
> io performance here, just the response of admin command. Since admin
> queue does not support coalescing, I assume it needs to be processed asap.
> I think iocq sharing interrupts is fine. Just think admin cq better not share
> interrupt with any IOCQs. An alternative could be using a separate vector for
> admin queue with affinity hint to all cpus online for example.

I hadn't thought much about it, but I always assumed coalescing isn't an
option for the admin command because you wouldn't expect a workload on
there that even comes close to realizing the benefits of coalescing.

If the device raises an interrupt for completions on the IOQ or Admin
Queue (or both), the driver's interrupt routine will be called twice:
once for each queue. The interrupt service routine will process all the
completed requests for the first queue it is called with, then it will
do so for the other queue. Are you saying that draining the completions
from the IO queue takes an unexceptable amount of time if there is a
completion on the admin queue? That doesn't seem likely.
