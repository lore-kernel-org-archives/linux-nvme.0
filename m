From: hare@suse.de (Hannes Reinecke)
Date: Mon, 11 Jun 2018 17:51:54 +0200
Subject: [PATCHv2] nvme: ANA transition timeout handling
In-Reply-To: <20180611142205.GA13515@lst.de>
References: <20180608121320.74149-1-hare@suse.de>
 <20180611142205.GA13515@lst.de>
Message-ID: <011f229c-01dc-827e-5e44-f5c41775c6b2@suse.de>

On 06/11/2018 04:22 PM, Christoph Hellwig wrote:
>> +			/*
>> +			 * Use timer_reduce() to ensure we're not modifying
>> +			 * an already running timer.
>> +			 */
>> +			timer_reduce(&grp->anatt_timer,
>> +				     ns->ctrl->anatt * HZ + jiffies);
> 
> That's a bit of a gross hack for a timer that never is actually
> reduced, just added.
> 
Well, yes; but using timer_reduce allows me to use the timer code 
without having to take a lock; if I would've used add_timer() I always 
would have to have two statements (one for setting the timer, and on 
call to add_timer) which from my understanding would need to be 
protected by a lock.

>> +		if (ctrl->state == NVME_CTRL_LIVE && state == NVME_ANA_CHANGE)
>> +			timer_reduce(&grp->anatt_timer,
>> +				     ctrl->anatt * HZ + jiffies);
>> +		else
>> +			del_timer(&grp->anatt_timer);
> 
> 
>> +	for (grpid = 0; grpid < ctrl->anagrpmax; grpid++) {
>> +		struct nvme_ana_group *grp = &ctrl->ana_groups[grpid];
>> +
>> +		del_timer(&grp->anatt_timer);
> 
> Without del_timer_sync you are going to create use after free
> conditions.
> 
Hmm. Possibly.
Will be looking into it if

> 
> Anyway, v4 of the ANA series I've just sent contains simple ANATT
> handling based on a per-controller timer, which should be sufficient
> to catch the intent behind ANATT.  Comments welcome.
> Actually, I looked into moving the timer handling into the controller, too.
But then the problem was that we'll catch only the most current 
transition; if we have two namespaces, both going into the 'change 
state' mode independently (as would be the case with our nvmet, if both 
namespaces are configured on different ANA groups), we would only able 
to register the most current transition.
If we have a scenario like

1. NS A: ANA change state
2. NS A: ANA AEN
-> start ANATT
3. NS B: ANA change state
4. NS B: ANA AEN
-> not starting ANATT as it's already running
5. NS A: final state
6. NS A: ANA AEN
-> kill ANATT

we will start ANATT for NS B (with the full transition timeout) only 
after 6., failing to reduce the timer by the time spent between 4. and 6.

If that's not an issue, okay, we can use that approach.
I just didn't dare so, knowing as it has design flaws.

Cheers,

Hannes
