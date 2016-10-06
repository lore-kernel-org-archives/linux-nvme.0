From: j.naumann@fu-berlin.de (Jan Luca Naumann)
Date: Thu, 6 Oct 2016 17:15:04 +0200
Subject: Problem with new uapi header in Linux kernel 4.4+
Message-ID: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>

Hey,

at the moment I try to install a tool called "sedutil"[1]. The tool
manages self encrypting drives that conform to the TCG OPAL 2.0
specification.

The program uses in the current version i.a. ioctl() to communicate with
NVMe disks (see header [2] and source file [3]). The problem is that the
tool uses the no longer to the user space exported header file
"linux/nvme.h". In the new uapi header "linux/nvme_ioctl.h" are the
enumeration "nvme_admin_opcode" and the structure "nvme_id_ctrl" no
longer available that are used in the source code...

Since I do not have much experience with ioctl/NVMe and the upstream
author has no time at the moment, I want to ask you what would be the
best attempt to fix this.

Thank you in advance and best regards,
Jan

[1] https://github.com/Drive-Trust-Alliance/sedutil
[2]
https://github.com/Drive-Trust-Alliance/sedutil/blob/master/linux/DtaDevLinuxNvme.h
[3]
https://github.com/Drive-Trust-Alliance/sedutil/blob/master/linux/DtaDevLinuxNvme.cpp

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161006/d77ab0b5/attachment-0001.sig>
