From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Mon, 8 Jul 2019 18:35:29 +0000
Subject: Should hot removed devices close open namespace bd references?
Message-ID: <d7027ad47e28339f13eb2d7f1bff4c7749da1160.camel@intel.com>

Hello,

5.2 shows a strange regression where if a namespace handle is open and
the device is hot removed, then hot inserted, the new controller
instance fails to enumerate.

Previous kernels back to the multipathing introduction would simply add
the new namespace to the previous controller's subsystem id, so you
would end up with something like:
/dev/nvme2
/dev/nvme0n2
Because the subsystem namespace instance is 2 upon enumeration as the
previous handle hadn't been released through the block layer.

With 5.2, I instead see:
[  247.767504] nvme nvme2: pci function 10000:01:00.0
[  247.772642] nvme 10000:01:00.0: enabling device (0000 -> 0002)
[  247.778671] pcieport 10000:00:02.0: can't derive routing for PCI INT
A
[  247.785411] nvme 10000:01:00.0: PCI INT A: no GSI
[  247.899879] nvme nvme2: Duplicate cntlid 0 with nvme0, rejecting
[  247.906086] nvme nvme2: Removing after probe failure status: -22


Here's a test program:
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
        int fd;

        fd = open("/dev/nvme0n1", O_DIRECT);

        for (;;)
                ;
}



Run this and in parallel, remove the link from the upstream port:
setpci -s <BDF> CAP_EXP+10.w=10:10
And add it back:
setpci -s <BDF> CAP_EXP+10.w=0:10
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190708/00327404/attachment.bin>
