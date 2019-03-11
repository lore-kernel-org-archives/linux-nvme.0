From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 11 Mar 2019 18:16:19 +0800
Subject: NVMe: Regression: write zeros corrupts ext4 file system
In-Reply-To: <08f3d0f9-c10c-ef72-72f5-62670388763b@oracle.com>
References: <20190311022441.GA16849@ming.t460p>
 <08f3d0f9-c10c-ef72-72f5-62670388763b@oracle.com>
Message-ID: <20190311101618.GA26229@ming.t460p>

On Mon, Mar 11, 2019@03:54:16PM +0800, Dongli Zhang wrote:
> 
> 
> On 3/11/19 10:24 AM, Ming Lei wrote:
> > Hi,
> > 
> > It is observed that ext4 is corrupted easily by running some workloads
> > on QEMU NVMe, such as:
> 
> I cannot reproduce with most recent up-to-date mainline kernel on below qemu
> versions:
> 
> - qemu-2.10.2
> - qemu-3.0.0

The qemu in my test is from Fedora 27, and it isn't built by me, and
'qemu-system-x86_64 -version' shows that:

	QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)

My test VM is actually cloned from the official Fedora 27 Cloud image[1],
then run 'dnf update' before starting the test.

[1] https://download.fedoraproject.org/pub/fedora/linux/releases/27/CloudImages/x86_64/images/Fedora-Cloud-Base-27-1.6.x86_64.qcow2

> 
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
> 
> As above commit is for Write Zeros command, I instrument and add printf at the
> beginning of nvme_write_zeros() for qemu-2.10.2.
> 
> nvme_write_zeros() are only called for 47 times during "mount /dev/nvme0n1 /mnt".
> 
> 
> During "git clone" from torvalds' linux.git, there is no call of nvme_write_zeros().
> 
> Perhaps there is some special configuration required to trigger the
> nvme_write_zeros() on purpose during "git clone" to involve the
> nvme_cmd_write_zeroes on kernel side?

It can be triggered by random write workloads after mkfs & mount on the
nvme.

> 
> My test nvme image is only about 5GB.

Mine is 8GB.


Thanks,
Ming
