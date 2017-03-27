From: keith.busch@intel.com (Keith Busch)
Date: Mon, 27 Mar 2017 10:43:39 -0400
Subject: [PATCH v5 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <1490329423-17152-1-git-send-email-helen.koike@collabora.com>
References: <20170317222843.GD13709@localhost.localdomain>
 <1490329423-17152-1-git-send-email-helen.koike@collabora.com>
Message-ID: <20170327144338.GA29463@localhost.localdomain>

On Fri, Mar 24, 2017@01:23:43AM -0300, Helen Koike wrote:
> +	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
> +		result = nvme_dbbuf_dma_alloc(dev);
> +		if (result)
> +			goto out;
> +	}

We are still functional without enabling this feature, so I don't think
we should error out. Just log a warning that it's less than optimal.
