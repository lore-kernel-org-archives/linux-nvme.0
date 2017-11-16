From: james.smart@broadcom.com (James Smart)
Date: Wed, 15 Nov 2017 16:13:26 -0800
Subject: [PATCH] nvmet: better data length validation
In-Reply-To: <20171109132958.1816-1-hch@lst.de>
References: <20171109132958.1816-1-hch@lst.de>
Message-ID: <025652d1-f120-aec7-e2e8-94ad594d67d8@broadcom.com>

On 11/9/2017 5:29 AM, Christoph Hellwig wrote:
> Currently the NVMe target stores the expexted data length in req->data_len
> and uses that for data transfer decisions, but that does not take the
> actual transfer length in the SGLs into account.  So this adds a new
> transfer_len field, into which the transport drivers store the actual
> transfer length.  We then check the two match before actually executing
> the command.
>
> The FC transport driver already had such a field, which is removed in
> favour of the common one.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/target/core.c  | 10 ++++++++++
>   drivers/nvme/target/fc.c    | 32 ++++++++++++--------------------
>   drivers/nvme/target/loop.c  |  3 ++-
>   drivers/nvme/target/nvmet.h |  4 ++++
>   drivers/nvme/target/rdma.c  | 10 ++++++----
>   5 files changed, 34 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index da088293eafc..22a2a2bb40f9 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -501,6 +501,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>   	req->ops = ops;
>   	req->sg = NULL;
>   	req->sg_cnt = 0;
> +	req->transfer_len = 0;
>   	req->rsp->status = 0;
>   
>   	/* no support for fused commands yet */
...
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 5f2570f5dfa9..739b8feadc7d 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
...
> @@ -2160,7 +2157,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>   
>   	fod->fcpreq->done = nvmet_fc_xmt_fcp_op_done;
>   
> -	fod->total_length = be32_to_cpu(cmdiu->data_len);
> +	fod->req.transfer_len = be32_to_cpu(cmdiu->data_len);
>   	if (cmdiu->flags & FCNVME_CMD_FLAGS_WRITE) {
>   		fod->io_dir = NVMET_FCP_WRITE;
>   		if (!nvme_is_write(&cmdiu->sqe))

So the above combination hosed FC as the extraction of the data length 
from the cmd iu was done prior to the nvmet_req_init() call, so the init 
call zero'd it.

I'll send a patch, within FC, that corrects it.

-- james
