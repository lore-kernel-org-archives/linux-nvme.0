From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Jul 2015 15:56:30 +0100
Subject: [Ksummit-discuss] [TECH TOPIC] IRQ affinity
In-Reply-To: <20150715120708.GA24534@infradead.org>
References: <20150715120708.GA24534@infradead.org>
Message-ID: <55A6749E.7040803@arm.com>

On 15/07/15 13:07, Christoph Hellwig wrote:
> Many years ago we decided to move setting of IRQ to core affnities to
> userspace with the irqbalance daemon.
> 
> These days we have systems with lots of MSI-X vector, and we have
> hardware and subsystem support for per-CPU I/O queues in the block
> layer, the RDMA subsystem and probably the network stack (I'm not too
> familar with the recent developments there).  It would really help the
> out of the box performance and experience if we could allow such
> subsystems to bind interrupt vectors to the node that the queue is
> configured on.
> 
> I'd like to discuss if the rationale for moving the IRQ affinity setting
> fully to userspace are still correct in todays world any any pitfalls
> we'll have to learn from in irqbalanced and the old in-kernel affinity
> code.

I've been pondering about having some notion of "grouping", where some
interrupts are logically part of the same working set, and it doesn't
make much sense to spread it among CPUs, and userspace doesn't really
have a clue about this.

A related problem is that some weird HW (things like cascaded interrupt
controllers) can only move a bunch of interrupt in one go, which isn't
really what userspace expects to see (move one interrupt, see another 31
moving).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
