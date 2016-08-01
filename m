From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 13:06:04 +0200
Subject: [PATCH 4/5] nvme-rdma: Remove duplicate call to
 nvme_remove_namespaces
In-Reply-To: <1469822242-3477-5-git-send-email-sagi@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-5-git-send-email-sagi@grimberg.me>
Message-ID: <20160801110604.GE16141@lst.de>

> -	nvme_remove_namespaces(&ctrl->ctrl);
> -	nvme_rdma_shutdown_ctrl(ctrl);
>  	nvme_uninit_ctrl(&ctrl->ctrl);
> +	nvme_rdma_shutdown_ctrl(ctrl);

How safe is the reordering here?  The description should explain why
it's fine.
