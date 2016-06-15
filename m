From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 15 Jun 2016 10:44:37 +0200
Subject: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
In-Reply-To: <1465934346-20648-3-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
Message-ID: <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>

On 06/14/2016 09:58 PM, Christoph Hellwig wrote:
> From: Thomas Gleixner <tglx at linutronix.de>
>
> Interupts marked with this flag are excluded from user space interrupt
> affinity changes. Contrary to the IRQ_NO_BALANCING flag, the kernel internal
> affinity mechanism is not blocked.
>
> This flag will be used for multi-queue device interrupts.

It's great to see that the goal of this patch series is to configure 
interrupt affinity automatically for adapters that support multiple 
MSI-X vectors. However, is excluding these interrupts from irqbalanced 
really the way to go? Suppose e.g. that a system is equipped with two 
RDMA adapters, that these adapters are used by a blk-mq enabled block 
initiator driver and that each adapter supports eight MSI-X vectors. 
Should the interrupts of the two RDMA adapters be assigned to different 
CPU cores? If so, which software layer should realize this? The kernel 
or user space?

Sorry that I missed the first version of this patch series.

Thanks,

Bart.
