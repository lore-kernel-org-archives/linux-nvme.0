From: keith.busch@intel.com (Keith Busch)
Date: Tue, 6 Feb 2018 09:33:47 -0700
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
Message-ID: <20180206163347.GG31110@localhost.localdomain>

On Mon, Feb 05, 2018@03:49:40PM -0600, wenxiong@vmlinux.vnet.ibm.com wrote:
> @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	struct nvme_command cmd;
>  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> +	/* If PCI error recovery process is happening, we cannot reset or
> +	 * the recovery mechanism will surely fail.
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev)))
> +		return BLK_EH_HANDLED;
> +

This patch will tell the block layer to complete the request and consider
it a success, but it doesn't look like the command actually completed at
all. You're going to get data corruption this way, right? Is returning
BLK_EH_HANDLED immediately really the right thing to do here?
