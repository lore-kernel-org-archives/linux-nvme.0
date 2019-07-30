From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 30 Jul 2019 13:28:57 -0700
Subject: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
In-Reply-To: <20190730153044.GA13948@localhost.localdomain>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190730153044.GA13948@localhost.localdomain>
Message-ID: <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>

On Tue, 2019-07-30@09:30 -0600, Keith Busch wrote:
> On Fri, Jul 19, 2019@03:31:02PM +1000, Benjamin Herrenschmidt wrote:
> > From 8dcba2ef5b1466b023b88b4eca463b30de78d9eb Mon Sep 17 00:00:00 2001
> > From: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> > Date: Fri, 19 Jul 2019 15:03:06 +1000
> > Subject: 
> > 
> > Another issue with the Apple T2 based 2018 controllers seem to be
> > that they blow up (and shut the machine down) if there's a tag
> > collision between the IO queue and the Admin queue.
> > 
> > My suspicion is that they use our tags for their internal tracking
> > and don't mix them with the queue id. They also seem to not like
> > when tags go beyond the IO queue depth, ie 128 tags.
> > 
> > This adds a quirk that marks tags 0..31 of the IO queue reserved
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> > ---
> 
> One problem is that we've an nvme parameter, io_queue_depth, that a user
> could set to something less than 32, and then you won't be able to do
> any IO. I'd recommend enforce the admin queue to QD1 for this device so
> that you have more potential IO tags.

So I had a look and it's not that trivial. I would have to change
a few things that use constants for the admin queue depth, such as
the AEN tag etc...

For such a special case, I am tempted instead to do the much simpler:

	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) {
		if (dev->q_depth < (NVME_AQ_DEPTH + 2))
			dev->q_depth = NVME_AQ_DEPTH + 2;
	}

In nvme_pci_enable() next to the existing q_depth hackery for other
controllers.

Thoughts ?

Cheers,
Ben.
