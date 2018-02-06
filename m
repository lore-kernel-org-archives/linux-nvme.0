From: wenxiong@linux.vnet.ibm.com (wenxiong)
Date: Tue, 06 Feb 2018 10:55:41 -0600
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <20180206163347.GG31110@localhost.localdomain>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
Message-ID: <d2ea54c017d9954e4f3d4cf80040867d@linux.vnet.ibm.com>

On 2018-02-06 10:33, Keith Busch wrote:
> On Mon, Feb 05, 2018 at 03:49:40PM -0600, wenxiong at vmlinux.vnet.ibm.com 
> wrote:
>> @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return 
>> nvme_timeout(struct request *req, bool reserved)
>>  	struct nvme_command cmd;
>>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>> 
>> +	/* If PCI error recovery process is happening, we cannot reset or
>> +	 * the recovery mechanism will surely fail.
>> +	 */
>> +	if (pci_channel_offline(to_pci_dev(dev->dev)))
>> +		return BLK_EH_HANDLED;
>> +
> 
> This patch will tell the block layer to complete the request and 
> consider
> it a success, but it doesn't look like the command actually completed 
> at
> all. You're going to get data corruption this way, right? Is returning
> BLK_EH_HANDLED immediately really the right thing to do here?
> 
Hi Keith,

Do you think we can return with BLK_EH_NOT_HANDLED?
enum blk_eh_timer_return {
         BLK_EH_NOT_HANDLED,
         BLK_EH_HANDLED,
         BLK_EH_RESET_TIMER,
};

Probably need to change the following return value as well.
         /*
          * Reset immediately if the controller is failed
          */
         if (nvme_should_reset(dev, csts)) {
                 nvme_warn_reset(dev, csts);
                 nvme_dev_disable(dev, false);
                 nvme_reset_ctrl(&dev->ctrl);
                 return BLK_EH_HANDLED;
         }

Let me know. I can re-build the kernel and try it.

Thanks,
Wendy
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
