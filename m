From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:26:29 +0200
Subject: [PATCH 3/4] nvme: ANA transition timeout handling
In-Reply-To: <ffb79ccc-3259-ca9a-dc71-309baca1e10d@grimberg.me>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-4-hare@suse.de>
 <ffb79ccc-3259-ca9a-dc71-309baca1e10d@grimberg.me>
Message-ID: <20180607132629.GA14154@lst.de>

On Thu, Jun 07, 2018@04:16:09PM +0300, Sagi Grimberg wrote:
>> -		/*
>> -		 * XXX: We should verify the controller doesn't die on during
>> -		 * the transition.  But that means we per-group timeout from
>> -		 * when we first hit the change state, so this won't be
>> -		 * entirely trivial..
>> -		 */
>>   		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
>> +		if (!timer_pending(&ns->anatt_timer)) {
>> +			ns->anatt_timer.expires =
>> +				ns->ctrl->anatt * HZ + jiffies;
>> +			add_timer(&ns->anatt_timer);
>> +		}
>
> Shouldn't this del and re-add the timer if its pending?

Basically what we need to do is an xchg on the state variable,
at which point it can't ever be pending.
