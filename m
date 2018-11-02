From: hare@suse.de (Hannes Reinecke)
Date: Fri, 2 Nov 2018 09:04:53 +0100
Subject: [PATCH v2 2/4] nvmet: support for traffic based keep-alive
In-Reply-To: <20181030174344.20171-3-sagi@grimberg.me>
References: <20181030174344.20171-1-sagi@grimberg.me>
 <20181030174344.20171-3-sagi@grimberg.me>
Message-ID: <d1585e6f-56f7-581e-039d-372a29a5cd99@suse.de>

On 10/30/18 6:43 PM, Sagi Grimberg wrote:
> A controller that supports traffic based keep-alive can restart
> its keep alive timer even if keep-alive was not issued in the
> kato period but other admin or io commands was. For each command
> set ctrl->cmd_seen to true, and when keep-alive timer expires,
> if any commands were seen, resched ka_work instead of escalating
> to a fatal error.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/admin-cmd.c |  3 ++-
>   drivers/nvme/target/core.c      | 12 ++++++++++++
>   drivers/nvme/target/nvmet.h     |  2 ++
>   include/linux/nvme.h            |  1 +
>   4 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 30778ffc46f5..c9c6d25a3ec2 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -304,7 +304,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   
>   	/* XXX: figure out what to do about RTD3R/RTD3 */
>   	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
> -	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT);
> +	id->ctratt = cpu_to_le32(NVME_CTRL_ATTR_HID_128_BIT |
> +		NVME_CTRL_ATTR_TBKAS);
>   
>   	id->oacs = 0;
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 0acdff9e6842..ebe951a05712 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -298,6 +298,15 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
>   {
>   	struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
>   			struct nvmet_ctrl, ka_work);
> +	bool cmd_seen = ctrl->cmd_seen;
> +
> +	ctrl->cmd_seen = false;
> +	if (cmd_seen) {
> +		pr_debug("ctrl %d traffic-based keep-alive timer expired, reschedule\n",
> +			ctrl->cntlid);
> +		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
> +		return;
> +	}
>   
>   	pr_err("ctrl %d keep-alive timer (%d seconds) expired!\n",
>   		ctrl->cntlid, ctrl->kato);

Please rephrase that. For TBKA 'expired' means that everything is 
working, whereas for all other cases 'expired' signals an error.

Maybe just 'reschedule traffic-based keep-alive timer' ?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
