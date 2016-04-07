From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Thu, 7 Apr 2016 12:42:29 -0300
Subject: [PATCH] Avoid reset work on watchdog timer function during error
 recovery
In-Reply-To: <20160407142449.GA9586@localhost.localdomain>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160407131131.GA2063@infradead.org>
 <20160407142449.GA9586@localhost.localdomain>
Message-ID: <57067FE5.7060002@linux.vnet.ibm.com>



On 04/07/2016 11:24 AM, Keith Busch wrote:
> On Thu, Apr 07, 2016@06:11:31AM -0700, Christoph Hellwig wrote:
>> static bool nvme_should_reset(struct nvme_dev *dev)
>> {
>> 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>>
>> 	if (!(csts & NVME_CSTS_CFS) &&
>> 	    !((dev->subsystem && (csts & NVME_CSTS_NSSRO))))
>> 		return false;
>>
>> 	if (work_pending(&dev->reset_work))
>> 		return false;
>> 	if (work_busy(&dev->reset_work))
>> 		return false;
>
> We could also skip checking work_pending since work_busy does that for us.
>

Great! What name should/can I choose for the function?

Thanks,


Guilherme
