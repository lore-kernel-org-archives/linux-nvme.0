From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Feb 2018 18:39:10 +0200
Subject: [PATCH V2]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <20180207211202.GD1337@localhost.localdomain>
References: <1518034178-26176-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20180207211202.GD1337@localhost.localdomain>
Message-ID: <75ec663f-1598-7ad8-a23a-0524edc6e575@grimberg.me>

>> @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>   	struct nvme_command cmd;
>>   	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>>   
>> +	/* If PCI error recovery process is happening, we cannot reset or
>> +	 * the recovery mechanism will surely fail.
>> +	 */
>> +	if (pci_channel_offline(to_pci_dev(dev->dev)))
>> +		return BLK_EH_RESET_TIMER;
> 
> So reading csts is what triggers EEH to be detected and get the channel
> set offline? If so, don't we need a memory barrier before calling
> pci_channel_offline? Otherwise it looks like the compiler optimization
> could reorder these.

I think you're right.
