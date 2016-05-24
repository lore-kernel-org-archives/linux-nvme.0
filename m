From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 May 2016 11:02:55 -0400
Subject: [PATCH] NVMe: Sync reset and scan work
In-Reply-To: <1464101341-9986-1-git-send-email-keith.busch@intel.com>
References: <1464101341-9986-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160524150255.GH17208@localhost.localdomain>

On Tue, May 24, 2016@08:49:01AM -0600, Keith Busch wrote:
>  	spin_lock_irq(&ctrl->lock);
>  	switch (new_state) {
> +	case NVME_CTRL_SCHED_RESET:
> +		switch (old_state) {
> +		case NVME_CTRL_LIVE:
> +			changed = true;
> +			/* FALLTHRU */
> +		default:
> +			break;
> +		}

Uh, the new state needs to be added as changeable from the old state
going to NVME_CTRL_RESETTING. It's important to test the same code as the
emailed patch, and that would have been obvious nothing was happening...
