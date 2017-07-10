From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 08:54:57 +0300
Subject: [PATCH] nvme-pci: add module parameter for io queue depth
In-Reply-To: <20170707152948.GB14788@localhost.localdomain>
References: <20170707090547.GA2420@localhost.didichuxing.com>
 <20170707152948.GB14788@localhost.localdomain>
Message-ID: <dabfe11a-d133-4de9-4be5-b1b8e0c63e87@grimberg.me>


>> +static int io_queue_depth = 1024;
>> +module_param(io_queue_depth, int, 0644);
>> +MODULE_PARM_DESC(io_queue_depth, "set io queue depth");
>> +
>>   static struct workqueue_struct *nvme_workq;
>>   
>>   struct nvme_dev;
>> @@ -1730,7 +1733,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>>   
>>   	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
>>   
>> -	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
>> +	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, io_queue_depth);
> 
> We need to be a little more careful about this field if users can write
> whatever they want. It's gotta be >= 2 or else trouble will occur.

Agreed, please resend the patch. Perhaps a good way is to use
module_param_cb() to verify the input value is >= 2?
