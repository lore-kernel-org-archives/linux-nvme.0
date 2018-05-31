From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 12:24:51 +0300
Subject: [PATCH 2/5] nvme: don't hold nvmf_transports_rwsem for more than
 transport lookups
In-Reply-To: <20180515074826.GA23659@lst.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-3-jthumshirn@suse.de> <20180515074826.GA23659@lst.de>
Message-ID: <8577e467-ad74-d9bd-8f49-3ace18fc1126@grimberg.me>


>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 7ae732a77fe8..febf82639b40 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -957,16 +957,17 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
>>   
>>   	down_read(&nvmf_transports_rwsem);
>>   	ops = nvmf_lookup_transport(opts);
>> +	up_read(&nvmf_transports_rwsem);
> 
> And what protects us from the transport getting unregister right here
> from anothet thread waiting to acquire nvmf_transports_rwsem?

I think having the module_get inside as well would protect against it.
