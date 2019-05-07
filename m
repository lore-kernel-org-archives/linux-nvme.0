From: kbusch@kernel.org (Keith Busch)
Date: Tue, 7 May 2019 08:21:17 -0600
Subject: [PATCH] nvme-pci: mark expected switch fall-through
In-Reply-To: <20190507142300.GA25717@embeddedor>
References: <20190507142300.GA25717@embeddedor>
Message-ID: <20190507142117.GE2219@localhost.localdomain>

On Tue, May 07, 2019@09:23:00AM -0500, Gustavo A. R. Silva wrote:
> @@ -1296,6 +1296,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	switch (dev->ctrl.state) {
>  	case NVME_CTRL_DELETING:
>  		shutdown = true;
> +		/* fall through */
>  	case NVME_CTRL_CONNECTING:
>  	case NVME_CTRL_RESETTING:
>  		dev_warn_ratelimited(dev->ctrl.device,

Thanks, Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
