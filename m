From: hare@suse.de (Hannes Reinecke)
Date: Tue, 2 Oct 2018 16:08:37 +0200
Subject: [PATCH rfc 4/4] nvme: Ask for fabrics SQ flow control disable by
 default
In-Reply-To: <20181002001422.9111-5-sagi@grimberg.me>
References: <20181002001422.9111-1-sagi@grimberg.me>
 <20181002001422.9111-5-sagi@grimberg.me>
Message-ID: <5adcc26b-a82c-31e9-5e95-55adeb40f9c0@suse.de>

On 10/2/18 2:14 AM, Sagi Grimberg wrote:
> As for now, we don't care about sq_head pointer updates anyway, so
> at least allow the controller to micro-optimize by omiting this update.
> 
> Note that we will probably need to support it when a controller
> that requires this comes along.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 38cf9d371953..ce61c3e1c22b 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -392,6 +392,9 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   	cmd.connect.kato = ctrl->opts->discovery_nqn ? 0 :
>   		cpu_to_le32((ctrl->kato + NVME_KATO_GRACE) * 1000);
>   
> +	/* Ask to disable SQ head pointer updates */
> +	cmd.connect.cattr |= NVME_CONNECT_SQ_FC_DISABLED;
> +
>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
> @@ -451,6 +454,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>   	cmd.connect.qid = cpu_to_le16(qid);
>   	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
>   
> +	/* Ask to disable SQ head pointer updates */
> +	cmd.connect.cattr |= NVME_CONNECT_SQ_FC_DISABLED;
> +
>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
> 
There are two issues with that:
- as the bit was reserved initially any target is free to reject the 
connect command on the grounds that some undefined bits are set.
- As per SQ flow control specification any target might _legitimately_ 
reject the connect command, namely if the target doesn't allow to 
disable SQ flow control. With this change we would never be able to 
connect to these targets.

Hence I would prefer to have an option '--disable-sqflow' for the 'nvme 
connect' command, allowing us to manually disable SQ Flow control.
That would not modify existing behaviour, and we can properly support 
arrays requiring SQ flow control.

Cheers,

Hannes
