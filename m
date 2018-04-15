From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 15 Apr 2018 11:54:59 +0300
Subject: [PATCH v1 3/3] nvmet: Add port transport state flag
In-Reply-To: <20180413171421.GA23432@lst.de>
References: <20180412080656.1691-1-sagi@grimberg.me>
 <20180412080656.1691-4-sagi@grimberg.me> <20180413171421.GA23432@lst.de>
Message-ID: <5f7a6f5e-cddc-0612-ab29-0b2a34a0dd76@grimberg.me>



>> +{
>> +	struct nvmet_port *port = to_nvmet_port(item);
>> +
>> +	return sprintf(page, "%s\n",
>> +		nvmet_is_port_active(port) ? "up" : "down");
>> +}
>> +
>> +CONFIGFS_ATTR_RO(nvmet_, trstate);
>> +
>>   /*
>>    * Namespace structures & file operation functions below
>>    */
>> @@ -870,6 +880,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>>   	&nvmet_attr_addr_traddr,
>>   	&nvmet_attr_addr_trsvcid,
>>   	&nvmet_attr_addr_trtype,
>> +	&nvmet_attr_trstate,
> 
> Please don't create attributes without a group ever.  Just create a
> different group which isn't serialized, e.g. state as the group name
> and then transport as the attribute name inside it, or something similar.

We already have ns enable which is not within a group. How is that
different?
