From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Oct 2017 12:12:30 +0200
Subject: [PATCH 5/9] nvme: track subsystems
In-Reply-To: <1535c6f9-8ddf-ab30-2bbd-5d9ce626b913@grimberg.me>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-6-hch@lst.de>
 <1535c6f9-8ddf-ab30-2bbd-5d9ce626b913@grimberg.me>
Message-ID: <20171018101230.GA14859@lst.de>

>>   static void nvme_free_ctrl(struct kref *kref)
>>   {
>>   	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
>> +	struct nvme_subsystem *subsys = ctrl->subsys;
>>     	put_device(ctrl->device);
>>   	nvme_release_instance(ctrl);
>>   	ida_destroy(&ctrl->ns_ida);
>>   +	if (subsys) {
>> +		mutex_lock(&subsys->lock);
>> +		list_del(&ctrl->subsys_entry);
>> +		mutex_unlock(&subsys->lock);
>> +	}
>> +
>
> When can this happen? can a controller not have a subsys?

When we fail early enough to not have set up the subsystem yet.
