From: jvbockel@gmail.com (John Van Bockel)
Date: Fri, 16 Nov 2018 18:17:22 -0600
Subject: Two M.2 NVMe drives with same NQN, one gets removed
Message-ID: <CAGmwwfeJEVkw2uf1oVoEYgNtuLPRrDqWHXQi-KXTdofsUdH2Dg@mail.gmail.com>

Hi,

I have an Intel NUC8i7HVK mini-computer and a pair of Intel 760p 1TB M.2 NVMe
SSD drives.  With Fedora 29 and Ubuntu 18.10 (both 4.18 kernels), the
nvme kernel
module insists upon disabling one of the two NVMe drives when it notices that
both have been assigned the same NVMe Qualified Name (NQN).  The one that gets
removed by the nvme module is not always the same.  Whichever remains enabled
performs perfectly.

[root at NUCnFutz ~]# dmesg | grep -i nvme

[    3.372662] nvme nvme0: pci function 0000:72:00.0
[    3.372710] nvme nvme1: pci function 0000:73:00.0
[    3.484113]  nvme0n1: p1 p2 p3 p4
[    3.584531] nvme nvme1: ignoring ctrl due to duplicate subnqn
(nqn.2017-12.org.nvmexpress:uuid:11111111-2222-3333-4444-555555555555).
[    3.584533] nvme nvme1: Removing after probe failure status: -22

If I disable one in the UEFI BIOS, the other works perfectly with Linux.  It
does not matter which I disable, the enabled drive works perfectly.  Windows 10
has no trouble performing I/O against both drives when both are enabled.  I've
tried various combinations of settings in the UEFI to see if I could alter the
result of both being given the same NQN.  Firware versions for both
the NUC8i7hvk
and 760p SSD drives are at the latest 51 and 004C versions, respectively.

With the first M.2 slot enabled in UEFI, "nvme list" & "nvme list-subsys" yield:
/dev/nvme0n1 BTHH81850C8W1P0E INTEL SSDPEKKW010T8 1 1.02 TB / 1.02 TB
512 B + 0 B 004C
nvme-subsys0 - NQN=nqn.2017-12.org.nvmexpress:uuid:11111111-2222-3333-4444-555555555555
+- nvme0 pcie 0000:72:00.0

With the second M.2 slot enabled, "nvme list" & "nvme list-susbsys" produce:
/dev/nvme0n1 BTHH81850BX31P0E INTEL SSDPEKKW010T8 1 1.02 TB / 1.02 TB
512 B + 0 B 004C
nvme-subsys0 - NQN=nqn.2017-12.org.nvmexpress:uuid:11111111-2222-3333-4444-555555555555
+- nvme0 pcie 0000:73:00.0

I did have one boot in which both remained enabled.  Slot one was given a device
name of /dev/nvme0n1 with a 0000:72:00.0 path and slot two was given the
/dev/nvme0n2 name with its 0000:73:00.0 path.  I was excited by this result but
was unable to repeat the result.  I wish I had thought to see if both continued
to share the same NQN in that one fleeting success.

Intel regards the combination of NUC8i7HVK and 2TB 760p NVMe drives as
supported.
Mine are the 1TB version of the 760p drives, so I am deviating ever so slightly.
Also, Intel doesn't claim any responsibility for running Linux on the
NUCs and says
to contact the distribution.  The problem seems to be independent of
distribution,
having tried both Fedora 29 (kernel 4.18.16 & 4.18.18) and Ubuntu
18.10 (4.18.?).

I do not know how the NQN is being assigned to the drives.  Whether
the UEFI BIOS
is to blame or is instead being assigned by a Linux kernel module.  If this is
instead a defect in the UEFI, please let me know and I'll move on to communicate
with Intel Support.

Thanks
jvbockel at gmail.com
