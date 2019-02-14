From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 09:50:13 +0100 (CET)
Subject: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
In-Reply-To: <20190213223711.GC8027@localhost.localdomain>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-2-ming.lei@redhat.com>
 <20190213150407.GB96272@google.com>
 <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
 <20190213213149.GB8027@localhost.localdomain>
 <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
 <20190213223711.GC8027@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>

On Wed, 13 Feb 2019, Keith Busch wrote:

Cc+ Huacai Chen

> On Wed, Feb 13, 2019@10:41:55PM +0100, Thomas Gleixner wrote:
> > Btw, while I have your attention. There popped up an issue recently related
> > to that affinity logic.
> > 
> > The current implementation fails when:
> > 
> >         /*
> >          * If there aren't any vectors left after applying the pre/post
> >          * vectors don't bother with assigning affinity.
> > 	 */
> > 	if (nvecs == affd->pre_vectors + affd->post_vectors)
> >     		return NULL;
> > 
> > Now the discussion arised, that in that case the affinity sets are not
> > allocated and filled in for the pre/post vectors, but somehow the
> > underlying device still works and later on triggers the warning in the
> > blk-mq code because the MSI entries do not have affinity information
> > attached.
> >
> > Sure, we could make that work, but there are several issues:
> > 
> >     1) irq_create_affinity_masks() has another reason to return NULL:
> >        memory allocation fails.
> > 
> >     2) Does it make sense at all.
> > 
> > Right now the PCI allocator ignores the NULL return and proceeds without
> > setting any affinities. As a consequence nothing is managed and everything
> > happens to work.
> > 
> > But that happens to work is more by chance than by design and the warning
> > is bogus if this is an expected mode of operation.
> > 
> > We should address these points in some way.
> 
> Ah, yes, that's a mistake in the nvme driver. It is assuming IO queues are
> always on managed interrupts, but that's not true if when only 1 vector
> could be allocated. This should be an appropriate fix to the warning:

Looks correct. Chen, can you please test that?

> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 022ea1ee63f8..f2ccebe1c926 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -506,7 +506,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		 * affinity), so use the regular blk-mq cpu mapping
>  		 */
>  		map->queue_offset = qoff;
> -		if (i != HCTX_TYPE_POLL)
> +		if (i != HCTX_TYPE_POLL && dev->num_vecs > 1)
>  			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
>  		else
>  			blk_mq_map_queues(map);
> --
> 
