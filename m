From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Apr 2016 21:35:20 +0300
Subject: [PATCH 2/5] nvme: introduce a controller state machine
In-Reply-To: <20160419182545.GA989@lst.de>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
 <1460982893-11315-3-git-send-email-hch@lst.de> <5715294A.3020309@grimberg.me>
 <20160418201710.GA4921@lst.de> <571543EA.6080700@grimberg.me>
 <20160419182545.GA989@lst.de>
Message-ID: <57167A68.5050206@grimberg.me>


>>>>> -	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
>>>>> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
>>>>> +		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
>>>>> +		goto out;
>>>>> +	}
>>>>>     	return;
>>>>>
>>>>>      out:
>>>>
>>>> You're missing a state change before removing a
>>>> dead controller...
>>>
>>> why?
>>
>> Just to have the state consistent with what the driver
>> is doing. Not a must though...
>
> Let's allocate states on an as needed basis and avoid that new
> state for now.

Didn't mean a new state, just a transition to NVME_CTRL_DELETING
if nvme_reset_work fails...
