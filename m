From: hch@lst.de (Christoph Hellwig)
Date: Thu, 2 Nov 2017 20:39:26 +0100
Subject: [PATCH 1/2] nvme: Factor get log into a helper
In-Reply-To: <20171101180400.6619-1-keith.busch@intel.com>
References: <20171101180400.6619-1-keith.busch@intel.com>
Message-ID: <20171102193926.GA5270@lst.de>

> +static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log,
> +								size_t size)

The argument alignmnet here looks a little odd, but we can fix that
up on the go.

Except for that this looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
