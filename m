From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 7 Nov 2017 11:25:28 -0800
Subject: [PATCH 1/1] nvme/fc: add 'discovery' sysfs attribute to fc
 transport device
In-Reply-To: <1509722369-95879-2-git-send-email-hare@suse.de>
References: <1509722369-95879-1-git-send-email-hare@suse.de>
 <1509722369-95879-2-git-send-email-hare@suse.de>
Message-ID: <20171107192528.GC13618@infradead.org>

> +	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
> +		list_for_each_entry_safe(rport, tmp_rport,
> +					 &lport->endp_list, endp_list) {
> +			if (!nvme_fc_rport_get(rport))
> +				continue;
> +			spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +			nvme_fc_signal_discovery_scan(lport, rport);
> +			nvme_fc_rport_put(rport);
> +			spin_lock_irqsave(&nvme_fc_lock, flags);
> +		}
> +	}
> +	spin_unlock_irqrestore(&nvme_fc_lock, flags);

What guarantees the list next pointers are still valid after
you dropped nvme_fc_lock?
