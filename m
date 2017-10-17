From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 17 Oct 2017 14:31:11 +0000
Subject: [PATCH v2 5/8] target: Use sgl_alloc_order() and sgl_free()
In-Reply-To: <c5e05f84-2602-5c3f-521e-6f35601011cf@suse.de>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-6-bart.vanassche@wdc.com>
 <c5e05f84-2602-5c3f-521e-6f35601011cf@suse.de>
Message-ID: <1508250670.3596.2.camel@wdc.com>

On Tue, 2017-10-17@08:14 +0200, Hannes Reinecke wrote:
> On 10/17/2017 12:49 AM, Bart Van Assche wrote:
> > [ ... ]
> >  void target_free_sgl(struct scatterlist *sgl, int nents)
> >  {
> > -	struct scatterlist *sg;
> > -	int count;
> > -
> > -	for_each_sg(sgl, sg, nents, count)
> > -		__free_page(sg_page(sg));
> > -
> > -	kfree(sgl);
> > +	sgl_free(sgl);
> >  }
> >  EXPORT_SYMBOL(target_free_sgl);
> >  
> > @@ -2423,42 +2417,10 @@ int
> >  target_alloc_sgl(struct scatterlist **sgl, unsigned int *nents, u32 length,
> >  		 bool zero_page, bool chainable)
> >  {
> > -	[ ... ]
> > +	*sgl = sgl_alloc_order(length, 0, chainable, gfp, nents);
> > +	return *sgl ? 0 : -ENOMEM;
> >  }
> >  EXPORT_SYMBOL(target_alloc_sgl);
> >  
> > The calling convention from target_alloc_sgl() is decidedly dodgy.
> 
> Can't we convert it into returning the sgl, and remove the first parameter?

Hello Hannes,

Another option is to remove the target_alloc_sgl() and target_free_sgl() functions
and to make LIO target drivers call sgl_alloc_order() and sgl_free_order() directly.
Do you perhaps have a preference for one of these two approaches?

Thanks,

Bart.
