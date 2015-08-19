From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Aug 2015 03:42:46 -0700
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55D45AE0.50805@dev.mellanox.co.il>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
 <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
 <55A7D4B6.9020101@kernel.dk> <55ABBFB1.7070201@dev.mellanox.co.il>
 <20150819094003.GB14734@infradead.org>
 <55D45AE0.50805@dev.mellanox.co.il>
Message-ID: <20150819104246.GA4956@infradead.org>

On Wed, Aug 19, 2015@01:30:56PM +0300, Sagi Grimberg wrote:
> Actually I didn't. I started to, but then I noticed that
> I was still seeing gaps when using cfq (e.g. non-mq code
> path), I assume that this was never tested?

It probably wasn't.  The only user so far is the NVMe driver which
is blk-mq only.

> Since I was busy with the iser-target iWARP support with Steve
> so I didn't get a chance to get back to it yet...

Ok.
