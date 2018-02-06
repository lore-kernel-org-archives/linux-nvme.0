From: keith.busch@intel.com (Keith Busch)
Date: Tue, 6 Feb 2018 10:02:00 -0700
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <d2ea54c017d9954e4f3d4cf80040867d@linux.vnet.ibm.com>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
 <d2ea54c017d9954e4f3d4cf80040867d@linux.vnet.ibm.com>
Message-ID: <20180206170200.GA658@localhost.localdomain>

On Tue, Feb 06, 2018@10:55:41AM -0600, wenxiong wrote:
> On 2018-02-06 10:33, Keith Busch wrote:
> > On Mon, Feb 05, 2018 at 03:49:40PM -0600, wenxiong at vmlinux.vnet.ibm.com
> > wrote:
> > > @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return
> > > nvme_timeout(struct request *req, bool reserved)
> > >  	struct nvme_command cmd;
> > >  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> > > 
> > > +	/* If PCI error recovery process is happening, we cannot reset or
> > > +	 * the recovery mechanism will surely fail.
> > > +	 */
> > > +	if (pci_channel_offline(to_pci_dev(dev->dev)))
> > > +		return BLK_EH_HANDLED;
> > > +
> > 
> > This patch will tell the block layer to complete the request and
> > consider
> > it a success, but it doesn't look like the command actually completed at
> > all. You're going to get data corruption this way, right? Is returning
> > BLK_EH_HANDLED immediately really the right thing to do here?
> > 
> Hi Keith,
> 
> Do you think we can return with BLK_EH_NOT_HANDLED?

Maybe. I'm not familiar with how the EEH handling is going to go. Do
you expect some other recovery to get the driver to either see a natural
completion at some point or recover it some other way?

> Probably need to change the following return value as well.
>         /*
>          * Reset immediately if the controller is failed
>          */
>         if (nvme_should_reset(dev, csts)) {
>                 nvme_warn_reset(dev, csts);
>                 nvme_dev_disable(dev, false);
>                 nvme_reset_ctrl(&dev->ctrl);
>                 return BLK_EH_HANDLED;
>         }

This is fine as-is. nvme_dev_disable reclaims all outstanding IO, so
there's no way the timed out command has not been handled, making this
the appropriate return code here.
