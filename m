From: mlin@kernel.org (Ming Lin)
Date: Tue, 13 Oct 2015 16:23:18 -0700
Subject: RFC: nvme driver split, the main part
In-Reply-To: <1444633811-28319-1-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
Message-ID: <1444778598.20969.11.camel@ssi>


On Mon, 2015-10-12@09:10 +0200, Christoph Hellwig wrote:
> And this is where the real work starts.  This moves all the block device,
> char device and sysfs interface code as well as the controller identification
> and namespaces scanning into the common code.  I've ported both my nvme-loop
> and the fabrics driver over to this scheme to validate that it works fine.
> 
> The main complication here is patch two which uses the block layer PI
> infrastructure for metdata passthrough.  I can't test it because I don't
> have access to a metadata capable device so I'll have to rely on testers.
> 
> Once this this series is done there are a few more items remaining:
> 
>  - remove a few library-like functions to core.c (trivial)
>  - abort rewrite to sit on top of the struct request infrastructure (in progress)
>  - AEN rewrite, including making a small part of it common
>  - a proper state machine for probing, scanning and resets (will take a while)
> 
> To make testing easier I've pushed out a git tree with this and all dependencies:
> 
>     git://git.infradead.org/users/hch/block.git nvme-split.4

I ported virtio-nvme to nvme-split. It works.
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-split/virtio

root at wheezy:/sys/class/nvme# ll
lrwxrwxrwx  1 root root 0 Oct 13 16:06 nvme0 -> ../../devices/pci0000:00/0000:00:04.0/nvme/nvme0/
lrwxrwxrwx  1 root root 0 Oct 13 16:06 nvme1 -> ../../devices/pci0000:00/0000:00:05.0/virtio1/nvme/nvme1/

root at wheezy:/sys/block# ll nvme*
lrwxrwxrwx 1 root root 0 Oct 13 16:07 nvme0n1 -> ../devices/pci0000:00/0000:00:04.0/nvme/nvme0/nvme0n1/
lrwxrwxrwx 1 root root 0 Oct 13 16:07 nvme1n1 -> ../devices/pci0000:00/0000:00:05.0/virtio1/nvme/nvme1/nvme1n1/

For the core part, I only moved the call of nvme_core_{init,exit} from
pci.c to core.c.

For the naming, how about:
- for core data structures/functions, prefixed all with nvme_core_*
- for pci data structures/functions, prefixed all with nvme_pci_*

I did this naming in drivers/nvme/host/virtio.c.

I can send a patch if you agree.

Thanks.
