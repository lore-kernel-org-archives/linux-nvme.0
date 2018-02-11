From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 11 Feb 2018 11:53:06 +0200
Subject: [PATCH 3/3] nvme: Fail controller on timeouts during reset
In-Reply-To: <75313a79-29da-3ea1-dd5b-c3d0d8c9069d@oracle.com>
References: <20180209174127.7224-1-keith.busch@intel.com>
 <20180209174127.7224-3-keith.busch@intel.com>
 <75313a79-29da-3ea1-dd5b-c3d0d8c9069d@oracle.com>
Message-ID: <2f2b2f64-8ce4-89a7-20dd-5c29b3d4b4e7@grimberg.me>


>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 7a2e4383c468..77929d35eae8 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1212,11 +1212,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>   	/*
>>   	 * Shutdown immediately if controller times out while starting. The
>>   	 * reset work will see the pci device disabled when it gets the forced
>> -	 * cancellation error. All outstanding requests are completed on
>> +	 * cancellation error. The driver won't see the status if it is waiting
>> +	 * on asynchronous comands, so we set the state to deleting to prevent
>> +	 * it from progressing. All outstanding requests are completed on
>>   	 * shutdown, so we return BLK_EH_HANDLED.
>>   	 */
>>   	switch (dev->ctrl.state) {
>>   	case NVME_CTRL_CONNECTING:
> 
> It seems that Max's commit (Fix host side state machine) have not been committed.
> So it should be RECONNECTING here.

Actually, they are already in nvme-4.16-rc.

I'd like to pick these up as well once they converge (even
taking 1+3 would be a good start).
