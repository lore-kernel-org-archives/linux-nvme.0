From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Jun 2017 00:48:10 -0700
Subject: [PATCH] nvme_fc: fix confused queue size handling
In-Reply-To: <20170602055351.2750-1-jsmart2021@gmail.com>
References: <20170602055351.2750-1-jsmart2021@gmail.com>
Message-ID: <20170602074810.GC11424@infradead.org>

On Thu, Jun 01, 2017@10:53:51PM -0700, James Smart wrote:
> The code gets confused whether to use queue_size (the 1's) value
> or the ctrl.sqsize (the 0's value) in places.
> 
> In init_io_queues - should use the 1's value.
> if queue size reduced due to MQES or MAXCMD, need to reduce both
> queue_size and ctrl.sqsize.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 5b14cbefb724..f24c2c670618 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1681,7 +1681,7 @@ nvme_fc_init_io_queues(struct nvme_fc_ctrl *ctrl)
>  	int i;
>  
>  	for (i = 1; i < ctrl->queue_count; i++)
> -		nvme_fc_init_queue(ctrl, i, ctrl->ctrl.sqsize);
> +		nvme_fc_init_queue(ctrl, i, ctrl->ctrl.opts->queue_size);
>  }
>  
>  static void
> @@ -2336,8 +2336,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  		goto out_disconnect_admin_queue;
>  	}
>  
> -	ctrl->ctrl.sqsize =
> -		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
> +	if (NVME_CAP_MQES(ctrl->cap) < ctrl->ctrl.sqsize) {
> +		ctrl->ctrl.sqsize = NVME_CAP_MQES(ctrl->cap);
> +		opts->queue_size = ctrl->ctrl.sqsize + 1;
> +	}

I already asked Sagi when he fixed the previous issues in this
area, but I guess I need to get more serious about it:
Please move this to common code instead of having it in the transport
drivers.
