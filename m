From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Apr 2018 19:29:25 +0200
Subject: [PATCH 05/20] nvmet: add NVMe I/O command handlers for file
In-Reply-To: <20180418190011.3973-6-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
 <20180418190011.3973-6-chaitanya.kulkarni@wdc.com>
Message-ID: <20180424172925.GC30391@lst.de>

> +#define NR_BVEC(req)	(req->data_len / PAGE_SIZE)

Don't we need to round up here instead of rounding down for
transfers that aren't a multiple of PAGE_SIZE?

Also given that there is a single user only it might make more sense
to just open code it.

> +static void nvmet_file_io_complete(struct kiocb *iocb, long ret, long ret2)
> +{
> +	struct nvmet_req *req = container_of(iocb, struct nvmet_req, iocb);
> +
> +	kfree(req->bvec);
> +	req->bvec = NULL;

There should be no need to set req->bvec to NULL there.

> +static void nvmet_execute_rw_file(struct nvmet_req *req)
> +{
> +	struct iov_iter iter;
> +	struct sg_mapping_iter miter;
> +	loff_t pos;
> +	ssize_t len = 0, ret;
> +	int ki_flags = IOCB_DIRECT;
> +	int bv_cnt = 0, rw = READ;

Maybe do a simple bool is_write instead of using the nasty
legacy READ/WRITE defines?

> +	req->bvec = kmalloc_array(NR_BVEC(req), sizeof(struct bio_vec),
> +			GFP_KERNEL);
> +	if (!req->bvec)
> +		goto out;

Any chance to reuse the inline_bvec for small requests?

> +
> +	sg_miter_start(&miter, req->sg, req->sg_cnt, SG_MITER_FROM_SG);
> +	while (sg_miter_next(&miter)) {
> +		req->bvec[bv_cnt].bv_page = miter.page;
> +		req->bvec[bv_cnt].bv_offset = miter.__offset;

>From scatterlist.h:

	/* these are internal states, keep away */
	unsigned int            __offset;       /* offset within page */

But given that the nvmet code allocated the scatterlist we already know
each element is only a page long at maximum.  So a simple for_each_sg
loop as for the block backend will probably do it.

> +	pos = le64_to_cpu(req->cmd->rw.slba) * (1 << (req->ns->blksize_shift));

The block backend does:

	sector = le64_to_cpu(req->cmd->rw.slba);
        sector <<= (req->ns->blksize_shift - 9);

which should be more efficient as it avoids the multiplication.

> +	if (rw == WRITE)
> +		ret = call_write_iter(req->ns->filp, &req->iocb, &iter);
> +	else
> +		ret = call_read_iter(req->ns->filp, &req->iocb, &iter);

Please call the read_iter/write_iter methods directly.

> +static void nvmet_execute_flush_file(struct nvmet_req *req)
> +{
> +	int ret = vfs_fsync(req->ns->filp, 1);
> +
> +	nvmet_req_complete(req, ret);
> +}

This will work ok but block the caller frontend thread for possibly
a long time.  Offloading this to a simple schedule_work might be
beneficial.
