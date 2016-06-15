From: hch@lst.de (Christoph Hellwig)
Date: Wed, 15 Jun 2016 12:23:11 +0200
Subject: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
In-Reply-To: <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
Message-ID: <20160615102311.GA16619@lst.de>

Hi Bart,

On Wed, Jun 15, 2016@10:44:37AM +0200, Bart Van Assche wrote:
> However, is excluding these interrupts from irqbalanced really the 
> way to go?

What positive effect will irqbalanced have on explcititly spread
interrupts?

> Suppose e.g. that a system is equipped with two RDMA adapters, 
> that these adapters are used by a blk-mq enabled block initiator driver and 
> that each adapter supports eight MSI-X vectors. Should the interrupts of 
> the two RDMA adapters be assigned to different CPU cores? If so, which 
> software layer should realize this? The kernel or user space?

RDMA should eventually use the interrupt spreading implemented in this
series, as should networking (RDMA actually is on my near term todo list).

RDMA block protocols will then pick up the queue information from the
HCA driver.  I've not actually implemented this yet, but my current idea
is:

 - the HCA drivers are switch to use pci_alloc_irq_vectors to spread
   their interrupt vectors around the system
 - the HCA drivers will expose the irq_affinity affinity array
   in struct ib_device (we'll need to consider what do about the
   odd completion vectors instead of irq terminology in the RDMA stack,
   but that's not a show stopper)
 - multiqueue aware block drivers will then feed the irq_affinity
   cpumask from the hca driver to blk-mq.  We'll also need to ensure
   the number of protocol queues aligns nicely to the number of hardware
   queues.  My current thinking is that they should be the same or
   a fraction of the hardware completion queues, but this might need
   some careful benchmarking.
