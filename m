From: keith.busch@intel.com (Keith Busch)
Date: Mon, 10 Jul 2017 15:08:19 -0400
Subject: kernel BUG at nvme/host/pci.c
In-Reply-To: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
References: <28fcb21a-35b6-61c1-29e0-9adcc954c98c@pse-consulting.de>
Message-ID: <20170710190818.GA13671@localhost.localdomain>

On Mon, Jul 10, 2017@08:03:16PM +0200, Andreas Pflug wrote:
> I'm running a patched (see below) debian 4.9.30 kernel with xen4.8.1 on
> Debian9. Starting a specific virtual machine, very soon the kernel will emit
> 
>     kernel BUG at /usr/src/kernel/linux-4.9.30/drivers/nvme/host/pci.c:495!
> 
> via netconsole to my logging host, and become unstable until hard reset.
> Hardware is dual E5-2620v4 on Supermicro 10DRI-T with two SAMSUNG
> MZQLW960HMJP-00003 NVME disks (mdadm RAID-1) backing the vhds (os on
> separate SSD).
> 
> The bug was reported to debian as https://bugs.debian.org/866511 . According
> to Ben Hutchings' advice, I patched the standard kernel with
> 0001-swiotlb-ensure-that-page-sized-mappings-are-page-ali.patch since its
> description sounded promising, but the bug remains.

The BUG_ON means the nvme driver was given a scatter list that is invalid
for the constraints the NVMe device was registered with. There have been
issues in the past when NVMe is used with stacking devices like RAID,
but I think they are all resolved. Would you happen to know if this
is successful with the 4.12 kernel? If so, I might be able to find the
patch(es) for 4.9-stable, otherwise we'll need to fix it there first.
