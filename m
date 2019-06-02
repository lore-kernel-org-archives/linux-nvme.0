From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 2 Jun 2019 22:57:08 +0000
Subject: [PATCH] nvmet: fix data_len to 0 for bdev-backed write_zeroes
References: <20190602034339.11246-1-minwoo.im.dev@gmail.com>
Message-ID: <BYAPR04MB57498FFBBE30504483A61590861B0@BYAPR04MB5749.namprd04.prod.outlook.com>

Thanks for the fix.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 6/1/19 8:44 PM, Minwoo Im wrote:
> The WRITE ZEROES command has no data transfer so that we need to
> initialize the struct (nvmet_req *req)->data_len to 0x0.  While
> (nvmet_req *req)->transfer_len is initialized in nvmet_req_init(),
> data_len will be initialized by nowhere which might cause the failure
> with status code NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR randomly.  It's
> because nvmet_req_execute() checks like:
>
> 	if (unlikely(req->data_len != req->transfer_len)) {
> 		req->error_loc = offsetof(struct nvme_common_command, dptr);
> 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
> 	} else
> 		req->execute(req);
>
> This patch fixes req->data_len not to be a randomly assigned by
> initializing it to 0x0 when preparing the command in
> nvmet_bdev_parse_io_cmd().
>
> nvmet_file_parse_io_cmd() which is for file-backed I/O has already
> initialized the data_len field to 0x0, though.
>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 3efc52f9c309..7a1cf6437a6a 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -293,6 +293,7 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
>  		return 0;
>  	case nvme_cmd_write_zeroes:
>  		req->execute = nvmet_bdev_execute_write_zeroes;
> +		req->data_len = 0;
>  		return 0;
>  	default:
>  		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
