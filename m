From: jsmart2021@gmail.com (James Smart)
Date: Tue, 11 Sep 2018 11:02:13 -0700
Subject: [REPOST][PATCH] nvme_fc: add 'nvme_discovery' sysfs attribute to
 fc transport device
In-Reply-To: <20180911085843.GA17520@infradead.org>
References: <20180820220611.8769-1-jsmart2021@gmail.com>
 <20180911085843.GA17520@infradead.org>
Message-ID: <c806be1b-f86f-de84-3669-d9bb89aaaf65@gmail.com>

On 9/11/2018 1:58 AM, Christoph Hellwig wrote:
>> +	unsigned long flags;
>> +	struct nvme_fc_lport *lport;
>> +	struct nvme_fc_rport *rport, *tmp_rport;
>> +
>> +	list_for_each_entry_safe(rport, tmp_rport,
>> +				 lheadp, disc_list) {
>> +		spin_lock_irqsave(&nvme_fc_lock, flags);
>> +		list_del_init(&rport->disc_list);
>> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
>> +		lport = rport->lport;
>> +		/* signal discovery. Won't hurt if it repeats */
>> +		nvme_fc_signal_discovery_scan(lport, rport);
>> +		nvme_fc_rport_put(rport);
>> +		nvme_fc_lport_put(lport);
>> +	}
> 
> This list iteration is not safe.  It should probably be something like:
> 
> 	spin_lock_irqsave(&nvme_fc_lock, flags);
> 	while (!list_empty(disc_list)) {
> 		struct nvme_fc_rport *rport = list_entry(disc_list->next,
> 				struct nvme_fc_lport, disct_list);
> 
> 		list_del_init(&rport->disc_list);
> 		spin_unlock_irqrestore(&nvme_fc_lock, flags);
> 
> 		lport = rport->lport;
> 		/* signal discovery. Won't hurt if it repeats */
> 		nvme_fc_signal_discovery_scan(lport, rport);
> 		nvme_fc_rport_put(rport);
> 		nvme_fc_lport_put(lport);
> 
> 		spin_lock_irqsave(&nvme_fc_lock, flags);
> 	}
> 	spin_unlock_irqrestore(&nvme_fc_lock, flags);

Well, I don't think I agree with you on the safeness of the locking, but 
moving it to the other style isn't different and looks more normal. I'll 
rework it.


> 
> 
>> +			if (!nvme_fc_lport_get(lport))
>> +				continue;
>> +			if (!nvme_fc_rport_get(rport)) {
>> +				/*
>> +				 * This is a temporary condition, so upon
>> +				 * restart this node will be gone from the
>> +				 * list.
>> +				 */
>> +				spin_unlock_irqrestore(&nvme_fc_lock, flags);
>> +				nvme_fc_lport_put(lport);
>> +				nvme_fc_discovery_unwind(&nvme_fc_disc_list);
>> +				if (failcnt++ < DISCOVERY_MAX_FAIL)
>> +					goto restart;
>> +				pr_err("nvme_discovery: too many reference "
>> +				       "failures\n");
>> +				return 0;
>> +			}
> 
> Maybe use a goto for this condition to move it out of the loop?

May not be necessary. I think I want to change this loop a little.

> 
>> +	list_for_each_entry_safe(rport, tmp_rport,
>> +				 &nvme_fc_disc_list, disc_list) {
>> +		spin_lock_irqsave(&nvme_fc_lock, flags);
>> +		list_del_init(&rport->disc_list);
>> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
>> +		lport = rport->lport;
>> +		nvme_fc_signal_discovery_scan(lport, rport);
>> +		nvme_fc_rport_put(rport);
>> +		nvme_fc_lport_put(lport);
>> +	}
> 
> Same locking issue as above.  And in fact exactly the same code, so
> it should probably call nvme_fc_discovery_unwind.

ok

-- james
