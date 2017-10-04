From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 4 Oct 2017 01:28:13 -0700
Subject: [PATCH v2 1/7] nvme core: allow controller RESETTING to
 RECONNECTING transition
In-Reply-To: <20170927045046.22238-2-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-2-jsmart2021@gmail.com>
Message-ID: <20171004082813.GA23467@infradead.org>

On Tue, Sep 26, 2017@09:50:40PM -0700, James Smart wrote:
> Allow controller state transition : RESETTING to RECONNECTING
> 
> Transport will typically transition from LIVE->RESETTING when
> initially performing a reset or recovering from an error. Adding
> this transition allows a transport to transition to RECONNECTING
> when it checks/waits for connectivity then creates new transport
> connections and reinits the controller.

Looks fine for now, although we really need to move to a common
state machine..

Reviewed-by: Christoph Hellwig <hch at lst.de>

> 
> -- james
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bb2aad078637..179ca6f79da3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -205,6 +205,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  	case NVME_CTRL_RECONNECTING:
>  		switch (old_state) {
>  		case NVME_CTRL_LIVE:
> +		case NVME_CTRL_RESETTING:
>  			changed = true;
>  			/* FALLTHRU */
>  		default:
> -- 
> 2.13.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
