From: freeman.zhang1992@gmail.com (Zhengyu Zhang)
Date: Wed, 15 Nov 2017 10:02:47 +0800
Subject: Is There Any Plan for Bit-Bucket SGL Implement?
Message-ID: <03d5178a-1edc-8a8b-f55b-9c96ee7d4101@gmail.com>

Hi list!

I am a NVMe user and I'm exploring NVMe specification for fun and
profit. I find that there are two types of data pointer in NVMe command,
i.e. PRP and SGL. And there are five types of SGL and one of them is
Bit-Bucket SGL, which enables user to leave out some blocks when read. I
think it's fun and profitable.

When I want to try this feature, however, it seems that the kernel does
not implement it. The `linux/drivers/nvme/host/pci.c` shows that the
kernel is now using PRP mode data pointer instead of SGL.

So I am here to ask:

- Is there any plan to implement (Bit-Bucket)SGL in linux kernel?
- Is there any other way to make use of this feature?
- Is this feature hardware-specific?


FYI:

- NVMe Spec I am reading is version 1.3, chapter 4.4.
- The kernel I am exploring is updated stage-next.
- The device I am using is an Intel P3700 400GB NVMe SSD.


Thanks!
Zhengyu

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171115/16f4eecb/attachment.sig>
