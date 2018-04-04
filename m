From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 16:42:08 +0300
Subject: [PATCH v3] nvme: expand nvmf_check_if_ready checks
In-Reply-To: <20180328202102.9267-1-jsmart2021@gmail.com>
References: <20180328202102.9267-1-jsmart2021@gmail.com>
Message-ID: <a8d6de5d-5487-8f60-50af-eecb7b885aae@grimberg.me>



On 03/28/2018 11:21 PM, James Smart wrote:
> The nvmf_check_if_ready() checks that were added are very simplistic.
> As such, the routine allows a lot of cases to fail ios during windows
> of reset or re-connection. In cases where there are not multi-path
> options present, the error goes back to the callee - the filesystem
> or application. Not good.
> 
> The common routine was rewritten and calling syntax slightly expanded
> so that per-transport is_ready routines don't need to be present.
> The transports now call the routine directly. The routine is now a
> fabrics routine rather than an inline function.
> 
> The routine now looks at controller state to decide the action to
> take. Some states mandate io failure. Others define the condition where
> a command can be accepted.  When the decision is unclear, a generic
> queue-or-reject check is made to look for failfast or multipath ios and
> only fails the io if it is so marked. Otherwise, the io will be queued
> and wait for the controller state to resolve.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v2:
>    needed to set nvme status when rejecting io
> v3:
>    renamed qlive to queue_live and connectivity to is_connected
>    converted from inline routine to fabrics exported routine.
> ---
>   drivers/nvme/host/fabrics.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h | 33 ++------------------
>   drivers/nvme/host/fc.c      | 12 ++-----
>   drivers/nvme/host/rdma.c    | 14 ++-------
>   drivers/nvme/target/loop.c  | 11 ++-----
>   5 files changed, 85 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index a1c58e35075e..73ac41f93ae0 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -536,6 +536,82 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   	return NULL;
>   }
>   
> +blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
> +		bool queue_live, bool is_connected)
> +{
> +	struct nvme_command *cmd = nvme_req(rq)->cmd;
> +
> +	if (ctrl->state == NVME_CTRL_LIVE && is_connected)
> +		return BLK_STS_OK;

Nit: would be nice to have a likely statement here as its the hot
path. Other than that, looks good,

Reviewed-by: Sagi Grimberg <sagi at grmberg.me>
