From: leon@kernel.org (Leon Romanovsky)
Date: Thu, 7 Sep 2017 08:18:05 +0300
Subject: [LPC] 2nd RDMA Mini-Summit Schedule
Message-ID: <20170907051805.GA19175@mtr-leonro.local>

Hi,

We're happy to announce schedule of the 2nd RDMA mini-summit, which will be
held as part of coming Linux Plumbers Conference 2017.

During the conference, we will have two sessions: main track session and
round table session.

First session will be held on Thursday, September 14, 2017 from 9:30am ? 12:30pm
with the topics relevant for the wider audience.

In the second session, we  will focus on more face to face discussions in round
table format and it will be scheduled a little bit later once we will get meeting
room.

---------------------------------------------------------------------------------------
FIRST SESSION:
---------------------------------------------------------------------------------------
 * Backporting issues with multi-subsystem device (RDMA + netdev + more) by Don Dutile
   - More and more devices in RDMA are dependent on netdev as well as other
     subsystems -- target, NFS, scsi, block, cgroups, SELinux.... Can we make
     backporting task for distro people easier?
 * kABI Update by Matan Barak
   - Going forward with a flexible and secure RDMA kABI
 * System Boot and RDMA by Jason Gunthrope
   - Discuss boot-time issues with the RDMA subsystem
 * Paravirtual RDMA device by Marcel Apfelbaum and Yuval Shaia
   - QEMU's limited RDMA support leaves it behind other modern hypervisors.
     Marcel and Yuval will present the implementation of an emulated RDMA device,
     analyze its performance and usability, and finally talk about future plans
     for a possible virtio-rdma device.
  * TX Flow Steering for IPsec by Liran Liss (pending time slot)
   - The IPsec protocol provides both encryption and authentication for IP
     protocol packets. Users of the raw ethernet QP that send/receive IPsec packets
     could benefit from the IPsec crypto offloads capabilities that are
     available in recent NICs.
  * OpenFabrics Alliance - Status and New Directions by Jason Gunthrope
  * BOF - Open Discussion
   - Open discussion with the community lead by Leon Romanovsky, Jason Gunthorpe,
     Christoph Lameter and Dennis Dalessandro

---------------------------------------------------------------------------------------
ROUND TABLE SESSION:
---------------------------------------------------------------------------------------
Possible list, bring your own topics:
 * RDMA and ULPs
 * Verbs testing suite
 * RDMA netlink and RDMAtool future plans
 * RDMA and the Linux IP stack
 * Infrastructure issues with Travis CI
 * Infrastructure gaps with rdma-core
 * Packaging as part of CI for rdma-core.
 * ....

See you next week at Linux Plumber Conference 2017.

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170907/7194bc5a/attachment.sig>
