From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Thu, 29 Oct 2015 21:41:45 +0100
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
In-Reply-To: <20151029203115.GA12930@localhost.localdomain>
References: <bd1f730603ee00205657774a362aab10@localhost>
 <20151029151056.GA2580@localhost.localdomain>
 <1765c91018bf3b7840ce79d9b51762e8@localhost>
 <20151029203115.GA12930@localhost.localdomain>
Message-ID: <522dda87abb1d285ba3e7ef46f5ac0a1@localhost>

On 2015/October/29 08:31, Keith Busch wrote:
> On Thu, Oct 29, 2015@08:46:38PM +0100, Stephan G?nther wrote:
> > On 2015/October/29 09:10, Jon Derrick wrote:
> > > Christoph recently added a quirks mechanism where I think it would fit
> > 
> > To be honest we don't know what mechanism you are referring to. Please 
> > give us pointer.
> 
> It's new, not merged in an official tree. A copy is on the mailing list
> somewhere. I committed it to my personal tree here:
> 
> http://git.infradead.org/users/kbusch/linux-nvme.git/commitdiff/e43f1dc5d9f31380090cc6b67fd3fa43a15089e6
>  
> > I assume that we concur that this workaround--as well as making the nvme 
> > driver claim the Apple controller--should be a runtime-decisions based 
> > on the device id. That avoids both penalties in terms of cpu cycles and 
> > the tedious manual binding.
> 
> Just append the Vendor + Device to struct pci_device_id nvme_id_table
> if the 64 bit register access really is the only problem preventing it
> from working in an NVMe compliant way. You can check at run time for
> the lo_hi_[read/write]q quirk.

Great, I will give this a try.

> 
> If it really works with only this one change to the nvme driver, I also
> wonder Apple typo'ed their class code.

The only thing that prevents me from wiping the ssd and debootstrapping 
is the problem with the internal keyboard. That's another story but I'm
looking into that.

Now that there is a way to get the controller working (read/write was ok
when I tested it on the Macbook's EFI partition), we will hopefully have
some answers soon.


Of course everyone should make some backups before trying that... I did 
not test anything else than writing a couple of text files to the
device, syncing and deleting the files afterwards.

Best,
Stephan
