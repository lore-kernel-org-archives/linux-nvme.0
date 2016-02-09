From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Feb 2016 14:14:08 +0100
Subject: [PATCH 3/4] nvme: split dev_list_lock
In-Reply-To: <20160209124134.GM27969@c203.arch.suse.de>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-4-git-send-email-mlin@kernel.org>
 <20160209124134.GM27969@c203.arch.suse.de>
Message-ID: <20160209131408.GA25813@lst.de>

On Tue, Feb 09, 2016@01:41:34PM +0100, Johannes Thumshirn wrote:
> On Mon, Feb 08, 2016@02:24:43PM -0800, Ming Lin wrote:
> > Split dev_list_lock into one in the core and one in the PCI driver.
> 
> The dev_list_lock in core.c doesn't really protect the dev_list, like it does
> in pci.c. Wouldn't it be better to rename it to something more appropriate? I
> just can't come up with a name, as it seems to be some kind of catch all lock.

I plans to remove the core.c dev_list_lock by rewriting the character
device interface code.  Let's keep the name for now, it'll go away.

(and the pci.c might be gone even sooner, but at least it has the right name
:))
