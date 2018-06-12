From: hare@suse.de (Hannes Reinecke)
Date: Tue, 12 Jun 2018 13:08:37 +0200
Subject: [PATCH 4/4] nvme-fabrics: reverse polarity in __nvmf_check_ready
In-Reply-To: <20180611154647.32558-5-hch@lst.de>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-5-hch@lst.de>
Message-ID: <20180612130837.47a16bd2@pentland.suse.de>

On Mon, 11 Jun 2018 17:46:47 +0200
Christoph Hellwig <hch@lst.de> wrote:

> All non-live, non-dead states have the same command filters.  So just
> check for the dead state first, and then apply out filters to catch
> all other "special" states automatically.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/fabrics.c | 42
> ++++++++++++++----------------------- 1 file changed, 16
> insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 6b4e253b9347..dc87719a5c9e 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -556,34 +556,24 @@ EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>  bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>  		bool queue_live)
>  {
> -	struct nvme_command *cmd = nvme_req(rq)->cmd;
> -
> -	switch (ctrl->state) {
> -	case NVME_CTRL_NEW:
> -	case NVME_CTRL_CONNECTING:
> -	case NVME_CTRL_DELETING:
> -		/*
> -		 * If queue is live, allow only commands that are
> internally
> -		 * generated pass through.  These are commands on
> the admin
> -		 * queue to initialize the controller. This will
> reject any
> -		 * ioctl admin cmds received while initializing.
> -		 */
> -		if (queue_live && !(nvme_req(rq)->flags &
> NVME_REQ_USERCMD))
> -			return true;
> -
> -		/*
> -		 * If the queue is not live, allow only a connect
> command.  This
> -		 * will reject any ioctl admin cmd as well as
> initialization
> -		 * commands if the controller reverted the queue to
> non-live.
> -		 */
> -		if (!queue_live && blk_rq_is_passthrough(rq) &&
> -		     cmd->common.opcode == nvme_fabrics_command &&
> -		     cmd->fabrics.fctype ==
> nvme_fabrics_type_connect)
> -			return true;
> +	if (ctrl->state == NVME_CTRL_DEAD)
>  		return false;
> -	default:
> +
> +	/*
> +	 * If the queue is not live the only thing allowed is a
> connect
> +	 * command to actually set the queue live.
> +	 */
> +	if (!queue_live &&
> +	    (nvme_req(rq)->cmd->common.opcode !=
> nvme_fabrics_command ||
> +	     nvme_req(rq)->cmd->fabrics.fctype !=
> nvme_fabrics_type_connect)) return false;
> -	}
> +
> +	/*
> +	 * If we are in some state of setup or teardown only allow
> +	 * internally generated commands.
> +	 */
> +	return blk_rq_is_passthrough(rq) &&
> +		!(nvme_req(rq)->flags & NVME_REQ_USERCMD);
>  }
>  EXPORT_SYMBOL_GPL(__nvmf_check_ready);
>  

Is that really correct?
We're squashing the 'queue_live' check with the check for the 'connect'
command, meaning we will be submitting non-connect commands even on a
non-live queue.

I'd rather split that check into two if-clauses like:

if (!queue_live) {
  if (nvme_req(rq)->cmd....)
     return false;
  return true;
}

to improve readability (and possibly correctness)

Cheers,

Hannes
