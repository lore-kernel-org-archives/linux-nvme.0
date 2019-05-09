From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 9 May 2019 05:13:04 +0000
Subject: [PATCH, RFC 1/2] nvme: change locking for the per-subsystem
 controller list
References: <20190508075508.28552-1-hch@lst.de>
 <SN6PR04MB452790A4249949BA3C43DB4786320@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <SN6PR04MB45271E40F4CB44DD5F3A8B2386330@SN6PR04MB4527.namprd04.prod.outlook.com>

Please ignore my earlier comment, I can see it is already been done.

On 5/8/19 3:42 PM, Chaitanya Kulkarni wrote:
> On 05/08/2019 12:55 AM, Christoph Hellwig wrote:
>> Life becomes a lot simpler if we just use the global
>> nvme_subsystems_lock to protect this list.  Given that it is only
>> accessed during controller probing and removal that isn't a scalability
>> problem either.
>>
>> Signed-off-by: Christoph Hellwig <hch at lst.de>
>> ---
>>    drivers/nvme/host/core.c | 30 ++++++++++++------------------
>>    1 file changed, 12 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index eebaeadaa800..4f4ffcce7416 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2346,13 +2346,11 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
>>    	int count = 0;
>>    	struct nvme_ctrl *ctrl;
>>
>> -	mutex_lock(&subsys->lock);
>>    	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>    		if (ctrl->state != NVME_CTRL_DELETING &&
>>    		    ctrl->state != NVME_CTRL_DEAD)
>>    			count++;
>>    	}
>> -	mutex_unlock(&subsys->lock);
> Please correct me if I'm wrong.
> 
> nvme_free_ctrl() seems to be removing the ctrl from subsys->ctrls which
> gets added in the nvme_init_subsystem() and it is using subsys->lock.
> 
> In order to make above change work across nvme_init_subsytem() and
> nvme_free_ctrl() and it is not in the hot path, do we need to use
> nvme_subsystems_lock in nvme_free_ctrl() also ?
>>
>>    	return count;
>>    }
>> @@ -2394,6 +2392,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>    	mutex_lock(&nvme_subsystems_lock);
>>    	found = __nvme_find_get_subsystem(subsys->subnqn);
>>    	if (found) {
>> +		__nvme_release_subsystem(subsys);
>> +		subsys = found;
>> +
>>    		/*
>>    		 * Verify that the subsystem actually supports multiple
>>    		 * controllers, else bail out.
>> @@ -2402,14 +2403,10 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>    		    nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
>>    			dev_err(ctrl->device,
>>    				"ignoring ctrl due to duplicate subnqn (%s).\n",
>> -				found->subnqn);
>> -			nvme_put_subsystem(found);
>> +				subsys->subnqn);
>>    			ret = -EINVAL;
>> -			goto out_unlock;
>> +			goto out_put_subsystem;
>>    		}
>> -
>> -		__nvme_release_subsystem(subsys);
>> -		subsys = found;
>>    	} else {
>>    		ret = device_add(&subsys->dev);
>>    		if (ret) {
>> @@ -2421,23 +2418,20 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>    		list_add_tail(&subsys->entry, &nvme_subsystems);
>>    	}
>>
>> -	ctrl->subsys = subsys;
>> -	mutex_unlock(&nvme_subsystems_lock);
>> -
>>    	if (sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
>>    			dev_name(ctrl->device))) {
>>    		dev_err(ctrl->device,
>>    			"failed to create sysfs link from subsystem.\n");
>> -		/* the transport driver will eventually put the subsystem */
>> -		return -EINVAL;
>> +		goto out_put_subsystem;
>>    	}
>>
>> -	mutex_lock(&subsys->lock);
>> +	ctrl->subsys = subsys;
>>    	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>> -	mutex_unlock(&subsys->lock);
>> -
>> +	mutex_unlock(&nvme_subsystems_lock);
>>    	return 0;
>>
>> +out_put_subsystem:
>> +	nvme_put_subsystem(subsys);
>>    out_unlock:
>>    	mutex_unlock(&nvme_subsystems_lock);
>>    	put_device(&subsys->dev);
>> @@ -3695,10 +3689,10 @@ static void nvme_free_ctrl(struct device *dev)
>>    	__free_page(ctrl->discard_page);
>>
>>    	if (subsys) {
>> -		mutex_lock(&subsys->lock);
>> +		mutex_lock(&nvme_subsystems_lock);
>>    		list_del(&ctrl->subsys_entry);
>> -		mutex_unlock(&subsys->lock);
>>    		sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
>> +		mutex_unlock(&nvme_subsystems_lock);
>>    	}
>>
>>    	ctrl->ops->free_ctrl(ctrl);
>>
> 
> 
