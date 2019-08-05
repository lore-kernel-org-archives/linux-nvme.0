From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 05 Aug 2019 16:49:23 +1000
Subject: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
In-Reply-To: <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190730153044.GA13948@localhost.localdomain>
 <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
Message-ID: <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>

On Tue, 2019-07-30@13:28 -0700, Benjamin Herrenschmidt wrote:
> > One problem is that we've an nvme parameter, io_queue_depth, that a user
> > could set to something less than 32, and then you won't be able to do
> > any IO. I'd recommend enforce the admin queue to QD1 for this device so
> > that you have more potential IO tags.
> 
> So I had a look and it's not that trivial. I would have to change
> a few things that use constants for the admin queue depth, such as
> the AEN tag etc...
> 
> For such a special case, I am tempted instead to do the much simpler:
> 
>         if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS) {
>                 if (dev->q_depth < (NVME_AQ_DEPTH + 2))
>                         dev->q_depth = NVME_AQ_DEPTH + 2;
>         }
> 
> In nvme_pci_enable() next to the existing q_depth hackery for other
> controllers.
> 
> Thoughts ?

Ping ? I had another look today and I don't feel like mucking around
with all the AQ size logic, AEN magic tag etc... just for that sake of
that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
to make much of a difference in practice anyway.

But if you feel strongly about it, then I'll implement the "proper" way
sometimes this week, adding a way to shrink the AQ down to something
like 3 (one admin request, one async event (AEN), and the empty slot)
by making a bunch of the constants involved variables instead.

This leas to a question: Wouldn't be be nicer/cleaner to make AEN be
tag 0 of the AQ ? That way we just include it as reserved tag ? Not a
huge different from what we do now, just a thought.

Cheers,
Ben.
