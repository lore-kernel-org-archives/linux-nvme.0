From: kashyap.desai@broadcom.com (Kashyap Desai)
Date: Mon, 29 Jan 2018 22:12:09 +0530
Subject: [LSF/MM TOPIC] irq affinity handling for high CPU count machines
In-Reply-To: <64c1849c-908f-3576-506b-d5714f06c263@wdc.com>
References: <45dc032d-a0ce-816c-d2c5-74c69433bd29@suse.de>
 <AT5PR8401MB0387022075AF24A278FA522EABE50@AT5PR8401MB0387.NAMPRD84.PROD.OUTLOOK.COM>
 <64c1849c-908f-3576-506b-d5714f06c263@wdc.com>
Message-ID: <634c8002772da76e493890b6e4ec6242@mail.gmail.com>

> -----Original Message-----
> From: Bart Van Assche [mailto:bart.vanassche at wdc.com]
> Sent: Monday, January 29, 2018 10:08 PM
> To: Elliott, Robert (Persistent Memory); Hannes Reinecke;
> lsf-pc at lists.linux-
> foundation.org
> Cc: linux-scsi at vger.kernel.org; linux-nvme at lists.infradead.org; Kashyap
> Desai
> Subject: Re: [LSF/MM TOPIC] irq affinity handling for high CPU count
> machines
>
> On 01/29/18 07:41, Elliott, Robert (Persistent Memory) wrote:
> >> -----Original Message-----
> >> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> >> Behalf Of Hannes Reinecke
> >> Sent: Monday, January 29, 2018 3:09 AM
> >> To: lsf-pc at lists.linux-foundation.org
> >> Cc: linux-nvme at lists.infradead.org; linux-scsi at vger.kernel.org;
> >> Kashyap Desai <kashyap.desai at broadcom.com>
> >> Subject: [LSF/MM TOPIC] irq affinity handling for high CPU count
> >> machines
> >>
> >> Hi all,
> >>
> >> here's a topic which came up on the SCSI ML (cf thread '[RFC 0/2]
> >> mpt3sas/megaraid_sas: irq poll and load balancing of reply queue').
> >>
> >> When doing I/O tests on a machine with more CPUs than MSIx vectors
> >> provided by the HBA we can easily setup a scenario where one CPU is
> >> submitting I/O and the other one is completing I/O. Which will result
> >> in the latter CPU being stuck in the interrupt completion routine for
> >> basically ever, resulting in the lockup detector kicking in.
> >>
> >> How should these situations be handled?
> >> Should it be made the responsibility of the drivers, ensuring that
> >> the interrupt completion routine is terminated after a certain time?
> >> Should it be made the responsibility of the upper layers?
> >> Should it be the responsibility of the interrupt mapping code?
> >> Can/should interrupt polling be used in these situations?
> >
> > Back when we introduced scsi-mq with hpsa, the best approach was to
> > route interrupts and completion handling so each CPU core handles its
> > own submissions; this way, they are self-throttling.


Ideal scenario is to make sure submitter is interrupted for completion.  It
is not possible to manage via any tuning like rq_affinity=2 (and --exact
irqbalance policy), if we have more # of CPUs than MSI-x vector supported by
controllers. If we use irq poll interface with good amount of weights in irq
poll API, we will no more see CPU lockups because low level driver will quit
ISR routine after each weighted completion. There will be always chance that
we will have back to back pressure on the same CPU for completion, but irq
poll design will manage to run watchdog task and timestamp will updated.
Using irq poll we may see close to 100% CPU consumption, but there will be
no  lockup detection.

>
> That approach may work for the hpsa adapter but I'm not sure whether it
> works for all adapter types. It has already been observed with the SRP
> initiator
> driver running inside a VM that a single core spent all its time
> processing IB
> interrupts.
>
> Additionally, only initiator workloads are self-throttling. Target style
> workloads are not self-throttling.
>
> In other words, I think it's worth to discuss this topic further.
>
> Bart.
>
