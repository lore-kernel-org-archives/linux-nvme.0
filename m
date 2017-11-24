From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Nov 2017 00:32:59 -0800
Subject: [GIT PULL] nvme fixes for Linux 4.15
In-Reply-To: <1dcadbce-8a97-9578-686a-c43bd8dc06fc@kernel.dk>
References: <20171123144438.wfs2fo64l6vwgfxj@infradead.org>
 <514cf7e6-f651-112e-c8bb-e5ad837d4394@kernel.dk>
 <1dcadbce-8a97-9578-686a-c43bd8dc06fc@kernel.dk>
Message-ID: <20171124083259.GA10952@infradead.org>

On Thu, Nov 23, 2017@10:04:55PM -0700, Jens Axboe wrote:
> > +       NVME_FC_Q_LIVE = (1 << 1),                                              
> > }; 
> > 
> > for flags that are used with set_bit() and friends? That's just
> > misleading, should be 0, 1, etc, not a shift.
> > 
> > The rest looks pretty straight forward, but the above is an eye sore.

Yes, it is misleading, but so far harmless.

Your fixup looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
