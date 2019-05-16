From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 13:05:42 -0600
Subject: [PATCH 4/4] nvme: release namespace SRCU protection before
 performing controller ioctls
In-Reply-To: <20190516185036.17394-4-hch@lst.de>
References: <20190516185036.17394-1-hch@lst.de>
 <20190516185036.17394-4-hch@lst.de>
Message-ID: <20190516190542.GD23669@localhost.localdomain>

On Thu, May 16, 2019@08:50:36PM +0200, Christoph Hellwig wrote:
> +		if (cmd == NVME_IOCTL_ADMIN_CMD)
> +			ret = nvme_user_cmd(ctrl, NULL, argp);
> +		else
> +			ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
> +
> +		nvme_get_ctrl(ctrl);

nvme_put_ctrl(ctrl);
