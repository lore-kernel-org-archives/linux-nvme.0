From: hare@suse.com (Hannes Reinecke)
Date: Tue, 17 Jul 2018 15:48:41 +0200
Subject: [PATCH 2/5] nvmet: fixup crash on NULL device path
In-Reply-To: <20180717134841.GA16604@lst.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-3-hare@suse.de> <20180717134841.GA16604@lst.de>
Message-ID: <f4775b23-c601-6e57-c892-be88a23c5cf3@suse.com>

On 07/17/2018 03:48 PM, Christoph Hellwig wrote:
> On Mon, Jul 16, 2018@12:58:34PM +0200, Hannes Reinecke wrote:
>> index 094d216ae62a..76efc8120c00 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -295,6 +295,12 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
>>  	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
>>  	if (!ns->device_path)
>>  		goto out_unlock;
>> +	if (!strlen(ns->device_path)) {
>> +		kfree(ns->device_path);
>> +		ns->device_path = NULL;
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
> 
> I think this should rather be:
> 
> 	ret = -EINVAL;
> 	len = strcspn(page, "\n");
> 	if (len == 0)
> 		goto out_unlock;
> 	ret = -ENOMEM;
> 	ns->device_path = kstrndup(page, len, GFP_KERNEL);
> 	if (!ns->device_path)
> 		goto out_unlock;
> 
Okay.

>> index 0aeccbddd716..956d293d293d 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -373,8 +373,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>>  	if (ns->enabled)
>>  		goto out_unlock;
>>  
>> +	if (!ns->device_path) {
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
> 
> I don't think we should need this fix.
> 
>>  	ret = nvmet_bdev_ns_enable(ns);
>> -	if (ret)
>> +	if (ret == -ENOTBLK)
>>  		ret = nvmet_file_ns_enable(ns);
> 
> Looks sensible, but please split this into a separate patch.
> 
Right. And should be sent independently of the ANA stuff, too.

Will be updating both.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
