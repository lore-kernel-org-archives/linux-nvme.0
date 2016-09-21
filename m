From: robert.m.riches.jr@intel.com (Riches Jr, Robert M)
Date: Wed, 21 Sep 2016 18:15:16 +0000
Subject: newbie question: Chelsio NIC drivers want kernel 4.1
Message-ID: <3D44B3DCE57399449CC1391C2AD6EC4C999A1AA7@ORSMSX101.amr.corp.intel.com>

(New subscriber to the list.  Could not find a relevant-looking
FAQ.  Searched 25MB of archives before sending.  Apologies if I
have the wrong list or am guilty of some other infraction.)

Attempting to set up a pair of machines to do NVMf experiments
with Chelsio T580-LP-CR NICs.  Was instructed to use CentOS 7.2,
the Chelsio hardware-specific driver modules, and the
git-snapshot-nvmf-all.3 "NVMe over Fabrics RDMA target support"
module(s).  Preliminary testing with Chelsio's binary RPMs (their
rbdi and rbdt modules) worked well.

The git-snapshot-nvmf-all.3 tar archive is kernel 4.7.0-rc2, but
Chelsio's source modules require kernel 4.1 or before.  The
NVMf-RDMA-enabled 4.7.0-rc2 kernel built, booted, and is running
well.  However, attempts to build the Chelsio NIC modules have
failed--even after modifying the Python configuration script to
not choke when trying to build for kernel 4.1.

To attempt to reconcile the kernel versions, I downloaded this
v4.1 tag snapshot:

    http://git.infradead.org/nvme-fabrics.git/snapshot/b953c0d234bc72e8489d3bf51a276c5c4ec85345.tar.gz

However, "make menuconfig" does not show any options resembling
"NVMe over Fabrics RDMA target support" that I could discern.

If necessary, I'm willing to modify the Chelsio driver source to
make it work with kernel 4.7.0-rc2, but I'm suspicious that would
be a rathole.

Any suggestions?  What do I not understand about how to get a
kernel that talks to the cards and does "NVMe over Fabrics RDMA
..."?  Is there any chance the git-snapshot-nvmf-all.3 kernel
4.7.0-rc2 can talk directly to the cards without the Chelsio
modules?

Thanks,

Robert Riches
