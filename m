From: hch@lst.de (Christoph Hellwig)
Date: Mon, 21 Mar 2016 15:47:59 +0100
Subject: [PATCH RFC] nvme: rewrite discard support
In-Reply-To: <20160317153335.GB6217@localhost.lm.intel.com>
References: <1458170132-16031-1-git-send-email-mlin@kernel.org>
 <20160317153335.GB6217@localhost.lm.intel.com>
Message-ID: <20160321144759.GA12934@lst.de>

On Thu, Mar 17, 2016@03:33:35PM +0000, Keith Busch wrote:
> Initial thoughts on this, I see the appeal to having a generic NVMe
> discard setup, but I liked the existing implementation not needing a
> special case for discard check on every IO in the completion handler.

This looks fine now, although if we'd ever support SGLs for PCIe
it wouldn't work anymore either way.

> Allocating a page for just 16 bytes of data seems a bit wasteful even
> if it is short-lived. When it was allocating 256b from the DMA pool,
> the smaller amount of additional data seemed worth it for not creating
> a conditional completion.

I think we should just do a 16 byte (or rather cache line size) kmalloc,
as there is no need for a mempool for discards.  Would a version of
that be fine with you?  Because discard is currently the only thing
preventing us from having a split between transport and commanset specific
setup for NVMe.  And as things like Fabrics and LighNVM show I think
a clean split there would be rather benefitical in the long run.
