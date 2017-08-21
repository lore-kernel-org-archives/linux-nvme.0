From: felipeapolanco@gmail.com (Felipe Arturo Polanco)
Date: Mon, 21 Aug 2017 15:23:09 -0400
Subject: NVMe driver with kernel panic
Message-ID: <CADcj3=5oXJzsBO7eNPNbGM+W9qKwbVBmmokY9h7-qP8butZLTg@mail.gmail.com>

Hello,

We have been having kernel panics in our servers while using NVMe disks.
Our setup consist of two Intel P4500 in Software Raid1 with mdadm.
We are running KVM on top of them.

The message we see in ring buffer is the following:

[531622.412922] ------------[ cut here ]------------
[531622.413254] kernel BUG at drivers/nvme/host/pci.c:467!
[531622.413468] invalid opcode: 0000 [#1] SMP

Online we found a workaround to avoid using the explicit BUG_ON() and
instead we got that changed to WARN_ONCE() to not crash the server but
we are not entirely sure if this is a fix at all as it may cause other
issues.

We were told by a developer that this issue is caused by wrong block
size being reported by the hardware, 4KB expected and got 512 bytes
instead.

Has anyone seen this before or has applied a patch that fixed this?

We are running VzLinux7 based on RHEL 7.3, kernel 3.10.0-514.26.1.vz7.33.22

Thanks,
