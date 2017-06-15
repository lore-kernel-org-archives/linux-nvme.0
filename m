From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 11:58:06 +0300
Subject: [PATCH] nvmet-fc: Remove a set-but-not-used variable
In-Reply-To: <20170608164329.20304-1-bart.vanassche@wdc.com>
References: <20170608164329.20304-1-bart.vanassche@wdc.com>
Message-ID: <5a272c14-1faf-fa08-0f2f-47aa0e4f2e32@grimberg.me>

already applied, but FWIW,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

On 08/06/17 19:43, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche at sandisk.com>
> 
> This was detected by building the nvmet-fc driver with W=1.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 294a6611fb24..1bb9d5b311b1 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -569,7 +569,6 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
>   			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
>   {
>   	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
> -	int active;
>   
>   	/*
>   	 * mark aborted only in case there were 2 threads in transport
> @@ -577,7 +576,6 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
>   	 * after the abort request
>   	 */
>   	spin_lock(&tfcp_req->reqlock);
> -	active = tfcp_req->active;
>   	tfcp_req->aborted = true;
>   	spin_unlock(&tfcp_req->reqlock);
>   
> 
