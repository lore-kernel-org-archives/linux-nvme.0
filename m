From: james.smart@broadcom.com (James Smart)
Date: Tue, 18 Sep 2018 12:43:30 -0700
Subject: [PATCH] nvme-fabrics -in case of REQ_NVME_MPATH we should return
 BLK_STS_RESOURCE
In-Reply-To: <20180918190834.GA26013@localhost.localdomain>
References: <CY4PR17MB1368DE7C1E52DF30E17060BBE61D0@CY4PR17MB1368.namprd17.prod.outlook.com>
 <20180918162526.GA5038@lst.de>
 <2866a0d5-9864-a2fd-572b-6e6f2c581de5@broadcom.com>
 <20180918190834.GA26013@localhost.localdomain>
Message-ID: <19b26262-686c-c778-7e01-488917537636@broadcom.com>



On 9/18/2018 12:08 PM, Keith Busch wrote:
> On Tue, Sep 18, 2018@11:37:50AM -0700, James Smart wrote:
>> On 9/18/2018 9:25 AM, hch@lst.de wrote:
>>> Can you resend this with a proper signoff so that we can apply it?
>>>
>>> While you're at it please also make sure you have a line break after
>>> 73 chars for the commit message.
>> where is this patch ? I can't find it on the reflector.
> The list rejected the message because it was not sent in plain text.
> This was the attachment:
>
> ---
> --- a/drivers/nvme/host/fabrics.c	2018-09-18 02:14:25.590722134 -0700
> +++ b/drivers/nvme/host/fabrics.c	2018-09-18 03:18:11.663131011 -0700
> @@ -539,8 +539,13 @@ static struct nvmf_transport_ops *nvmf_l
>   /*
>    * For something we're not in a state to send to the device the default action
>    * is to busy it and retry it after the controller state is recovered.  However,
> - * if the controller is deleting or if anything is marked for failfast or
> - * nvme multipath it is immediately failed.
> + * if the controller is deleting or if anything is marked for failfast.
> + * It may happen that just after choosing current path in case of multipath
> + * controller state can go into resetting/connecting either from keep_alive
> + * timeout or IO failure followed by failover. So there can be a race like
> + * when path was selected ctrl state was LIVE but while queue_check is done
> + * in rdma.c ctrl state was changed to resetting/connecting. We have to retry the
> + * same IO from different path and it will succeed.
>    *
>    * Note: commands used to initialize the controller will be marked for failfast.
>    * Note: nvme cli/ioctl commands are marked for failfast.
> @@ -550,7 +555,7 @@ blk_status_t nvmf_fail_nonready_command(
>   {
>   	if (ctrl->state != NVME_CTRL_DELETING &&
>   	    ctrl->state != NVME_CTRL_DEAD &&
> -	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> +	    !blk_noretry_request(rq))
>   		return BLK_STS_RESOURCE;
>   	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
>   	return BLK_STS_IOERR;
> --

ok - so this was what i thought it was - and we've hit this on FC as 
well. However, I don't believe it should be solved this way.? I believe 
we do want it to return error, as it does now, so blk_mq will 
release/fail it back to the caller, which should be the multipather, so 
it can move it over to a different path - the whole point of "fast 
failover".

The issue that I believe exists is that the multipath driver/core knows 
how to retry on a different path when the request is accepted then the 
nvme_complete_rq() is called. But it doesn't know how to retry on a 
different path when the initial transport:queue_rq() fails - the io ends 
up failing completely.?? I think we need to fix that code path, not 
"busy" requeue the mpath io.

-- james
