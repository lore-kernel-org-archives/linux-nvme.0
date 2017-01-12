From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 12 Jan 2017 19:13:17 +0000
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <ccb6cf4d-4810-47b2-015a-0202d784280a@grimberg.me>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com>
 <ccb6cf4d-4810-47b2-015a-0202d784280a@grimberg.me>
Message-ID: <1484248382.2720.9.camel@sandisk.com>

On Thu, 2017-01-12@10:41 +0200, Sagi Grimberg wrote:
> First, when the nvme device fires an interrupt, the driver consumes
> the completion(s) from the interrupt (usually there will be some more
> completions waiting in the cq by the time the host start processing it).
> With irq-poll, we disable further interrupts and schedule soft-irq for
> processing, which if at all, improve the completions per interrupt
> utilization (because it takes slightly longer before processing the cq).
> 
> Moreover, irq-poll is budgeting the completion queue processing which is
> important for a couple of reasons.
> 
> 1. it prevents hard-irq context abuse like we do today. if other cpu
>     cores are pounding with more submissions on the same queue, we might
>     get into a hard-lockup (which I've seen happening).
> 
> 2. irq-poll maintains fairness between devices by correctly budgeting
>     the processing of different completions queues that share the same
>     affinity. This can become crucial when working with multiple nvme
>     devices, each has multiple io queues that share the same IRQ
>     assignment.
> 
> 3. It reduces (or at least should reduce) the overall number of
>     interrupts in the system because we only enable interrupts again
>     when the completion queue is completely processed.
> 
> So overall, I think it's very useful for nvme and other modern HBAs,
> but unfortunately, other than solving (1), I wasn't able to see
> performance improvement but rather a slight regression, but I can't
> explain where its coming from...

Hello Sagi,

Thank you for the additional clarification. Although I am not sure whether
irq-poll is the ideal solution for the problems that has been described
above, I agree that it would help to discuss this topic further during
LSF/MM.

Bart.
