From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 3 Nov 2016 23:20:43 +0200
Subject: [PATCH v2] nvmet: Fix possible infinite loop triggered on hot
 namespace removal
In-Reply-To: <20161102144045.GB13577@lst.de>
References: <1478015644-26108-1-git-send-email-sagi@grimberg.me>
 <20161102144045.GB13577@lst.de>
Message-ID: <b80d19a9-267d-d5cf-dcbb-b678e9624e15@grimberg.me>


>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 6559d5afa7bf..bf36d2486245 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -264,9 +264,11 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>>  	int ret = 0;
>>
>>  	mutex_lock(&subsys->lock);
>> -	if (!list_empty(&ns->dev_link))
>> +	if (ns->enabled)
>>  		goto out_unlock;
>>
>> +	ns->enabled = true;
>> +
>>  	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
>>  			NULL);
>>  	if (IS_ERR(ns->bdev)) {
>
> This will leave the enable flag set when an error happen? later,
> won't it?  I'd set it just before dropping the lock.

Yep, will do.

>
>>  static inline bool nvmet_ns_enabled(struct nvmet_ns *ns)
>>  {
>> -	return !list_empty_careful(&ns->dev_link);
>> +	return ns->enabled;
>
> and we can probably kill this helper, it's pretty pointless
> now.

I will.
