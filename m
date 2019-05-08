From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Wed, 8 May 2019 16:37:13 -0700
Subject: [RFC PATCH] nvme: guard ctrl->state by lock
In-Reply-To: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>
References: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>
Message-ID: <57d2800d-adf4-665e-fd8d-a27282188d0b@linux.microsoft.com>

On 5/8/19 2:41 PM, Chaitanya Kulkarni wrote:
> This patch adds a helper function to check the nvme_ctrl state.
> This helper function uses controller lock when accessing ctrl->state
> member which is guarded in the nvme_change_ctrl_state().
> 
> This RFC is light on the details, if this change is acceptable I'd
> like to send the detailed tested version.


I'm not sure I see that this presents any functional change. Is it your
intent to ensure that ctrl->state always has a legal value, and can that be
done by a range check in nvme_change_ctrl_state()?


> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   drivers/nvme/host/core.c      | 80 ++++++++++++++++++++++++++++-------
>   drivers/nvme/host/fabrics.c   |  4 +-
>   drivers/nvme/host/fabrics.h   |  8 ++--
>   drivers/nvme/host/multipath.c |  6 +--
>   drivers/nvme/host/nvme.h      |  1 +
>   5 files changed, 74 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index afd303489473..5182ce9fe21b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -94,6 +94,57 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   					   unsigned nsid);
>   
> +inline bool nvme_validate_ctrl_state(enum nvme_ctrl_state s)
> +{
> +	int ret;

type bool?

> +
> +	switch (s) {
> +	case NVME_CTRL_NEW:
> +		ret = true;
> +		break;
> +	case NVME_CTR_LIVE:
> +		ret = true;
> +		break;
> +	case NVME_CTRL_ADMIN_ONLY:
> +		ret = true;
> +		break;
> +	case NVME_CTRL_RESETTING:
> +		ret = true;
> +		break;
> +	case NVME_CTRL_CONNECTING:
> +		ret = true;
> +		break;
> +	case NVME_CTRL_DELETING:
> +		ret = true;
> +		break;
> +	case NVME_CTRL_DEAD:
> +		break;

missing ret = assignment.

Also, the above cases could all be flattened, i.e.:

	case NVME_CTRL_NEW:
	case NVME_CTR_LIVE:
	case NVME_CTRL_ADMIN_ONLY:
	case NVME_CTRL_RESETTING:
	case NVME_CTRL_CONNECTING:
	case NVME_CTRL_DELETING:
	case NVME_CTRL_DEAD:
		ret = true;
		break;
	

> +	default:
> +		ret = false;
> +	}
> +	return ret;
> +}
> +
> +bool nvme_check_ctrl_state(struct nvme_ctrl *c, enum nvme_ctrl_state state)
> +{
> +	bool ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->lock, flags);
> +
> +	if (!nvme_validate_ctrl_state(state)) {
> +		ret = false;
> +		goto out_unlock;
> +	}

Seems simpler just to open code nvme_validate_ctrl_state() here.

Thanks,
Ed

> +
> +	ret = c->state == state ? true : false;
> +
> +out_unlock:
> +	spin_unlock_irqrestore(&c->lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_check_ctrl_state);
> +
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
>   	/*
