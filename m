From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 14:47:14 +0200
Subject: [PATCH V5] nvmet: add simple file backed ns support
In-Reply-To: <20180517054558.5648-1-chaitanya.kulkarni@wdc.com>
References: <20180517054558.5648-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180517124714.GA31470@lst.de>

On Thu, May 17, 2018@01:45:58AM -0400, Chaitanya Kulkarni wrote:
> This patch adds simple file backed namespace support for
> NVMeOF target.
> 
> In current implementation NVMeOF supports block
> device backed namespaces on the target side.
> With this implementation regular file(s) can be used
> to initialize the namespace(s) via target side
> configfs interface.
> 
> For admin smart log command on the target side, we only
> use block device backed namespaces to compute target
> side smart log.
> 
> The new file io-cmd-file.c is responsible for handling
> the code for I/O commands when ns is file backed. Also,
> we introduce mempools based slow path for file backed
> ns.

Please use ~ 73 lines for the changelog to instead of line wrapping
earlier.

> +static int nvmet_ns_enable_blkdev(struct nvmet_ns *ns)

> +static int nvmet_ns_enable_file(struct nvmet_ns *ns)

I think these should be moved to io-cmd.c and io-cmd-file.c
respectively, including adding little helpers for close, so that
the code dealing with file structures or block devices is relatively
isolated now that we split up the implementation files.

Sagi - what do you think about renaming io-cmd.c to io-cmd-bdev.c
while we're at it?

> +	ns->cachep = kmem_cache_create("nvmet-fs",

what about nvmet-bvec as the name?

> +	if (req->ns->file)
> +		return nvmet_parse_io_cmd_file(req);
> +	else if (req->ns->bdev)
> +		return nvmet_parse_io_cmd_blkdev(req);
> +
> +	WARN_ON_ONCE("failed to parse io cmd: invalid ns handle");
> +
> +	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;

I'd just leave it at and if/else, things will blow up nicely if this
invariant ever gets broken:

	if (req->ns->file)
		return nvmet_parse_io_cmd_file(req);
	else
		return nvmet_parse_io_cmd_blkdev(req);

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

You can remove this whole boilerplate given that you have a SPDX tag.

> +typedef ssize_t (*call_iter_t) (struct kiocb *, struct iov_iter *);
> +typedef void (*ki_complete_t)(struct kiocb *iocb, long ret, long ret2);

No need for these typedefs.

> +		if ((bv_cnt == NVMET_MAX_BVEC) || ((nr_bvec - 1) == 0)) {

No need for all but the outer braces.

> +			init_completion(&req->f.io_complete);
> +
> +			ret = nvmet_issue_bvec(req, pos, bv_cnt, len, io_done);
> +			if (ret == -EIOCBQUEUED)
> +				wait_for_completion(&req->f.io_complete);

Instead of using your own completion, the synchronous case should just
not set a ki_complete callback at all, which means the file system
will handle the I/O synchronously for you.

That probably means you can share the actual low-level routine for
doing I/O, just don't set ki_complete in the is_sync case, and have
some sort of outer loop chunking up into nr_bvec sized chunks


> +	req->f.bvec = req->inline_bvec;
> +	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
> +		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
> +				GFP_KERNEL);
> +		/* fallback */
> +		if (!req->f.bvec) {
> +			req->f.bvec = mempool_alloc(req->ns->mempool,
> +					GFP_KERNEL);
> +			if (!req->f.bvec)
> +				goto out;
> +			slow_path = true;
> +		}
> +	}
> +
> +	req->f.bvec = mempool_alloc(req->ns->mempool,
> +			GFP_KERNEL);
> +	if (!req->f.bvec)
> +		goto out;
> +	slow_path = true;

This seems to always hit the slow path.  How about this instead:

	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
				GFP_KERNEL);
	} else {
		req->f.bvec = req->inline_bvec;
	}

	/* fallback under memory pressure */
	if (unlikely(!req->f.bvec)) {
		req->f.bvec = mempool_alloc(req->ns->mempool, GFP_KERNEL);
		if (nr_bvec > NVMET_MAX_MEMPOOL_BVEC)
			is_sync = true;
	}

}

Also I think NVMET_MAX_BVEC should be NVMET_MAX_MEMPOOL_BVEC and
the actual I/O functions really don't need most of the arguments as
far as I can tell.  mempool_alloc with a GFP_KERNEL argument can't
fail it will just block forever, so no need to chek the return value
there.

> -static inline u32 nvmet_rw_len(struct nvmet_req *req)
> +inline u32 nvmet_rw_len(struct nvmet_req *req)
>  {
>  	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
>  			req->ns->blksize_shift;

I'd keep this as an inline and just move it to nvmet.h

> +#define NVMET_MAX_BVEC			16
> +#define NVMET_MPOOL_MIN_OBJ		NVMET_MAX_BVEC

Even if both of these are 16 they aren't really related, so please
define NVMET_MPOOL_MIN_OBJ directly.  Also with the move of the
enable function these can be kept in io-cmd-file.c.


>  /* Helper Macros when NVMe error is NVME_SC_CONNECT_INVALID_PARAM
>   * The 16 bit shift is to set IATTR bit to 1, which means offending
> @@ -43,6 +45,7 @@ struct nvmet_ns {
>  	struct list_head	dev_link;
>  	struct percpu_ref	ref;
>  	struct block_device	*bdev;
> +	struct file		*file;
>  	u32			nsid;
>  	u32			blksize_shift;
>  	loff_t			size;
> @@ -57,6 +60,8 @@ struct nvmet_ns {
>  	struct config_group	group;
>  
>  	struct completion	disable_done;
> +	mempool_t		*mempool;
> +	struct kmem_cache	*cachep;

I'd name these bvec_pool an bvec_cache.
