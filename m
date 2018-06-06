From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Jun 2018 15:27:30 +0300
Subject: [PATCH v2] nvmet: filter newlines from user input
In-Reply-To: <20180606105624.GA11670@lst.de>
References: <20180606091049.12661-1-sagi@grimberg.me>
 <20180606105624.GA11670@lst.de>
Message-ID: <a48b8768-7237-8d73-e09d-49b2c92be15b@grimberg.me>


>> +	ret = sscanf(page, "%s\n", port->disc_addr.traddr);
>> +	if (ret < 1)
>> +		return -EINVAL;
>> +
>> +	return count;
> 
> I think this should be:
> 
> 	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1))
> 		return -EINVAL;
> 	return count;
> 
> Same for the other instances.
> 
>>   	ret = -ENOMEM;
>> -	ns->device_path = kstrdup(page, GFP_KERNEL);
>> -	if (!ns->device_path)
>> +	s = kstrdup(page, GFP_KERNEL);
>> +	if (!s)
>>   		goto out_unlock;
>>   
>> +	ns->device_path = strsep(&s, "\n");
> 
> I'd just go for something like
> 
> 	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
> 

Thanks for the suggestions. sending v3
