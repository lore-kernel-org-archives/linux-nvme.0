From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Oct 2018 16:16:51 -0600
Subject: [PATCH 04/16] nvme-core: Complain if nvme_init_identify() fails
In-Reply-To: <20181008212854.68310-5-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
 <20181008212854.68310-5-bvanassche@acm.org>
Message-ID: <20181008221650.GA5979@localhost.localdomain>

On Mon, Oct 08, 2018@02:28:42PM -0700, Bart Van Assche wrote:
> This patch avoids that Coverity complains that some but not all callers of
> nvme_init_identify() check the return value of that function. See also
> Coverity ID 1423964.

That seems like an odd thing to complain about. If we required the
return value be checked, we have the "__must_check" attribute. In this
particular path, we don't care if nvme_init_identify returns an error,
and the failure is logged in kernel messages within the function already.

Is there another way to suppress the complaint?

> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3746fe49c382..2ce3e9d15618 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1213,7 +1213,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
>  	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
>  		nvme_unfreeze(ctrl);
>  	if (effects & NVME_CMD_EFFECTS_CCC)
> -		nvme_init_identify(ctrl);
> +		WARN_ON_ONCE(nvme_init_identify(ctrl) < 0);
>  	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
>  		nvme_queue_scan(ctrl);
>  }
