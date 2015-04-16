From: m@bjorling.me (Matias Bjorling)
Date: Thu, 16 Apr 2015 19:17:47 +0200
Subject: [PATCH 5/5 v2] nvme: LightNVM support
In-Reply-To: <alpine.LNX.2.00.1504161433110.32385@localhost.lm.intel.com>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-6-git-send-email-m@bjorling.me>
 <alpine.LNX.2.00.1504161433110.32385@localhost.lm.intel.com>
Message-ID: <552FEEBB.2010106@bjorling.me>

Den 16-04-2015 kl. 16:55 skrev Keith Busch:
> On Wed, 15 Apr 2015, Matias Bj?rling wrote:
>> @@ -2316,7 +2686,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
>>     struct nvme_id_ctrl *ctrl;
>>     void *mem;
>>     dma_addr_t dma_addr;
>> -    int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
>> +    u64 cap = readq(&dev->bar->cap);
>> +    int shift = NVME_CAP_MPSMIN(cap) + 12;
>> +    int nvm_cmdset = NVME_CAP_NVM(cap);
>
> The controller capabilities' command sets supported used here is the
> right way to key off on support for this new command set, IMHO, but I do
> not see in this patch the command set being selected when the controller
> is enabled

I'll get that added. Wouldn't it just be that the command set always is 
selected? A NVMe controller can expose both normal and lightnvm 
namespaces. So we would always enable it, if CAP bit is set.

>
> Also if we're going this route, I think we need to define this reserved
> bit in the spec, but I'm not sure how to help with that.

Agree, we'll see how it can be proposed.

>
>> @@ -2332,6 +2704,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>>     ctrl = mem;
>>     nn = le32_to_cpup(&ctrl->nn);
>>     dev->oncs = le16_to_cpup(&ctrl->oncs);
>> +    dev->oacs = le16_to_cpup(&ctrl->oacs);
>
> I don't find OACS used anywhere in the rest of the patch. I think this
> must be left over from v1.

Oops, yes, that's just a left over.

>
> Otherwise it looks pretty good to me, but I think it would be cleaner if
> the lightnvm stuff is not mixed in the same file with the standard nvme
> command set. We might end up splitting nvme-core in the future anyway
> for command sets and transports.

Will do. Thanks.
