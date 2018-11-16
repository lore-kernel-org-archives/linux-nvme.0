From: hare@suse.com (Hannes Reinecke)
Date: Fri, 16 Nov 2018 09:07:26 +0100
Subject: [PATCH 1/2] nvme-multipath: add 'iopolicy' subsystem attribute
In-Reply-To: <4e31f5b2-077b-8ed6-7b9e-3ffcb4948d68@grimberg.me>
References: <20181115122927.40431-1-hare@suse.de>
 <20181115122927.40431-2-hare@suse.de>
 <4e31f5b2-077b-8ed6-7b9e-3ffcb4948d68@grimberg.me>
Message-ID: <e1a55fa8-5d80-0a7a-fba7-4b7508dc54d6@suse.com>

On 11/15/18 6:35 PM, Sagi Grimberg wrote:
> 
>> +static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>> +??????? struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +??? unsigned int iopolicy = NVME_IOPOLICY_UNKNOWN;
>> +
>> +??? if (!strncmp(buf, "none", 4))
>> +??????? iopolicy = NVME_IOPOLICY_NONE;
>> +??? else if (!strncmp(buf, "numa", 4))
>> +??????? iopolicy = NVME_IOPOLICY_NUMA;
>> +
>> +??? if (iopolicy == NVME_IOPOLICY_UNKNOWN)
>> +??????? return -EINVAL;
> 
> Missed assignment to subsys->iopolicy?
> 
Yeah, moved to the next patch.
Will be cleaned up in the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
