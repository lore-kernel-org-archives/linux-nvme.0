From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 11 Sep 2018 01:58:43 -0700
Subject: [REPOST][PATCH] nvme_fc: add 'nvme_discovery' sysfs attribute to
 fc transport device
In-Reply-To: <20180820220611.8769-1-jsmart2021@gmail.com>
References: <20180820220611.8769-1-jsmart2021@gmail.com>
Message-ID: <20180911085843.GA17520@infradead.org>

> +	unsigned long flags;
> +	struct nvme_fc_lport *lport;
> +	struct nvme_fc_rport *rport, *tmp_rport;
> +
> +	list_for_each_entry_safe(rport, tmp_rport,
> +				 lheadp, disc_list) {
> +		spin_lock_irqsave(&nvme_fc_lock, flags);
> +		list_del_init(&rport->disc_list);
> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +		lport = rport->lport;
> +		/* signal discovery. Won't hurt if it repeats */
> +		nvme_fc_signal_discovery_scan(lport, rport);
> +		nvme_fc_rport_put(rport);
> +		nvme_fc_lport_put(lport);
> +	}

This list iteration is not safe.  It should probably be something like:

	spin_lock_irqsave(&nvme_fc_lock, flags);
	while (!list_empty(disc_list)) {
		struct nvme_fc_rport *rport = list_entry(disc_list->next,
				struct nvme_fc_lport, disct_list);

		list_del_init(&rport->disc_list);
		spin_unlock_irqrestore(&nvme_fc_lock, flags);

		lport = rport->lport;
		/* signal discovery. Won't hurt if it repeats */
		nvme_fc_signal_discovery_scan(lport, rport);
		nvme_fc_rport_put(rport);
		nvme_fc_lport_put(lport);

		spin_lock_irqsave(&nvme_fc_lock, flags);
	}
	spin_unlock_irqrestore(&nvme_fc_lock, flags);


> +			if (!nvme_fc_lport_get(lport))
> +				continue;
> +			if (!nvme_fc_rport_get(rport)) {
> +				/*
> +				 * This is a temporary condition, so upon
> +				 * restart this node will be gone from the
> +				 * list.
> +				 */
> +				spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +				nvme_fc_lport_put(lport);
> +				nvme_fc_discovery_unwind(&nvme_fc_disc_list);
> +				if (failcnt++ < DISCOVERY_MAX_FAIL)
> +					goto restart;
> +				pr_err("nvme_discovery: too many reference "
> +				       "failures\n");
> +				return 0;
> +			}

Maybe use a goto for this condition to move it out of the loop?

> +	list_for_each_entry_safe(rport, tmp_rport,
> +				 &nvme_fc_disc_list, disc_list) {
> +		spin_lock_irqsave(&nvme_fc_lock, flags);
> +		list_del_init(&rport->disc_list);
> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +		lport = rport->lport;
> +		nvme_fc_signal_discovery_scan(lport, rport);
> +		nvme_fc_rport_put(rport);
> +		nvme_fc_lport_put(lport);
> +	}

Same locking issue as above.  And in fact exactly the same code, so
it should probably call nvme_fc_discovery_unwind.
