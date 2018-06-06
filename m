From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 14:29:39 +0200
Subject: [PATCH V2] nvmet: allow file backed ns to use cache
In-Reply-To: <20180531140700.13708-1-chaitanya.kulkarni@wdc.com>
References: <20180531140700.13708-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180606122939.GA13398@lst.de>

> +	if (ns->file && ns->buffered_io != buffered_io) {
> +		nvmet_ns_disable(ns);
> +		ns->buffered_io = buffered_io;
> +		ret = nvmet_ns_enable(ns);
> +	}

This section should be under subsys->lock to protect against
concurrent modification.  For which we'd need to move the locking
out of nvmet_ns_disable/nvmet_ns_enable into the existing callers,
which should probably be a prep patch for this one.


> -	int ret;
> +	int flags = O_RDWR | O_LARGEFILE | ns->buffered_io ? 0 : O_DIRECT;
>  	struct kstat stat;
> +	int ret;

Cosmetic, but I'd prefer:

	int flags = O_RDWR | O_LARGEFILE;

	if (!ns->buffered_io)
		flags |= O_DIRECT;

>  
> -	ns->file = filp_open(ns->device_path,
> -			O_RDWR | O_LARGEFILE | O_DIRECT, 0);
> +	ns->file = filp_open(ns->device_path, flags, 0);


> @@ -97,6 +111,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
>  	iocb->ki_pos = pos;
>  	iocb->ki_filp = req->ns->file;
>  	iocb->ki_flags = IOCB_DIRECT | ki_flags;
> +	iocb->ki_flags = ki_flags | req->ns->buffered_io ? 0 : IOCB_DIRECT;

I'd rather use iocb_flags() here, e.g.

	iocb->ki_flags = ki_flags | iocb_flags(ns->file);

>  static void nvmet_file_execute_flush(struct nvmet_req *req)
>  {
> +	if (req->ns->buffered_io)
> +		flush_workqueue(req->ns->file_wq);

No needed.  NVMe Flush doesn't affect in-flight commands.  Quote from
the spec:

  The flush applies to all commands completed prior to the submission of the
  Flush command. The controller may also flush additional data and/or
  metadata from any namespace.

Otherwise this looks fine.
