From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 16:22:05 +0200
Subject: [PATCHv2] nvme: ANA transition timeout handling
In-Reply-To: <20180608121320.74149-1-hare@suse.de>
References: <20180608121320.74149-1-hare@suse.de>
Message-ID: <20180611142205.GA13515@lst.de>

> +			/*
> +			 * Use timer_reduce() to ensure we're not modifying
> +			 * an already running timer.
> +			 */
> +			timer_reduce(&grp->anatt_timer,
> +				     ns->ctrl->anatt * HZ + jiffies);

That's a bit of a gross hack for a timer that never is actually
reduced, just added.

> +		if (ctrl->state == NVME_CTRL_LIVE && state == NVME_ANA_CHANGE)
> +			timer_reduce(&grp->anatt_timer,
> +				     ctrl->anatt * HZ + jiffies);
> +		else
> +			del_timer(&grp->anatt_timer);


> +	for (grpid = 0; grpid < ctrl->anagrpmax; grpid++) {
> +		struct nvme_ana_group *grp = &ctrl->ana_groups[grpid];
> +
> +		del_timer(&grp->anatt_timer);

Without del_timer_sync you are going to create use after free
conditions.


Anyway, v4 of the ANA series I've just sent contains simple ANATT
handling based on a per-controller timer, which should be sufficient
to catch the intent behind ANATT.  Comments welcome.
