From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 May 2019 08:17:16 +0200
Subject: [PATCH, RFC 1/2] nvme: change locking for the per-subsystem
 controller list
In-Reply-To: <6b9497da-a1d1-84ed-f59c-ef602297a2aa@linux.microsoft.com>
References: <20190508075508.28552-1-hch@lst.de>
 <6b9497da-a1d1-84ed-f59c-ef602297a2aa@linux.microsoft.com>
Message-ID: <20190509061716.GD15229@lst.de>

On Wed, May 08, 2019@09:47:42AM -0700, Edmund Nadolski wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index eebaeadaa800..4f4ffcce7416 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2346,13 +2346,11 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
>>   	int count = 0;
>>   	struct nvme_ctrl *ctrl;
>>   -	mutex_lock(&subsys->lock);
>>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>   		if (ctrl->state != NVME_CTRL_DELETING &&
>>   		    ctrl->state != NVME_CTRL_DEAD)
>>   			count++;
>>   	}
>> -	mutex_unlock(&subsys->lock);
>>     	return count;
>>   }
>
> Would lockdep_assert_held(&nvme_subsystems_lock); be beneficial here?

It certainly would not hurt, although it seems a little overkill for
a trivial helper with a single caller.
