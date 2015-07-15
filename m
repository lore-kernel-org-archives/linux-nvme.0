From: mst@redhat.com (Michael S. Tsirkin)
Date: Wed, 15 Jul 2015 19:05:41 +0300
Subject: [Ksummit-discuss] [TECH TOPIC] IRQ affinity
In-Reply-To: <20150715120708.GA24534@infradead.org>
References: <20150715120708.GA24534@infradead.org>
Message-ID: <20150715160540.GA757@redhat.com>

On Wed, Jul 15, 2015@05:07:08AM -0700, Christoph Hellwig wrote:
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

I think you are right, it's true for networking.

Whenever someone tries to benchmark networking, first thing done is
always disabling irqbalance and pinning IRQs manually away from
whereever the benchmark is running, but at the same numa node.

Without that, interrupts don't let the benchmark make progress.

Alternatively, people give up on interrupts completely and
start polling hardware aggressively. Nice for a benchmark,
not nice for the environment.

> 
> I'd like to discuss if the rationale for moving the IRQ affinity setting
> fully to userspace are still correct in todays world any any pitfalls
> we'll have to learn from in irqbalanced and the old in-kernel affinity
> code.

IMHO there could be a benefit from a better integration with the scheduler.
Maybe an interrupt handler can be viewed as a kind of thread,
so scheduler can make decisions about where to run it next?

> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss at lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
