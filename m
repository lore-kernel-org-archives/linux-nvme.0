From: muhlemmer@gmail.com (Tim Mohlmann)
Date: Mon, 28 Mar 2016 19:44:20 +0300
Subject: nvme device timeout
Message-ID: <CAHOCc18wCgprYh1k0m0ow1FhU51J-1JN-X2Fj-8VKHDVi-Zo9Q@mail.gmail.com>

Hi,

During boot my nvme device is not showing up. I've found the following
dmesg output from nvme:
[    0.634251] nvme 0000:04:00.0: PCI INT A: no GSI
[   61.703015] nvme 0000:04:00.0: I/O 0 QID 0 timeout, disable controller
[   61.704028] nvme 0000:04:00.0: Identify Controller failed (-4)
[   61.705016] nvme 0000:04:00.0: Removing after probe failure status: -5

lspci does not list device anymore.

This problem occured after upgrading my kernel from 4.4.5 to 4.5-rc7.

I'm new to posting about bugs in the kernel, so please advise how I
can provide you with more meaningful info.

Regards,

Tim
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg
Type: application/octet-stream
Size: 54785 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160328/bf047afc/attachment-0001.obj>
