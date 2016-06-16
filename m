From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Thu, 16 Jun 2016 17:39:07 +0200
Subject: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
In-Reply-To: <20160616152006.GA13615@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160616152006.GA13615@lst.de>
Message-ID: <f22e87c1-6875-9a59-94db-42a6f71663b8@sandisk.com>

On 06/16/2016 05:20 PM, Christoph Hellwig wrote:
> On Wed, Jun 15, 2016@09:36:54PM +0200, Bart Van Assche wrote:
>> Do you agree that - ignoring other interrupt assignments - that the latter
>> interrupt assignment scheme would result in higher throughput and lower
>> interrupt processing latency?
>
> Probably.  Once we've got it in the core IRQ code we can tweak the
> algorithm to be optimal.

Sorry but I'm afraid that we are embedding policy in the kernel, 
something we should not do. I know that there are workloads for which 
dedicating some CPU cores to interrupt processing and other CPU cores to 
running kernel threads improves throughput, probably because this 
results in less cache eviction on the CPU cores that run kernel threads 
and some degree of interrupt coalescing on the CPU cores that process 
interrupts. My concern is that I doubt that there is an interrupt 
assignment scheme that works optimally for all workloads. Hence my 
request to preserve the ability to modify interrupt affinity from user 
space.

Bart.
