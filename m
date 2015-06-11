From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Jun 2015 00:38:26 -0700
Subject: [PATCHv2] NVMe: Stripe queue IRQ vector assignments
In-Reply-To: <alpine.LNX.2.00.1506110020180.15930@localhost.lm.intel.com>
References: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>
 <20150610190812.GA6200@infradead.org>
 <alpine.LNX.2.00.1506110020180.15930@localhost.lm.intel.com>
Message-ID: <20150611073826.GA27065@infradead.org>

On Thu, Jun 11, 2015@12:22:27AM +0000, Keith Busch wrote:
> On Wed, 10 Jun 2015, Christoph Hellwig wrote:
> >On Wed, Jun 10, 2015@10:41:30AM -0600, Jon Derrick wrote:
> >>a) There is a known issue in one controller where irq coalescing cannot
> >>occur on vectors to which the admin queue is assigned. This patch assigns
> >>the admin queue its own vector, as long as there are enough vectors
> >>available to assign one to each io queue and the admin queue.
> >
> >I think this should be a quirk for that particular PCI ID, and needs
> >a comment int the code explaining the reason.
> 
> Let's just remove this from the commit message. The real win is the second
> part, which we know to be a worthwhile gain in senarios where h/w queues
> and cpus exceed available irq's. This other coalescing benefit is a nice
> bonus, but not necessary to consider for this commit.

Sorry if I wasn't clear - I meant the fact that we avoid the vectors
that have the admin queue assigned for I?O queue vectors.  While it's
fine to use separate vectors if we have enough I'd rather share an I/O
queue with the admin queue than with another I/O queue if that's not the
case.

The limitation seems odd enough and specific to a piece of silicone that
I think we really need a comment and even better a quirk to document it.
