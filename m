From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 2 Feb 2018 10:02:36 +0800
Subject: [LSF/MM TOPIC] irq affinity handling for high CPU count machines
In-Reply-To: <a6bf37e1aa2c45ef725c4cc1a7f57af9@mail.gmail.com>
References: <45dc032d-a0ce-816c-d2c5-74c69433bd29@suse.de>
 <20180201150532.GA31930@ming.t460p>
 <0f650f4b-aa7f-bf52-2ecb-582761b4937f@suse.de>
 <a6bf37e1aa2c45ef725c4cc1a7f57af9@mail.gmail.com>
Message-ID: <20180202020235.GE19173@ming.t460p>

Hello Kashyap,

On Thu, Feb 01, 2018@10:29:22PM +0530, Kashyap Desai wrote:
> > -----Original Message-----
> > From: Hannes Reinecke [mailto:hare at suse.de]
> > Sent: Thursday, February 1, 2018 9:50 PM
> > To: Ming Lei
> > Cc: lsf-pc at lists.linux-foundation.org; linux-scsi at vger.kernel.org; linux-
> > nvme at lists.infradead.org; Kashyap Desai
> > Subject: Re: [LSF/MM TOPIC] irq affinity handling for high CPU count
> > machines
> >
> > On 02/01/2018 04:05 PM, Ming Lei wrote:
> > > Hello Hannes,
> > >
> > > On Mon, Jan 29, 2018@10:08:43AM +0100, Hannes Reinecke wrote:
> > >> Hi all,
> > >>
> > >> here's a topic which came up on the SCSI ML (cf thread '[RFC 0/2]
> > >> mpt3sas/megaraid_sas: irq poll and load balancing of reply queue').
> > >>
> > >> When doing I/O tests on a machine with more CPUs than MSIx vectors
> > >> provided by the HBA we can easily setup a scenario where one CPU is
> > >> submitting I/O and the other one is completing I/O. Which will result
> > >> in the latter CPU being stuck in the interrupt completion routine for
> > >> basically ever, resulting in the lockup detector kicking in.
> > >
> > > Today I am looking at one megaraid_sas related issue, and found
> > > pci_alloc_irq_vectors(PCI_IRQ_AFFINITY) is used in the driver, so
> > > looks each reply queue has been handled by more than one CPU if there
> > > are more CPUs than MSIx vectors in the system, which is done by
> > > generic irq affinity code, please see kernel/irq/affinity.c.
> 
> Yes. That is a problematic area. If CPU and MSI-x(reply queue) is 1:1
> mapped, we don't have any issue.

I guess the problematic area is similar with the following link:

	https://marc.info/?l=linux-kernel&m=151748144730409&w=2

otherwise could you explain a bit about the area?

> 
> > >
> > > Also IMO each reply queue may be treated as blk-mq's hw queue, then
> > > megaraid may benefit from blk-mq's MQ framework, but one annoying
> > > thing is that both legacy and blk-mq path need to be handled inside
> > > driver.
> 
> Both MR and IT driver is (due to H/W design.) is using blk-mq frame work but
> it is really  a single h/w queue.
> IT and MR HBA has single submission queue and multiple reply queue.

It should have been covered by MQ, but just we need to share tags among
hctxs, like what Hannes posted long time ago.

> 
> > >
> > The megaraid driver is a really strange beast;, having layered two
> > different
> > interfaces (the 'legacy' MFI interface and that from from
> > mpt3sas) on top of each other.
> > I had been thinking of converting it to scsi-mq, too (as my mpt3sas patch
> > finally went in), but I'm not sure if we can benefit from it as we're
> > still be
> > bound by the HBA-wide tag pool.
> > It's on my todo list, albeit pretty far down :-)
> 
> Hannes, this is typically same in both MR (megaraid_sas) and IT (mpt3sas).
> Both the driver is using shared HBA-wide tag pool.
> Both MR and IT driver use request->tag to get command from free pool.

Seems a generic thing, same with HPSA too.


Thanks,
Ming
