From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Oct 2017 00:58:45 -0700
Subject: [PATCH V6] nvme-pci: add SGL support
In-Reply-To: <a04ca9b1-c551-d86e-2e61-fc37c7ddd086@mellanox.com>
References: <1507232903-9532-1-git-send-email-ckulkarnilinux@gmail.com>
 <1507232903-9532-2-git-send-email-ckulkarnilinux@gmail.com>
 <a04ca9b1-c551-d86e-2e61-fc37c7ddd086@mellanox.com>
Message-ID: <20171016075845.GA14943@infradead.org>

[can you trim down your quotes to the relevant part?  That would
 make it a lot easier to read]

On Sun, Oct 08, 2017@12:16:10PM +0300, Max Gurtovoy wrote:
> >   #define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
> > +#define SGES_PER_PAGE          (PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> 
> should we use PAGE_SIZE or ctrl->page_size ?

It should be PAGE_SIZE - as that is the size of the PRP page pool
that is also reused for SGLs.

> > +	if (entries <= 256 / sizeof(struct nvme_sgl_desc)) {
>
> 
> where does 256 comes from ? can we use macro definition here ?

That is the size of the small PRP pool.

I think a little cleanup to define constants for the small and
large pools, and remove the PRP from the name might be nice, but
we can do that after this patch.

> > +	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
> 
> Can you create macros for the spec definitions ?
> In case of Dword alignment and granularity, where do we check that
> requirement ?

These bits don't have names in the spec, so I think we should not
make them up.
