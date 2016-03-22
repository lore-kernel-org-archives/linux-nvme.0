From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Mar 2016 21:43:40 +0000
Subject: [PATCH] NVMe: Fix reset/remove race
In-Reply-To: <1458681956-27047-1-git-send-email-keith.busch@intel.com>
References: <1458681956-27047-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160322214339.GC4188@localhost.localdomain>

On Tue, Mar 22, 2016@03:25:56PM -0600, Keith Busch wrote:
>  	/*
> -	 * Shutdown immediately if controller times out while starting. The
> -	 * reset work will see the pci device disabled when it gets the forced
> -	 * cancellation error. All outstanding requests are completed on
> -	 * shutdown, so we return BLK_EH_HANDLED.
> +	 * Disable immediately if controller times out while starting or
> +	 * stopping. If resetting, the work will see the pci device disabled
> +	 * when it gets the forced cancellation error. All outstanding requests
> +	 * are completed on shutdown, so we return BLK_EH_HANDLED.
>  	 */
> -	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
> +	if (test_bit(NVME_CTRL_RESETTING, &dev->flags) ||
> +	    test_bit(NVME_CTRL_REMOVING, &dev->flags)) {
>  		dev_warn(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, disable controller\n",
>  			 req->tag, nvmeq->qid);

The portion above was not tested, and should not have been part in this
commit. Apologies for the churn, but will need to resend as it doesn't
appear correct.
