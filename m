From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 15:20:49 +0100
Subject: [PATCH 03/15] block: add a rq_dma_dir helper
In-Reply-To: <80ffa084-e1fb-4c5c-da92-7d9486084cb6@suse.de>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-4-hch@lst.de>
 <80ffa084-e1fb-4c5c-da92-7d9486084cb6@suse.de>
Message-ID: <20190327142049.GC26200@lst.de>

On Fri, Mar 22, 2019@02:06:43PM +0100, Johannes Thumshirn wrote:
> On 22/03/2019 00:10, Christoph Hellwig wrote:
> > In a lot of places we want to know the DMA direction for a given
> > struct request.  Add a little helper to make it a littler easier.
> 
> You introuduce the helper here but you're using it in 8/15 for the 1st time.
> 
> Could you convert the possible users to use the new helper in this patch
> as well?

I'd rather not throw that into a nvme series.  Those are easily cleanups
for later.  Maybe we can even encourage people that would otherwise
do whitespace cleanups or incorrect refcount_t conversions to take care
of it :)
