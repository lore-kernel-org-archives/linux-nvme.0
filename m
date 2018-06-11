From: james.smart@broadcom.com (James Smart)
Date: Mon, 11 Jun 2018 15:56:55 -0700
Subject: [PATCH] nvme-fabrics: allow internal passthrough command on
 deleting controllers
In-Reply-To: <20180530061116.23610-1-hch@lst.de>
References: <20180530061116.23610-1-hch@lst.de>
Message-ID: <77f6bd7f-d393-e1be-3ad9-73b01362217e@broadcom.com>

I know you have already committed this patch, However I'd like to pass 
on my comments - as I disagree with at least 1 section in this patch.

Please keep in mind that most of the "core" paths currently change 
controller state then schedule a workq item do to the real work (see 
nvme_reset_ctrl() and nvme_delete_ctrl()). It's the workq item that ends 
up changing queue states and stopping queues.? So there's a sizeable 
window where new io may be arriving, on a queue that is "live", that 
doesn't jive with the controller state.


On 5/29/2018 11:11 PM, Christoph Hellwig wrote:
> Without this we can't cleanly shut down.
>
> Based on analysis an an earlier patch from Hannes Reinecke.
>
> Fixes: bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
> Reported-by: Hannes Reinecke <hare at suse.de>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: James Smart <james.smart at broadcom.com>
> ---
>
> Note: Pending full testing on FC by James..
>
>
>   drivers/nvme/host/fabrics.c | 79 +++++++++++++++----------------------
>   1 file changed, 31 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index aa318136460e..5f5f7067c41d 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -545,71 +545,54 @@ blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   		return BLK_STS_OK;
>   
>   	switch (ctrl->state) {
> -	case NVME_CTRL_DELETING:
> -		goto reject_io;
> -
>   	case NVME_CTRL_NEW:
>   	case NVME_CTRL_CONNECTING:
> +	case NVME_CTRL_DELETING:
> +		/*
> +		 * This is the case of starting a new or deleting an association
> +		 * but connectivity was lost before it was fully created or torn
> +		 * down. We need to error the commands used to initialize the
> +		 * controller so the reconnect can go into a retry attempt.  The
> +		 * commands should all be marked REQ_FAILFAST_DRIVER, which will
> +		 * hit the reject path below. Anything else will be queued while
> +		 * the state settles.
> +		 */
Well - my preference, if you are deleting, is to fail any new requests.? 
I agree with the property_set() to write EN=0, and as such, see that as 
valid exception. I don't like the idea of lumping this with other states 
that may allow the io to still go out on the wire and prologing 
(hopefully not confusing) the deletion.


On a different note - odd you kept my Reviewed-by when it was for a very 
different patch.?? My review was very specific to the prop_get/set while 
in the deleting state. That is not what is here now.


>   		if (!is_connected)
> -			/*
> -			 * This is the case of starting a new
> -			 * association but connectivity was lost
> -			 * before it was fully created. We need to
> -			 * error the commands used to initialize the
> -			 * controller so the reconnect can go into a
> -			 * retry attempt. The commands should all be
> -			 * marked REQ_FAILFAST_DRIVER, which will hit
> -			 * the reject path below. Anything else will
> -			 * be queued while the state settles.
> -			 */
> -			goto reject_or_queue_io;

By removing this, on FC, you are now allowing commands to pass through 
to a device that no longer exists - whether they be request part of 
reconnecting/reinitializing a controller or io requests. Yes, FC can 
augment these checks with its own - but a little surprised you are 
against adding this. I can't believe there won't eventually be 
transports besides FC that know a device's presence, but ok.


> -
> -		if ((queue_live &&
> -		     !(nvme_req(rq)->flags & NVME_REQ_USERCMD)) ||
> -		    (!queue_live && blk_rq_is_passthrough(rq) &&
> -		     cmd->common.opcode == nvme_fabrics_command &&
> -		     cmd->fabrics.fctype == nvme_fabrics_type_connect))
> -			/*
> -			 * If queue is live, allow only commands that
> -			 * are internally generated pass through. These
> -			 * are commands on the admin queue to initialize
> -			 * the controller. This will reject any ioctl
> -			 * admin cmds received while initializing.
> -			 *
> -			 * If the queue is not live, allow only a
> -			 * connect command. This will reject any ioctl
> -			 * admin cmd as well as initialization commands
> -			 * if the controller reverted the queue to non-live.
> -			 */
> +			break;
> +
> +		/*
> +		 * If queue is live, allow only commands that are internally
> +		 * generated pass through.  These are commands on the admin
> +		 * queue to initialize the controller. This will reject any
> +		 * ioctl admin cmds received while initializing.
> +		 */
> +		if (queue_live && !(nvme_req(rq)->flags & NVME_REQ_USERCMD))
>   			return BLK_STS_OK;

This is where I disagree.

Now all new read/write block/fs io, received while the workq item is 
being scheduled, will be allowed and passed on to the transport to be 
put out on the wire. If nothing else, It increases the load (and thus 
time) that has to be failed/recovered/deleted.? Prior code would have 
either rejected them (if deleting), or classified them to determine if 
they should be busied or not.

>   
>   		/*
> -		 * fall-thru to the reject_or_queue_io clause
> +		 * If the queue is not live, allow only a connect command.  This
> +		 * will reject any ioctl admin cmd as well as initialization
> +		 * commands if the controller reverted the queue to non-live.
>   		 */
> +		if (!queue_live && blk_rq_is_passthrough(rq) &&
> +		     cmd->common.opcode == nvme_fabrics_command &&
> +		     cmd->fabrics.fctype == nvme_fabrics_type_connect)
> +			return BLK_STS_OK;

ok.


>   		break;
> -
> -	/* these cases fall-thru
> -	 * case NVME_CTRL_LIVE:
> -	 * case NVME_CTRL_RESETTING:
> -	 */
no biggie - but I like comments that provide clarity, especially if more 
states are added in the future.

>   	default:
>   		break;
>   	}
>   
> -reject_or_queue_io:
>   	/*
> -	 * Any other new io is something we're not in a state to send
> -	 * to the device. Default action is to busy it and retry it
> -	 * after the controller state is recovered. However, anything
> -	 * marked for failfast or nvme multipath is immediately failed.
> -	 * Note: commands used to initialize the controller will be
> -	 *  marked for failfast.
> +	 * Any other new io is something we're not in a state to send to the
> +	 * device.  Default action is to busy it and retry it after the
> +	 * controller state is recovered. However, anything marked for failfast
> +	 * or nvme multipath is immediately failed.  Note: commands used to
> +	 * initialize the controller will be marked for failfast.
>   	 * Note: nvme cli/ioctl commands are marked for failfast.
>   	 */
>   	if (!blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> -
> -reject_io:
>   	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
>   	return BLK_STS_IOERR;
>   }

this is fine.
