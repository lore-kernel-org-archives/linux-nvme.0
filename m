From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 15 Jul 2015 05:07:08 -0700
Subject: [TECH TOPIC] IRQ affinity
Message-ID: <20150715120708.GA24534@infradead.org>

Many years ago we decided to move setting of IRQ to core affnities to
userspace with the irqbalance daemon.

These days we have systems with lots of MSI-X vector, and we have
hardware and subsystem support for per-CPU I/O queues in the block
layer, the RDMA subsystem and probably the network stack (I'm not too
familar with the recent developments there).  It would really help the
out of the box performance and experience if we could allow such
subsystems to bind interrupt vectors to the node that the queue is
configured on.

I'd like to discuss if the rationale for moving the IRQ affinity setting
fully to userspace are still correct in todays world any any pitfalls
we'll have to learn from in irqbalanced and the old in-kernel affinity
code.
