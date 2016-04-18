From: hch@lst.de (Christoph Hellwig)
Date: Mon, 18 Apr 2016 22:17:10 +0200
Subject: [PATCH 2/5] nvme: introduce a controller state machine
In-Reply-To: <5715294A.3020309@grimberg.me>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
 <1460982893-11315-3-git-send-email-hch@lst.de> <5715294A.3020309@grimberg.me>
Message-ID: <20160418201710.GA4921@lst.de>

>> -	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
>> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
>> +		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
>> +		goto out;
>> +	}
>>   	return;
>>
>>    out:
>
> You're missing a state change before removing a
> dead controller...

why?
