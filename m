From: scott.bauer@intel.com (Bauer, Scott)
Date: Thu, 6 Oct 2016 23:28:40 +0000
Subject: Problem with new uapi header in Linux kernel 4.4+
In-Reply-To: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>
References: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>
Message-ID: <C17953214F1EE04D9E8A11E8F3E869F051C4F9@ORSMSX110.amr.corp.intel.com>



-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Jan Luca Naumann
Sent: Thursday, October 6, 2016 9:15 AM
To: linux-nvme at lists.infradead.org
Subject: Problem with new uapi header in Linux kernel 4.4+

Hey,

at the moment I try to install a tool called "sedutil"[1]. The tool manages self encrypting drives that conform to the TCG OPAL 2.0 specification.

The program uses in the current version i.a. ioctl() to communicate with NVMe disks (see header [2] and source file [3]). The problem is that the tool uses the no longer to the user space exported header file "linux/nvme.h". In the new uapi header "linux/nvme_ioctl.h" are the enumeration "nvme_admin_opcode" and the structure "nvme_id_ctrl" no longer available that are used in the source code...

Since I do not have much experience with ioctl/NVMe and the upstream author has no time at the moment, I want to ask you what would be the best attempt to fix this.

Thank you in advance and best regards,
Jan

[1] https://github.com/Drive-Trust-Alliance/sedutil
[2]
https://github.com/Drive-Trust-Alliance/sedutil/blob/master/linux/DtaDevLinuxNvme.h
[3]
https://github.com/Drive-Trust-Alliance/sedutil/blob/master/linux/DtaDevLinuxNvme.cpp

----

If you want it to *just work*: 
1) Place the attached nvme.h file in /usr/include/liunx/
2) Modify sedutil/linux/DtaDevLinuxNvme.cpp
     Add #include <linux/nvme_ioctl.h>
3) rebuild

This is what I did a while ago to get this to build. Just so you know I was having issues with this upstream version of sedutil not actually working on a opal-enabled controller. I had to checkout version 1.12 for it to work.
https://github.com/Drive-Trust-Alliance/sedutil/tree/1.12.

For what it is worth the kernel will soon have OPAL support built in so you won't have to do this weird hack, and use a
tool that is no longer maintained. 

Thanks,
Sott

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: nvme.h
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161006/f9228ead/attachment.h>
