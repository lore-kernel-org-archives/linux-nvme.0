From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 9 Jul 2019 13:09:13 -0700
Subject: Should hot removed devices close open namespace bd references?
In-Reply-To: <d7027ad47e28339f13eb2d7f1bff4c7749da1160.camel@intel.com>
References: <d7027ad47e28339f13eb2d7f1bff4c7749da1160.camel@intel.com>
Message-ID: <32a2e339-b948-43fe-72a3-77eb2e626c63@grimberg.me>


> Hello,
> 
> 5.2 shows a strange regression where if a namespace handle is open and
> the device is hot removed, then hot inserted, the new controller
> instance fails to enumerate.

This is due to 1b1031ca63b2 ("nvme: validate cntlid during controller 
initialisation")

> Previous kernels back to the multipathing introduction would simply add
> the new namespace to the previous controller's subsystem id, so you
> would end up with something like:
> /dev/nvme2
> /dev/nvme0n2
> Because the subsystem namespace instance is 2 upon enumeration as the
> previous handle hadn't been released through the block layer.

Its the controller that is not released (as the open ns handle holds
a reference to it). But what is the old controller state? the code
is supposed to allow this check if the old controller is in
DELETING/DEAD.


> 
> With 5.2, I instead see:
> [  247.767504] nvme nvme2: pci function 10000:01:00.0
> [  247.772642] nvme 10000:01:00.0: enabling device (0000 -> 0002)
> [  247.778671] pcieport 10000:00:02.0: can't derive routing for PCI INT
> A
> [  247.785411] nvme 10000:01:00.0: PCI INT A: no GSI
> [  247.899879] nvme nvme2: Duplicate cntlid 0 with nvme0, rejecting
> [  247.906086] nvme nvme2: Removing after probe failure status: -22
> 
> 
> Here's a test program:
> #define _GNU_SOURCE
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> 
> int main(int argc, char *argv[])
> {
>          int fd;
> 
>          fd = open("/dev/nvme0n1", O_DIRECT);
> 
>          for (;;)
>                  ;
> }
> 
> 
> 
> Run this and in parallel, remove the link from the upstream port:
> setpci -s <BDF> CAP_EXP+10.w=10:10
> And add it back:
> setpci -s <BDF> CAP_EXP+10.w=0:10

If you wait a bit between these operations, does it work as expected?
