From: wenxiong@linux.vnet.ibm.com (wenxiong)
Date: Tue, 06 Feb 2018 11:08:14 -0600
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <20180206170200.GA658@localhost.localdomain>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
 <d2ea54c017d9954e4f3d4cf80040867d@linux.vnet.ibm.com>
 <20180206170200.GA658@localhost.localdomain>
Message-ID: <0cc8ee246d548b5bf2b397591419e7b6@linux.vnet.ibm.com>

On 2018-02-06 11:02, Keith Busch wrote:
> On Tue, Feb 06, 2018@10:55:41AM -0600, wenxiong wrote:
>> On 2018-02-06 10:33, Keith Busch wrote:
>> > On Mon, Feb 05, 2018 at 03:49:40PM -0600, wenxiong at vmlinux.vnet.ibm.com
>> > wrote:
>> > > @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return
>> > > nvme_timeout(struct request *req, bool reserved)
>> > >  	struct nvme_command cmd;
>> > >  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
>> > >
>> > > +	/* If PCI error recovery process is happening, we cannot reset or
>> > > +	 * the recovery mechanism will surely fail.
>> > > +	 */
>> > > +	if (pci_channel_offline(to_pci_dev(dev->dev)))
>> > > +		return BLK_EH_HANDLED;
>> > > +
>> >
>> > This patch will tell the block layer to complete the request and
>> > consider
>> > it a success, but it doesn't look like the command actually completed at
>> > all. You're going to get data corruption this way, right? Is returning
>> > BLK_EH_HANDLED immediately really the right thing to do here?
>> >
>> Hi Keith,
>> 
>> Do you think we can return with BLK_EH_NOT_HANDLED?
> 
> Maybe. I'm not familiar with how the EEH handling is going to go. Do
> you expect some other recovery to get the driver to either see a 
> natural
> completion at some point or recover it some other way?
> 

Powerpc kernel code/nvme driver eeh callback functions are  going to 
recover it at this point.


Thanks,
Wendy
