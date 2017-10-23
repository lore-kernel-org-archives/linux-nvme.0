From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Oct 2017 16:26:37 +0200
Subject: [PATCH 1/1] nvme-rdma: align nvme_rdma_device structure
In-Reply-To: <1508752767-22939-1-git-send-email-maxg@mellanox.com>
References: <1508752767-22939-1-git-send-email-maxg@mellanox.com>
Message-ID: <20171023142637.GB25316@lst.de>

On Mon, Oct 23, 2017@12:59:27PM +0300, Max Gurtovoy wrote:
>  struct nvme_rdma_device {
> -	struct ib_device       *dev;
> -	struct ib_pd	       *pd;
> +	struct ib_device	*dev;
> +	struct ib_pd		*pd;

Looks fine, I'll queue it up for 4.15.
