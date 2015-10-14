From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Oct 2015 14:58:57 +0200
Subject: RFC: nvme driver split, the main part
In-Reply-To: <1444778598.20969.11.camel@ssi>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444778598.20969.11.camel@ssi>
Message-ID: <20151014125857.GB14457@lst.de>

On Tue, Oct 13, 2015@04:23:18PM -0700, Ming Lin wrote:
> I ported virtio-nvme to nvme-split. It works.
> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-split/virtio

Great!  I'll take a close look at your code soon.

> For the naming, how about:
> - for core data structures/functions, prefixed all with nvme_core_*
> - for pci data structures/functions, prefixed all with nvme_pci_*

I've use nvme_pci_* for any newly added PCI specific functions, and
we can slowly move the rest over once the split is done.  I'd prefer
to just use nvme_ for the core code.  While we're still working on
the split I'd prefer to avoid cosmetic renames for now.
