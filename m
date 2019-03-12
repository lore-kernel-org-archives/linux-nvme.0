From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 12 Mar 2019 09:32:46 +0800
Subject: NVMe: Regression: write zeros corrupts ext4 file system
In-Reply-To: <20190311145457.GA10411@localhost.localdomain>
References: <20190311022441.GA16849@ming.t460p>
 <20190311145457.GA10411@localhost.localdomain>
Message-ID: <20190312013245.GD28841@ming.t460p>

On Mon, Mar 11, 2019@08:54:59AM -0600, Keith Busch wrote:
> On Mon, Mar 11, 2019@10:24:42AM +0800, Ming Lei wrote:
> > Hi,
> > 
> > It is observed that ext4 is corrupted easily by running some workloads
> > on QEMU NVMe, such as:
> > 
> > 1) mkfs.ext4 /dev/nvme0n1
> > 
> > 2) mount /dev/nvme0n1 /mnt
> > 
> > 3) cd /mnt; git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 
> > 4) then the following error message may show up:
> > 
> > [ 1642.271816] EXT4-fs error (device nvme0n1): ext4_mb_generate_buddy:747: group 0, block bitmap and bg descriptor inconsistent: 32768 vs 23513 free clusters
> > 
> > Or fsck.ext4 will complain after running 'umount /mnt'
> > 
> > The issue disappears by reverting 6e02318eaea53eaafe6 ("nvme: add support for the
> > Write Zeroes command").
> > 
> > QEMU version:
> > 
> > QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)
> > Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> 
> In QEMU, blk_aio_pwrite_zeroes() takes bytes, but the nvme controller
> thought it was blocks. Oops, that went by unnoticed till now!
> 
> We should fix QEMU (patch below). Question is, should we quirk driver 
> for older versions too?

I think so, users may never upgrade their QEMU.

Thanks,
Ming
