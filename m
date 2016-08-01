From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 13:15:30 +0200
Subject: [PATCH v3] nvmet-rdma: Correctly handle RDMA device hot removal
In-Reply-To: <1469967347-20466-1-git-send-email-sagi@grimberg.me>
References: <1469967347-20466-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160801111530.GB16474@lst.de>

This looks reasonable to me, but a little question below:

> @@ -1442,7 +1491,8 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
>  {
>  	struct rdma_cm_id *cm_id = port->priv;
>  
> -	rdma_destroy_id(cm_id);
> +	if (cm_id)
> +		rdma_destroy_id(cm_id);
>  }

How is ->remove_port synchronized vs the RDMA/CM even handler?
