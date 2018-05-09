From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 May 2018 07:53:56 +0200
Subject: [PATCH V3] nvmet: add simple file backed ns support
In-Reply-To: <20180508053829.406-1-chaitanya.kulkarni@wdc.com>
References: <20180508053829.406-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180509055356.GA18926@lst.de>

Hi Chaitanya,

this looks great.  A couple mostly cosmetic comments below:

> +	/* for file backed ns just return */
> +	if (!ns->bdev)
> +		goto out;
>
> @@ -71,6 +77,9 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
> +		/* for file backed ns just return */

Maybe expand the comment a bit that we don't have the data and this
is the best we can do?

> +static int nvmet_ns_enable_blk(struct nvmet_ns *ns)

s/blk/blkdev/

> +{
> +	int blk_flags = FMODE_READ | FMODE_WRITE;
> +
> +	ns->bdev = blkdev_get_by_path(ns->device_path, blk_flags, NULL);

I'd say just kill the blk_flags variable and pass the flags directly
to blkdev_get_by_path.

> +	if (IS_ERR(ns->bdev)) {
> +		pr_err("failed to open block device %s: (%ld)\n",
> +				ns->device_path, PTR_ERR(ns->bdev));

This is going to be printed everytime we open a file, isn't it?
Maybe skip the error print for the error code we get in the case
where the path actually is a file.

> +		ns->bdev = NULL;
> +		return -1;

This should be

		return PTR_ERR(ns->bdev);

> +	}
> +	ns->size = i_size_read(ns->bdev->bd_inode);
> +	ns->blksize_shift =
> +		blksize_bits(bdev_logical_block_size(ns->bdev));

This fits into a single line:

	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));

> +static int nvmet_ns_enable_file(struct nvmet_ns *ns)
> +{
> +	int ret;
> +	int flags = O_RDWR | O_LARGEFILE | O_DIRECT;
> +	struct kstat stat;
> +
> +	ns->file = filp_open(ns->device_path, flags, 0);

No need for the flags argument either.

> +	if (!ns->file || IS_ERR(ns->file)) {

filp_open never returns NULL, so you just need the IS_ERR check.

> +		pr_err("failed to open file %s: (%ld)\n",
> +				ns->device_path, PTR_ERR(ns->bdev));
> +		ns->file = NULL;
> +		return -1;

This should be:
		return PTR_ERR(ns->bdev);

> +	}
> +
> +	ret = vfs_getattr(&ns->file->f_path,
> +			&stat, STATX_INO, AT_STATX_SYNC_AS_STAT);

I think we want AT_STATX_FORCE_SYNC here, and STATX_INO is the wrong
value to ask for (but no one really looks at ir yet, so for now it
happens to work just fine).

So this should be:

	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
			AT_STATX_FORCE_SYNC);

> +	if (ret)
> +		goto err;
> +
> +	ns->size = stat.size;
> +	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
> +
> +	return ret;
> +err:
> +	fput(ns->file);
> +	ns->size = ns->blksize_shift = 0;

Please use a separate line for each assignment.

> +	ns->file = NULL;
> +
> +	return ret;

No need for the blank line here.

> +static int nvmet_ns_dev_enable(struct nvmet_ns *ns)
> +{
> +	int ret = 0;
> +
> +	ret = nvmet_ns_enable_blk(ns);
> +	if (ret)
> +		ret = nvmet_ns_enable_file(ns);
> +
> +	return ret;

Same here.  Also I suspect this function can be removed and the two
calls just be done in the only caller.

> +static void nvmet_flush_work_file(struct work_struct *work)
> +{
> +	int ret;
> +	struct nvmet_req *req;
> +
> +	req = container_of(work, struct nvmet_req, flush_work);

Maybe:

	struct nvmet_req *req = container_of(work, struct nvmet_req, work);
	int ret;


> +static void nvmet_execute_discard_file(struct nvmet_req *req)
> +{
> +	struct nvme_dsm_range range;
> +	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> +	loff_t offset;
> +	loff_t len;
> +	int i, ret;
> +
> +	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
> +		if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
> +					sizeof(range)))
> +			break;
> +		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
> +		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
> +		ret = vfs_fallocate(req->ns->file, mode, offset, len);
> +		if (ret)
> +			break;
> +	}
> +
> +	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
> +}

Discard and write zeroes should probably also be exectured using the
work struct as they will usually block.

>  u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>  {
>  	struct nvme_command *cmd = req->cmd;
> @@ -207,20 +341,33 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>  	switch (cmd->common.opcode) {
>  	case nvme_cmd_read:
>  	case nvme_cmd_write:
> -		req->execute = nvmet_execute_rw;
> +		if (req->ns->file)
> +			req->execute = nvmet_execute_rw_file;
> +		else
> +			req->execute = nvmet_execute_rw;
>  		req->data_len = nvmet_rw_len(req);

Maybe it would be cleaner to have separate parse_block_io_cmd/
parse_file_io_cmd helpers? (I'm not entirely sure, use your own
judgement)

> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 15fd84a..60f399f 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -26,6 +26,8 @@
>  #include <linux/configfs.h>
>  #include <linux/rcupdate.h>
>  #include <linux/blkdev.h>
> +#include <linux/file.h>
> +#include <linux/falloc.h>

We shouldn't really need these in nvmet.h, only in io-cmd.c, with
possible an empty forward declaration for struct file here.

> @@ -224,6 +227,8 @@ struct nvmet_req {
>  	struct scatterlist	*sg;
>  	struct bio		inline_bio;
>  	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
> +	struct kiocb		iocb;
> +	struct bio_vec		*bvec;
>  	int			sg_cnt;
>  	/* data length as parsed from the command: */
>  	size_t			data_len;
> @@ -234,6 +239,7 @@ struct nvmet_req {
>  
>  	void (*execute)(struct nvmet_req *req);
>  	const struct nvmet_fabrics_ops *ops;
> +	struct work_struct	flush_work;

I think we want a union between the block and file fields to
not bloat the structure, e.g.

	union {
		struct {
			struct bio	inline_bio;
		} b;
		struct {
			struct kiocb	iocb;
			struct bio_vec	*bvev;
			struct work_struct work;
		} f;
	};

plus auditing for other files only used in one path.
