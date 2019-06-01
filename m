From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Jun 2019 11:08:09 +0200
Subject: [PATCH 2/3] nvme: rearm fw notification in admin only state
In-Reply-To: <20190524202036.17265-3-keith.busch@intel.com>
References: <20190524202036.17265-1-keith.busch@intel.com>
 <20190524202036.17265-3-keith.busch@intel.com>
Message-ID: <20190601090809.GH6453@lst.de>

On Fri, May 24, 2019@02:20:35PM -0600, Keith Busch wrote:
> +	if (ctrl->state != NVME_CTRL_LIVE &&
> +	    ctrl->state != NVME_CTRL_ADMIN_ONLY)

I think we really

 a) need a nvme_ctrl_is_live() helper encapsulating the above
 b) audit all checks for NVME_CTRL_LIVE if they really need to use
    this helper instead.
