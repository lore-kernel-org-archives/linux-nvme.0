From: hare@suse.de (Hannes Reinecke)
Date: Wed, 8 Nov 2017 17:31:23 +0100
Subject: [PATCH 1/1] nvme/fc: add 'discovery' sysfs attribute to fc
 transport device
In-Reply-To: <20171107192528.GC13618@infradead.org>
References: <1509722369-95879-1-git-send-email-hare@suse.de>
 <1509722369-95879-2-git-send-email-hare@suse.de>
 <20171107192528.GC13618@infradead.org>
Message-ID: <16dd3bc5-ae52-1ff5-3841-d313f676ed90@suse.de>

On 11/07/2017 08:25 PM, Christoph Hellwig wrote:
>> +	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
>> +		list_for_each_entry_safe(rport, tmp_rport,
>> +					 &lport->endp_list, endp_list) {
>> +			if (!nvme_fc_rport_get(rport))
>> +				continue;
>> +			spin_unlock_irqrestore(&nvme_fc_lock, flags);
>> +			nvme_fc_signal_discovery_scan(lport, rport);
>> +			nvme_fc_rport_put(rport);
>> +			spin_lock_irqsave(&nvme_fc_lock, flags);
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&nvme_fc_lock, flags);
> 
> What guarantees the list next pointers are still valid after
> you dropped nvme_fc_lock?
> 
You know, I wondered about that, too.
But then I cannot hold the lock when calling nvme_fc_rport_put().
And I'm somewhat reluctant to use list_for_each_entry_safe() in the
outer loop.

I'll be checking what we can do here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
