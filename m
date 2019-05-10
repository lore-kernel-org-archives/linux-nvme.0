From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 10 May 2019 18:12:14 +0000
Subject: [PATCHv3 2/2] nvme: validate cntlid during controller
 initialisation
References: <20190503133736.111201-1-hare@suse.de>
 <20190503133736.111201-3-hare@suse.de>
 <6e3b55d1-abfa-a67b-f2d4-fe083f3ce37c@Oracle.com>
Message-ID: <SN6PR04MB45274F1821B5D809E34AE9AF860C0@SN6PR04MB4527.namprd04.prod.outlook.com>

Thanks John for reply. If you are interested you can always add tests to 
blktests framework here is link of the project :-

https://github.com/osandov/blktests.

On 05/10/2019 07:52 AM, John Donnelly wrote:
> On 5/3/19 8:37 AM, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare at suse.com>
>>
>> The CNTLID value is required to be unique, and we do rely on this
>> for correct operation. So reject any controller for which a non-unique
>> CNTLID has been detected.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>>    drivers/nvme/host/core.c | 32 ++++++++++++++++++++++++++++++--
>>    1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index cd16d98d1f1a..dc74f7ba6f4a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2358,6 +2358,23 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
>>    	return count;
>>    }
>>
>> +static bool nvme_duplicate_cntlid(struct nvme_subsystem *subsys,
>> +				  struct nvme_ctrl *ctrl)
>> +{
>> +	struct nvme_ctrl *tmp;
>> +	bool ret = false;
>> +
>> +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
>> +		if (tmp == ctrl)
>> +			continue;
>> +		if (tmp->cntlid == ctrl->cntlid) {
>> +			ret = true;
>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>>    static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>    {
>>    	struct nvme_subsystem *subsys, *found;
>> @@ -2411,6 +2428,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>
>>    		__nvme_release_subsystem(subsys);
>>    		subsys = found;
>> +		ret = 0;
>>    	} else {
>>    		ret = device_add(&subsys->dev);
>>    		if (ret) {
>> @@ -2434,10 +2452,20 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>    	}
>>
>>    	mutex_lock(&subsys->lock);
>> -	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>> +	if (!nvme_duplicate_cntlid(subsys, ctrl))
>> +		list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>> +	else {
>> +		dev_err(ctrl->device,
>> +			"Duplicate cntlid %u, rejecting\n",
>> +			ctrl->cntlid);
>> +		ctrl->subsys = NULL;
>> +		sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
>> +		nvme_put_subsystem(subsys);
>> +		ret = -EINVAL;
>> +	}
>>    	mutex_unlock(&subsys->lock);
>>
>> -	return 0;
>> +	return ret;
>>
>>    out_unlock:
>>    	mutex_unlock(&nvme_subsystems_lock);
>>
>
> Hello,
>
> I am interested in testing this series when they are finalized. I
> believe I have a test scenario for it that was discovered using the
> recent nvme-cli.1.8.1 release.
>
