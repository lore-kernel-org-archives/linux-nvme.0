From: hch@lst.de (Christoph Hellwig)
Date: Sat, 19 Jan 2019 14:36:46 +0100
Subject: [PATCH] nvme-tcp: fix timeout handler
In-Reply-To: <20190108090942.11752-1-sagi@grimberg.me>
References: <20190108090942.11752-1-sagi@grimberg.me>
Message-ID: <20190119133646.GC24763@lst.de>

> +		/*
> +		 * teardown immediately if controller times out while starting
> +		 * or we are already started error recovery. all outstanding
> +		 * requests are completed on shutdown, so we return BLK_EH_DONE.
> +		 */

Same grammar nitpick as for rdma.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
