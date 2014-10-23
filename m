From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 23 Oct 2014 12:53:39 -0400
Subject: Questions on Interruption handling
In-Reply-To: <CAMjVwgThWfs4M0pQy0QpfNONV_hv4rLQGXOPvh-OC9xkyvrHPA@mail.gmail.com>
References: <CAMjVwgThWfs4M0pQy0QpfNONV_hv4rLQGXOPvh-OC9xkyvrHPA@mail.gmail.com>
Message-ID: <20141023165339.GR11522@wil.cx>

On Wed, Oct 22, 2014@02:43:44PM -0300, Angelo Brito wrote:
> I had some issues with the Interruption handling. The scenario is as follows:
> We have a NVMe Device with single MSI enabled and some of its
> transfers took about 1000 jiffies (ms) to execute. We saw this when we
> used IOMeter to benchmark a NVMe controller and we noticed that about
> 1 in 10 commands took much longer than expected. When we traced
> through the kernel code we tracked the issue to come from the nvme_irq
> function. In most cases, it is triggered by the interrupts and all
> CQEs in the queue are processed correctly. In some cases, though, we
> found out that a new CQE arrived while the nvme_irq function was
> processing previous entries or just after the CQ doorbell has been
> sent. These entries were overlooked by the driver and picked up later
> by the nvme_kthread function, which reexecutes the nvme_process_cq
> function once every second.

This ought not be possible.  This is how things are supposed to work:

A. Device writes to CQ
B. Device sends MSI

1. Host receives interrupt
2. Host checks CQ

Now, I'm assuming that you have a flood of interrupts coming in because
you have a high IOPS workload and haven't configured interrupt mitigation.
The soft interrupt mitigation in handle_edge_irq() should be kicking in
and preventing the driver from being overwhelmed:

        if (unlikely(irqd_irq_disabled(&desc->irq_data) ||
                     irqd_irq_inprogress(&desc->irq_data) || !desc->action)) {
                if (!irq_check_poll(desc)) {
                        desc->istate |= IRQS_PENDING;
                        mask_ack_irq(desc);
                        goto out_unlock;
                }
        }
...
        do {
...
                if (unlikely(desc->istate & IRQS_PENDING)) {
                        if (!irqd_irq_disabled(&desc->irq_data) &&
                            irqd_irq_masked(&desc->irq_data))
                                unmask_irq(desc);
                }

                handle_irq_event(desc);

        } while ((desc->istate & IRQS_PENDING) &&
                 !irqd_irq_disabled(&desc->irq_data));

handle_irq_event() ends up calling the nvme_irq() handler.

Notice that we never tell the *device* to stop sending interrupts.
We'll mask this interrupt on the CPU, but we'll always unmask it before
calling the interrupt handler again.  That guarantees that if an interrupt
arrives during handling of the previous interrupt, we'll call the handler
at least once more.

So, absolutely, a CQE can arive *just* after nvme_process_cq() loads
the cqe.  But if it does, there should be an interrupt shortly afterwards
that triggers nvme_irq() to be called again.  Are you sure your device
is sending an interrupt after it sends the CQE whose processing is
being delayed?
