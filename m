From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Nov 2017 10:16:38 -0800
Subject: [PATCH 1/1] nvme/fc: add 'discovery' sysfs attribute to fc
 transport device
In-Reply-To: <16dd3bc5-ae52-1ff5-3841-d313f676ed90@suse.de>
References: <1509722369-95879-1-git-send-email-hare@suse.de>
 <1509722369-95879-2-git-send-email-hare@suse.de>
 <20171107192528.GC13618@infradead.org>
 <16dd3bc5-ae52-1ff5-3841-d313f676ed90@suse.de>
Message-ID: <20171108181638.GB6606@infradead.org>

On Wed, Nov 08, 2017@05:31:23PM +0100, Hannes Reinecke wrote:
> On 11/07/2017 08:25 PM, Christoph Hellwig wrote:
> >> +	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
> >> +		list_for_each_entry_safe(rport, tmp_rport,
> >> +					 &lport->endp_list, endp_list) {
> >> +			if (!nvme_fc_rport_get(rport))
> >> +				continue;
> >> +			spin_unlock_irqrestore(&nvme_fc_lock, flags);
> >> +			nvme_fc_signal_discovery_scan(lport, rport);
> >> +			nvme_fc_rport_put(rport);
> >> +			spin_lock_irqsave(&nvme_fc_lock, flags);
> >> +		}
> >> +	}
> >> +	spin_unlock_irqrestore(&nvme_fc_lock, flags);
> > 
> > What guarantees the list next pointers are still valid after
> > you dropped nvme_fc_lock?
> > 
> You know, I wondered about that, too.
> But then I cannot hold the lock when calling nvme_fc_rport_put().
> And I'm somewhat reluctant to use list_for_each_entry_safe() in the
> outer loop.

list_for_each_entry_safe isn't going to help you with races - it
only helps you when you delete the current node.
