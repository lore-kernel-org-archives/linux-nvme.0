From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 14:45:16 -0700
Subject: [PATCH 1/4] nvme-fabrics: refactor queue ready check
In-Reply-To: <20180611154647.32558-2-hch@lst.de>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-2-hch@lst.de>
Message-ID: <99751a08-8485-787f-95bc-862b8f9d02ed@broadcom.com>

Looking through this - I don't see anything wrong with the if_connect 
movement or the splitting of the if_ready into a 2 part implementation.

However, I disagree with the existing base, which added the DELETING 
state to the same logic block for NEW and CONNECTING, as the qlive state 
may not yet be accurate for the controller state, thus we're allowing io 
when we shouldn't be.

For example - as nvme_delete_ctrl() changes state, then scheduled 
delete_work, and as delete_work won't change the queue_live state, until 
ctrl->ops->delete_ctrl() is called, which isn't until after the 
nvme_stop_ctrl and nvme_remove_namespaces() is done.... there's a workq 
scheduling window where we allow lots more regular io through and it 
keeps going through even as we're stopping the controller.? that's live 
io that may need to finish (with no assist by the transport to 
stop/abort it) before the delete can take place.

Additionally, if a user-mode delete request is made while in the middle 
of a RECONNECT, and the io the if_ready is looking at is part of the 
reconnect - we're allowing the connect command to go out/complete even 
though we're in the middle of deleting it.?? May well be fine - but I 
don't know why we're letting all this io through simply because we 
didn't want to add a check for a property_set() on a reset or delete.

-- james


On 6/11/2018 8:46 AM, Christoph Hellwig wrote:
> Move the is_connected check to the fibre channel transport, as it has no
> meaning for other transports.  To facilitate this split out a new
> nvmf_fail_nonready_command helper that is called by the transport when
> it is asked to handle a command on a queue that is not ready.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/fabrics.c | 60 ++++++++++++++++---------------------
>   drivers/nvme/host/fabrics.h |  5 ++--
>   drivers/nvme/host/fc.c      |  9 +++---
>   drivers/nvme/host/rdma.c    |  7 ++---
>   drivers/nvme/target/loop.c  |  7 ++---
>   5 files changed, 39 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index fa32c1216409..72d290c71a1e 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -536,30 +536,35 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   	return NULL;
>   }
>   
> -blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
> -		bool queue_live, bool is_connected)
> +/*
> + * For something we're not in a state to send to the device the default action
> + * is to busy it and retry it after the controller state is recovered.  However,
> + * anything marked for failfast or nvme multipath is immediately failed.
> + *
> + * Note: commands used to initialize the controller will be marked for failfast.
> + * Note: nvme cli/ioctl commands are marked for failfast.
> + */
> +blk_status_t nvmf_fail_nonready_command(struct request *rq)
> +{
> +	if (!blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> +		return BLK_STS_RESOURCE;
> +	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
> +	return BLK_STS_IOERR;
> +}
> +EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
> +
> +bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
> +		bool queue_live)
>   {
>   	struct nvme_command *cmd = nvme_req(rq)->cmd;
>   
> -	if (likely(ctrl->state == NVME_CTRL_LIVE && is_connected))
> -		return BLK_STS_OK;
> +	if (likely(ctrl->state == NVME_CTRL_LIVE))
> +		return true;
>   
>   	switch (ctrl->state) {
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_CONNECTING:
>   	case NVME_CTRL_DELETING:
> -		/*
> -		 * This is the case of starting a new or deleting an association
> -		 * but connectivity was lost before it was fully created or torn
> -		 * down. We need to error the commands used to initialize the
> -		 * controller so the reconnect can go into a retry attempt.  The
> -		 * commands should all be marked REQ_FAILFAST_DRIVER, which will
> -		 * hit the reject path below. Anything else will be queued while
> -		 * the state settles.
> -		 */
> -		if (!is_connected)
> -			break;
> -
>   		/*
>   		 * If queue is live, allow only commands that are internally
>   		 * generated pass through.  These are commands on the admin
> @@ -567,7 +572,7 @@ blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   		 * ioctl admin cmds received while initializing.
>   		 */
>   		if (queue_live && !(nvme_req(rq)->flags & NVME_REQ_USERCMD))
> -			return BLK_STS_OK;
> +			return true;
