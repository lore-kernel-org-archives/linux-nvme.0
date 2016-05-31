From: keith.busch@intel.com (Keith Busch)
Date: Tue, 31 May 2016 17:31:18 -0400
Subject: [PATCH v2] NVMe: Add controller state for scheduling resets
In-Reply-To: <1464729484-14424-1-git-send-email-keith.busch@intel.com>
References: <1464729484-14424-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160531213118.GF24107@localhost.localdomain>

On Tue, May 31, 2016@03:18:04PM -0600, Keith Busch wrote:
>  	/* Skip controllers under certain specific conditions. */
>  	if (nvme_should_reset(dev, csts)) {
> -		if (queue_work(nvme_workq, &dev->reset_work))
> +		if (nvme_reset_ctrl(&dev->ctrl))
>  			dev_warn(dev->dev,
>  				"Failed status: 0x%x, reset controller.\n",
>  				csts);

err, that condition should be !nvme_reset_ctrl since it returns 0 on
success rather than the status of queue_work. It still does correctly
resets the controller, but we miss the very useful warning message. Let
me send a v3...
