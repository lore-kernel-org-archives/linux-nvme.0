From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Feb 2018 14:12:02 -0700
Subject: [PATCH V2]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <1518034178-26176-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1518034178-26176-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Message-ID: <20180207211202.GD1337@localhost.localdomain>

On Wed, Feb 07, 2018@02:09:38PM -0600, wenxiong@linux.vnet.ibm.com wrote:
> @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	struct nvme_command cmd;
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> +	/* If PCI error recovery process is happening, we cannot reset or
> +	 * the recovery mechanism will surely fail.
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev)))
> +		return BLK_EH_RESET_TIMER;

So reading csts is what triggers EEH to be detected and get the channel
set offline? If so, don't we need a memory barrier before calling
pci_channel_offline? Otherwise it looks like the compiler optimization
could reorder these.
