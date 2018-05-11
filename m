From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 May 2018 09:00:40 +0200
Subject: [PATCH V4] nvmet: add simple file backed ns support
In-Reply-To: <20180510214508.4563-1-chaitanya.kulkarni@wdc.com>
References: <20180510214508.4563-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180511070040.GA8633@lst.de>

On Thu, May 10, 2018@05:45:08PM -0400, Chaitanya Kulkarni wrote:
> This patch adds simple file backed namespace support for
> NVMeOF target.
> 
> In current implementation NVMeOF supports block
> device backed namespaces on the target side.
> With this implementation regular file(s) can be used to
> initialize the namespace(s) via target side configfs
> interface.
> 
> For admin smart log command on the target side, we only use
> block device backed namespaces to compute target
> side smart log.
> 
> We isolate the code for each ns handle type
> (file/block device) and add wrapper routines to manipulate
> the respective ns handle types.

Please use up to 75 characters per line for your changelog.

> diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
> index cd23441..a5f787b 100644
> --- a/drivers/nvme/target/io-cmd.c
> +++ b/drivers/nvme/target/io-cmd.c

Btw, I think now that the file code doesn't really reuse any
block code maybe it is a better idea to have a separate io-cmd-file.c
file after all.  I had initially envisioned the file code reusing
the bio for the bvec allocation, but without that there is basically no
code sharing left.

> +static void nvmet_execute_rw_file(struct nvmet_req *req)
> +{
> +	int rw = req->cmd->rw.opcode == nvme_cmd_write ? WRITE : READ;
> +	u32 nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
> +	struct sg_page_iter sg_pg_iter;
> +	struct bio_vec *bvec;
> +	struct iov_iter iter;
> +	struct kiocb *iocb;
> +	ssize_t len = 0, ret;
> +	int bv_cnt = 0;
> +	loff_t pos;
> +
> +	bvec = req->inline_bvec;
> +	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC) {
> +		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
> +				GFP_KERNEL);

So we still don't have the mempool or anything guaranteeing forward
progress here.

> +u16 nvmet_parse_io_cmd_file(struct nvmet_req *req)
> +{
> +	struct nvme_command *cmd = req->cmd;
> +
> +	switch (cmd->common.opcode) {
> +	case nvme_cmd_read:
> +	case nvme_cmd_write:
> +		req->handle.f.bvec = NULL;
> +		memset(&req->handle.f.iocb, 0, sizeof(req->handle.f.iocb));
> +		req->execute = nvmet_execute_rw_file;
> +		req->data_len = nvmet_rw_len(req);
> +		return 0;
> +	case nvme_cmd_flush:
> +		req->execute = nvmet_execute_flush_file;
> +		INIT_WORK(&req->handle.f.io_work, nvmet_flush_work_file);
> +		req->data_len = 0;
> +		return 0;
> +	case nvme_cmd_dsm:
> +		INIT_WORK(&req->handle.f.io_work, nvmet_dsm_work_file);
> +		req->execute = nvmet_execute_dsm_file;
> +		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
> +			sizeof(struct nvme_dsm_range);
> +		return 0;
> +	case nvme_cmd_write_zeroes:
> +		INIT_WORK(&req->handle.f.io_work, nvmet_write_zeroes_work_file);
> +		req->execute = nvmet_execute_write_zeroes_file;
> +		req->data_len = 0;
> +		return 0;

I'd be tempted to keep the INIT_WORK and memset calls in the actual
handlers and leave this as a pure dispatcher just setting the execute
callbacl and the data_len.

> @@ -222,8 +239,8 @@ struct nvmet_req {
>  	struct nvmet_cq		*cq;
>  	struct nvmet_ns		*ns;
>  	struct scatterlist	*sg;
> -	struct bio		inline_bio;
>  	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
> +	union  ns_handle	handle;

Can you just make this an anonymous union so that identifiers stay
short and crispy?
