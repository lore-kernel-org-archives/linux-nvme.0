From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 00:51:33 -0700
Subject: nvme: batch completions and do them outside of the queue lock
In-Reply-To: <20180516223538.GE20223@localhost.localdomain>
References: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
 <20180516212757.GD20223@localhost.localdomain>
 <20180516223538.GE20223@localhost.localdomain>
Message-ID: <20180517075133.GB24736@infradead.org>

On Wed, May 16, 2018@04:35:38PM -0600, Keith Busch wrote:
> While I'm not seeing a difference, I assume you are. I tried adding on
> to this proposal by batching *all* completions without using the stack,
> exploiting the fact we never wrap the queue so it can be accessed
> lockless after moving the cq_head.

But we do wrap around, in nvme_read_cqe don't we?  From a quick look
we probably are save because we size our SQs and CQs to the number
of outstanding command, and thus the device won't be able to reuse
the slots until we complete and reuse the command ids.  But that isn't
exactly obvious from the code, so I think we really need some good
comments in the code.
