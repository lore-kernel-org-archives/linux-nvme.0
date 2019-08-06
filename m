From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 06 Aug 2019 15:26:03 +1000
Subject: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
In-Reply-To: <40a6acc2-beae-3e36-ca20-af5801038a1e@grimberg.me>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190730153044.GA13948@localhost.localdomain>
 <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
 <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
 <20190805134907.GC18647@localhost.localdomain>
 <40a6acc2-beae-3e36-ca20-af5801038a1e@grimberg.me>
Message-ID: <590ea33755f29ffd8549a4681b9ad9f041fc506a.camel@kernel.crashing.org>

On Mon, 2019-08-05@11:27 -0700, Sagi Grimberg wrote:
> > > Ping ? I had another look today and I don't feel like mucking
> > > around
> > > with all the AQ size logic, AEN magic tag etc... just for that
> > > sake of
> > > that Apple gunk. I'm happy to have it give up IO tags, it doesn't
> > > seem
> > > to make much of a difference in practice anyway.
> > > 
> > > But if you feel strongly about it, then I'll implement the
> > > "proper" way
> > > sometimes this week, adding a way to shrink the AQ down to
> > > something
> > > like 3 (one admin request, one async event (AEN), and the empty
> > > slot)
> > > by making a bunch of the constants involved variables instead.
> > 
> > I don't feel too strongly about it. I think your patch is fine, so
> > 
> > Acked-by: Keith Busch <keith.busch at intel.com>
> 
> Should we pick this up for 5.3-rc?

Well, if you are talking about just this patch, it's not needed unless
you also merge the rest of the Apple T2 support patches, which some
people I'm sure would like but I think Christoph is a bit cold feet
about (I don't care either way).

If you are talking about the whole series, give me a day or two to
respin with the added check that Keith requested (I believe his ack is
for a respin with the check so setting the IO queue too small doesn't
kill the driver).

Cheers,
Ben.
