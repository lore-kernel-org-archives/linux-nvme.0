From: hare@suse.de (Hannes Reinecke)
Date: Thu, 26 Jul 2018 15:37:48 +0200
Subject: [PATCH] nvme: Register for ANA AEN
In-Reply-To: <20180726120711.GA2684@lst.de>
References: <20180726105554.80437-1-hare@suse.de>
 <9a5908f1-92fe-e338-47e0-ad51837b3212@suse.de> <20180726115913.GA2187@lst.de>
 <20180726120113.GA2289@lst.de> <06a3d125-0dd6-d288-bedd-8462d96c3b9d@suse.de>
 <20180726120711.GA2684@lst.de>
Message-ID: <763ec760-8651-ff20-fe01-00ab43f29337@suse.de>

On 07/26/2018 02:07 PM, Christoph Hellwig wrote:
> On Thu, Jul 26, 2018@02:02:38PM +0200, Hannes Reinecke wrote:
>> On 07/26/2018 02:01 PM, Christoph Hellwig wrote:
>>> On Thu, Jul 26, 2018@01:59:13PM +0200, Christoph Hellwig wrote:
>>>> What target do you run against?  With the current 4004a TP
>>>> NVME_AEN_CFG_ANA_CHANGE should be set in OAES, which at least the
>>>> Linux target always did anyway.
>>>
>>> Ah, but the patches I sent out are missing this host side fix:
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index e482f223f8fd..f6e52ffe6a6d 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1035,7 +1035,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>>>  EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>>>  
>>>  #define NVME_AEN_SUPPORTED \
>>> -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT)
>>> +	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
>>>  
>>>  static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>>>  {
>>>
>> Ah. Maybe we should fix it up for the final submission...
> 
> I'll send out another round later today.
> 
Would it make sense to read back the features after we've tried to
enable them?
It might be that the target doesn't enable ANA AENs (or doesn't support
them), at which point we have to disable ANA on the host as we rely on
ANA AENs for correct operations ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
