From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 9 Feb 2016 14:34:12 +0100
Subject: [PATCH 3/4] nvme: split dev_list_lock
In-Reply-To: <20160209131408.GA25813@lst.de>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-4-git-send-email-mlin@kernel.org>
 <20160209124134.GM27969@c203.arch.suse.de>
 <20160209131408.GA25813@lst.de>
Message-ID: <20160209133412.GP27969@c203.arch.suse.de>

On Tue, Feb 09, 2016@02:14:08PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 09, 2016@01:41:34PM +0100, Johannes Thumshirn wrote:
> > On Mon, Feb 08, 2016@02:24:43PM -0800, Ming Lin wrote:
> > > Split dev_list_lock into one in the core and one in the PCI driver.
> > 
> > The dev_list_lock in core.c doesn't really protect the dev_list, like it does
> > in pci.c. Wouldn't it be better to rename it to something more appropriate? I
> > just can't come up with a name, as it seems to be some kind of catch all lock.
> 
> I plans to remove the core.c dev_list_lock by rewriting the character
> device interface code.  Let's keep the name for now, it'll go away.
> 
> (and the pci.c might be gone even sooner, but at least it has the right name
> :))

OK, then I'm fine with it.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
