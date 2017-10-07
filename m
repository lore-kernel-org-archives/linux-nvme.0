From: jsmart2021@gmail.com (James Smart)
Date: Sat, 7 Oct 2017 08:53:37 -0700
Subject: [PATCH v2 2/7] nvme_fc: change ctlr state assignments during
 reset/reconnect
In-Reply-To: <20171005075730.GA5063@infradead.org>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-3-jsmart2021@gmail.com>
 <20171005075730.GA5063@infradead.org>
Message-ID: <95dd2176-c5bb-386f-6a7a-4705576713fd@gmail.com>

On 10/5/2017 12:57 AM, Christoph Hellwig wrote:
>>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>> -	WARN_ON_ONCE(!changed);
>>   
>>   	ctrl->ctrl.nr_reconnects = 0;
>>   
>> -	nvme_start_ctrl(&ctrl->ctrl);
>> +	if (changed)
>> +		nvme_start_ctrl(&ctrl->ctrl);
> 
> It's just cosmetic, but can you folow the RDMA pattern here:
> 
> 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> 	if (!changed) {
> 		/* state change failure is ok if we're in DELETING state */
> 		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
> 		return;
> 	}
> 
> else the patch looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 

Actually, it's not just cosmetic. I don't want the warning to be 
displayed. With FC's notification on device loss, in testing, we've seen 
a device loss occur as this state transition occurs. I doubt that's 
something rdma would ever see. With the device connectivity loss 
notification, the state moves from NEW to RESETTING, then RECONNECTING. 
I prefer to clear the reconnect counter (as we just went through a 
connect) to ensure that the full reconnect attempts will occur.

As such, I'd prefer to leave it the same.

-- james
