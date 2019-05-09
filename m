From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Thu, 9 May 2019 14:43:04 -0700
Subject: [PATCH, RFC 1/2] nvme: change locking for the per-subsystem
 controller list
In-Reply-To: <20190509061716.GD15229@lst.de>
References: <20190508075508.28552-1-hch@lst.de>
 <6b9497da-a1d1-84ed-f59c-ef602297a2aa@linux.microsoft.com>
 <20190509061716.GD15229@lst.de>
Message-ID: <dc2d70e6-3607-a4f2-c8a7-a41220ea5085@linux.microsoft.com>

On 5/8/19 11:17 PM, Christoph Hellwig wrote:
> On Wed, May 08, 2019@09:47:42AM -0700, Edmund Nadolski wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index eebaeadaa800..4f4ffcce7416 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2346,13 +2346,11 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
>>>   	int count = 0;
>>>   	struct nvme_ctrl *ctrl;
>>>   -	mutex_lock(&subsys->lock);
>>>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>>   		if (ctrl->state != NVME_CTRL_DELETING &&
>>>   		    ctrl->state != NVME_CTRL_DEAD)
>>>   			count++;
>>>   	}
>>> -	mutex_unlock(&subsys->lock);
>>>     	return count;
>>>   }
>>
>> Would lockdep_assert_held(&nvme_subsystems_lock); be beneficial here?
> 
> It certainly would not hurt, although it seems a little overkill for
> a trivial helper with a single caller.

True, the thought is that it would be indicative that subsys->lock is not
needed in this context.

Ed
