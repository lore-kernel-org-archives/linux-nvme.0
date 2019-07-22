From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 23 Jul 2019 07:54:49 +1000
Subject: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
In-Reply-To: <91ef44522140bf83720f6c377648b307964d34e4.camel@kernel.crashing.org>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190719122859.GA30193@lst.de>
 <91ef44522140bf83720f6c377648b307964d34e4.camel@kernel.crashing.org>
Message-ID: <00f7a7e127467c0de98b114f2fe38f836601eef8.camel@kernel.crashing.org>

On Fri, 2019-07-19@23:51 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2019-07-19@14:28 +0200, Christoph Hellwig wrote:
> > Yikes, that things looks worse and worse.  I think at this point
> > we'll
> > have to defer the support to 5.4 unfortunately as it is getting more
> > and more involved..
> 
> Well, at least v3 of that patch, thanks to Damien's idea, isn't
> particularly invasive and I've hammered the SSD with it over night with
> a combination of IOs and smart commands, it's solid.
> 
> But if you prefer waiting for 5.4, no worries.

BTW. It's been solid for 3 days now, so I think that was the last of it
(famous last words...)

Cheers,
Ben.
