From: hch@lst.de (Christoph Hellwig)
Date: Sat, 19 Jan 2019 14:36:01 +0100
Subject: [PATCH v2] nvme-rdma: fix timeout handler
In-Reply-To: <20190108085734.9681-1-sagi@grimberg.me>
References: <20190108085734.9681-1-sagi@grimberg.me>
Message-ID: <20190119133601.GA24763@lst.de>

> +	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
> +		/*
> +		 * teardown immediately if controller times out while starting
> +		 * or we are already started error recovery. all outstanding
> +		 * requests are completed on shutdown, so we return BLK_EH_DONE.

Nitpick: please start sentences with upper case letters.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
