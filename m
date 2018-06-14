From: james.smart@broadcom.com (James Smart)
Date: Thu, 14 Jun 2018 10:37:01 -0700
Subject: [PATCH 3/3] nvme-fabrics: fix and refine state checks in
 __nvmf_check_ready
In-Reply-To: <20180614122215.4395-4-hch@lst.de>
References: <20180614122215.4395-1-hch@lst.de>
 <20180614122215.4395-4-hch@lst.de>
Message-ID: <2185be0b-7936-3b3f-2659-d6634336f907@broadcom.com>

On 6/14/2018 5:22 AM, Christoph Hellwig wrote:
>   - make sure we only allow internally generates commands in any non-live
>     state
>   - only allow connect commands on non-live queues when actually in the
>     new or connecting states
>   - treat all other non-live, non-dead states the same as a default
>     cach-all
>
> This fixes a regression where we could not shutdown a controller
> orderly as we didn't allow the internal generated Property Set
> command, and also ensures we don't accidentally let a Connect command
> through in the wrong state.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/fabrics.c | 39 ++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 6b4e253b9347..903eb4545e26 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -556,34 +556,33 @@ EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>   bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   		bool queue_live)
>   {
> -	struct nvme_command *cmd = nvme_req(rq)->cmd;
> +	struct nvme_request *req = nvme_req(rq);
>   
> +	/*
> +	 * If we are in some state of setup or teardown only allow
> +	 * internally generated commands.
> +	 */
> +	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
> +		return false;
> +
> +	/*
> +	 * Only allow commands on a live queue, except for the connect command,
> +	 * which is require to set the queue live in the appropinquate states.
> +	 */
>   	switch (ctrl->state) {
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_CONNECTING:
> -	case NVME_CTRL_DELETING:
> -		/*
> -		 * If queue is live, allow only commands that are internally
> -		 * generated pass through.  These are commands on the admin
> -		 * queue to initialize the controller. This will reject any
> -		 * ioctl admin cmds received while initializing.
> -		 */
> -		if (queue_live && !(nvme_req(rq)->flags & NVME_REQ_USERCMD))
> +		if (req->cmd->common.opcode == nvme_fabrics_command &&
> +		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
>   			return true;
> -
> -		/*
> -		 * If the queue is not live, allow only a connect command.  This
> -		 * will reject any ioctl admin cmd as well as initialization
> -		 * commands if the controller reverted the queue to non-live.
> -		 */
> -		if (!queue_live && blk_rq_is_passthrough(rq) &&
> -		     cmd->common.opcode == nvme_fabrics_command &&
> -		     cmd->fabrics.fctype == nvme_fabrics_type_connect)
> -			return true;
> -		return false;
> +		break;
>   	default:
> +		break;
> +	case NVME_CTRL_DEAD:
>   		return false;
>   	}
> +
> +	return queue_live;
>   }
>   EXPORT_SYMBOL_GPL(__nvmf_check_ready);
>   

I like what's here and think it's pretty conclusive. Enough that I'm 
good with a Reviewed-by for me to be added.

In thinking this through: There's still the issue of queue_live being 
set true when in a RESETTING/DELETING state as the workqueue element to 
enact the reset/delete has yet to be run or is just starting to run. 
Since above restricts it to kernel-generated commands only, the only 
things that should get through in this case are:
1) a property_set command to write CC.NE=0 is issued by the transport 
reset/delete handler. Note: it's unclear whether the queue will be live 
or not.
2) controller was in a NEW/CONNECTING state and was sending a command 
used to init the controller.
3) a keep alive

(1) is desired behavior, assuming queue is live to let it through.
(2) and (3) - I assume the transport reset/delete handler will freeze 
the queues, cycle through any outstanding command and will terminate 
them. So it should be ok. I assume, based on the time needed to freeze 
the queues, that there shouldn't be a possibility for the delete/reset 
handler queue freeze code to race with an io allowed by the checks (it 
should be long gone).?? If there's not agreement on that assumption, 
then a clause should be added after the switch case that checks for 
RESETTING or DELETING and if so, only allows a Property_Set for CC.EN=0 
command.

-- james
