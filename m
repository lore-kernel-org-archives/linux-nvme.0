From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 2 Jun 2019 10:47:38 +0900
Subject: [PATCH V5 1/5] nvme: Make trace common for host and target both
In-Reply-To: <20190601085016.GA6375@lst.de>
References: <20190601072143.21233-1-minwoo.im.dev@gmail.com>
 <20190601072143.21233-2-minwoo.im.dev@gmail.com>
 <20190601085016.GA6375@lst.de>
Message-ID: <20190602014737.GA28933@minwooim-desktop>

On 19-06-01 10:50:16, Christoph Hellwig wrote:
> > diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
> > index 0096a7fd1431..12f193502d46 100644
> > --- a/drivers/nvme/Makefile
> > +++ b/drivers/nvme/Makefile
> > @@ -1,3 +1,6 @@
> >  
> > +ccflags-y		+= -I$(src)
> > +obj-$(CONFIG_TRACING)	+= trace.o
> 
> this will always build the file into the kernel if CONFIG_TRACING,
> even if no nvme code is enabled.

Oh, thanks to point it out.

> And looking at the later patches I don't even think this sharing is
> worth it, as the actual trace points are pretty different.

That's why this patch series introduces DECLARE_EVENT_CLASS as a
template, and gives different events for it by DEFINE_EVENT.

> 
> I'd much prefer to have different implementations for host vs target for
> now instead of introducing a common library.  Maybe we could revisit
> that later if we end up having a lot of shared code.

As you know, nvmet handles not only nvme fabrics commands, but normal
commands in nvmet_req_init() and nvmet_req_complete().  Which means that
we already have a lot of shared codes in parsing point of view.

The host/trace.c provides parsing admin commands which can be used by
nvmet also.  I guess it's enough to be shared for host and target both.

I hope you can correct me if I missed someting here.

Thanks, Christoph.
