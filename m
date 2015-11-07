From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:35 +0100
Subject: [RFC] generic NVMe target and NVMe loop driver
Message-ID: <1446915643-21175-1-git-send-email-hch@lst.de>

This series continues the NVMe host drive split and also starts adding a
consume for it.  The consumer is mostly interesting for developers at this
point as it's simply a 'loopback' NVMe device that ties the split NVMe
driver fronted into the new generic NVMe target subsystem.  This was
developed for our NVMe over Fabrics prototype, but will also be useful for
other work like Ming's virtio-nvme or event an implementation traditional
PCIe NVMe using vhost.

The biggest gap at this point is aborts and resets, which are still under
heavy development.  Once those are done and I've finished the configfs
layout the code will hopefully be ready for inclusion in Linux 4.5.

I've also written a python based shell to ease configuration of the target
subsystem which I'll hopefully be able to release soon.

As this depends on a lot of pending NVMe patch a git tree is also
available:

	http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-loop.2
