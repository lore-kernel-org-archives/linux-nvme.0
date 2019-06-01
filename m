From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Jun 2019 10:50:16 +0200
Subject: [PATCH V5 1/5] nvme: Make trace common for host and target both
In-Reply-To: <20190601072143.21233-2-minwoo.im.dev@gmail.com>
References: <20190601072143.21233-1-minwoo.im.dev@gmail.com>
 <20190601072143.21233-2-minwoo.im.dev@gmail.com>
Message-ID: <20190601085016.GA6375@lst.de>

> diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
> index 0096a7fd1431..12f193502d46 100644
> --- a/drivers/nvme/Makefile
> +++ b/drivers/nvme/Makefile
> @@ -1,3 +1,6 @@
>  
> +ccflags-y		+= -I$(src)
> +obj-$(CONFIG_TRACING)	+= trace.o

this will always build the file into the kernel if CONFIG_TRACING,
even if no nvme code is enabled.

And looking at the later patches I don't even think this sharing is
worth it, as the actual trace points are pretty different.

I'd much prefer to have different implementations for host vs target for
now instead of introducing a common library.  Maybe we could revisit
that later if we end up having a lot of shared code.
