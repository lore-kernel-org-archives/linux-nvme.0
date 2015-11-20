From: mlin@kernel.org (Ming Lin)
Date: Thu, 19 Nov 2015 16:20:59 -0800
Subject: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme target
Message-ID: <1447978868-17138-1-git-send-email-mlin@kernel.org>

Hi,

This is the first attempt to add a new qemu nvme backend using
in-kernel nvme target.

Most code are ported from qemu-nvme and also borrow code from
Hannes Reinecke's rts-megasas.

It's similar as vhost-scsi, but doesn't use virtio.
The advantage is guest can run unmodified NVMe driver.
So guest can be any OS that has a NVMe driver.

The goal is to get as good performance as vhost-scsi.
But for now, peformance is poor.

MMIO is the bottleneck.

One improvment could be to use google's NVMe vendor extension that
I send in another thread, aslo here:
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext

Qemu side:
http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=vhost-nvme.0
Kernel side also here:
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=vhost-nvme.0

Thanks for any comment,
Ming
