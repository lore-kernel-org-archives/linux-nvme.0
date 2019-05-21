From: hch@lst.de (Christoph Hellwig)
Date: Tue, 21 May 2019 08:46:07 +0200
Subject: [PATCH 1/4] nvme: separate out nvme_ctrl_state_name()
In-Reply-To: <20190520063624.50338-2-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-2-hare@suse.de>
Message-ID: <20190521064607.GB30402@lst.de>

> +const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
> +{
> +	if ((unsigned)ctrl->state < ARRAY_SIZE(nvme_ctrl_state_names) &&

Can we please drop this odd cast, even if it was there in the old code?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
