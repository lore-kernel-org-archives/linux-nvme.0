From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 14:11:35 +0200
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607073556.39050-5-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-5-hare@suse.de>
Message-ID: <20180607121135.GD11938@lst.de>

> +	ana_state = READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
>  	switch (nvme_req(req)->status & 0x7ff) {
>  	case NVME_SC_ANA_TRANSITION:
> -		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> -		if (!timer_pending(&ns->anatt_timer)) {
> -			ns->anatt_timer.expires =
> -				ns->ctrl->anatt * HZ + jiffies;
> -			add_timer(&ns->anatt_timer);
> +		if (ana_state != NVME_ANA_CHANGE) {
> +			nvme_update_ana_state(ns, NVME_ANA_CHANGE);
> +			ana_state_changed = true;

Needs an xchg operation to be atomic.

>  	case NVME_SC_ANA_PERSISTENT_LOSS:
> -		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
> +		if (ana_state != NVME_ANA_PERSISTENT_LOSS) {
> +			nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
> +			ana_state_changed = true;
> +		}
>  		break;
>  	case NVME_SC_ANA_INACCESSIBLE:
> -		nvme_update_ana_state(ns, NVME_ANA_INACCESSIBLE);
> +		if (ana_state != NVME_ANA_INACCESSIBLE) {
> +			nvme_update_ana_state(ns, NVME_ANA_INACCESSIBLE);
> +			ana_state_changed = true;
> +		}
>  		break;

We don't need to start the ANA timer for these states, it should
only happen for the CHANGE state.
