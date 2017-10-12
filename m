From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 12 Oct 2017 23:00:10 +0000
Subject: [PATCH 1/8] lib: Introduce sgl_alloc() and sgl_free()
In-Reply-To: <ee12eeaf-9848-478d-4ebe-9d3497e248e0@kernel.dk>
References: <20171012224550.25440-1-bart.vanassche@wdc.com>
 <20171012224550.25440-2-bart.vanassche@wdc.com>
 <ee12eeaf-9848-478d-4ebe-9d3497e248e0@kernel.dk>
Message-ID: <1507849209.14112.1.camel@wdc.com>

On Thu, 2017-10-12@16:52 -0600, Jens Axboe wrote:
> On 10/12/2017 04:45 PM, Bart Van Assche wrote:
> > +++ b/include/linux/sgl_alloc.h
> > @@ -0,0 +1,16 @@
> > +#ifndef _SGL_ALLOC_H_
> > +#define _SGL_ALLOC_H_
> > +
> > +#include <linux/types.h> /* bool, gfp_t */
> > +
> > +struct scatterlist;
> > +
> > +struct scatterlist *sgl_alloc_order(unsigned long long length,
> > +				    unsigned int order, unsigned int *nent_p,
> > +				    gfp_t gfp, bool chainable);
> > +struct scatterlist *sgl_alloc(unsigned long long length, unsigned int *nent_p,
> > +			      gfp_t gfp);
> > +void sgl_free_order(struct scatterlist *sgl, int order);
> > +void sgl_free(struct scatterlist *sgl);
> > +
> > +#endif /* _SGL_ALLOC_H_ */
> 
> Should this just go into linux/scatterlist.h instead of creating a new header
> file?

That's something I can change. I don't have a strong opinion about whether
these declarations should go into a new header file or into linux/scatterlist.h.

Bart.
