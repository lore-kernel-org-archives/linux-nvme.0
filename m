From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 28 May 2018 15:41:02 +0300
Subject: [PATCH 10/17] nvme: export nvme_ns_has_pi function
In-Reply-To: <20180528072544.GI5618@lst.de>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-11-git-send-email-maxg@mellanox.com>
 <20180528072544.GI5618@lst.de>
Message-ID: <e2c29e4b-4676-6d48-37f0-eaf97b47c8ed@mellanox.com>



On 5/28/2018 10:25 AM, Christoph Hellwig wrote:
>> -static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
>> +bool nvme_ns_has_pi(struct nvme_ns *ns)
>>   {
>>   	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
>>   }
>> +EXPORT_SYMBOL_GPL(nvme_ns_has_pi);
> 
> Just make this an inline in nvme.h
> 

Sure, I'll do it in V2.
Thanks.
