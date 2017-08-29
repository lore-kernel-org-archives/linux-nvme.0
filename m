From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Aug 2017 16:50:33 +0200
Subject: [PATCH for-4.13] nvme-pci: use dma memory for the host memory
 buffer descriptors
In-Reply-To: <20170829135923.GF9310@linux-x5ow.site>
References: <20170828084718.29007-1-hch@lst.de>
 <20170829135923.GF9310@linux-x5ow.site>
Message-ID: <20170829145032.GA32673@lst.de>

On Tue, Aug 29, 2017@03:59:23PM +0200, Johannes Thumshirn wrote:
> On Mon, Aug 28, 2017@10:47:18AM +0200, Christoph Hellwig wrote:
> > -	descs = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
> > +	descs = dma_zalloc_coherent(dev->dev, max_entries * sizeof(*descs),
> > +			&descs_dma, GFP_KERNEL);
> 
> [...]
> 
> > -	kfree(descs);
> > +	dma_free_coherent(dev->dev, max_entries * sizeof(*dev->host_mem_descs),
> > +			descs, descs_dma);
> 
> If the patch isn't super urgent, I'd prefere the sizeof() arguments being
> aligned, i.e. either sizeof(*descs) _or_ sizeof(*dev->host_mem_descs) but not
> both. It's rather confusing for the reader. Maybe just cache the max_entries *
> sizeof(*dev->host_mem_descs) value?

Sure, I'll fix it up.
