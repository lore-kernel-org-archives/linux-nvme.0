From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Jun 2015 14:10:17 +0000 (UTC)
Subject: [PATCHv2] NVMe: Stripe queue IRQ vector assignments
In-Reply-To: <20150611073826.GA27065@infradead.org>
References: <1433954490-22939-1-git-send-email-jonathan.derrick@intel.com>
 <20150610190812.GA6200@infradead.org>
 <alpine.LNX.2.00.1506110020180.15930@localhost.lm.intel.com>
 <20150611073826.GA27065@infradead.org>
Message-ID: <alpine.LNX.2.00.1506111350580.15930@localhost.lm.intel.com>

On Thu, 11 Jun 2015, Christoph Hellwig wrote:
> Sorry if I wasn't clear - I meant the fact that we avoid the vectors
> that have the admin queue assigned for I?O queue vectors.  While it's
> fine to use separate vectors if we have enough I'd rather share an I/O
> queue with the admin queue than with another I/O queue if that's not the
> case.

Right, I think Jon's patch captures that. If there are not enough for
1:1, the irqs are shared modulo the number of vectors, so the first
shared vector is the admin queue's vector 0.

> The limitation seems odd enough and specific to a piece of silicone that
> I think we really need a comment and even better a quirk to document it.

It's an errata, but I can imagine what the implementers were thinking:
per the spec, the admin queue never participates in interrupt coalescing,
and the admin queue always gets interrupt vector 0. The feature was
incorrectly tied to the vector rather than the queue.
