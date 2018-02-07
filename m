From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 7 Feb 2018 09:24:37 +0800
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <787e4960b62a03b3888c67e73d7e1ee2@linux.vnet.ibm.com>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
 <787e4960b62a03b3888c67e73d7e1ee2@linux.vnet.ibm.com>
Message-ID: <20180207012353.GD13470@ming.t460p>

On Tue, Feb 06, 2018@02:01:05PM -0600, wenxiong wrote:
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
> 
> Hi Ming,
> 
> Can you help checking if it is ok if returning BLK_EH_HANDLEDED in this
> case?

Hi Wenxiong,

Looks Keith is correct, and this timed out request will be completed by
block layer and NVMe driver if BLK_EH_HANDLED is returned, but this IO
isn't completed actually, so either data loss(write) or read failure is
caused.

Maybe BLK_EH_RESET_TIMER is fine under this situation.

Thanks,
Ming
